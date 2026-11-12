Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45C606A32A
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=piFAmCQG;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zg5SEKX/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MMnSDrSrXvV4F97gt6WM8daxklUWuNqIgikRmFjT6Po=; b=piFAmCQG7H23rb
	X+AngxB0VORxBchVMQBDzt+xVMZDLd1IO1t6M8iTD73xtVdqM2ogGa84aHGMT8YaRGdj4kKmEvmj3
	TeT47o/TFa5stuteF/QaPcwYHXPAMO4tsfCFfbLAVvPYyI/kzoWst/5ZL1KZuVWUFrZgzA8n+s/Du
	W37+pjzl6kz8W3xDUkUYPAKx302Ui/VpDB/9vG3/94pcBDYdp5PsbE6U+jxkfKoHzq4DX0Azk9Tbs
	lR8QFeKVvEeWtPJML/q/tGjb4paSxgalMownXDZyqwFj+FPokmJcNZEUN7r6CNYCRBjeGkHT+hiA+
	y1YK+Gq2bYMubumX876A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSrq-00000009fWb-3HT8;
	Thu, 12 Nov 2026 11:21:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSrk-00000009fRx-3yke
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:21:20 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iDTD2854172;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MMnSDrSrXvV4F97gt
	6WM8daxklUWuNqIgikRmFjT6Po=; b=Zg5SEKX/amD2LGPHYT4uVm7BiMxi/VVo8
	YQzyjUQK7RVgacwg8fMwFIKT31RQDodVj8+E4AzGTrbHnfoVQeP+V10TqjVshMCK
	O+4utPSfgpZmS1Ygvue0az4QtZD+h+vJGVCJXz6a0A/aegr53ED28oenWxf7sn2y
	1ga7BrYfvd6EdpMWBtYFl4yITsa7XckbYvtS7/8FtFkP42D9u8ETda1I/DFI59KH
	PyvicpsHMmFq9r7js4UxYe0/9R+JkkHv/DvqtjhFrb+tZzsv+Kp26trEsfLkqbet
	KBAoz7SB4La9gozgC8CXe9oKVzMIhBJjUXJ7khBDZa+O1H8Thhkog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq771pk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8Jadj016766;
	Thu, 12 Nov 2026 11:21:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328hhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL5It31392248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A140B20043;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 734122004E;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] s390/kdump: Enable crashkernel CMA infrastructure
Date: Thu, 12 Nov 2026 12:20:58 +0100
Message-ID: <20261112112105.1169118-2-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX5fm9gCXrtvvs
 jENSgShuIdasX7+rCHDZpd5oJvUj6Nx2AyB3wHuy3J3q5iuIZ5QVCKmJOXPnj5kMPgtq3ejXkU6
 xJNP3YJd0ZxhPpVHDFueK6UqLjywl3M=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af5a126 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=SCa88stCgWRd7v6xzU4A:9
X-Proofpoint-ORIG-GUID: WYNyKYsdZIHeuyg1NO0I0DxAJdSWsDow
X-Proofpoint-GUID: WYNyKYsdZIHeuyg1NO0I0DxAJdSWsDow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX1ZuujC63B89K
 7MMHcx9LS7RqU3LmSX7KatbW3BH8e9uMFhPXz2O16+jWjrWOZWVCyE1Ii8WEvNKYNdZBl+EVL4y
 mjxiAikCNgytuPDYwGr/1oAJU5mhqtqM1KNWy9R5HjfscseFrfpV/gZalaPKKzhDfVjBUEUkMwY
 mdDCCJ4KkQtJLzSxNZdz+l2fsWWG/9V4GiKhqlpkux4zFFbmyKy4hAKgJvaITz6Q41VnA28RiVf
 0ovNrZZNkK2evJmF4hWh0J5bc+fgCup3DiwB+eCIe/pDDp3g8/MLXDBgyN4SI7hympobaq1bGR4
 eF+BQIv68LXjitG0A0bgaAm0W9pahGniuDztyaGGvlOtcHFd6RSwDnveJAWZXnXyuc4s/Xa9EoR
 GbgxNYHgYUrrG7QY+6436AjI0q3Pvy/b23bl1jLNMg6awOwXI3qO8CMxpBcOe+93NEZeR6ftbZo
 BfdVkIgePmi5MsVKFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_032116_997495_D218F3E0 
X-CRM114-Status: GOOD (  16.70  )
X-Spam-Score: -2.6 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION to build the generic
crashkernel CMA code: reserve_crashkernel_cma() and crashk_cma_ranges[].

s390 keeps its own reserve_crashkernel(), the CRASH_* definitions in the
new asm/crash_reserve.h are only there to satisfy the generic header.
arch_add_crash_res_to_iomem() returns false because setup_resources()
already inserts the crashkernel resource.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/Kconfig                     |  3 +++
 arch/s390/include/asm/crash_reserve.h | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/s390/include/asm/crash_reserve.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7138d923d86f..1a99fcf520bf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -331,6 +331,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
 	  This option also enables s390 zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_RESERVE
+
 config ARCH_DEFAULT_CRASH_DUMP
 	def_bool y
 
diff --git a/arch/s390/include/asm/crash_reserve.h b/arch/s390/include/asm/crash_reserve.h
new file mode 100644
index 000000000000..7e04db630bc6
--- /dev/null
+++ b/arch/s390/include/asm/crash_reserve.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_CRASH_RESERVE_H
+#define _ASM_S390_CRASH_RESERVE_H
+/*
+ * s390 crashkernel alignment and address limits.
+ */
+
+#define CRASH_ALIGN		HPAGE_SIZE	/* matches KEXEC_CRASH_MEM_ALIGN */
+
+#define CRASH_ADDR_LOW_MAX	(4UL << 30)	/* 4 GB */
+#define CRASH_ADDR_HIGH_MAX	ULONG_MAX
+
+/*
+ * s390 keeps its own reserve_crashkernel() and manages its own
+ * iomem resources via setup_resources(). Prevent the generic
+ * insert_crashkernel_resources() from inserting duplicates.
+ */
+#define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
+static inline bool arch_add_crash_res_to_iomem(void)
+{
+	return false;
+}
+
+#endif /* _ASM_S390_CRASH_RESERVE_H */
-- 
2.55.0


