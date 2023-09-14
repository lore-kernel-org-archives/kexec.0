Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D77AEDE99E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=alkIKUu98o03UQH1kJIE3xR4ES5gywHGLxlV1x96QdM=; b=042w1jlRZr02kE
	R/DZYVRpXopb2QDc7hpBVJL/HgWpDMiqwPYigovP01Mbs+kMVi+YA9m1NQ2DSbaeuLDJTdXJ5Xt2I
	04lqkSINCno0EIYLHgK09IIAEsGz7t49yJ8EeEpm6yNjZXQDjxuFtWF7SXbRHHnxfjrwOTXtXKuHJ
	hM9njWY8VuSLEG8nL0Z3YdFMPbedBRZMhD3XeMs8wNQmgbyWiFo+CTKgGmrUgPmhm5fZRJydjm53A
	h2qgwgsndQP/+bDpiYJfqG3zXg7Qa8IlaZOrj54eRr1oU/tR8qB5isZQXybVxz2l0gmzWqd31QDFT
	LGPuL12I+aUpKR3K/Epg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgiYc-007pG9-0v;
	Thu, 14 Sep 2023 09:22:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgiYX-007pFg-36
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 09:22:40 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E98vVX022605
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Sy4vHKnDQHkgpqsMPWsuOHcA2ohe42hwGsXRUTI0V0Y=;
 b=Du4961jBI0PAq1rZC3ezX0iEMJlYoZt45Swu2BFbbUmbUb/3UtOe+WovDrbtQzXdwMN2
 VDEdrgI6KD5GELEdHKVRfzTsUt8WFUC3u9RSP1Sp2lZVqXtjHY9fYjaWvfos3n25LEbk
 oso3e7B07ZNjJ/Qq1q0YG9gnPPLazPgJyifsr1ruRUI8miK8aFXyZHbdbmKENYG0buiX
 yil2OpZfT5Bn6ln9Py5I5FnN1aTR2OxgaWv0JKtpxerykTauQwx7tgqwYXDbBfbhbIb4
 7rdqU0JjmWg1djA2S54QwWwdgE9b/s28Jov1S74XE3NBN+gVHgLbThuUjg9F/OIrlS8q IA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3xr41d6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:22:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38E7xBjQ023152
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:22:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141p1u6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:22:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38E9MPvp17892086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 09:22:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37ECF20040;
	Thu, 14 Sep 2023 09:22:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA2720043;
	Thu, 14 Sep 2023 09:22:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Sep 2023 09:22:23 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] makedumpfile: ppc64: do page traversal if vmemmap_list not populated
Date: Thu, 14 Sep 2023 14:52:23 +0530
Message-ID: <20230914092223.172811-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ILiiFmx3rr-d6Pk2x5Vy8Fv3OlDv0aH7
X-Proofpoint-ORIG-GUID: ILiiFmx3rr-d6Pk2x5Vy8Fv3OlDv0aH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_022238_357935_C27E532F 
X-CRM114-Status: GOOD (  29.69  )
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

Currently 'makedumpfile' fails to collect vmcore on upstream kernel,
with the errors:

    readpage_elf: Attempt to read non-existent page at 0x4000000000000000.
    readmem: type_addr: 0, addr:0, size:8
    get_vmemmap_list_info: Can't get vmemmap region addresses
    get_machdep_info_ppc64: Can't get vmemmap list info.

This occurs since makedumpfile depends on 'vmemmap_list' for translating
vmemmap addresses. But with below commit in Linux, vmemmap_list can be
empty, in case of Radix MMU on PowerPC64

    368a0590d954: (powerpc/book3s64/vmemmap: switch radix to use a
    different vmemmap handling function)

In case vmemmap_list is empty, then it's head is NULL, which causes
makedumpfile to fail with above error.

Since with above commit, 'vmemmap_list' is not populated (when MMU is
Radix MMU), kernel populates corresponding page table entries in kernel
page table. Hence, instead of depending on 'vmemmap_list' for address
translation for vmemmap addresses, do a kernel pagetable walk.

And since the pte can also be introduced at higher levels in the page
table, such as at PMD level, add hugepage support, by checking for
PAGE_PTE flag

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 arch/ppc64.c   | 111 ++++++++++++++++++++++++++++++++++---------------
 makedumpfile.h |   6 +++
 2 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 5e70acb51aba..9456b8b570c5 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -196,6 +196,10 @@ ppc64_vmemmap_init(void)
 	int psize, shift;
 	ulong head;
 
+	/* initialise vmemmap_list in case SYMBOL(vmemmap_list) is not found */
+	info->vmemmap_list = NULL;
+	info->vmemmap_cnt = 0;
+	
 	if ((SYMBOL(vmemmap_list) == NOT_FOUND_SYMBOL)
 	    || (SYMBOL(mmu_psize_defs) == NOT_FOUND_SYMBOL)
 	    || (SYMBOL(mmu_vmemmap_psize) == NOT_FOUND_SYMBOL)
@@ -216,15 +220,24 @@ ppc64_vmemmap_init(void)
 		return FALSE;
 	info->vmemmap_psize = 1 << shift;
 
-	if (!readmem(VADDR, SYMBOL(vmemmap_list), &head, sizeof(unsigned long)))
-		return FALSE;
-
 	/*
-	 * Get vmemmap list count and populate vmemmap regions info
-	 */
-	info->vmemmap_cnt = get_vmemmap_list_info(head);
-	if (info->vmemmap_cnt == 0)
-		return FALSE;
+	 * vmemmap_list symbol can be missing or set to 0 in the kernel.
+	 * This would imply vmemmap region is mapped in the kernel pagetable.
+	 *
+	 * So, read vmemmap_list anyway, and use 'vmemmap_list' if it's not empty
+	 * (head != NULL), or we will do a kernel pagetable walk for vmemmap address
+	 * translation later
+	 **/
+	readmem(VADDR, SYMBOL(vmemmap_list), &head, sizeof(unsigned long));
+
+	if (head) {
+		/*
+		 * Get vmemmap list count and populate vmemmap regions info
+		 */
+		info->vmemmap_cnt = get_vmemmap_list_info(head);
+		if (info->vmemmap_cnt == 0)
+			return FALSE;
+	}
 
 	info->flag_vmemmap = TRUE;
 	return TRUE;
@@ -347,29 +360,6 @@ ppc64_vmalloc_init(void)
 	return TRUE;
 }
 
-/*
- *  If the vmemmap address translation information is stored in the kernel,
- *  make the translation.
- */
-static unsigned long long
-ppc64_vmemmap_to_phys(unsigned long vaddr)
-{
-	int	i;
-	ulong	offset;
-	unsigned long long paddr = NOT_PADDR;
-
-	for (i = 0; i < info->vmemmap_cnt; i++) {
-		if ((vaddr >= info->vmemmap_list[i].virt) && (vaddr <
-		    (info->vmemmap_list[i].virt + info->vmemmap_psize))) {
-			offset = vaddr - info->vmemmap_list[i].virt;
-			paddr = info->vmemmap_list[i].phys + offset;
-			break;
-		}
-	}
-
-	return paddr;
-}
-
 static unsigned long long
 ppc64_vtop_level4(unsigned long vaddr)
 {
@@ -379,6 +369,8 @@ ppc64_vtop_level4(unsigned long vaddr)
 	unsigned long long pgd_pte, pud_pte;
 	unsigned long long pmd_pte, pte;
 	unsigned long long paddr = NOT_PADDR;
+	uint is_hugepage = 0;
+	uint pdshift;
 	uint swap = 0;
 
 	if (info->page_buf == NULL) {
@@ -413,6 +405,13 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!pgd_pte)
 		return NOT_PADDR;
 
+	if (IS_HUGEPAGE(pgd_pte)) {
+		is_hugepage = 1;
+		pte = pgd_pte;
+		pdshift = info->l4_shift;
+		goto out;
+	}
+
 	/*
 	 * Sometimes we don't have level3 pagetable entries
 	 */
@@ -426,6 +425,13 @@ ppc64_vtop_level4(unsigned long vaddr)
 		pud_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(page_upper))), swap);
 		if (!pud_pte)
 			return NOT_PADDR;
+
+		if (IS_HUGEPAGE(pud_pte)) {
+			is_hugepage = 1;
+			pte = pud_pte;
+			pdshift = info->l3_shift;
+			goto out;
+		}
 	} else {
 		pud_pte = pgd_pte;
 	}
@@ -440,6 +446,13 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!(pmd_pte))
 		return NOT_PADDR;
 
+	if (IS_HUGEPAGE(pmd_pte)) {
+		is_hugepage = 1;
+		pte = pmd_pte;
+		pdshift = info->l2_shift;
+		goto out;
+	}
+
 	pmd_pte = pmd_page_vaddr_l4(pmd_pte);
 	page_table = (ulong *)(pmd_pte)
 			+ (BTOP(vaddr) & (info->ptrs_per_l1 - 1));
@@ -456,8 +469,40 @@ ppc64_vtop_level4(unsigned long vaddr)
 	if (!pte)
 		return NOT_PADDR;
 
-	paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
+out:
+	if (is_hugepage) {
+		paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
+			+ (vaddr & ((1UL << pdshift) - 1));
+	} else {
+		paddr = PAGEBASE(PTOB((pte & info->pte_rpn_mask) >> info->pte_rpn_shift))
 			+ PAGEOFFSET(vaddr);
+	}
+
+	return paddr;
+}
+
+/*
+ *  If the vmemmap address translation information is stored in the kernel,
+ *  make the translation.
+ */
+static unsigned long long
+ppc64_vmemmap_to_phys(unsigned long vaddr)
+{
+	int	i;
+	ulong	offset;
+	unsigned long long paddr = NOT_PADDR;
+
+	if (!info->vmemmap_list)
+		return ppc64_vtop_level4(vaddr);
+
+	for (i = 0; i < info->vmemmap_cnt; i++) {
+		if ((vaddr >= info->vmemmap_list[i].virt) && (vaddr <
+		    (info->vmemmap_list[i].virt + info->vmemmap_psize))) {
+			offset = vaddr - info->vmemmap_list[i].virt;
+			paddr = info->vmemmap_list[i].phys + offset;
+			break;
+		}
+	}
 
 	return paddr;
 }
@@ -567,8 +612,8 @@ get_machdep_info_ppc64(void)
 		return FALSE;
 	}
 
+	info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
 	if (SYMBOL(vmemmap_list) != NOT_FOUND_SYMBOL) {
-		info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
 		info->vmemmap_end = info->vmemmap_start;
 		if (ppc64_vmemmap_init() == FALSE) {
 			ERRMSG("Can't get vmemmap list info.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 85e5a4932983..056aee191519 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -678,6 +678,12 @@ unsigned long get_kvbase_arm64(void);
 #define REGION_SHIFT            (60UL)
 #define VMEMMAP_REGION_ID       (0xfUL)
 
+/*
+ * If PAGE_PTE is set, then it's a leaf PTE for hugepage
+ */
+#define PAGE_PTE (1UL << 62)
+#define IS_HUGEPAGE(pte) (!!((pte) & PAGE_PTE))
+
 /* 4-level page table support */
 
 /* 4K pagesize */
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
