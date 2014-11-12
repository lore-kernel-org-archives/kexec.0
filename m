Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoRbL-00078d-HN
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 06:40:24 +0000
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6ACCD3EE0C0
 for <kexec@lists.infradead.org>; Wed, 12 Nov 2014 15:39:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A1E1AC05FB
 for <kexec@lists.infradead.org>; Wed, 12 Nov 2014 15:39:57 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 25C511DB8042
 for <kexec@lists.infradead.org>; Wed, 12 Nov 2014 15:39:57 +0900 (JST)
Date: Wed, 12 Nov 2014 15:40:42 +0900 (JST)
Message-Id: <20141112.154042.59640143160036130.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, anderson@redhat.com

Currently, VMCOREINFO note information reports the virtual address of
phys_base that is assigned to symbol phys_base. But this doesn't make
sense because to refer to value of the phys_base, it's necessary to
get the value of phys_base itself we are now about to refer to.

Userland tools related to kdump such as makedumpfile and crash utility
so far have made some efforts to calculate phys_base from memory
mapping information on a variety of crash dump formats. But there's no
guarantee to keep maintaining it in the future.

This is also useful for crash dump mechanism running outside Linux
kernel such as virtual machine hypervisor such as qemu dump, which
ordinary users use via virsh dump, or ones implemented on vendor
specific firmware. They cannot get phys_base without special mechanism
because phys_base is kernel information.

To get VMCOREINFO in vmcore, it's easy to use strings and grep
commands like this; VMCOREINFO consists of simple string:

$ strings vmcore-3.10.0-121.el7.x86_64 | grep -E ".*VMCOREINFO.*" -A 100
VMCOREINFO
OSRELEASE=3.10.0-121.el7.x86_64
PAGESIZE=4096
...

Similarly, this is also useful to get value of phys_base in kdump 2nd
kernel contained in vmcore using the above-mentioned external crash
dump mechanism; kdump 2nd kernel is an inherently relocated kernel.

This commit doesn't remove VMCOREINFO_SYMBOL(phys_base) line because
makedumpfile refers to it and if removing it, old versions
makedumpfile doesn't work well.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4859810..e6d00a4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -334,6 +334,7 @@ void arch_crash_save_vmcoreinfo(void)
 #endif
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
 			      (unsigned long)&_text - __START_KERNEL);
+	VMCOREINFO_LENGTH(phys_base, phys_base);
 }
 
 /* arch-dependent functionality related to kexec file-based syscall */
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
