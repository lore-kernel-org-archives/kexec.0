Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8A0C3DA49
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1bIFZT5BD7fEz3sfb22Idreh/2VFZMFuToRynVIUuu4=; b=4wHrJECgxiuAQb
	YKC6f8IGzF1xN4Fq8JbvyYTYbV6A8LpdlIcidkb0YKas0E84KjJMizpkzcDtu6qE8B7T+Guc82e/f
	xndb8sco+wubbqgrcPl8VvZ+y9dxFiiPNceSkaJFfx7ccqfFw1iq2h+sit/WEWwgV0M4oyLhAJxW8
	lYOhY/zyOBxI3bJSZWc1WQQgka2ZfjY14q9z6L7V55azvQUMvTM90uEZ9LwJWKppUbih6Nuq8RDme
	ymJWEiUc1C7obmROLj9BtxRpX1Rhbsqqf4HAYB/Y3O8CXH7y/WnDOGiH9tzuSyCpdk93iRi5ZhUs2
	g/9rqX+LXQvrKRWvLy4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUN0e-0000000GVaN-040b;
	Thu, 18 Jul 2024 09:01:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUN0Y-0000000GVYQ-3SQJ
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 09:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hNfYZDiuxS1NyyJIIF1E+E75SCF0d1XgAjWnjU5K1g=;
	b=HFe+NrOZZJlD0ZSryZv4RDeHp/qBXuultfeqUhrv+u66mSjXLCgnLjzzUgpDNdmjhH4Xjm
	PRI5nk2otnLU+oHr7u2a7unpVHR3M6HMPrJFKSIenhSffwT4XHMfLZmU1BfRj+q2T1mGRg
	xkdgY8tMc1ZLH/1uYF3szaCZ//AZYf0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-D31q2u5bOAauFQDGlbOiXQ-1; Thu,
 18 Jul 2024 04:59:14 -0400
X-MC-Unique: D31q2u5bOAauFQDGlbOiXQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EF131955D5C;
	Thu, 18 Jul 2024 08:59:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13330300018A;
	Thu, 18 Jul 2024 08:59:02 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 6/7] arm64: kexec: Prepare page table for emulator
Date: Thu, 18 Jul 2024 16:57:56 +0800
Message-ID: <20240718085759.13247-7-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_020104_789980_B512B0CA 
X-CRM114-Status: GOOD (  24.60  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The emulator will run in identity mapping, and the first kernel prepares
for it. The special allocator resorts to kimage_alloc_control_pages(),
which can avoid the allocation on the spot of the destination and
overwritten during copying the kernel.

The identity mapping covers only all of the kexec segments, and this
reduces the memory consumption of page table.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 arch/arm64/kernel/machine_kexec.c | 90 +++++++++++++++++++++++++++++--
 include/linux/kexec.h             |  5 +-
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203d86a31..ae76874879188 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 #include <linux/reboot.h>
 #include <linux/set_memory.h>
 #include <linux/smp.h>
+#include <linux/efi_emulator.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -86,8 +87,22 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
 }
 
+/* todo: alloc page for the pgtable used by efi emulator in crashkernel range */
+static phys_addr_t crash_page_alloc(int unused, void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	int i;
+
+	//skip kimage->segment[].mem
+	for (i = 0; i < kimage->nr_segments; i ++) {
+		//seg = &kimage->segment[i];
+	}
+	//skip any range allocated
+	return -1;
+}
+
 /* Allocates pages for kexec page table */
-static void *kexec_page_alloc(void *arg)
+static void *__kexec_page_alloc(void *arg)
 {
 	struct kimage *kimage = arg;
 	struct page *page = kimage_alloc_control_pages(kimage, 0);
@@ -102,6 +117,69 @@ static void *kexec_page_alloc(void *arg)
 	return vaddr;
 }
 
+static phys_addr_t kexec_page_alloc(int unused, void *arg)
+{
+	void *vaddr;
+
+	vaddr = __kexec_page_alloc(arg);
+	if (!vaddr)
+		return (phys_addr_t)-1;
+	return virt_to_phys(vaddr);
+}
+
+/*
+ * This function should be called after all kimage segments have been profiled 
+ * Return physical address of page table's root
+ */
+phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage,
+		struct efi_emulator_param *param)
+{
+	struct kexec_segment *seg;
+	unsigned long paddr, sz;
+	pgd_t *pgd;
+	typedef phys_addr_t (* alloc_fn)(int, void *);
+	alloc_fn alloc;
+	phys_addr_t pgd_paddr;
+	int i;
+
+	/*
+	 * Set up pgtable of emulator, either for crash or for reboot.
+	 * All of the segments have been profiled, and kimage_alloc_normal_control_pages()
+	 * will allocate page in safe zone.
+	 * On the other hand, these pages are not in any segment, which means they are
+	 * left, not copied. Hence the radix tree laying out on them is not broken.
+	 */
+	if (kimage->head & IND_DONE)
+		alloc = crash_page_alloc;
+	else
+		alloc = kexec_page_alloc;
+	pgd_paddr = alloc(0, kimage);
+	pgd = (pgd_t *)phys_to_virt(pgd_paddr);
+	for (i = 0; i < kimage->nr_segments; i ++) {
+		seg = &kimage->segment[i];
+		paddr = ALIGN_DOWN(seg->mem, PAGE_SIZE);
+		sz = ALIGN(seg->mem - paddr + seg->memsz, PAGE_SIZE);
+		kexec_dprintk("Set up mapping for phyaddr: 0x%lx, size:0x%lx", paddr, sz);
+		//todo: distinguish executable segment
+		__create_pgd_mapping_locked(pgd, paddr, paddr, sz,
+				PAGE_KERNEL_EXEC, alloc, kimage, 0);
+	}
+
+	/*
+	 * Per UEFI specification, SetVirtualAddressMap() is oneshot, which means
+	 * efi stub should not call EFI runtime service without setting up mapping.
+	 * As a result, emulator does not need to set up the mapping for
+	 * EFI_RUNTIME_SERVICES_CODE etc.
+	 */
+
+	if (param->print_enabled)
+		__create_pgd_mapping_locked(pgd, param->earlycon_reg_base,
+				param->earlycon_reg_base, param->earlycon_reg_sz,
+				pgprot_device(PAGE_KERNEL), alloc, kimage, 0);
+
+	return pgd_paddr;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	int rc;
@@ -109,7 +187,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	long reloc_size;
 	struct trans_pgd_info info = {
-		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_page	= __kexec_page_alloc,
 		.trans_alloc_arg	= kimage,
 	};
 
@@ -129,7 +207,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	}
 
 	/* Create a copy of the linear map */
-	trans_pgd = kexec_page_alloc(kimage);
+	trans_pgd = __kexec_page_alloc(kimage);
 	if (!trans_pgd)
 		return -ENOMEM;
 	rc = trans_pgd_create_copy(&info, &trans_pgd, PAGE_OFFSET, PAGE_END);
@@ -145,6 +223,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 				  &kimage->arch.t0sz, reloc_code);
 	if (rc)
 		return rc;
+
 	kimage->arch.phys_offset = virt_to_phys(kimage) - (long)kimage;
 
 	/* Flush the reloc_code in preparation for its execution. */
@@ -175,7 +254,6 @@ void machine_kexec(struct kimage *kimage)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	pr_info("Bye!\n");
-
 	local_daif_mask();
 
 	/*
@@ -192,7 +270,8 @@ void machine_kexec(struct kimage *kimage)
 
 		cpu_install_idmap();
 		restart = (void *)__pa_symbol(cpu_soft_restart);
-		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
+		/* kimage->start can be either the entry of kernel or efi emulator */
+		restart(is_hyp_nvhe(), kimage->start, kimage->arch.param_mem,
 			0, 0);
 	} else {
 		void (*kernel_reloc)(struct kimage *kimage);
@@ -201,6 +280,7 @@ void machine_kexec(struct kimage *kimage)
 			__hyp_set_vectors(kimage->arch.el2_vectors);
 		cpu_install_ttbr0(kimage->arch.ttbr0, kimage->arch.t0sz);
 		kernel_reloc = (void *)kimage->arch.kern_reloc;
+		//tell between the emulator and normal kernel inside the relocate code 
 		kernel_reloc(kimage);
 	}
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index cff6b6869498b..c68427f796d31 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -22,6 +22,7 @@
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
+#include <linux/efi_emulator.h>
 
 extern note_buf_t __percpu *crash_notes;
 
@@ -463,7 +464,9 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage);
+extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage,
+		struct efi_emulator_param *param);
+
 extern bool kexec_file_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
