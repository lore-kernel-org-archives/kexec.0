Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC01C46CD2
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bt22gkelGroVSCpoNqsXOH2hBFQ6N9T50IBKlatp174=; b=aeKYuin/rxp7wW
	FQrDNxuoI5AjNOQ2K29bC5npxyJkXbJxWAhSpqmFt4kEUWK1RAYo5Y5MVqQtmzvmaudT4BcSSgmvw
	+f6IsuvYXV1YN3dIkrfRdlDXJ7Q9nbZz7IIQgq7ayRhJ6VZITHw4YIDprZSxarznpy/ZEjANC+EMF
	Bl+awk2EakwGQP8ckv+UwAYwsKS9kGwhfbIqkSAwHK349XMRgwoVSrS0zKklBiYAmYs3ip/Yd967U
	R52YcAg6CJfQdIMh3mxYDKQ7YUn6pPY1bFu8lmS8ruEGsc+EU6Yj68b2tNsWsoW3tdxoC1oALAWJL
	w81Zn+V3mqO3fPYXu4Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpK3-0073Fw-1x;
	Fri, 22 Dec 2023 23:52:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpK0-0073C2-2I
	for kexec@bombadil.infradead.org;
	Fri, 22 Dec 2023 23:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=91ymazoo0RKRu9k17Ba4s4AasV5hBx6Nfj64CPYL1NU=; b=T5f4TsPBhK99VRjESFpOOCqxS9
	BV1ZvVtjtlRQjDFZjd3e2Y6csaA3TWL9tK+aA+tv+6AUQc0/Px7i9zwfPVKkOIQMtzAIO2m7D313u
	FCnUuIlo0bjZ9zvOSFK4x8ydjpQfiSQXXk0anXleIpnoo4VcQzXWdmyXxes9qPCd6wmYYH5M47CtT
	2mjc6Rfrnomq4QMT2AVdfv6kWcDsrkkrroSDEpvVE497gHrzkVVGGq9ik4ATNvfmThBvra9Mp9/YY
	ChPpbi3xS7Mk9vfNX4XZXrJpsrJxYZOOgV+lLUItECxGukyhQQbyL0uMJxG8i6ISZFqM/Q7M66HeZ
	XfsXxoSQ==;
Received: from mgamail.intel.com ([192.198.163.10])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJv-00FQML-15
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 23:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289167; x=1734825167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0KNXcx7kYiuLNhk2lubKN7E5oHJBEIlL2/mP4OOsUg=;
  b=Q9XTIFJtNUKxxfpD3SgBQXJsPUfXqAymNWlUcGw/9n4RbcIySalJHkZt
   m0XMbA6q+XvPend6wCyqviBu3rx7iORLnRDEF5WZ0JiZNrdpb3notRVyW
   cfNsKirRXpYJRRWyf3ToGzc8DG2lGVq/e6RUuv1dpb61Vp26rLtIBdzDW
   tnbPuWmtA+YYiAlUeaXkk6meoEXmf2JVyxlKwnuMfBk/+nBhCVm4DrQmZ
   Fyd8jUL+gbLjuVCNPS0FIHHPauKc1yvjhhiZVqftlSPj7sNLW1HhaAjI1
   8IR98H0quto6jueBLjOAian9/kup2I/F160YFH5NuC5La74+APgPGnRW2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3414390"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3414390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="726961507"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="726961507"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.35.180])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:29 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 7502410A4E1; Sat, 23 Dec 2023 02:52:12 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Date: Sat, 23 Dec 2023 02:52:07 +0300
Message-ID: <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_235249_101069_57EC56EB 
X-CRM114-Status: GOOD (  15.09  )
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

The helper complements kernel_ident_mapping_init(): it frees the
identity mapping that was previously allocated. It will be used in the
error path to free a partially allocated mapping or if the mapping is no
longer needed.

The caller provides a struct x86_mapping_info with the free_pgd_page()
callback hooked up and the pgd_t to free.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/init.h |  3 ++
 arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index cc9ccf61b6bd..14d72727d7ee 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -6,6 +6,7 @@
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
+	void (*free_pgt_page)(void *, void *); /* free buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
 	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
 	unsigned long offset;		 /* ident mapping offset */
@@ -16,4 +17,6 @@ struct x86_mapping_info {
 int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 				unsigned long pstart, unsigned long pend);
 
+void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
+
 #endif /* _ASM_X86_INIT_H */
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..3996af7b4abf 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -4,6 +4,79 @@
  * included by both the compressed kernel and the regular kernel.
  */
 
+static void free_pte(struct x86_mapping_info *info, pmd_t *pmd)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+
+	info->free_pgt_page(pte, info->context);
+}
+
+static void free_pmd(struct x86_mapping_info *info, pud_t *pud)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_present(pmd[i]))
+			continue;
+
+		if (pmd_leaf(pmd[i]))
+			continue;
+
+		free_pte(info, &pmd[i]);
+	}
+
+	info->free_pgt_page(pmd, info->context);
+}
+
+static void free_pud(struct x86_mapping_info *info, p4d_t *p4d)
+{
+	pud_t *pud = pud_offset(p4d, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (!pud_present(pud[i]))
+			continue;
+
+		if (pud_leaf(pud[i]))
+			continue;
+
+		free_pmd(info, &pud[i]);
+	}
+
+	info->free_pgt_page(pud, info->context);
+}
+
+static void free_p4d(struct x86_mapping_info *info, pgd_t *pgd)
+{
+	p4d_t *p4d = p4d_offset(pgd, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (!p4d_present(p4d[i]))
+			continue;
+
+		free_pud(info, &p4d[i]);
+	}
+
+	if (pgtable_l5_enabled())
+		info->free_pgt_page(pgd, info->context);
+}
+
+void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (!pgd_present(pgd[i]))
+			continue;
+
+		free_p4d(info, &pgd[i]);
+	}
+
+	info->free_pgt_page(pgd, info->context);
+}
+
 static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
 			   unsigned long addr, unsigned long end)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
