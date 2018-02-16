Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eme8z-0003h4-RP
 for kexec@lists.infradead.org; Fri, 16 Feb 2018 11:25:42 +0000
Received: by mail-wm0-x242.google.com with SMTP id v71so2543705wmv.2
 for <kexec@lists.infradead.org>; Fri, 16 Feb 2018 03:25:23 -0800 (PST)
From: Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [PATCH v2] add description for jumping back to the primary kernel in
 man page
Date: Fri, 16 Feb 2018 12:25:14 +0100
Message-Id: <20180216112514.28584-1-gi-oh.kim@profitbricks.com>
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
To: kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, Gioh Kim <gi-oh.kim@profitbricks.com>, bhe@redhat.com

"--load-preserve-context", "--load-jump-back-helper" and "--entry"
options are described separately but there is not any description
how to use them.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 kexec/kexec.8 | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4..675a285 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -30,6 +30,9 @@ when configuring the kernel. The
 option enables the
 .B kexec
 system call.
+After booting into secondary kernel, you can jump back to the primary kernel with enabling
+.B CONFIG_KEXEC_JUMP
+option (x86 and sh only).
 .SH USAGE
 Using
 .B kexec
@@ -94,7 +97,7 @@ then you would use the following command to load the kernel:
 .RB \-l\  /boot/vmlinux
 .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
 .RE
-.PP
+
 After this kernel is loaded, it can be booted to at any time using the
 command:
 
@@ -102,6 +105,25 @@ command:
 .BR kexec \ \-e
 .RE
 
+For jumping back to the primary kernel, you need to prepare the jump with following command:
+
+.RS
+.B kexec
+.RB \-\-load\-jump\-back\-helper \ \-\-entry=<address>
+.RE
+
+The
+.BR <address>
+value is specified by
+.BR kexec_jump_back_entry=<address>
+kernel parameter in /proc/cmdline. Then the primary kernel can be booted
+using the command:
+
+.RS
+.BR kexec \ \-e
+.RE
+.PP
+
 .SH OPTIONS
 .TP
 .B \-d\ (\-\-debug)
@@ -173,6 +195,9 @@ Specify the jump back address. (0 means it's not jump back or preserve context)
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
