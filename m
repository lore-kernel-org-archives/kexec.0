Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WnmTu-00026I-Ot
 for kexec@lists.infradead.org; Fri, 23 May 2014 10:13:43 +0000
Date: Fri, 23 May 2014 18:14:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] x86: do not enable efi boot for sgi uv machine
Message-ID: <20140523101454.GA8608@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org, horms@verge.net.au, vgoyal@redhat.com


kexec/kdump uefi support depends on the 1:1 mapping scheme
in 3.14 kernel but SGI reported that 1:1 mapping does not work on
their UV system. thus there's below commit to switch back to
old ioremap way for sgi uv machines.

So for kexec-tools before we got the 1:1 mapping support on those
machines we should also use old way that means boot 2nd kernel
without uefi.

Tested on a uv1 machine.

Here is the kernel commit to quirk out SGI UV:
commit a5d90c923bcfb9632d998ed06e9569216ad695f3
Author: Borislav Petkov <bp@suse.de>
Date:   Tue Mar 4 17:02:17 2014 +0100

    x86/efi: Quirk out SGI UV
    
    Alex reported hitting the following BUG after the EFI 1:1 virtual
    mapping work was merged,
    
     kernel BUG at arch/x86/mm/init_64.c:351!
     invalid opcode: 0000 [#1] SMP
     Call Trace:
      [<ffffffff818aa71d>] init_extra_mapping_uc+0x13/0x15
      [<ffffffff818a5e20>] uv_system_init+0x22b/0x124b
      [<ffffffff8108b886>] ? clockevents_register_device+0x138/0x13d
      [<ffffffff81028dbb>] ? setup_APIC_timer+0xc5/0xc7
      [<ffffffff8108b620>] ? clockevent_delta2ns+0xb/0xd
      [<ffffffff818a3a92>] ? setup_boot_APIC_clock+0x4a8/0x4b7
      [<ffffffff8153d955>] ? printk+0x72/0x74
      [<ffffffff818a1757>] native_smp_prepare_cpus+0x389/0x3d6
      [<ffffffff818957bc>] kernel_init_freeable+0xb7/0x1fb
      [<ffffffff81535530>] ? rest_init+0x74/0x74
      [<ffffffff81535539>] kernel_init+0x9/0xff
      [<ffffffff81541dfc>] ret_from_fork+0x7c/0xb0
      [<ffffffff81535530>] ? rest_init+0x74/0x74
    
    Getting this thing to work with the new mapping scheme would need more
    work, so automatically switch to the old memmap layout for SGI UV.


Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -817,12 +817,25 @@ out:
 	return;
 }
 
+static int is_sgi_uv_machine(void)
+{
+	DIR *sgi_dir;
+
+	sgi_dir = opendir("/sys/firmware/sgi_uv");
+	if (sgi_dir) {
+		closedir(sgi_dir);
+		return 1;
+	}
+
+	return 0;
+}
+
 void setup_linux_system_parameters(struct kexec_info *info,
 				   struct x86_linux_param_header *real_mode)
 {
 	/* get subarch from running kernel */
 	setup_subarch(real_mode);
-	if (bzImage_support_efi_boot)
+	if (bzImage_support_efi_boot && !is_sgi_uv_machine())
 		setup_efi_info(info, real_mode);
 	
 	/* Default screen size */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
