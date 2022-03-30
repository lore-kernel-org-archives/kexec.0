From: Lichen Liu <lichliu@redhat.com>
Date: Wed, 30 Mar 2022 19:09:51 +0800
Subject: [PATCH] kexec-tools: fix leak FILE pointer.
Message-ID: <20220330110951.3261355-1-lichliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Close fp if file size is smaller than 13 bytes.

Signed-off-by: Lichen Liu <lichliu@redhat.com>
---
 kexec/lzma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/lzma.c b/kexec/lzma.c
index f27cfe2..2fc07e6 100644
--- a/kexec/lzma.c
+++ b/kexec/lzma.c
@@ -170,8 +170,11 @@ int is_lzma_file(const char *filename)
 
 	const size_t size = fread(buf, 1, sizeof(buf), fp);
 
-	if (size != 13)
+	if (size != 13) {
+		/* file is too small to be a lzma file. */
+		fclose(fp);
 		return 0;
+	}
 
 	lzma_filter filter = { .id = LZMA_FILTER_LZMA1 };
 
-- 
2.27.0


