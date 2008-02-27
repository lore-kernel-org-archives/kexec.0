Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUJmd-0002s0-HP
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 10:45:07 +0000
Message-Id: <20080227104402.579623520@vergenet.net>
References: <20080227103536.406746333@vergenet.net>
Date: Wed, 27 Feb 2008 19:35:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 4/7] kexec-tools: Remove unused variables in
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
To: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>
Cc: kexec@lists.infradead.org

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
-       unsigned long value;
-       char *end;
 
        opterr = 0; /* Don't complain about unrecognized options here */
        while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
