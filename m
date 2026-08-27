Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765D1C61DB9
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9Wsdf8rVeG8RWU3k0TB6qxezFClQPADVajE5uS5jrFU=; b=Mu8Jy9kDF6Tywkc0BduV/0P/CE
	Dtwd2p4i/lSwOvr9JjvharBbXNsPZYZZ9gaWUgkxESJVrTdmPsz87fiaIvJLrtNcjZZ9BiZQPY0Kq
	bG2+mEyTZHqPOFj3l1+n/EuDaHbX5OLO+43xkDXLImblajgO0AJ0ir8r+u7OQ8pPlHZo/FxfWoU25
	uVrkUEBexvijhu+9EVxttkv8uVPem1XwCri31pGNgl9yYPzxSQyxorv1LfslGxMNo9S6ESrT9yV+H
	+weiG03bQKKM9FT2ttUeS3CSbBGVHmerw3PSNBdMLwFQ43ftcgEXTZLfYYbKu8Zb2LSfpOjRMr8SQ
	1w6XwruQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzbM0-00000004BmB-2JHd;
	Thu, 27 Aug 2026 14:45:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzbLt-00000004BlQ-0xwk;
	Thu, 27 Aug 2026 14:45:16 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67REVxiP3333991;
	Thu, 27 Aug 2026 14:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9Wsdf8rVeG8RWU3k0TB6qxezFClQPADVajE5uS5jr
	FU=; b=K1kUxPgLYOP1BZT45K3gVMptFc+QZVJSTvqyRbbeqRuOE0ZW14Ebjevcz
	PkhQOi3MJUCnPAf8FlbSSq2gJeWWeu++0vwJlHYLI9Q6bwoospjVQT2XoSjGHtTU
	Eimr0l33CMDErEIHdBIV/PpT0PJmXw0/gPO4ywFy6ly3d4NiR3vMYRRowtatbmrr
	aWdAMk9DjzgA7Rcm5EgFAIfUvXZsKYBW12fP4QDxHZz2BFHLLQXfxnzyLLPnERCR
	vr3A8YSiK6DrkxqV81QJchBY3wjSFM0OvcfkVd0nBHOccEgrL8zCwraAC1ZlYNZp
	COeVMLQyJgJkeuaimlGv22x4jKvcQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxnn5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 14:45:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67REfF4O026300;
	Thu, 27 Aug 2026 14:45:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsygasf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 14:45:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67REj2em37487042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 14:45:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258A12004B;
	Thu, 27 Aug 2026 14:45:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E7920040;
	Thu, 27 Aug 2026 14:44:56 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.domain.name (unknown [9.67.160.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 14:44:56 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH] kexec_file: remove unused arch_kexec_locate_mem_hole hook
Date: Thu, 27 Aug 2026 20:14:52 +0530
Message-ID: <20260827144452.508328-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXy84UX2sXhnLT
 LaNtJyz+aF9qIImZWKYxb+r7rlmbGmQIil5i+oGlFlw1b1IUSmp2nZelsysTHq5Dk9d6uTnpgpd
 V6ufqUDaM75hzMTDTCmE5t0hrBuHR6Y=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a904d70 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8
 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=RFyrcEgT9I63OMj7VqIA:9
 a=HkZW87K1Qel5hWWM3VKY:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: La38qUEpUZRLxheRuQ91YouAfAvZu4Kz
X-Proofpoint-GUID: La38qUEpUZRLxheRuQ91YouAfAvZu4Kz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9uFIUwCD1ZsR
 hMFNu0gvVhiL6e2uEo8oTTVETLUBxFNVWFkrUG2fcRXH1u9GDVoZ9ZEZuFeKzF+b0b2VbE1QoIj
 08ZpC8j3Uar9R0J+wRE/MQDivcmA0s4sL0A05P8dHYGZ4XpFMa5bwMbWll2VyHkp1y117NtHuJc
 XlSijr+5KDKXpaUj04Dr7/tEz7ohGAM4fG9ak6+q5K+U85aqLrDHUvxu7/jykAs8lVI5NhDPiYw
 iO6XG608zXp+X7SXW9pzDiXPzjWYmWMkHqZba4Bg3zUg2pU/r6zauHiOU/UY6N5gLG95VcFSrxT
 xIRMKkVqL2D5W7Oub8ykcBARuHHaTwn47BvrGx6gosqHE/VGM7p+t+sWjVhNIwA9y3ffk663ZFZ
 wETs83wfBC1jECRppsospXXsMbIjHHTsAf5CRJGPc7hMAWDPlliyDrjaINHBBT6uP1Bafu59r/j
 /RcM5YQm1ZD1OaR2fMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_074515_425368_4637FDE1 
X-CRM114-Status: GOOD (  16.31  )
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

No architecture provides an implementation of
arch_kexec_locate_mem_hole(). Use kexec_locate_mem_hole() directly
and remove the unused fallback wrapper from the kexec header.

This simplifies the kexec memory allocation path without changing
its behavior.

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/riscv/kernel/kexec_elf.c |  2 +-
 include/linux/kexec.h         | 15 ---------------
 kernel/kexec_file.c           |  2 +-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
index 3e9a32acb8f2..ca5abbad59e5 100644
--- a/arch/riscv/kernel/kexec_elf.c
+++ b/arch/riscv/kernel/kexec_elf.c
@@ -91,7 +91,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.cma = NULL;
 	kbuf.top_down = false;
-	ret = arch_kexec_locate_mem_hole(&kbuf);
+	ret = kexec_locate_mem_hole(&kbuf);
 	if (!ret) {
 		*old_pbase = lowest_paddr;
 		*new_pbase = kbuf.mem;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0af8ae4fdd08..e5f1cfc11fef 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -259,21 +259,6 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
-#ifndef arch_kexec_locate_mem_hole
-/**
- * arch_kexec_locate_mem_hole - Find free memory to place the segments.
- * @kbuf:                       Parameters for the memory search.
- *
- * On success, kbuf->mem will have the start address of the memory region found.
- *
- * Return: 0 on success, negative errno on error.
- */
-static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
-{
-	return kexec_locate_mem_hole(kbuf);
-}
-#endif
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..9a981359addd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -784,7 +784,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	kbuf->cma = NULL;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = arch_kexec_locate_mem_hole(kbuf);
+	ret = kexec_locate_mem_hole(kbuf);
 	if (ret)
 		return ret;
 
-- 
2.55.0


