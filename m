Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrC-0006yl-VL
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:57:47 +0000
Message-Id: <20080306094759.628025769@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 07/12] kexec-tools: mipsel: Remove unused variables in
	arch_process_options()
Content-Disposition: inline;
	filename=mips-arch_process_options-unused-values.patch
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

 kexec/arch/mipsel/kexec-mipsel.c |    2 --
 1 file changed, 2 deletions(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-mipsel.c	2008-02-27 19:14:03.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c	2008-02-27 19:18:15.000000000 +0900
@@ -111,8 +111,6 @@ int arch_process_options(int argc, char 
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR;
 	int opt;
-	unsigned long value;
-	char *end;
 
 	opterr = 0; /* Don't complain about unrecognized options here */
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
