Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17313C982EE
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xCjTdloxc6nkdYmhJBIoS65cvexU8uxkyprCbgscSQ=; b=QRJ+4Py5Pziz8b5x6IKu9vJm4m
	X7hhQ5apjl9WSFiyjKJbKhJkueiK5fuGgozrMCnBhb8nlMtUt3ssNkA12nci7E5lKgZo8fZWalAHk
	Xy7IE5C09MBppqeeEvoRYfQd7oVw53aDP5YxPDXvoxQLUbBzfmlmIOMJPmVfvbzuPPIQNiikcJ7Ci
	ELZ2hcrwcFv7PPhRm9HzQw6CLXI4f8/f/3tgDOwV6Iteq1OJ2casnTIGOkJ5r0d8IyIh0n16aGPFp
	WcBs5fecfR+LVyXP5vrZV/p57+26/ykPAO9F1hll3ydPvaOCQY8LVpajQWruZHm/sUf1K2zBkhIy8
	1zAmVXFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O55-00000000O40-3kye;
	Sun, 20 Sep 2026 20:24:11 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NOP-00000000JIK-3WOy
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:40:08 +0000
Received: by mail-yx2-x11.google.com with SMTP id 00721157ae682-85d43db0c16so16390187b3.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933205; x=1790538005; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+xCjTdloxc6nkdYmhJBIoS65cvexU8uxkyprCbgscSQ=;
        b=blgxQtlg+jC7qw7hxA6kDThxLtO8RARuOg0WU6avkPOXrvEb2ekHbX0KiW3S6P4ihC
         gf+9w4toxdhaQAgCKlEdHlEWjIuMmC+C5Jz8E6Ubp/LDMoYK97GuvJPo7ge3940QylsG
         KdJ9HnURS5FI7AsVosJxDZfRnP9jAEWRyczNmDiF9IHiriq1LujqVIO4E6UYF3B/Ko2j
         lh7mp6YVfmwquhz2mwfVm/ArV6+vtflLr/M/AjictAXnHKTJN1l4B0tMG4qwy76vPV7l
         eEpD5G2bX+kOsw6QqXAvHR16PF9T+LzrzegL0nRJ0ZP4s8ZLcjMdI2dFNy3mznlo1xBv
         Zr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933205; x=1790538005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+xCjTdloxc6nkdYmhJBIoS65cvexU8uxkyprCbgscSQ=;
        b=NcGRpeOKH70vCbUmMy4cWWIAC5eL4sIwyHHBIQJ9RqHg4T+kNuUqjBzuwpPpdxc5wU
         WtB9YR3UXoOFIONNO57ywrvpy8CimtDDQXUurVOsWDtNy+ULN6EQtwJtcyr78GxAT/eV
         /YKJVfTb3af+gTUBsXsCH9OOBrf6FCP7Lhnjpjw/AURoVdjdFe85GXU1WPskxb2q5TxH
         l6SOZoZuEoLycw6FZhGgDqQK3wP2OID8vZugxfw/CUaTk/11QCY86BYNEDCtNtwSG/cu
         HxPbzacWfDKRCA9suucf/+K5mjyiNdsFiEofqly61P5w1yliUTP3I1lLOfuYXG97/tJk
         agew==
X-Forwarded-Encrypted: i=1; AKwUvByLDbzMKoj/v+KDYo/1d7Gwvae9NxtDgXMh3XllfFzwaC+WMoUjcuhwnafPz4B+P1XRiBXBGw==@lists.infradead.org
X-Gm-Message-State: AFuF++krslVUMjK+fNkkwHAnrYKsSqYeg0khLMgY90QhmqBUJET28/PO
	Z2TjqSPUkvfX2UB6JqtiP5ROvgjw4M18VGgs1zAi3Vq4SijGTRSiYG9bu0tD081PLkw=
X-Gm-Gg: AYBFou2V9VDLUCRuWpTZzgEutVmA+ngGlRokY4eTNCTUg9iTdosEfLa7kP8MxSW+mz0
	KfGm4eNFEEULmUZwmKpNE4+lv6BK1kSQS/iUTUGgWXm+eR9Y3pNmNRYIujTYEwpU4fGW7hsaJVk
	O0Js86hhXZeoibJSGXs1eu2R8SV2hcEJyVyHnBsI6tk8+I1I6xMOp1LVQa0c9BAa2d8Kpy/o6F+
	kUhmRcWFr3fesAui8e8ZKHiCJ4z2y2tFL2K/WedsJzvlWcrBEA7a/4tTomDxcJ1YO+a0vt1uHu6
	yeHSbF+8ykTmw947M81Twy2YJ8pRDgJHcv2m5oCZzpyMVzhA77KRWJ6ISeb76fj/ZjyCdOeBu7k
	Lu7Z4g2faZ3kcwFaZTQDddhgv6pf51PCV7IvVCO2Dm6uEqvkfVb/rVkE9a08i1rw47BGeKxK+Cj
	5ErGqhgIFs3EPt9xB1ssT9pLLB2Cs/xotWMMPLvsg05MlN9lWBSmknlvJxLvPvjfMndwRolfwPa
	/942/m51zObyiTDT9u55ua9xCbfmBE3X4dAhfA6NHH53R26h9tcFNgDD3srVdgc+qT5V44cKzmi
	sAjsUkSgOoI4CoNdHlg=
X-Received: by 2002:a05:690c:d8b:b0:873:5c6b:a2ff with SMTP id 00721157ae682-89736f266a6mr23324237b3.45.1789933204717;
        Sun, 20 Sep 2026 12:40:04 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8de3fsm18926787b3.8.2026.09.20.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:40:04 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 32/46] KVM: x86: Add TDP MMU KHO preservation helpers
Date: Sun, 20 Sep 2026 15:36:36 -0400
Message-ID: <20260920193650.3373435-33-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_124005_944723_C0E0EB3C 
X-CRM114-Status: GOOD (  21.33  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add arch/x86/kvm/mmu/kho.c to preserve and adopt TDP MMU EPT/NPT
root page tables across Kexec Handover (KHO) live updates.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/mmu.h     |   7 ++
 arch/x86/kvm/mmu/kho.c | 193 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/x86/kvm/mmu/kho.c

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..f35948f0906c 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -410,4 +410,11 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn & kvm_gfn_direct_bits(kvm);
 }
+
+/*
+ * Declared here rather than in asm/kvm_host.h: it is internal to
+ * arch/x86/kvm and has no callers outside it.  Defined in mmu/kho.c.
+ */
+int kvm_mmu_preserve_kho(struct kvm *kvm);
+
 #endif
diff --git a/arch/x86/kvm/mmu/kho.c b/arch/x86/kvm/mmu/kho.c
new file mode 100644
index 000000000000..a04600f0c3e0
--- /dev/null
+++ b/arch/x86/kvm/mmu/kho.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * KHO preservation of the x86 KVM MMU page tables.
+ *
+ * An orphaned vCPU keeps running its guest out of the shadow/TDP page tables
+ * while the VM is detached, so every page those tables are built from has to
+ * survive the kexec.
+ */
+
+#include <linux/kexec_handover.h>
+#include <linux/kvm_host.h>
+
+#include "mmu.h"
+#include "mmu_internal.h"
+#include "spte.h"
+#include "tdp_iter.h"
+#include "tdp_mmu.h"
+
+/*
+ * Page-pointer accumulator.
+ *
+ * kho_preserve_pages() cannot be called while holding kvm->mmu_lock: it is a
+ * rwlock_t, so the section is atomic, whereas kho_radix_add_key() below it
+ * calls might_sleep(), takes a mutex and allocates with GFP_KERNEL.  So the
+ * walk runs in two phases -- collect the pages under the lock, preserve them
+ * after dropping it.
+ *
+ * A NULL @pages simply counts, which is how the caller sizes the array.
+ */
+struct kvm_mmu_kho_pages {
+	struct page **pages;
+	unsigned long nr;
+	unsigned long capacity;
+	bool overflow;
+};
+
+static void kvm_mmu_kho_add(struct kvm_mmu_kho_pages *acc, struct page *page)
+{
+	if (!acc->pages) {
+		acc->nr++;
+		return;
+	}
+
+	if (acc->nr >= acc->capacity) {
+		acc->overflow = true;
+		return;
+	}
+
+	acc->pages[acc->nr++] = page;
+}
+
+static void kvm_tdp_mmu_collect(struct kvm *kvm,
+				struct kvm_mmu_kho_pages *acc)
+{
+	gfn_t end = kvm_mmu_max_gfn() + 1;
+	struct kvm_mmu_page *root;
+	struct tdp_iter iter;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(root, &kvm->arch.tdp_mmu_roots, link) {
+		if (root->spt)
+			kvm_mmu_kho_add(acc, virt_to_page(root->spt));
+
+		for_each_tdp_pte(iter, kvm, root, 0, end) {
+			struct page *page;
+
+			if (!is_shadow_present_pte(iter.old_spte) ||
+			    is_last_spte(iter.old_spte, iter.level))
+				continue;
+
+			page = pfn_to_page(spte_to_pfn(iter.old_spte));
+			kvm_mmu_kho_add(acc, page);
+		}
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * The per-vCPU root page tables are not linked into active_mmu_pages, so they
+ * have to be walked separately.  pae_root, pml4_root and pml5_root are each
+ * NULL unless the corresponding paging mode is in use.
+ */
+static void kvm_mmu_collect_roots(struct kvm_mmu *mmu,
+				  struct kvm_mmu_kho_pages *acc)
+{
+	void *const roots[] = { mmu->pae_root, mmu->pml4_root, mmu->pml5_root };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(roots); i++) {
+		if (roots[i])
+			kvm_mmu_kho_add(acc, virt_to_page(roots[i]));
+	}
+}
+
+/* Collect every page backing this VM's MMU.  Must be called under mmu_lock. */
+static void kvm_mmu_collect_all(struct kvm *kvm,
+				struct kvm_mmu_kho_pages *acc)
+{
+	struct kvm_mmu_page *sp;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	acc->nr = 0;
+	acc->overflow = false;
+
+	if (tdp_mmu_enabled)
+		kvm_tdp_mmu_collect(kvm, acc);
+
+	list_for_each_entry(sp, &kvm->arch.active_mmu_pages, link) {
+		if (sp->spt)
+			kvm_mmu_kho_add(acc, virt_to_page(sp->spt));
+	}
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.mmu)
+			kvm_mmu_collect_roots(vcpu->arch.mmu, acc);
+		kvm_mmu_collect_roots(&vcpu->arch.guest_mmu, acc);
+	}
+}
+
+int kvm_mmu_preserve_kho(struct kvm *kvm)
+{
+	struct kvm_mmu_kho_pages acc = {};
+	struct kvm_kho_folios_ser *kp;
+	unsigned long i;
+	int ret = 0;
+	int attempt;
+
+	/*
+	 * Size the array, then fill it.  The guest can fault in new page
+	 * tables between the two passes, so re-check for overflow and retry
+	 * with a larger array; the slack makes repeated growth unlikely.
+	 */
+	for (attempt = 0; attempt < 5; attempt++) {
+		write_lock(&kvm->mmu_lock);
+		kvm_mmu_collect_all(kvm, &acc);
+		write_unlock(&kvm->mmu_lock);
+
+		if (acc.pages && !acc.overflow)
+			break;
+
+		acc.capacity = acc.nr + (acc.nr >> 2) + 16;
+		kvfree(acc.pages);
+		acc.pages = kvmalloc_array(acc.capacity, sizeof(*acc.pages),
+					   GFP_KERNEL);
+		if (!acc.pages)
+			return -ENOMEM;
+	}
+
+	if (acc.overflow) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	if (!acc.nr)
+		goto out;
+
+	kp = kvm_kho_folios_alloc(acc.nr);
+	if (IS_ERR(kp)) {
+		ret = PTR_ERR(kp);
+		goto out;
+	}
+
+	for (i = 0; i < acc.nr; i++) {
+		ret = kho_preserve_folio(page_folio(acc.pages[i]));
+		if (ret) {
+			/*
+			 * Undo the partial preservation: leaving pages marked
+			 * would pin them in the incoming kernel forever with
+			 * nothing owning them.
+			 */
+			while (i--)
+				kho_unpreserve_folio(page_folio(acc.pages[i]));
+			kho_unpreserve_free(kp);
+			goto out;
+		}
+		kp->folios_pa[i] = page_to_phys(acc.pages[i]);
+	}
+
+	kp->nr_folios = acc.nr;
+	kvm->kho_folios = kp;
+
+out:
+	kvfree(acc.pages);
+	return ret;
+}
-- 
2.55.0.1082.g2b9226bbc0-goog


