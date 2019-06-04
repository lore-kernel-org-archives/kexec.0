Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr760088.outbound.protection.outlook.com
 ([40.107.76.88] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hYBnV-000227-5i
 for kexec@lists.infradead.org; Tue, 04 Jun 2019 15:56:26 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
Date: Tue, 4 Jun 2019 15:56:14 +0000
Message-ID: <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
In-Reply-To: <20190604134952.GC26891@MiWiFi-R3L-srv>
Content-Language: en-US
Content-ID: <D13757902CD10A43859E451C8DC1BB6A@namprd12.prod.outlook.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 6/4/19 8:49 AM, Baoquan He wrote:
> Hi Tom,
> 
> Lianbo reported kdump kernel can't boot well with 'nokaslr' added, and
> have to enable KASLR in kdump kernel to make it boot successfully. This
> blocked his work on enabling sme for kexec/kdump. And on some machines
> SME kernel can't boot in 1st kernel.
> 
> I checked code of SME implementation, and found out the root cause. The
> above failures are caused by SME code, sme_encrypt_kernel(). In
> sme_encrypt_kernel(), you get a 2M of encryption work area as intermediate
> buffer to encrypt kernel in-place. And the work area is just after _end of
> kernel.

I remember worrying about something like this back when I was testing the
kexec support. I had come up with a patch to address it, but never got the
time to test and submit it.  I've included it here if you'd like to test
it (I haven't done run this patch in quite some time). If it works, we can
think about submitting it.

Thanks,
Tom

---
x86/mm: Create an SME workarea in the kernel for early encryption

From: Tom Lendacky <thomas.lendacky@amd.com>

The SME workarea used during early encryption of the kernel during boot
is situated on a 2MB boundary after the end of the kernel text, data,
etc. sections (_end).  This works well during initial boot of a compressed
kernel because of the relocation used for decompression of the kernel.
But when performing a kexec boot, there's a chance that the SME workarea
may not be mapped by the kexec pagetables or that some of the other data
used by kexec could exist in this range.

Create a section for SME in the vmlinux.lds.S.  Position it after "_end"
so that the memory will be reclaimed during boot and since it is all
zeroes it compresses well.  Since this new section will be part of the
kernel, kexec will account for it in pagetable mappings and placement of
data after the kernel.

Here's an example of a kernel size without and with the SME section:
	without:
		vmlinux:	36,501,616
		bzImage:	 6,497,344

		100000000-47f37ffff : System RAM
		  1e4000000-1e47677d4 : Kernel code	(0x7677d4)
		  1e47677d5-1e4e2e0bf : Kernel data	(0x6c68ea)
		  1e5074000-1e5372fff : Kernel bss	(0x2fefff)

	with:
		vmlinux:	44,419,408
		bzImage:	 6,503,136

		880000000-c7ff7ffff : System RAM
		  8cf000000-8cf7677d4 : Kernel code	(0x7677d4)
		  8cf7677d5-8cfe2e0bf : Kernel data	(0x6c68ea)
		  8d0074000-8d0372fff : Kernel bss	(0x2fefff)

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/vmlinux.lds.S      |   16 ++++++++++++++++
 arch/x86/mm/mem_encrypt_identity.c |   22 ++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..8c4377983e54 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -379,6 +379,22 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * SME workarea section: Lives outside of the kernel proper
+	 * (_text - _end) for performing in-place encryption. Resides
+	 * on a 2MB boundary to simplify the pagetable setup used for
+	 * the encryption.
+	 */
+	. = ALIGN(HPAGE_SIZE);
+	.sme : AT(ADDR(.sme) - LOAD_OFFSET) {
+		__sme_begin = .;
+		*(.sme)
+		. = ALIGN(HPAGE_SIZE);
+		__sme_end = .;
+	}
+#endif
+
 	STABS_DEBUG
 	DWARF_DEBUG
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 4aa9b1480866..c55c2ec8fb12 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -73,6 +73,19 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+/*
+ * This work area lives in the .sme section, which lives outside of
+ * the kernel proper. It is sized to hold the intermediate copy buffer
+ * and more than enough pagetable pages.
+ *
+ * By using this section, the kernel can be encrypted in place and we
+ * avoid any possibility of boot parameters or initramfs images being
+ * placed such that the in-place encryption logic overwrites them.  This
+ * section is 2MB aligned to allow for simple pagetable setup using only
+ * PMD entries (see vmlinux.lds.S).
+ */
+static char sme_workarea[2 * PMD_PAGE_SIZE] __section(.sme);
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -314,8 +327,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/* Set the encryption workarea to be immediately after the kernel */
-	workarea_start = kernel_end;
+	/*
+	 * We're running identity mapped, so we must obtain the address to the
+	 * SME encryption workarea using rip-relative addressing.
+	 */
+	asm ("lea sme_workarea(%%rip), %0"
+	     : "=r" (workarea_start)
+	     : "p" (sme_workarea));
 
 	/*
 	 * Calculate required number of workarea bytes needed:


> 
> This happens to work in 1st kernel. But it will fail kexec/kdump kernel
> absolutely. Because we load realmode/kernel/initrd in kexec-tools from
> top to down. In kexec-tools, realmode is put just after kernel image. If
> KASLR enabled, kernel may be randomized to other position, then kdump
> kernel can boot. However, if nokaslr specified, the 2M intermediate
> encryption workarea will definitely stump into the following realmode,
> and fail kexec/kdump kernel booting.
> 
> I have hacked kexec-tools code to put real mode area 4M away from the
> kernel image end, it works and confirm my finding. So the current SME
> in-place encryption way is not only a kexec/kdump issue, but also an
> issue in 1st kernel. Because KASLR could put kernel at the end of an
> available memory region, how to make sure the next 2M intermediate
> workarea must exist; if KASLR put kernel to be close to starting address
> of any cmdline/initrd/setup_data, how to make sure the gap between them
> must be larger than 2M.
> 
> Thanks
> Baoquan
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
