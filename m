Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ju9Wn-0004p5-0R
	for kexec@lists.infradead.org; Thu, 08 May 2008 17:03:33 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 82D7445E2B
	for <kexec@lists.infradead.org>; Thu,  8 May 2008 19:03:31 +0200 (CEST)
Date: Thu, 8 May 2008 19:04:12 +0200
Subject: [PATCH] Document kexec without -e/-l/-f/-p and clarify -f
Message-ID: <20080508170412.GA6588@suse.de>
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

This patch tries to clarify the manpage in two aspects:

It describes the meaning of kexec without an -e / -l / -f / -p option (i.e. 
only with kernel, initrd and command line).

It also documents the difference between -f and normal kexec call better.

I made the patch to clarify the manpage because there was some confusion in
https://bugzilla.novell.com/show_bug.cgi?id=387601.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/kexec.8 |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -67,6 +67,17 @@ The optional
 .I initrd-image
 is the initrd image to be used during boot.
 .PP
+It's also possible to invoke
+.B kexec
+without an option parameter. In that case, kexec loads the specified
+kernel and then invokes
+.BR shutdown (1).
+If the shutdown scripts of your Linux distribution support
+kexec-based rebooting, they then call
+.B kexec
+.I -e
+just before actually rebooting the machine. That way, the machine does
+a clean shutdown including all shutdown scripts.
 
 .SH EXAMPLE
 .PP
@@ -99,7 +110,14 @@ Run the currently loaded kernel.
 .B \-f\ (\-\-force)
 Force an immediate
 .B kexec
-call, do not call shutdown.
+call, do not call
+.BR shutdown (1)
+(contrary to the default action without any option parameter). This option
+performs the same actions like executing
+.IR -l
+and
+.IR -e
+in one call.
 .TP
 .B \-h\ (\-\-help)
 Open a help file for

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
