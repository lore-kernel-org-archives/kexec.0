Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3E5C7EE2D
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=33o443ByYhwLBZ7C3maCRg7bieM+CfIYIm/7BAA0Jeo=; b=Kvt8hWKCbBTrHM
	aa+EFn5dCvQytX8kXEtp+4imOXTfTpkJV4ng6SHN8EhwFnJsjnb1fXqto36XddDnqjOQRcBldPXvi
	wfMv+busegxcri6Myw57BAPc0QpYmHXfj+hnC03EHn0HnVMipLd8aDFLSJzV9wH/UEsg8bkK9/c3l
	DqeKpZ4iWFet5mpKUJ2IHcMoLm8l5DGPICbhjcfpu5sHJXbTx7QJvuPM3CHaoHFzn8t1NCysIZCjc
	eFuZcCh8oC24nBpHDqFHqPOboiHyAo2BlBKn0Vz5VZRC/1LkQzEPn9bYztoRM4Xlszxy1fbP7JsaT
	t9+Lql9GOryK2qsEw9qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD4-0056ZM-2S;
	Thu, 27 Apr 2023 00:10:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCw-0056Qi-21
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:01 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxEQx025323;
	Thu, 27 Apr 2023 00:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=HqaUuCd1TrikYSZqcmSr/0DHMDDKEbvkxeVBZQXF+4s=;
 b=ymokuz3wRntwI30/UPMDy8uxtvahfMueGv8Da1N3qrPtLBUqqTRtFtKbvokd96e5oZPc
 pGY+TCBPIuSXwvnuN1QwEW7r2+WpUN6T68bsCFTIQXhsaByghzHkSw63dHZAIArr8Zok
 vRy10JtQfeUPrT0F4r+cKjI4JYbseEZWXcPUr7KtYBgw5zozoWZePDLxldsjq0Z8Fbe5
 SJR+63Zf6mzrcGiBcfd8IT3o7crf+MDRZs6cwBzPEY7dvharmXfVNp0dVkumlGxD/XU6
 S108cMR7bmO/7+BFit4IaIqe96T4ktAHBuex20hQ1G56cNGPf/8/HB8tDXQFc3myQwQr Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622ty4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNV55B007557;
	Thu, 27 Apr 2023 00:09:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938g013888;
	Thu, 27 Apr 2023 00:09:19 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-11;
	Thu, 27 Apr 2023 00:09:18 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 10/21] PKRAM: prepare for adding preserved ranges to memblock reserved
Date: Wed, 26 Apr 2023 17:08:46 -0700
Message-Id: <1682554137-13938-11-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-ORIG-GUID: Pb7Yjfl5p58r9mry-DL31w9dKlO5igMJ
X-Proofpoint-GUID: Pb7Yjfl5p58r9mry-DL31w9dKlO5igMJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_170958_668133_A65A536A 
X-CRM114-Status: GOOD (  22.88  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Calling memblock_reserve() repeatedly to add preserved ranges is
inefficient and risks clobbering preserved memory if the memblock
reserved regions array must be resized.  Instead, calculate the size
needed to accommodate the preserved ranges, find a suitable range for
a new reserved regions array that does not overlap any preserved range,
and populate it with a new, merged regions array.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index 3790e5180feb..c649504fa1fa 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1138,3 +1139,246 @@ static unsigned long pkram_populate_regions_list(void)
 
 	return priv.nr_regions;
 }
+
+struct pkram_region *pkram_first_region(struct pkram_super_block *sb,
+					struct pkram_region_list **rlp, int *idx)
+{
+	WARN_ON(!sb);
+	WARN_ON(!sb->region_list_pfn);
+
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	*rlp = pfn_to_kaddr(sb->region_list_pfn);
+	*idx = 0;
+
+	return &(*rlp)->regions[0];
+}
+
+struct pkram_region *pkram_next_region(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	i++;
+	if (i >= PKRAM_REGIONS_LIST_MAX) {
+		if (!rl->next_pfn) {
+			pr_err("PKRAM: %s: no more pkram_region_list pages\n", __func__);
+			return NULL;
+		}
+		rl = pfn_to_kaddr(rl->next_pfn);
+		*rlp = rl;
+		i = 0;
+	}
+	*idx = i;
+
+	if (rl->regions[i].size == 0)
+		return NULL;
+
+	return &rl->regions[i];
+}
+
+struct pkram_region *pkram_first_region_topdown(struct pkram_super_block *sb,
+						struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl;
+
+	WARN_ON(!sb);
+	WARN_ON(!sb->region_list_pfn);
+
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	rl = pfn_to_kaddr(sb->region_list_pfn);
+	if (!rl->prev_pfn) {
+		WARN_ON(1);
+		return NULL;
+	}
+	rl = pfn_to_kaddr(rl->prev_pfn);
+
+	*rlp = rl;
+
+	*idx = (sb->nr_regions - 1) % PKRAM_REGIONS_LIST_MAX;
+
+	return &rl->regions[*idx];
+}
+
+struct pkram_region *pkram_next_region_topdown(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	if (i == 0) {
+		if (!rl->prev_pfn)
+			return NULL;
+		rl = pfn_to_kaddr(rl->prev_pfn);
+		*rlp = rl;
+		i = PKRAM_REGIONS_LIST_MAX - 1;
+	} else
+		i--;
+
+	*idx = i;
+
+	return &rl->regions[i];
+}
+
+/*
+ * Use the pkram regions list to allocate a block of memory that does
+ * not overlap with preserved pages.
+ */
+phys_addr_t __init alloc_topdown(phys_addr_t size)
+{
+	phys_addr_t hole_start, hole_end, hole_size;
+	struct pkram_region_list *rl;
+	struct pkram_region *r;
+	phys_addr_t addr = 0;
+	int idx;
+
+	hole_end = memblock.current_limit;
+	r = pkram_first_region_topdown(pkram_sb, &rl, &idx);
+
+	while (r) {
+		hole_start = r->base + r->size;
+		hole_size = hole_end - hole_start;
+
+		if (hole_size >= size) {
+			addr = memblock_phys_alloc_range(size, PAGE_SIZE,
+							hole_start, hole_end);
+			if (addr)
+				break;
+		}
+
+		hole_end = r->base;
+		r = pkram_next_region_topdown(&rl, &idx);
+	}
+
+	if (!addr)
+		addr = memblock_phys_alloc_range(size, PAGE_SIZE, 0, hole_end);
+
+	return addr;
+}
+
+int __init pkram_create_merged_reserved(struct memblock_type *new)
+{
+	unsigned long cnt_a;
+	unsigned long cnt_b;
+	long i, j, k;
+	struct memblock_region *r;
+	struct memblock_region *rgn;
+	struct pkram_region *pkr;
+	struct pkram_region_list *rl;
+	int idx;
+	unsigned long total_size = 0;
+	unsigned long nr_preserved = 0;
+
+	cnt_a = memblock.reserved.cnt;
+	cnt_b = pkram_sb->nr_regions;
+
+	i = 0;
+	j = 0;
+	k = 0;
+
+	pkr = pkram_first_region(pkram_sb, &rl, &idx);
+	if (!pkr)
+		return -EINVAL;
+	while (i < cnt_a && j < cnt_b && pkr) {
+		r = &memblock.reserved.regions[i];
+		rgn = &new->regions[k];
+
+		if (r->base + r->size <= pkr->base) {
+			*rgn = *r;
+			i++;
+		} else if (pkr->base + pkr->size <= r->base) {
+			rgn->base = pkr->base;
+			rgn->size = pkr->size;
+			memblock_set_region_node(rgn, MAX_NUMNODES);
+
+			nr_preserved +=  (rgn->size >> PAGE_SHIFT);
+			pkr = pkram_next_region(&rl, &idx);
+			j++;
+		} else {
+			pr_err("PKRAM: unexpected overlap:\n");
+			pr_err("PKRAM: reserved: base=%pa,size=%pa,flags=0x%x\n", &r->base,
+				&r->size, (int)r->flags);
+			pr_err("PKRAM: pkram: base=%pa,size=%pa\n", &pkr->base, &pkr->size);
+			return -EBUSY;
+		}
+		total_size += rgn->size;
+		k++;
+	}
+
+	while (i < cnt_a) {
+		r = &memblock.reserved.regions[i];
+		rgn = &new->regions[k];
+
+		*rgn = *r;
+
+		total_size += rgn->size;
+		i++;
+		k++;
+	}
+	while (j < cnt_b && pkr) {
+		rgn = &new->regions[k];
+		rgn->base = pkr->base;
+		rgn->size = pkr->size;
+		memblock_set_region_node(rgn, MAX_NUMNODES);
+
+		nr_preserved += (rgn->size >> PAGE_SHIFT);
+		total_size += rgn->size;
+		pkr = pkram_next_region(&rl, &idx);
+		j++;
+		k++;
+	}
+
+	WARN_ON(cnt_a + cnt_b != k);
+	new->cnt = cnt_a + cnt_b;
+	new->total_size = total_size;
+
+	return 0;
+}
+
+/*
+ * Reserve pages that belong to preserved memory.  This is accomplished by
+ * merging the existing reserved ranges with the preserved ranges into
+ * a new, sufficiently sized memblock reserved array.
+ *
+ * This function should be called at boot time as early as possible to prevent
+ * preserved memory from being recycled.
+ */
+int __init pkram_merge_with_reserved(void)
+{
+	struct memblock_type new;
+	unsigned long new_max;
+	phys_addr_t new_size;
+	phys_addr_t addr;
+	int err;
+
+	/*
+	 * Need space to insert one more range into memblock.reserved
+	 * without memblock_double_array() being called.
+	 */
+	if (memblock.reserved.cnt == memblock.reserved.max) {
+		WARN_ONCE(1, "PKRAM: no space for new memblock list\n");
+		return -ENOMEM;
+	}
+
+	new_max = memblock.reserved.max + pkram_sb->nr_regions;
+	new_size = PAGE_ALIGN(sizeof(struct memblock_region) * new_max);
+
+	addr = alloc_topdown(new_size);
+	if (!addr)
+		return -ENOMEM;
+
+	new.regions = __va(addr);
+	new.max = new_max;
+	err = pkram_create_merged_reserved(&new);
+	if (err)
+		return err;
+
+	memblock.reserved.cnt = new.cnt;
+	memblock.reserved.max = new.max;
+	memblock.reserved.total_size = new.total_size;
+	memblock.reserved.regions = new.regions;
+
+	return 0;
+}
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
