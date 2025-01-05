
### **How `lookup` Works in the Context of the `mime_types` Map**

In your code, you're using the `lookup` function to find the MIME type for each file based on its extension. Here's the breakdown:

```hcl
content_type = lookup(var.mime_types, split(".", each.value)[1], "application/octet-stream")
```

### **Key Components of the `lookup` Function**
1. **`var.mime_types`**: 
   - This is the **map** that holds the file extensions as keys and the corresponding MIME types as values.
   - Example: `"html" = "text/html"`, `"css" = "text/css"`, `"png" = "image/png"`, etc.

2. **`split(".", each.value)[1]`**:
   - This part splits the filename (like `index.html`) by the period (`.`) to separate the file name from the file extension.
   - `split(".", "index.html")` results in `["index", "html"]`, and `split(".", each.value)[1]` extracts `"html"` (the file extension).

3. **`lookup(var.mime_types, ..., "application/octet-stream")`**:
   - The `lookup` function checks if the file extension (like `"html"`) exists in the `mime_types` map.
   - If the extension exists in the map, it returns the corresponding MIME type (like `"text/html"`).
   - If the extension is not found in the map, it returns the default value `"application/octet-stream"`, which is a generic MIME type for binary files.

---

### **Example with Fileset and `lookup`**

Let’s walk through an example where you have a list of files in the `website` directory, and you want to upload them to S3 with the correct `Content-Type`.

#### **1. Files in the `website` Directory**
Suppose you have the following files in the `website/` directory:
- `index.html`
- `styles.css`
- `image.png`
- `unknown.xyz`

#### **2. The `mime_types` Map**
You define the `mime_types` map to map file extensions to their corresponding MIME types:

```hcl
variable "mime_types" {
  default = {
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
  }
}
```

#### **3. Using `fileset` to Get the Files**
The `fileset` function is used to get a list of all files in a specific directory. For example:
```hcl
fileset("website", "*")
```
This will return a list of all files in the `website/` directory, such as:
- `index.html`
- `styles.css`
- `image.png`
- `unknown.xyz`

#### **4. Applying `lookup` to Get MIME Types**
For each file in the `website/` directory, the `lookup` function will use the file extension to determine the correct `Content-Type`.

For example:
- For `index.html`:
  - `split(".", "index.html")` results in `["index", "html"]`.
  - The extension `"html"` is found in the `mime_types` map, so it returns `"text/html"`.
  
- For `styles.css`:
  - `split(".", "styles.css")` results in `["styles", "css"]`.
  - The extension `"css"` is found in the `mime_types` map, so it returns `"text/css"`.

- For `image.png`:
  - `split(".", "image.png")` results in `["image", "png"]`.
  - The extension `"png"` is found in the `mime_types` map, so it returns `"image/png"`.

- For `unknown.xyz`:
  - `split(".", "unknown.xyz")` results in `["unknown", "xyz"]`.
  - The extension `"xyz"` is not found in the `mime_types` map, so it defaults to `"application/octet-stream"`.

#### **5. Uploading to S3**
When you upload the files to S3 using the `aws_s3_object` resource, the `Content-Type` for each file is set based on the MIME type returned by `lookup`.

```hcl
resource "aws_s3_object" "files_upload" {
  for_each = fileset("website", "*")

  bucket       = aws_s3_bucket.static_website.bucket
  key          = each.value
  source       = "website/${each.value}"
  content_type = lookup(var.mime_types, split(".", each.value)[1], "application/octet-stream")
}
```

---

### **Summary**
- **`lookup`** is used to fetch the MIME type from the `mime_types` map based on the file extension.
- **`split(".", each.value)[1]`** extracts the file extension from the filename (e.g., `"html"`, `"css"`, `"png"`).
- If the extension is found in the map, the corresponding MIME type is used. If not, it defaults to `"application/octet-stream"`.
