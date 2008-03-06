Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCr6-0006YY-5K
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:40 +0000
Message-Id: <20080306094759.405831871@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:43 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 06/12] kexec-tools: mipsel: Remove unused variables from
	elf_mipsel_load
Content-Disposition: inline;
	filename=mips-elf_mipsel_load-unused-variables.patch
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

 kexec/arch/mipsel/kexec-elf-mipsel.c |    2 --
 1 file changed, 2 deletions(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:17:47.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:17:49.000000000 +0900
@@ -116,9 +116,7 @@ int elf_mipsel_load(int argc, char **arg
 	int command_line_len;
 	unsigned char *setup_start;
 	uint32_t setup_size;
-	int result;
 	int opt;
-	int i;
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
