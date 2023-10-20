Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C558C0032E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=edcx3PPOeIqGjGCRdjl5pBb3idJFVU4KbWuVnvAJYZk=; b=1sSUt0a4eBoPEi
	67b6mbQ2W5S6lmsN9sQZ9DcAUtYEd8M0rITz8IvpzlPDBLH3MgmflMiRXUAFWLbeFSPOyb+aLca+k
	hfZO1q8mf1ZA7CMvRtaRVFwRtFLlfXhpSJG29MrDMmJldE2u+XsX4Cq30wUwn2kukssFuBoDcxDYR
	EOyKAtTPCMzcM5Xq+oX3YQKDQWzeipaX+imT1zh35E/atEZqTN7pRpdSQZiZZTFzQCsZ1mvePUERM
	o/i9mZs5H8ee8/ioHJWlP0j0PVcnmLHIefYxIGqarM0rDKac+3NCdecYXp7hOfgmMTW8JdU5qDX4f
	KeWCi5vE6ekEKKfIb1ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBp-002ZzD-19;
	Fri, 20 Oct 2023 15:13:29 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBm-002Zud-26
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 15:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697814806; x=1729350806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7MgS2tz+eXb3t+LyzYLE/xkq/zAhJTq68EvRtEFLASY=;
  b=DHMT5/8/PBgoZxM20KOoJXYe3xyl5N8oVMLAVTMjxUAMvBfh1T9aW/5R
   RcFjOLRXl+PSQS6oqFu2lrrBZgsuU/5oSUn+U0g9+ePG1eMSiXManv5Ed
   e1SRJlFRQbZ7zTfif1GumC267X27dB+H1iN8Jh+miXD/3A7aHN5qn4lcl
   IbFYe6or020939C9jUfqa6QDkdUtsn0ninBgdHi488jsLJzRSngOqS/AW
   MGnxkPsnf8EYksLEcXvNPIkv+kkqn3dvHKLwXFmMzOEZerGeYNfpneWnq
   f5feQkvr+VqJqD84PywbeHhAAqBmUO3ob/uC6ZwSNXZE4Iw1ybiDY2pyG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366742903"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366742903"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1004634221"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1004634221"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 3109210A299; Fri, 20 Oct 2023 18:12:45 +0300 (+03)
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
Subject: [PATCHv2 07/13] x86/mm: Return correct level from lookup_address() if pte is none
Date: Fri, 20 Oct 2023 18:12:36 +0300
Message-ID: <20231020151242.1814-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_081326_739406_50888863 
X-CRM114-Status: GOOD (  12.62  )
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

lookup_address() only returns correct page table level for the entry if
the entry is not none.

Make the helper to always return correct 'level'. It allows to implement
iterator over kernel page tables using lookup_address().

Add one more entry into enum pg_level to indicate size of VA covered by
one PGD entry in 5-level paging mode.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 1 +
 arch/x86/mm/pat/set_memory.c         | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0b748ee16b3d..3f648ffdfbe5 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -548,6 +548,7 @@ enum pg_level {
 	PG_LEVEL_2M,
 	PG_LEVEL_1G,
 	PG_LEVEL_512G,
+	PG_LEVEL_256T,
 	PG_LEVEL_NUM
 };
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6fbf22d5fa56..01f827eb8e80 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 
-	*level = PG_LEVEL_NONE;
+	*level = PG_LEVEL_256T;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*level = PG_LEVEL_512G;
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
 		return NULL;
 
-	*level = PG_LEVEL_512G;
 	if (p4d_large(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*level = PG_LEVEL_1G;
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
 
-	*level = PG_LEVEL_1G;
 	if (pud_large(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*level = PG_LEVEL_2M;
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
 
-	*level = PG_LEVEL_2M;
 	if (pmd_large(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
