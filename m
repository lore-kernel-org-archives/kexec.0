Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D46CC48BC4
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ILaYpKReSnZahrsczRV9b7PeUOuhyj9+3g4NPtcnINc=; b=W0+WF3mGG/MJit
	C0I5wZ8utohtPM0T5SmPQ3kMK9Vd/Og+EveuhBRIH10Oo/iXpDtHyA9Ys1gz71ftDVYXf9d3w/vuY
	cK3Z2mPSVfL7gBI4L3yKP4VUz9WvfNWTCvDikDOH57ms6rWEB9ojAsEe2X7uWViPpoCNlMO99WspM
	COpoC8SS4GHiyXwr6lD6uHFBdBt+SOtdbLZ5eZKEZuInySLA1a8CAKPHt2JhlRAxsMQSQtDjoGBVP
	ZQemSCtkYEMcTZVFhQZbt3s9K7nhO8SwkO463N1GfAJkP7MI0VZiFIyiGmMYR9SMxaYgQ7UTqlgdU
	RpoJFSOLUmRsSCp16mWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOV6-000000084wX-2xB5;
	Fri, 23 Feb 2024 05:53:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOUz-000000084rn-3WkI
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 05:53:33 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N57W8u032392
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 05:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=otXXge+74RzCQPzWsltxCnsdYnnt0s9HOv9bTuC+2NQ=;
 b=RaO/2vL4UrelJk6C9qKLxdDdQ/Y6ruetYHcnyK45KlKfauAoIhBiXU0BBOVxt/U1nkUd
 5g4BE47ZhIxSrpqCqZRQbJwCBwVzs8l5/tqnNh7lSZjpmKfarr8hy7HkK0Dti4RBtlEs
 x0wCSGxAHTCYhree8j59smhzqxs4RH5FvuFBy1P2KFBXmxtzhmqYaQrftzc9sDmD3iVT
 c6MTGryCmcY+2727ZLmqR27ulvM5a35MmykUpsVwEMvh1LSPvrz7rplePe0MZI43UI5d
 sJUCqmmeAwkmTDmGaqt95RuoHLaXVFCcWJya99bmmxq/HFdKRWLEN/unYKgbmG6hT2af 7g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wemxc0x31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 05:53:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N5or9H017257
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 05:53:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmu7hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 05:53:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41N5r8W024576526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 05:53:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D936420040;
	Fri, 23 Feb 2024 05:53:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0AF220043;
	Fri, 23 Feb 2024 05:53:07 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 05:53:07 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <kexec@lists.infradead.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Date: Fri, 23 Feb 2024 11:23:06 +0530
Message-ID: <20240223055306.34466-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DXjbfsJ7b2RKvhmkN9uTg0IrRqeCHei6
X-Proofpoint-ORIG-GUID: DXjbfsJ7b2RKvhmkN9uTg0IrRqeCHei6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=802 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_215330_173502_872FF7B1 
X-CRM114-Status: GOOD (  25.91  )
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

Currently makedumpfile depends on reading the 'cur_cpu_spec' kernel
symbol to get the current MMU type on PowerPC64.

The disadvantage with this approach was that it depends on bit '0x40'
('MMU_FTR_TYPE_RADIX') being set in 'cur_cpu_spec->mmu_features',
which implies kernel developers have to be careful of modifying
MMU_FTR_* defines

Instead a more stable approach was suggested by contributors in
https://lore.kernel.org/linuxppc-dev/87v8c3m70t.fsf@mail.lhotse/, to
pass information about the MMU type in vmcoreinfo itself, instead of
depending on the MMU_FTR_* defines

This was implemented in linux kernel in:
    commit 36e826b568e4 ("powerpc/vmcore: Add MMU information to vmcoreinfo")

With this commit, if RADIX_MMU is there in the vmcoreinfo, we prefer it
to get current mmu type, instead of 'cur_cpu_spec'.
On older kernels, where RADIX_MMU number is not there, makedumpfile will
simply fall back to using 'cur_cpu_spec'.

The earlier defines for 'RADIX_MMU' have been renamed to 'MMU_TYPE_RADIX'
which avoids conflict with the vmcoreinfo string 'RADIX_MMU', as well as
being more clear about the value 0x40 with a comment about MMU_FTR_TYPE_RADIX

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 arch/ppc64.c   | 15 ++++++++++-----
 makedumpfile.c |  1 +
 makedumpfile.h |  9 ++++++---
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 96c357cb0335..3b4f91981f71 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -250,7 +250,7 @@ ppc64_vmalloc_init(void)
 		/*
 		 * 64K pagesize
 		 */
-		if (info->cur_mmu_type & RADIX_MMU) {
+		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
 			info->l1_index_size = PTE_INDEX_SIZE_RADIX_64K;
 			info->l2_index_size = PMD_INDEX_SIZE_RADIX_64K;
 			info->l3_index_size = PUD_INDEX_SIZE_RADIX_64K;
@@ -300,7 +300,7 @@ ppc64_vmalloc_init(void)
 		/*
 		 * 4K pagesize
 		 */
-		if (info->cur_mmu_type & RADIX_MMU) {
+		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
 			info->l1_index_size = PTE_INDEX_SIZE_RADIX_4K;
 			info->l2_index_size = PMD_INDEX_SIZE_RADIX_4K;
 			info->l3_index_size = PUD_INDEX_SIZE_RADIX_4K;
@@ -635,14 +635,19 @@ get_versiondep_info_ppc64()
 	 * On PowerISA 3.0 based server processors, a kernel can run with
 	 * radix MMU or standard MMU. Get the current MMU type.
 	 */
-	info->cur_mmu_type = STD_MMU;
-	if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
+	info->cur_mmu_type = MMU_TYPE_STD;
+
+	if (NUMBER(RADIX_MMU) != NOT_FOUND_SYMBOL) {
+		if (NUMBER(RADIX_MMU) == 1) {
+			info->cur_mmu_type = MMU_TYPE_RADIX;
+		}
+	} else if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
 	    && (OFFSET(cpu_spec.mmu_features) != NOT_FOUND_STRUCTURE)) {
 		if (readmem(VADDR, SYMBOL(cur_cpu_spec), &cur_cpu_spec,
 		    sizeof(cur_cpu_spec))) {
 			if (readmem(VADDR, cur_cpu_spec + OFFSET(cpu_spec.mmu_features),
 			    &mmu_features, sizeof(mmu_features)))
-				info->cur_mmu_type = mmu_features & RADIX_MMU;
+				info->cur_mmu_type = mmu_features & MMU_TYPE_RADIX;
 		}
 	}
 
diff --git a/makedumpfile.c b/makedumpfile.c
index 3705bdd93deb..1bd7305f49ca 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2987,6 +2987,7 @@ read_vmcoreinfo(void)
 #endif
 
 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
+	READ_NUMBER("RADIX_MMU", RADIX_MMU);
 
 	return TRUE;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 3ed3ba551d96..a7b344974636 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -747,12 +747,13 @@ unsigned long get_kvbase_arm64(void);
 /*
  * Supported MMU types
  */
-#define STD_MMU         0x0
+#define MMU_TYPE_STD         0x0
 /*
  * The flag bit for radix MMU in cpu_spec.mmu_features
- * in the kernel. Use the same flag here.
+ * in the kernel (MMU_FTR_TYPE_RADIX).
+ * Use the same flag here.
  */
-#define RADIX_MMU       0x40
+#define MMU_TYPE_RADIX       0x40
 
 
 #define PGD_MASK_L4		\
@@ -2258,6 +2259,8 @@ struct number_table {
 	unsigned long kernel_link_addr;
 	unsigned long va_kernel_pa_offset;
 #endif
+
+	unsigned long RADIX_MMU;
 };
 
 struct srcfile_table {
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
