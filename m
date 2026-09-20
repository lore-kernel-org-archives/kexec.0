Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC32C982EE
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i5nAPiFxyuCO/MgJOwL1aiw4E3m2Ng0EpjBlpOl2sok=; b=ez006ZD5vERg7JzCFwmEghZchF
	H5PK/viMvQCb3qqNBSwg9qDX92zknWtBRdK503zIepNzuq5jH9O1emyvIzNBSVNnm2neZ3dHEOTFA
	vaP1mqnk8nlUJOrclTJQW1xkozNahPbB4VtDwuFH/WisthWwbGiWjs76BghkY4RspAjGsDCKSSMWw
	dYc1VLI9EMlLLTybjmkWP4zI+GSLFFUtKTjNeGnrA/dgDTE2gSxzwLk/HlE9SjJ2F0M8SJkEFePMv
	lzurfTgFUFWl8x3q0XsvTlhvjrMjsY1OUN9hz6cjd0YGthCKf4LQdIb629oJLwrHsaF1SK3o7zvaQ
	ivKBX8tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4M-00000000MFh-1sYH;
	Sun, 20 Sep 2026 20:23:26 +0000
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NLp-00000000IPO-2uym
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:27 +0000
Received: by mail-yx2-x0e.google.com with SMTP id 00721157ae682-895eaf306cfso17214867b3.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933045; x=1790537845; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i5nAPiFxyuCO/MgJOwL1aiw4E3m2Ng0EpjBlpOl2sok=;
        b=Q2VcItlIc55JW0Jr1xL+0YvHG+nJ4p3ELdeBjwR6L0LdY11KNAtXu7gyCajyMPukuw
         bd2Hvqw6BLY4T1oHt858bVqMU23QNw6P+dmXdE3dXyof830RH5411JOrgiEcaul4jR0f
         yYwhgqLoq4C2lDkVuWUVzSi+2gX4Xh17w4Nr7t42V3LcH4u9itFJ7Xt0J8y1haRqbd4v
         hk1WCywWwKw/DBY1xxMii8gvd3GA8nAAUmz8M/pTr/rOrL67WCyZP9M0FyTGG4EvdYUF
         +GR7hzGa1Zr5Pbye9sqzoauCEtQ+2UPE7FA8G/qNEl4KY6Jn0k8tYHMMLyELuj8oBtX1
         1YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933045; x=1790537845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i5nAPiFxyuCO/MgJOwL1aiw4E3m2Ng0EpjBlpOl2sok=;
        b=KOo5HpsxKClXr6YB5e1UsE0s5JqOCcTjdVYXwyMb1dj/vldDhK1hMeYvU7fVkdLuMv
         /BR4s9rYWRumFliaTjUAbGSN7gnMfojsTwgn9wQlEGO9uB+qtLc+LfGb9S4TLbTFjlUr
         wAMt5CnEJ2QaWMDneGfxDzARycP7Pr77ARUcNzuDbIkcgU5MkAYW/ym1QgCRFXIY4pCN
         6WTDP+fEz3B2cePmfpTNyXBH64zFyIpRKJyXrPodapmKAKlK2taGmkSx+0iEzelzZyLd
         4OuOkaDFHUMm61ch47X7axD1Xlogl3Myf5Wn/zpl0+szTnSrJOFH2JtGH8jOUUnizHEq
         PVuA==
X-Forwarded-Encrypted: i=1; AKwUvBxmxheFINxkAsqO1NNActsfhmqAIh8y/EdEQK7Ebm1fkp/kdGzU78ECff66L/QAd0vxgP94fQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nIavp0wpYzV8S5uBxEHKsVZnvTxb4lUgRz5/2QXreum/y5PQHf
	GGQ9nGq9e/supPM5lEcgvoya7bsqG+XLFsYaxVBOfRH986HLsXam6PfUl1eDXIzYMQw=
X-Gm-Gg: AYBFou1f74m6nr3xaFuFZtoF/QCK8g/nLRWWc2Ru5OouBuppfprWlGFiEvuLyWgSGQH
	eVnkWeZIhDIpiVR1eSysVewGz7PITOuQ5MdjIlXV8/mUVoyy5OpuhTafp1P9nIlzz+K0YpqbVZ9
	c7Va5M7YpRKfKvHUne8sXbW2jhNFloFC/f+VsMFNuXSe0QySwYUgbnRYg9szW0j2wW38bdB9rNO
	4Yxg+BNMWjfQZE+tNQFl6bOMIF7NmljNo8DdkutOhSAGQgfmr7Hup9Tr7eJ3vYl5b2ET5bJ+IIW
	lyCpOCD9zLNbW6S/nLGb1WkR7kK2N3q++tBDNQ6B5XiJz3dh7FCvymWkBNMoosoVpmU0SdZTLVs
	f/8w0d1W1j8FeQgo2NpCfrHlXyERnHDXe1UrDf0/4kyTfvbAMqn+96pAlHVwRiArd0Vr9eQwiB5
	Z9EH2whmKLS9lgWq0ks5lt+9fNJK1wKXp3SrnmfeYpbRapK21uebOx5F7SJEkzNitGmagT83u1y
	Itzm+8f0r66c4CVmuhBnSU1QRjJZ4VKu7eUDB+1jhBmlF7Jj9WC47GNy2oYMZTgXDbr6guYvOpA
	EkusuP/ZDE1KyGoABXU=
X-Received: by 2002:a05:690c:e297:20b0:870:f53:4edd with SMTP id 00721157ae682-897305168b0mr18683667b3.7.1789933044691;
        Sun, 20 Sep 2026 12:37:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a48aab042sm18597427b3.47.2026.09.20.12.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:24 -0700 (PDT)
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
Subject: [RFC PATCH 05/46] arm64: mm: Add trans_pgd_map_range() support
Date: Sun, 20 Sep 2026 15:36:09 -0400
Message-ID: <20260920193650.3373435-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123726_729581_2AB451A3 
X-CRM114-Status: GOOD (  12.31  )
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

Introduce trans_pgd_map_range() to allow mapping arbitrary physical
memory ranges into transitional page tables.

This helper allocates intermediate translation levels (P4D, PUD, PMD,
and PTE) on demand using the trans_pgd allocator, enabling precise
virtual-to-physical address mappings in transitional contexts such as
isolated execution environments.

Add comprehensive kernel documentation detailing the isolated page
table mappings: Caretaker text/rodata (ROX), writable data (RW),
stacks (RW), and preserved buffers without cloning the direct map.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  4 ++
 arch/arm64/mm/trans_pgd.c          | 70 ++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 033d400a4ea4..1e17ae145b0c 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -30,6 +30,10 @@ struct trans_pgd_info {
 int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
 			  unsigned long start, unsigned long end);
 
+int trans_pgd_map_range(struct trans_pgd_info *info, pgd_t *trans_pgd,
+			phys_addr_t pa, unsigned long va, size_t size,
+			pgprot_t prot);
+
 int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 			 unsigned long *t0sz, void *page);
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index cca9706a875c..f0a55d4270cc 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -200,6 +200,76 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
 	return rc;
 }
 
+/**
+ * trans_pgd_map_range - Map a physical address range into a transition page table
+ * @info: Transition page table allocation info containing the page allocator
+ * @trans_pgd: Root transition page table pointer
+ * @pa: Physical address to map
+ * @va: Virtual address to map to
+ * @size: Size of the range to map in bytes (page-aligned)
+ * @prot: Page protection attributes (e.g. PAGE_KERNEL, PAGE_KERNEL_ROX)
+ *
+ * Populates the page table hierarchy (P4D, PUD, PMD, PTE) allocating new
+ * intermediate tables using info->trans_alloc_page() as needed. Used by
+ * liveupdate Caretaker to construct isolated page tables.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int trans_pgd_map_range(struct trans_pgd_info *info, pgd_t *trans_pgd,
+			phys_addr_t pa, unsigned long va, size_t size,
+			pgprot_t prot)
+{
+	unsigned long end = va + size;
+	unsigned long addr = va;
+
+	while (addr < end) {
+		pgd_t *pgdp = pgd_offset_pgd(trans_pgd, addr);
+		p4d_t *p4dp;
+		pud_t *pudp;
+		pmd_t *pmdp;
+		pte_t *ptep;
+
+		if (pgd_none(READ_ONCE(*pgdp))) {
+			p4dp = trans_alloc(info);
+			if (!p4dp)
+				return -ENOMEM;
+			pgd_populate(&init_mm, pgdp, p4dp);
+		}
+		p4dp = p4d_offset(pgdp, addr);
+
+		if (p4d_none(READ_ONCE(*p4dp))) {
+			pudp = trans_alloc(info);
+			if (!pudp)
+				return -ENOMEM;
+			p4d_populate(&init_mm, p4dp, pudp);
+		}
+		pudp = pud_offset(p4dp, addr);
+
+		if (pud_none(READ_ONCE(*pudp))) {
+			pmdp = trans_alloc(info);
+			if (!pmdp)
+				return -ENOMEM;
+			pud_populate(&init_mm, pudp, pmdp);
+		}
+		pmdp = pmd_offset(pudp, addr);
+
+		if (pmd_none(READ_ONCE(*pmdp))) {
+			ptep = trans_alloc(info);
+			if (!ptep)
+				return -ENOMEM;
+			pmd_populate_kernel(&init_mm, pmdp, ptep);
+		}
+		ptep = pte_offset_kernel(pmdp, addr);
+
+		set_pte(ptep, pfn_pte(PHYS_PFN(pa), prot));
+
+		addr += PAGE_SIZE;
+		pa += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
 /*
  * The page we want to idmap may be outside the range covered by VA_BITS that
  * can be built using the kernel's p?d_populate() helpers. As a one off, for a
-- 
2.55.0.1082.g2b9226bbc0-goog


