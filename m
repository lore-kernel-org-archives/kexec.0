Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF37E7719A
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a51YAcOPHw8REYfzDT6Mazib9DPYr/BR2XxrvtalFWU=; b=21s/7+d1YnWl1etDrfzkTR5fMs
	DT8/3LIezppxZhr9eggPu143gN0y9vkG/xTq28ABe+sKR2rCINQnUO1Pm2OdXH8VtT2L7ZbVvKAjv
	U04omWP7SfJHcxp2AMR4zTytn2oLpb96yMxJr6rRYt0RSWyFbTsrWKugMbFfnsPaxm9TubDGbxAjm
	NDmUBbA0EcqWPsesxHXKlEFxvz2U+PkIiTNJdDJGY+3NFIR4UnALJbGMiuMf4j2xzrD6IDgaNT5Z+
	IsTITEVXXVxISeL5szswqgdaGoZhd9CHf8+wgAVedZvQ3uaZCETASGlhnMkyEuWaOoH94/841I0kl
	q6HooQ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTD0-00000007y15-3xTT;
	Wed, 08 Jan 2025 10:22:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVT5s-00000007wID-3C2O
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 10:15:21 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5083qf6n016007;
	Wed, 8 Jan 2025 10:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a51YAcOPHw8REYfzD
	T6Mazib9DPYr/BR2XxrvtalFWU=; b=AhQVV8QQxG72eHttCWIWd7bZnZ4zNd1lK
	XgKDaycUXuF+UdHaJoHJMAdqXbmy7ZqZNQhsiNU9jwZf21NRNdqs8w1t/0+KpJbD
	Wtb1wlarDFdpZXvg9tklkkvVtXlEsJU2M47sEuJ5eTKI9wYgng25sGXr4EJOSTOZ
	JWSL5YPI2X8Lhmr4T2DFfETcG15EqzB/upXHMGMFQS+r+EdjNyIiABLCeU3VpITv
	2Rc0VNOYL1TTGbFAl+uPJohFQVMKuLdTjIEbGfi+WOo68ekFbzd11UsPhBmbsTdX
	qqR7TLOSE1uHj897zpkWHs6SRQ+ogLp+VPrcUjZfq17gsHCftpGzw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc1ky5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:15:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5089UHKo015798;
	Wed, 8 Jan 2025 10:15:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtky3vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:15:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508AF6h341746916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 10:15:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B8B20063;
	Wed,  8 Jan 2025 10:15:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FBBB2005A;
	Wed,  8 Jan 2025 10:15:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 10:15:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 1/5] crash: remove an unused argument from reserve_crashkernel_generic()
Date: Wed,  8 Jan 2025 15:44:54 +0530
Message-ID: <20250108101458.406806-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IU4BIVkhGg9N4NI_oMQyJA8sLG-MN9Wy
X-Proofpoint-GUID: IU4BIVkhGg9N4NI_oMQyJA8sLG-MN9Wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=872
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_021520_804297_9CA14D44 
X-CRM114-Status: GOOD (  15.83  )
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

cmdline argument is not used in reserve_crashkernel_generic() so remove
it. Correspondingly, all the callers have been updated as well.

No functional change intended.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/arm64/mm/init.c          |  6 ++----
 arch/loongarch/kernel/setup.c |  5 ++---
 arch/riscv/mm/init.c          |  6 ++----
 arch/x86/kernel/setup.c       |  6 ++----
 include/linux/crash_reserve.h | 11 +++++------
 kernel/crash_reserve.c        |  9 ++++-----
 6 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ccdef53872a0..2e496209af80 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -98,21 +98,19 @@ static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 56934fe58170..ece9c4266c3f 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -259,18 +259,17 @@ static void __init arch_reserve_crashkernel(void)
 	int ret;
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base, &low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base, low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static void __init fdt_setup(void)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fc53ce748c80..750991df9e52 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1377,21 +1377,19 @@ static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
 		return;
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 void __init paging_init(void)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f1fea506e20f..15b6823556c8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -469,14 +469,13 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size, low_size = 0;
-	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
 				&low_size, &high);
 	if (ret)
@@ -487,8 +486,7 @@ static void __init arch_reserve_crashkernel(void)
 		return;
 	}
 
-	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
-				    low_size, high);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 static struct resource standard_io_resources[] = {
diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index 5a9df944fb80..1fe7e7d1b214 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -32,13 +32,12 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 #endif
 
-void __init reserve_crashkernel_generic(char *cmdline,
-		unsigned long long crash_size,
-		unsigned long long crash_base,
-		unsigned long long crash_low_size,
-		bool high);
+void __init reserve_crashkernel_generic(unsigned long long crash_size,
+					unsigned long long crash_base,
+					unsigned long long crash_low_size,
+					bool high);
 #else
-static inline void __init reserve_crashkernel_generic(char *cmdline,
+static inline void __init reserve_crashkernel_generic(
 		unsigned long long crash_size,
 		unsigned long long crash_base,
 		unsigned long long crash_low_size,
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index a620fb4b2116..aff7c0fdbefa 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -375,11 +375,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
-void __init reserve_crashkernel_generic(char *cmdline,
-			     unsigned long long crash_size,
-			     unsigned long long crash_base,
-			     unsigned long long crash_low_size,
-			     bool high)
+void __init reserve_crashkernel_generic(unsigned long long crash_size,
+					unsigned long long crash_base,
+					unsigned long long crash_low_size,
+					bool high)
 {
 	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
 	bool fixed_base = false;
-- 
2.47.1


