Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pip23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JLt4G-0002rp-6k
	for kexec@lists.infradead.org; Mon, 04 Feb 2008 04:36:35 +0000
Date: Mon, 4 Feb 2008 13:35:31 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] sh: Remove hardcoded PAGE_SIZE in NetBSD loader
Message-ID: <20080204043531.GB27300@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Horms <horms@verge.net.au>

The Linux host supports a multitude of page sizes, so having this
hardcoded doesn't really help matters. This also has the benefit of
killing off dependence on asm/ headers when none is needed. While
I'm not suggesting that anyone actually boot NetBSD, without this,
my build also ends up breaking.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 kexec/arch/sh/kexec-netbsd-sh.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/sh/kexec-netbsd-sh.c b/kexec/arch/sh/kexec-netbsd-sh.c
index a751420..07c7f26 100644
--- a/kexec/arch/sh/kexec-netbsd-sh.c
+++ b/kexec/arch/sh/kexec-netbsd-sh.c
@@ -25,13 +25,10 @@
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include <arch/options.h>
-#include <asm/page.h>
 
 static const int probe_debug = 0;
 const extern unsigned char netbsd_booter[];
 
-#define PAGE_ALIGN(addr)        (((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * netbsd_sh_probe - sanity check the elf image
  *
@@ -62,7 +59,7 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	const char *howto, *miniroot;
-	unsigned long entry, start, size;
+	unsigned long entry, start, size, psz;
 	char *miniroot_buf;
 	off_t miniroot_length;
 	unsigned int howto_value;
@@ -105,6 +102,8 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
 	        howto_value = strtol(howto, NULL, 0);
 	}
 
+	psz = getpagesize();
+
 	/* Parse the Elf file */
 	{
 	        Elf32_Ehdr *ehdr;
@@ -122,7 +121,8 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
 		if(size < bbs){
 		        size = bbs;
 		}
-		size  = PAGE_ALIGN(size);
+
+		size = (size + psz - 1) & ~(psz - 1);
 		memset(&img[bbs], 0, size-bbs);
 		add_segment(info, img, size, start, size);
 		start += size;
@@ -133,7 +133,7 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
 	if (miniroot) {
 		miniroot_buf = slurp_file(miniroot, &miniroot_length);
 		howto_value |= 0x200;
-		size = PAGE_ALIGN(miniroot_length);
+		size = (miniroot_length + psz - 1) & ~(psz - 1);
 		add_segment(info, miniroot_buf, size, start, size);
 		start += size;
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
