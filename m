Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455C7C7618E
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lJrb8HeQddKmn7TDjOaDPWSwskESMgRdr7TbAmvyoXQ=; b=AVqXz+4xXPLkL6
	puS96S7nzSm/Qi7kQK3NCSJQeh6uMsyx4YsXhmEzk6fwaUxwCwwYUoIlTNGRNKetwIpB8yZbKqvOf
	sgUqGr3WjLe0YM2fsGmySXhm8Arq6Bnjg/4jmNFq8JWItl6jaG2WthTTaKmfqdFbM4VGcEY9e+Q36
	Gqoki0Lc/zXyfyQ2JZervLfr7mAh7cVNAXMa8BBnuq1DZNoGKKCxbsgXFPr12zIocHobUH7u1KIMZ
	PGpOH/oa6rBoZC+qfBcjkGLipXSsd7khU9iX4OBpetS8P22gsVWrV59RA7VAh/umCDJglJ7AqFaTY
	8JKgG60yOBQY4fiBVdTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpDC-0056hn-0y;
	Thu, 27 Apr 2023 00:10:14 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCz-0056St-1H
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:06 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwqlV017095;
	Thu, 27 Apr 2023 00:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=75Jn2zmafPDZhmtzI/Kq6AU5iLzwZOe7CoJGlihTNLk=;
 b=MOXjt11P2QQBa/6vgt8DMX+0+ZgqCUaivtCph8kNnTLFgBTbUFLihY8agUGoQkhqCOXL
 0r3HEqV+4zssxzMNDVvjT0WWpU/tglDW6uKbJjRCvwYi199DE6+ohLNKqSrT7E5STFoX
 Jw9AKL4Zay68MyY1E2qTcYNTMMhyg/I5Ydd/AJyxqffV1b140ubkZsm9S9ROeOCfNvJy
 M3Zen9xmKgd3oPhKdrXmbDlq0nHMqHdvv6wJphA8J14HaVDW+6xqRy2BukjvxwL1tWMV
 OM2ISdxQsb1f1iT79Xjrs0hdyaPvf1E7CzCZ7AE3hZdsxWNpSI8UrQ6+k8mIlW6u0G98 Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c4arvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMDCSU007353;
	Thu, 27 Apr 2023 00:09:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R09394013888;
	Thu, 27 Apr 2023 00:09:35 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-22;
	Thu, 27 Apr 2023 00:09:35 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 21/21] x86/boot/compressed/64: use 1GB pages for mappings
Date: Wed, 26 Apr 2023 17:08:57 -0700
Message-Id: <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: HA43vq6yRTxbNgszb89rmJy5Zv5oWhzC
X-Proofpoint-ORIG-GUID: HA43vq6yRTxbNgszb89rmJy5Zv5oWhzC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_171001_596069_F5894418 
X-CRM114-Status: GOOD (  16.06  )
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

pkram kaslr code can incur multiple page faults when it walks its
preserved ranges list called via mem_avoid_overlap().  The multiple
faults can easily end up using up the small number of pages available
to be allocated for page table pages.

This patch hacks things so that mappings are 1GB which results in the need
for far fewer page table pages.  As is this breaks AMD SEV-ES which expects
the mappings to be 2M.  This could possibly be fixed by updating split
code to split 1GB page if the aren't any other issues with using 1GB
mappings.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 321a5011042d..1e02cf6dda3c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -95,8 +95,8 @@ void kernel_add_identity_map(unsigned long start, unsigned long end)
 	int ret;
 
 	/* Align boundary to 2M. */
-	start = round_down(start, PMD_SIZE);
-	end = round_up(end, PMD_SIZE);
+	start = round_down(start, PUD_SIZE);
+	end = round_up(end, PUD_SIZE);
 	if (start >= end)
 		return;
 
@@ -120,6 +120,7 @@ void initialize_identity_maps(void *rmode)
 	mapping_info.context = &pgt_data;
 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
 	mapping_info.kernpg_flag = _KERNPG_TABLE;
+	mapping_info.direct_gbpages = true;
 
 	/*
 	 * It should be impossible for this not to already be true,
@@ -365,8 +366,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
+	address   &= PUD_MASK;
+	end        = address + PUD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
