Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7IPP-0008Hm-Sj
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 11:32:25 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 098/230] x86/kexec: Dont setup EFI info if EFI runtime is
 not enabled
Date: Fri, 22 Mar 2019 12:13:56 +0100
Message-Id: <20190322111243.491677243@linuxfoundation.org>
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, David Howells <dhowells@redhat.com>, Yannik Sembritzki <yannik@sembritzki.me>, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>, Philipp Rudo <prudo@linux.vnet.ibm.com>, bhe@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, x86-ml <x86@kernel.org>, robert.moore@intel.com, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, erik.schmauss@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, Thomas Gleixner <tglx@linutronix.de>, Kairui Song <kasong@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2aa958c99c7fd3162b089a1a56a34a0cdb778de1 ]

Kexec-ing a kernel with "efi=noruntime" on the first kernel's command
line causes the following null pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  #PF error: [normal kernel read fault]
  Call Trace:
   efi_runtime_map_copy+0x28/0x30
   bzImage64_load+0x688/0x872
   arch_kexec_kernel_image_load+0x6d/0x70
   kimage_file_alloc_init+0x13e/0x220
   __x64_sys_kexec_file_load+0x144/0x290
   do_syscall_64+0x55/0x1a0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Just skip the EFI info setup if EFI runtime services are not enabled.

 [ bp: Massage commit message. ]

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: bhe@redhat.com
Cc: David Howells <dhowells@redhat.com>
Cc: erik.schmauss@intel.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com
Cc: robert.moore@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190118111310.29589-2-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 0f8a6bbaaa44..0bf17576dd2a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -168,6 +168,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-- 
2.19.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
