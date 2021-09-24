Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from unicom145.biz-email.net ([210.51.26.145])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTZlM-00CoZH-6F
 for kexec@lists.infradead.org; Fri, 24 Sep 2021 01:12:31 +0000
From: Kai Song <songkai01@inspur.com>
Subject: [PATCH] kexec:Fix  memory leak problem in zImage_ppc64_load()
Date: Fri, 24 Sep 2021 09:08:04 +0800
Message-ID: <20210924010804.10406-1-songkai01@inspur.com>
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

When the function exits abnormally,ph should be freed.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 kexec/arch/ppc64/kexec-zImage-ppc64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kexec/arch/ppc64/kexec-zImage-ppc64.c b/kexec/arch/ppc64/kexec-zImage-ppc64.c
index d084ee5..e946205 100644
--- a/kexec/arch/ppc64/kexec-zImage-ppc64.c
+++ b/kexec/arch/ppc64/kexec-zImage-ppc64.c
@@ -102,10 +102,12 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 	}
 	if (fseek(file, elf.e_phoff, SEEK_SET) < 0) {
 		perror("seek failed: ");
+		free(ph);
 		return -1;
 	}
 	if (fread(ph, sizeof(Elf32_Phdr) * elf.e_phnum, 1, file) != 1) {
 		perror("read error: ");
+		free(ph);
 		return -1;
 	}
 
@@ -113,6 +115,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 	if (*ret_segments == 0) {
 		fprintf(stderr, "malloc failed: %s\n",
 			strerror(errno));
+		free(ph);
 		return -1;
 	}
 	segment = ret_segments[0];
@@ -135,6 +138,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 	}
 	if (memsize == 0) {
 		fprintf(stderr, "Can't find a loadable segment.\n");
+		free(ph);
 		return -1;
 	}
 
@@ -143,6 +147,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 	segment->buf = malloc(filesize);
 	if (segment->buf == 0) {
 		perror("malloc failed: ");
+		free(ph);
 		return -1;
 	}
 	for (i = 0; i < elf.e_phnum; ++i, ++p) {
@@ -153,12 +158,14 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 		/* skip to the actual image */
 		if (fseek(file, p->p_offset, SEEK_SET) < 0) {
 			perror("seek error: ");
+			free(ph);
 			return -1;
 		}
 		mem_offset = p->p_vaddr - load_loc;
 		if (fread((void *)segment->buf+mem_offset, p->p_filesz, 1,
 				file) != 1) {
 			perror("read error: ");
+			free(ph);
 			return -1;
 		}
 	}
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
