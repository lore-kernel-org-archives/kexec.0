Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hLNRa-0002cC-Of
 for kexec@lists.infradead.org; Tue, 30 Apr 2019 07:44:52 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/3 v3] x86/kexec: Do not map the kexec area as decrypted when
 SEV is active
Date: Tue, 30 Apr 2019 15:44:19 +0800
Message-Id: <20190430074421.7852-2-lijiang@redhat.com>
In-Reply-To: <20190430074421.7852-1-lijiang@redhat.com>
References: <20190430074421.7852-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

When a virtual machine panic, also need to dump its memory for analysis.
But, for the SEV virtual machine, the memory is encrypted. To support
the SEV kdump, these changes would be necessary, otherwise, it will not
work.

Lets consider the following situations:

[1] How to load the images(kernel and initrd) when SEV is enabled in the
    first kernel?

    Based on the amd-memory-encryption.txt and SEV's patch series, the
    boot images must be encrypted before guest(VM) can be booted(Please
    see Secure Encrypted Virutualization Key Management 'Launching a
    guest(usage flow)'). Naturally use the similar way to load the images
    (kernel and initrd) to the crash reserved areas, and these areas are
    encrypted when SEV is active.

    That is to say, when SEV is active in the first kernel, need to load
    the kernel and initrd to the encrypted areas, so i made the following
    changes:

    [a] Do not map the kexec area as decrypted when SEV is active.
        Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
        maps the kexec areas as decrypted. Obviously, for the SEV case, it
        can not work well, need to improve them.

    [b] Set the C-bit in the identity map page table when SEV is active.
        Because the second kernel images(kernel and initrd) are loaded to
        the encrypted areas, in order to correctly access these encrypted
        memory(pages), need to set the C-bit in the identity mapping page
        table when kexec builds the identity mapping page table.

[2] How to dump the old memory in the second kernel?

    Here, it is similar to the SME kdump, if SEV was enabled in the first
    kernel, the old memory is also encrypted, the old memory has to be
    remapped with memory encryption mask in order to access it properly.

    [a] The ioremap_encrypted() is still necessary.
        Used to remap the old memory with memory encryption mask.

    [b] Enable dumping encrypted memory when SEV was active.
        Because the whole memory is encrypted in the first kernel when SEV
        is enabled, that is to say, the notes and elfcorehdr are also
        encrypted, and they are also saved to the encrypted memory.
        Following commit 992b649a3f01 ("kdump, proc/vmcore: Enable kdumping
        encrypted memory with SME enabled"), both SME and SEV cases need to
        be considered and modified correctly.

As above mentioned, currently, the arch_kexec_post_{alloc,free}_pages()
unconditionally maps the kexec area as decrypted. Lets make sure that
arch_kexec_post_{alloc,free}_pages() does not clear the memory encryption
mask from the kexec area when SEV is active.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..f60611531d17 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -559,18 +559,33 @@ void arch_kexec_unprotect_crashkres(void)
 	kexec_mark_crashkres(false);
 }
 
+/*
+ * During a traditional boot under SME, SME will encrypt the kernel,
+ * so the SME kexec kernel also needs to be un-encrypted in order to
+ * replicate a normal SME boot.
+ * During a traditional boot under SEV, the kernel has already been
+ * loaded encrypted, so the SEV kexec kernel needs to be encrypted in
+ * order to replicate a normal SEV boot.
+ */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
+	if (sev_active())
+		return 0;
+
 	/*
 	 * If SME is active we need to be sure that kexec pages are
 	 * not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
+
 }
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
+	if (sev_active())
+		return;
+
 	/*
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
