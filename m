Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B4BC54798
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sr9kwemPDSL44Tg1PTjt2e/5Yc6CpsEcp2e7F+No+JM=; b=xIAYyXcoYYyn/7
	HDkg1fW5uEiHX9UfQVDK6yfJmjtaSQTy1Z2VK5X9XE1NY3aDdXMW7UBV0hPYYDugR8BwWQOrY+wxp
	tm73P6lXpXtlD+KAnaeiAcCWkLKMMW0qMtOO6rHKf/KlQfwKPYPXdjeh/SNlUgNMvUPc7y2UgaoKF
	cmuDQ4eYKebKJ+nFNVFuBH5VKjtBCoxky8qBAGXqU8VZf8rLbImWQS4A0/jbISkJihjJCCg0ce/jP
	qjs187Gs1iSd5kd8RnsUhjCkP2cqQAL1Pe3djoyzAeE2ISWDfcvbJsDeD0Zda0+9OfeEc4ddbfejG
	fY2qDqNvxm5vVCDPMYYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdaqU-0000000AwxL-0gaB;
	Fri, 23 Feb 2024 19:04:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdapu-0000000AwwK-4BjG
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 19:04:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIvHXj025352
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 19:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DEBjfDaKaBp4fGUxUeUKbl9YcUzYv2BfDVJ8y7Mqj2o=;
 b=p7E+hwU+QqwspOmBBjMQhuraB8ZRVUKftO2XlNYfNWAhql9aYYKwx5UWB7NWp+yhFe54
 /4Xt4kDtfoNm/YLVX3UXWmP1NANVcefB0UxJ1exB0RIj0mWR8oYDuPIgJJLNMUGyf4U6
 spjZ23jr5X++NleBwA/OnC//XYi0iCKBH0ovRhRNpQ9H5GpMIZqovI/5opsHh+5UIlkm
 67EH467NdAMn1HFe/Nt4B9v1SFAYVkY+GaJhWhS7pVRg+aofEtLovSdPC7N2WCwZ+HEy
 ectCX0ZZRJXM7PY/i/gHKiSWjkauPJ3hij7WdjAa20aj7pPo4dTPzZvHXJcOAIETmXp9 hA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf13d85qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 19:03:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIklHM013471
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 19:03:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0ypuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 19:03:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NJ3k5l58327330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 19:03:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 342DC2007B;
	Fri, 23 Feb 2024 19:03:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB20520075;
	Fri, 23 Feb 2024 19:03:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.41.126])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 19:03:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <kexec@lists.infradead.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] makedumpfile: ppc64: get vmalloc start address from vmcoreinfo
Date: Sat, 24 Feb 2024 00:33:42 +0530
Message-ID: <20240223190342.251365-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vBgOjJBVh7LNskRxQclGJzwqAlNEzf23
X-Proofpoint-ORIG-GUID: vBgOjJBVh7LNskRxQclGJzwqAlNEzf23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_110400_770316_9F1A34C3 
X-CRM114-Status: GOOD (  23.11  )
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

Below error was noticed when running makedumpfile on linux-next kernel
crash (linux-next tag next-20240121):

    ...
    Checking for memory holes : [100.0 %] | readpage_elf: Attempt to read non-existent page at 0xc000000000000.
    [ 17.551718] kdump.sh[404]: readmem: type_addr: 0, addr:c00c000000000000, size:16384
    [ 17.551793] kdump.sh[404]: __exclude_unnecessary_pages: Can't read the buffer of struct page.
    [ 17.551864] kdump.sh[404]: create_2nd_bitmap: Can't exclude unnecessary pages.
    [ 17.562632] kdump.sh[404]: The kernel version is not supported.
    [ 17.562708] kdump.sh[404]: The makedumpfile operation may be incomplete.
    [ 17.562773] kdump.sh[404]: makedumpfile Failed.
    [ 17.564335] kdump[406]: saving vmcore failed, _exitcode:1

Above error was due to 'vmap_area_list' and 'vmlist' symbols missing
from the vmcore.

'vmap_area_list' was removed in the linux kernel with below commit:

    commit 378eb24a0658dd922b29524e0ce35c6c43f56cba
         mm/vmalloc: remove vmap_area_list

Subsequently the commit also introduced 'VMALLOC_START' in vmcoreinfo to
get base address of vmalloc area, instead of depending on 'vmap_area_list'

Hence if 'VMALLOC_START' symbol is there in vmcoreinfo:
  1. Set vmalloc_start based on 'VMALLOC_START'
  2. Don't error if vmap_area_list/vmlist are not defined

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 arch/ppc64.c   | 19 +++++++++++++------
 makedumpfile.c |  3 ++-
 makedumpfile.h |  6 +++---
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 96c357cb0335..bb62e2cd199a 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -568,7 +568,9 @@ get_machdep_info_ppc64(void)
 	/*
 	 * Get vmalloc_start value from either vmap_area_list or vmlist.
 	 */
-	if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
+	if (NUMBER(vmalloc_start) != NOT_FOUND_SYMBOL) {
+		vmalloc_start = NUMBER(vmalloc_start);
+	} else if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
 	    && (OFFSET(vmap_area.va_start) != NOT_FOUND_STRUCTURE)
 	    && (OFFSET(vmap_area.list) != NOT_FOUND_STRUCTURE)) {
 		if (!readmem(VADDR, SYMBOL(vmap_area_list) + OFFSET(list_head.next),
@@ -684,11 +686,16 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 	if ((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
 	    || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
 	    || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE)) {
-		if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-		    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
-			ERRMSG("Can't get info for vmalloc translation.\n");
-			return NOT_PADDR;
-		}
+		/*
+		 * Don't depend on vmap_area_list/vmlist if vmalloc_start is set in
+		 * vmcoreinfo, in that case proceed without error
+		 */
+		if (NUMBER(vmalloc_start) == NOT_FOUND_NUMBER)
+			if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+				|| (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+				ERRMSG("Can't get info for vmalloc translation.\n");
+				return NOT_PADDR;
+			}
 	}
 
 	return ppc64_vtop_level4(vaddr);
diff --git a/makedumpfile.c b/makedumpfile.c
index b004b93fecb7..b6c63fad15f3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2978,6 +2978,8 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
+
+	READ_NUMBER_UNSIGNED("VMALLOC_START", vmalloc_start);
 #ifdef __aarch64__
 	READ_NUMBER("VA_BITS", VA_BITS);
 	READ_NUMBER("TCR_EL1_T1SZ", TCR_EL1_T1SZ);
@@ -2989,7 +2991,6 @@ read_vmcoreinfo(void)
 	READ_NUMBER("VA_BITS", va_bits);
 	READ_NUMBER_UNSIGNED("phys_ram_base", phys_ram_base);
 	READ_NUMBER_UNSIGNED("PAGE_OFFSET", page_offset);
-	READ_NUMBER_UNSIGNED("VMALLOC_START", vmalloc_start);
 	READ_NUMBER_UNSIGNED("VMALLOC_END", vmalloc_end);
 	READ_NUMBER_UNSIGNED("VMEMMAP_START", vmemmap_start);
 	READ_NUMBER_UNSIGNED("VMEMMAP_END", vmemmap_end);
diff --git a/makedumpfile.h b/makedumpfile.h
index 59c83e1d9df3..4021c5af2a34 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -541,8 +541,6 @@ do { \
  * The value of dependence on machine
  */
 #define PAGE_OFFSET		(info->page_offset)
-#define VMALLOC_START		(info->vmalloc_start)
-#define VMALLOC_END		(info->vmalloc_end)
 #define VMEMMAP_START		(info->vmemmap_start)
 #define VMEMMAP_END		(info->vmemmap_end)
 #define PMASK			(0x7ffffffffffff000UL)
@@ -2262,6 +2260,9 @@ struct number_table {
 	long    HUGETLB_PAGE_DTOR;
 	long	phys_base;
 	long	KERNEL_IMAGE_SIZE;
+
+	unsigned long vmalloc_start;
+
 #ifdef __aarch64__
 	long 	VA_BITS;
 	long	TCR_EL1_T1SZ;
@@ -2272,7 +2273,6 @@ struct number_table {
 	long va_bits;
 	unsigned long phys_ram_base;
 	unsigned long page_offset;
-	unsigned long vmalloc_start;
 	unsigned long vmalloc_end;
 	unsigned long vmemmap_start;
 	unsigned long vmemmap_end;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
