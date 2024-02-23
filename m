Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FBCC48BC4
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ILaYpKReSnZahrsczRV9b7PeUOuhyj9+3g4NPtcnINc=; b=DfDQESRuTLH5S/
	AZBl9iAlz3pSPhFcnKbs+WXxp3FAmkK3wOnTsUYkheQflRgoNFl63T1PP9PJCdpwxf9xzclcHQBvK
	z9b/8HSIWCo9+YYS71gEgf8+oEVODIrbAnsV6UtznjpRtDCLN9Og5VcLodTgb5/cc9vHuBQmDqPnu
	rE6yut1Xi7C5w38tLKeyyV1pJSBNqrqf5bGMPysnA/jIx2M29y0cmmU+Nfyif4yAz2eJI0ybuzU56
	307Lpw4EGRJ6vAtHu0jJEN2p8TIfM/YHiDXEZ60/5+uaCA/VyExNZLvSwHOKQdyEk20RVoIH8uKB2
	pKDYRswlLL4xsAKbg/zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdR5t-00000008XFm-21gP;
	Fri, 23 Feb 2024 08:39:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdR5Y-00000008X9P-2lwv
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 08:39:33 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N8bT39032314;
	Fri, 23 Feb 2024 08:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=otXXge+74RzCQPzWsltxCnsdYnnt0s9HOv9bTuC+2NQ=;
 b=JOdc+sEWlNo1A/yBrzjarKfhOFJxQkoK5sd2pcD4LeYeWHlRvQQKPOrlA4vhM+eXGBoW
 6fplQ8a/4VTBh299HHbh+Qrcy00W3a5s9Bcz0Z4MLPf0P8aNDuTni0GcCOcqQDLzhOQ0
 LNQMcXwmMRbMvlcYfFrWVrac770ooiV/syIVYdU8k0Illsnu/OwWJx4j0L/Zbc4NKv00
 dCRR79g1PQuoDIx6vf345vi87QrPws0emRjVQAjybDDH42YrP7G6vp04MThRW4ytuujL
 xdwT//ymKZf5YA9bNa2fmyb1cT5Y7ySWKUnSX/CjjekmgHHRLJQWtdwZgU/K7+XSgjxF RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wer0pg192-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:39:23 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41N8dNpn005244;
	Fri, 23 Feb 2024 08:39:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wer0pg18c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:39:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N7t3ge013492;
	Fri, 23 Feb 2024 08:39:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0vc7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:39:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41N8dFRY12583532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 08:39:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F87C2004B;
	Fri, 23 Feb 2024 08:39:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557F820040;
	Fri, 23 Feb 2024 08:39:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 08:39:14 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <kexec@lists.infradead.org>
Cc: =?UTF-8?q?HAGIO=20KAZUHITO=28=E8=90=A9=E5=B0=BE=20=E4=B8=80=E4=BB=81=29?= <k-hagio-ab@nec.com>,
        Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Date: Fri, 23 Feb 2024 14:09:13 +0530
Message-ID: <20240223083913.135091-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LE9f1iMPUsbo2ncWNoaXijute1rASZbS
X-Proofpoint-ORIG-GUID: 3Hn4WyUSnA6F8eJfJHdRRGSlJ_1JjHXt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=898 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_003924_785817_2F9417B9 
X-CRM114-Status: GOOD (  24.47  )
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
