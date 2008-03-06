Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrA-0006sQ-1I
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:44 +0000
Message-Id: <20080306094800.680153069@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 12/12] kexec-tools: mipsel: Define OPT_APPEND outside of any
	function
Content-Disposition: inline;
	filename=mipsel-opt-defines-outside-of-function.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-06 18:39:51.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-06 18:39:51.000000000 +0900
@@ -70,6 +70,8 @@ static struct boot_notes {
 };
 
 
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
+
 int elf_mipsel_probe(const char *buf, off_t len)
 {
 
@@ -117,7 +119,6 @@ int elf_mipsel_load(int argc, char **arg
 	unsigned char *setup_start;
 	uint32_t setup_size;
 	int opt;
-#define OPT_APPEND     (OPT_ARCH_MAX+0)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
