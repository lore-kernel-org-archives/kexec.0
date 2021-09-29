Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ssh248.corpemail.net ([210.51.61.248])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVUhK-00AKk0-9g
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 08:12:17 +0000
From: Kai Song <songkai01@inspur.com>
Subject: [PATCH] kexec-tools:Add some necessary free() calls
Date: Wed, 29 Sep 2021 16:11:57 +0800
Message-ID: <20210929081157.3999-1-songkai01@inspur.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Kai Song <songkai01@inspur.com>

free should be called before the function exit abnormally.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 kexec/kexec-uImage.c | 10 ++++++++--
 util_lib/elf_info.c  |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index eeee4be..016be10 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -157,12 +157,15 @@ static int uImage_gz_load(const char *buf, off_t len,
 	skip = 10;
 
 	/* check GZ magic */
-	if (buf[0] != 0x1f || buf[1] != 0x8b)
+	if (buf[0] != 0x1f || buf[1] != 0x8b) {
+		free(uncomp_buf);
 		return -1;
+	}
 
 	flags = buf[3];
 	if (buf[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
 		puts ("Error: Bad gzipped data\n");
+		free(uncomp_buf);
 		return -1;
 	}
 
@@ -187,8 +190,10 @@ static int uImage_gz_load(const char *buf, off_t len,
 
 	/* - activates parsing gz headers */
 	ret = inflateInit2(&strm, -MAX_WBITS);
-	if (ret != Z_OK)
+	if (ret != Z_OK) {
+		free(uncomp_buf);
 		return -1;
+	}
 
 	strm.next_out = uncomp_buf;
 	strm.avail_out = mem_alloc;
@@ -214,6 +219,7 @@ static int uImage_gz_load(const char *buf, off_t len,
 			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
 			strm.avail_out = inc_buf;
 		} else {
+			free(uncomp_buf);
 			printf("Error during decompression %d\n", ret);
 			return -1;
 		}
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 676926c..51d8b92 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -605,8 +605,10 @@ static int scan_notes(int fd, loff_t start, loff_t lsize)
 		scan_vmcoreinfo(n_desc, n_descsz);
 	}
 
-	if ((note + sizeof(Elf_Nhdr)) == last)
+	if ((note + sizeof(Elf_Nhdr)) == last) {
+		free(buf);
 		return -1;
+	}
 
 	free(buf);
 
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
