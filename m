Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1emHy4-0006up-4I
 for kexec@lists.infradead.org; Thu, 15 Feb 2018 11:44:53 +0000
Received: by mail-wm0-x242.google.com with SMTP id 141so258547wme.3
 for <kexec@lists.infradead.org>; Thu, 15 Feb 2018 03:44:35 -0800 (PST)
From: Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [PATCH] add description for jumping back to the original kernel in
 man page
Date: Thu, 15 Feb 2018 12:44:19 +0100
Message-Id: <20180215114419.12705-1-gi-oh.kim@profitbricks.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, bhe@redhat.com
Cc: bhupesh.linux@gmail.com, Gioh Kim <gi-oh.kim@profitbricks.com>

"--load-preserve-context", "--load-jump-back-helper" and "--entry"
options are described separately but there is not any description
how to use them.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 kexec/kexec.8 | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4..b7ac028 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -30,6 +30,9 @@ when configuring the kernel. The
 option enables the
 .B kexec
 system call.
+After booting into another kernel, you can jump back to the first kernel with enabling
+.B CONFIG_KEXEC_JUMP
+option (x86 only).
 .SH USAGE
 Using
 .B kexec
@@ -102,6 +105,30 @@ command:
 .BR kexec \ \-e
 .RE
 
+After booting the kernel, you can jump back to the first kernel if you enable
+.B CONFIG_KEXEC_JUMP
+kernel option and specify \-\-load\-preserve\-context option.
+You can see
+.BR "kexec_jump_back_entry=<address>"
+kernel parameter in /proc/cmdline file, for example:
+
+.RS
+.BR "kexec_jump_back_entry=0x00000000000810d2"
+.RE
+
+Frist you need to prepare jump with \-\-load\-jump\-back\-helper and \-\-entry options.
+
+.RS
+.B kexec
+.RB \-\-load\-jump\-back\-helper \-\-entry=0x810d2
+.RE
+
+Then the first kernel can be rebooted using the command:
+
+.RS
+.BR kexec \ \-e
+.RE
+
 .SH OPTIONS
 .TP
 .B \-d\ (\-\-debug)
@@ -173,6 +200,9 @@ Specify the jump back address. (0 means it's not jump back or preserve context)
 .TP
 .BI \-\-load\-preserve\-context
 Load the new kernel and preserve context of current kernel during kexec.
+(kexec returns error if
+.B CONFIG_KEXEC_JUMP
+is not enabled)
 .TP
 .BI \-\-load\-jump\-back\-helper
 Load a helper image to jump back to original kernel.
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
