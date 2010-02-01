Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAI-00054Q-N5
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:07 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 7D442245A2
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121321.315061652@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:01 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 05/27] i386: Remove unused kexec_flags parameter from
	setup_edd_info()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline;
	filename=i386-setup_edd_info-remove-unused-parameter.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c	2010-02-01 23:06:41.000000000 +1100
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c	2010-02-01 23:07:17.000000000 +1100
@@ -353,8 +353,7 @@ static void zero_edd(struct x86_linux_pa
 		EDD_MBR_SIG_MAX * sizeof(uint32_t));
 }
 
-void setup_edd_info(struct x86_linux_param_header *real_mode,
-					unsigned long kexec_flags)
+void setup_edd_info(struct x86_linux_param_header *real_mode)
 {
 	DIR *edd_dir;
 	struct dirent *cursor;
@@ -482,5 +481,5 @@ void setup_linux_system_parameters(struc
 	}
 
 	/* fill the EDD information */
-	setup_edd_info(real_mode, kexec_flags);
+	setup_edd_info(real_mode);
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
