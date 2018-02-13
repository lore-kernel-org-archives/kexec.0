Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elcQF-0000lp-To
 for kexec@lists.infradead.org; Tue, 13 Feb 2018 15:23:19 +0000
Received: by mail-wr0-x242.google.com with SMTP id 34so8722318wre.13
 for <kexec@lists.infradead.org>; Tue, 13 Feb 2018 07:22:56 -0800 (PST)
From: Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [PATCH] Documentation: kdump: describe jumping to dump-capture kernel
Date: Tue, 13 Feb 2018 16:22:36 +0100
Message-Id: <20180213152236.31413-1-gi-oh.kim@profitbricks.com>
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
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, dyoung@redhat.com, bhe@redhat.com
Cc: bhupesh.linux@gmail.com, Gioh Kim <gi-oh.kim@profitbricks.com>, vgoyal@redhat.com, corbet@lwn.net

Jumping between the system kernel and the dump-capture kernel
has been supported for long time but there is no description
how to use it. This patch adds the description how to use kexec tool
to jump to the dump-capture kernel and jump back to the system kernel.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 Documentation/kdump/kdump.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 51814450a7f8..35b71fef5d88 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -460,6 +460,44 @@ and the system will boot into the dump-capture kernel.
 For testing purposes, you can trigger a crash by using "ALT-SysRq-c",
 "echo c > /proc/sysrq-trigger" or write a module to force the panic.
 
+Jump between the System kernel and the Dump-capture kernel
+===============================
+
+Without system crash, the system can jump to the dump-capture kernel.
+
+1) Enable "jump between system kernel and dump-capture kernel" support under
+   "Processor type and features"
+
+   CONFIG_KEXEC_JUMP=y
+
+2) Load the dump-capture kernel with --load-preserve-context and mem-max
+   options as following.
+
+   kexec -l <dump-capture-kernel-vmlinux-image> \
+   --initrd=<initrd-for-dump-capture-kernel> --args-linux \
+   --append="root=<root-dev> <arch-specific-options>" \
+   --load-preserve-context \
+   --mem-max=<the highest memory address addr to load code into>
+
+3) Jump to the loaded kernel
+
+   kexec -e
+
+Now the system is running with the dump-capture kernel. You can jump back
+to the system kernel.
+
+1) Find kexec_jump_back_entry address in kernel booting parameters in
+   /proc/cmdline. That is the address for kexec to jump to. For example:
+   kexec_jump_back_entry=0x00000000000810d2
+
+2) Following command sets the jump-back address for kexec.
+
+   kexec --load-jump-back-helper --entry=0x810d2
+
+3) Jump to the system kernel
+
+   kexec -e
+
 Write Out the Dump File
 =======================
 
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
