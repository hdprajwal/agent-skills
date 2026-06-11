---
name: document-toolkit
description: "Read, extract, fill, and generate Office/PDF documents from Python — PDF (pypdf / pdfplumber), Word (.docx, python-docx), and Excel (.xlsx, openpyxl). Use whenever a .pdf, .docx, or .xlsx is the input or the desired output: extract text/tables, merge/split, fill forms, build a report, read or write a spreadsheet. Prefers libraries over brittle shell parsing."
allowed-tools: Read Write Edit Bash
---

# Document Toolkit (PDF · DOCX · XLSX)

Handle documents with the right Python library, not regex over raw bytes. Install
what you need:

```bash
pip install pypdf pdfplumber python-docx openpyxl
```

Pick by file type, then by task. Work on a copy; never overwrite the user's
original without confirming.

## PDF

**Extract text/tables** — `pdfplumber` is best for layout-aware text and tables:

```python
import pdfplumber
with pdfplumber.open("in.pdf") as pdf:
    text = "\n".join(p.extract_text() or "" for p in pdf.pages)
    tables = pdf.pages[0].extract_tables()
```

**Merge / split / rotate** — `pypdf`:

```python
from pypdf import PdfReader, PdfWriter
w = PdfWriter()
for f in ["a.pdf", "b.pdf"]:
    for page in PdfReader(f).pages:
        w.add_page(page)
with open("merged.pdf", "wb") as fh:
    w.write(fh)
```

**Scanned PDFs** need OCR first (`ocrmypdf in.pdf out.pdf`) before text
extraction. **Fill forms:** read field names with `reader.get_fields()`, then
`writer.update_page_form_field_values(...)`.

## Word (.docx)

```python
from docx import Document
doc = Document("in.docx")                      # read
full = "\n".join(p.text for p in doc.paragraphs)
for table in doc.tables:
    for row in table.rows:
        print([c.text for c in row.cells])

out = Document()                               # create
out.add_heading("Report", level=1)
out.add_paragraph("Body text.")
t = out.add_table(rows=1, cols=2); t.style = "Light Grid"
out.save("out.docx")
```

`python-docx` covers headings, paragraphs, runs (bold/italic), tables, images
(`add_picture`), and styles. It does **not** render to PDF — convert with
`libreoffice --headless --convert-to pdf out.docx` if needed.

## Excel (.xlsx)

```python
from openpyxl import load_workbook, Workbook
wb = load_workbook("in.xlsx", data_only=True)  # data_only → values, not formulas
ws = wb.active
for row in ws.iter_rows(values_only=True):
    print(row)

wb2 = Workbook(); ws2 = wb2.active             # create
ws2.append(["Name", "Score"]); ws2.append(["A", 91])
ws2["C1"] = "=SUM(B2:B100)"                     # formulas as strings
wb2.save("out.xlsx")
```

`openpyxl` handles sheets, formulas, styles, number formats, charts, and
freezing panes. For heavy numeric work, read with `pandas.read_excel` and write
with `df.to_excel`.

## Rules

- **Library over shell.** Don't `grep`/`sed` a binary doc — use the library.
- **Work on a copy**; confirm before overwriting an original.
- **Verify the output** — open the produced file (extract its text / list its
  rows) and confirm it's what was asked, not just that the script ran.
- For big batches, write a small script and run it once, rather than many ad-hoc
  one-liners.

## Credit

Approach and library choices follow the `pdf` / `docx` / `xlsx` skills in
[anthropics/skills](https://github.com/anthropics/skills).
