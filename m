Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4914D6D22E
	for <kexec@archiver.kernel.org>; Wed, 27 Nov 2024 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+iHS09x/bUbYczSnY4CdvRzG4X74WBD5o3VDFQQU2k=; b=IC2HvlBAwTPfJMoNucWzmsPut+
	f6CDp0U+c5alpmgiSs2BhRLB5a0n0nxDvTUeCwdA9sOIvNLemY1b2urt2mwnJA1A30Lfzc1SyVmps
	NUboCVMK0HQnZ+x77f4K3KWMnLWgQUzSIH1culdaBfEYFgoCE84NRK6pyKloYTCDxJ/8ZmgeRxFV4
	VAmbWOU2CJGYC/0QQcpRrDSKw+NcVTET4Do+o65TW7qPDpea1wV+Zlyrbrik4lV5VTZDxsJtf02uV
	VnJ1/MftSTslyaz/pvSok9vJDfvvATm3CwoTdJiuhA9qx/c8OwKxsU4h2AOButmsThF3DPJg8aoDp
	2K5uYXHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKO-0000000Dt7t-1pj7;
	Wed, 27 Nov 2024 19:03:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKJ-0000000Dt0x-33Qr
	for kexec@bombadil.infradead.org;
	Wed, 27 Nov 2024 19:03:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3+iHS09x/bUbYczSnY4CdvRzG4X74WBD5o3VDFQQU2k=; b=hwA8++2g3fZuKG6TcF6+2Z8MXR
	vv1srmp07bw1OZBEmjW7Nyr999NAwYCUCnBgDbKLTc47bA6aMV6nYY66kYP/E6YX5OktmHI8d9+2M
	ylzFzpUUlQMsmPpOo5VuK1/W/gHWLtDZ71xcC1aZwmdsSZvnYKsNM/4kyces0cIZhgcZ0/8R4smES
	AYvF/9fSPjO+/xXh0XV01Pv8TpinHEuBzZIZVupR2ZVfLTQGOzQNa/podDMGBjImaHGQ1hzwYJ7Cv
	n/iDPvNfHCONX2ddihN7KZ+VeOB2Lx1EpKxp5Cp8bQr24l96y0WyqCNNXc5S8ItYHFmp2x3wf/CZL
	ZoVwJzgA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sue-188L;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BiQ-0B6E;
	Wed, 27 Nov 2024 19:03:46 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 05/20] x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
Date: Wed, 27 Nov 2024 19:00:19 +0000
Message-ID: <20241127190343.44916-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

The set_p4d() and set_pgd() functions (in 4-level or 5-level page table setups
respectively) assume that the root page table is actually a 8KiB allocation,
with the userspace root immediately after the kernel root page table (so that
the former can enforce NX on on all the subordinate pages, which are actually
shared).

However, users of the kernel_ident_mapping_init() code do not give it an 8KiB
allocation for its PGD. Both swsusp_arch_resume() and acpi_mp_setup_reset()
allocate only a single 4KiB page. The kexec code on x86_64 currently gets
away with it purely by chance, because it allocates 8KiB for its "control
code page" and then actually uses the first half for the PGD, then copies the
actual trampoline code into the second half only after the identmap code has
finished scribbling over it.

Fix this by defining a _PAGE_NOPTISHADOW bit (which can use the same bit as
_PAGE_SAVED_DIRTY since one is only for the PGD/P4D root and the other is
exclusively for leaf PTEs.). This instructs __pti_set_user_pgtbl() not to
write to the userspace 'shadow' PGD.

Strictly, the _PAGE_NOPTISHADOW bit doesn't need to be written out to the
actual page tables; since __pti_set_user_pgtbl() returns the value to be
written to the kernel page table, it could be filtered out. But there seems
to be no benefit to actually doing so.

Cc: stable@kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/pgtable_types.h | 8 ++++++--
 arch/x86/mm/ident_map.c              | 6 +++---
 arch/x86/mm/pti.c                    | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 6f82e75b6149..4b804531b03c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -36,10 +36,12 @@
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD) */
 #else
 /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD) */
 #endif
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
@@ -139,6 +141,8 @@
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
+#define _PAGE_NOPTISHADOW (_AT(pteval_t, 1) << _PAGE_BIT_NOPTISHADOW)
+
 /*
  * Set of bits not changed in pte_modify.  The pte's
  * protection key is treated like _PAGE_RW, for
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 437e96fb4977..5ab7bd2f1983 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -174,7 +174,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		if (result)
 			return result;
 
-		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
+		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 	}
 
 	return 0;
@@ -218,14 +218,14 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		if (result)
 			return result;
 		if (pgtable_l5_enabled()) {
-			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		} else {
 			/*
 			 * With p4d folded, pgd is equal to p4d.
 			 * The pgd entry has to point to the pud page table in this case.
 			 */
 			pud_t *pud = pud_offset(p4d, 0);
-			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		}
 	}
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a..5f0d579932c6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -132,7 +132,7 @@ pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 	 * Top-level entries added to init_mm's usermode pgd after boot
 	 * will not be automatically propagated to other mms.
 	 */
-	if (!pgdp_maps_userspace(pgdp))
+	if (!pgdp_maps_userspace(pgdp) || (pgd.pgd & _PAGE_NOPTISHADOW))
 		return pgd;
 
 	/*
-- 
2.47.0


