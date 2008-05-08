Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ju8dr-0004DD-K3
	for kexec@lists.infradead.org; Thu, 08 May 2008 16:06:47 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 00A69456D8
	for <kexec@lists.infradead.org>; Thu,  8 May 2008 18:06:46 +0200 (CEST)
Date: Thu, 8 May 2008 18:01:03 +0200
Subject: [PATCH] Remove the 'bzImage' warning from manpage
Message-ID: <20080508160103.GA30762@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch removes the warning

   Compressed kernel images such as bzImage are not supported by kexec.
   Use the uncompressed vmlinux.

from the manual page as this is wrong now. Contrary, the usage of bzImage for
kdump is recommended because on x86_64 it's the only way to use a relocatable
kernel for dumping.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/kexec.8 |    4 ----
 1 file changed, 4 deletions(-)

--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -55,10 +55,6 @@ where
 .I kernel\-image
 is the kernel file that you intend to reboot to.
 .PP
-Note: Compressed kernel images such as bzImage are not supported by
-.BR kexec .
-Use the uncompressed vmlinux.
-.PP
 Insert the command-line parameters that must be passed to the new
 kernel into
 .IR command\-line\-options .

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
