Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F011C0218B
	for <kexec@archiver.kernel.org>; Tue, 21 Jan 2025 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qADcYPa4bM+Ff0Qcz2KjMujcQUaYXmGNS3B1iOxKeEA=; b=FRi88Th9PJ9+kQRyF8q6gRcGG7
	GktjJOUyJ3blByTteWPQlgKp1GxEPu37CE24Dsjs8/3FKWB00/NXKUrVTIEuBX6XvHkfP1COcGdp1
	3KtX5tURhItSiFiEIbpc0Iah+Io9ZuROMhQxVq/BLfaZ5et6VyWNW/JxbRpmZvZx+5E2pDUCt0XYM
	BbuqSk2XIZFGS7Fzk8PVnAkgiS/7Jwy0z0ao19UDZlHiUFNJLoRrLetjs0Fp6fml0g6u3qgsIhqpf
	+vp+KmAPoJkkJZozE4CsGW2yHiFAHDO4VSE8xsXpHbFmEdnB74Lagj+sAtc2LQD1SlGK5+RqtEkQq
	M1jhGHHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqg-00000007nNN-0sHR;
	Tue, 21 Jan 2025 11:55:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqd-00000007nKH-1Nxy
	for kexec@lists.infradead.org;
	Tue, 21 Jan 2025 11:55:12 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L7XLB5010140;
	Tue, 21 Jan 2025 11:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qADcYPa4bM+Ff0Qcz
	2KjMujcQUaYXmGNS3B1iOxKeEA=; b=GqpPwR/Eqv1J8y90NZHQ0vutCCG7DMz7J
	ZVmau3hFyjUr38ysRRjdZI9pmxs32g+5it1Oyv0o0bSZ9xAjhCqghhXDg5T0FtJh
	aKe2kDccy+MPYus3A3pGw/lZMIipEw/tlrzEVs+EAFTCUAqSbs72X9cRN6aXenuX
	KWxdLbdllb1r+6D55VoTHkRc5Mswb2dWKk411L9sAhJB3exnY9hHQFnHtyiibKKP
	fYewsXA3Uat8eRrfDdksElr6G8jtRTuMXp8zfbEFAcNhpkeyUK+sHn4F9A9kn2f9
	CjMOfYrQY9z5CtMhgWpB7Im5+DDQEH+hKohVzCFl1GoRA4/3qwPoQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a79n16ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LAtOU4021012;
	Tue, 21 Jan 2025 11:55:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1anh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LBt0PP54133066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 11:55:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE7220040;
	Tue, 21 Jan 2025 11:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC75120043;
	Tue, 21 Jan 2025 11:54:57 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.54.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jan 2025 11:54:57 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] crash: let arch decide crash memory export to iomem_resource
Date: Tue, 21 Jan 2025 17:24:39 +0530
Message-ID: <20250121115442.1278458-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gpkoxbm4_lMfrIfIwJce-msFe3yKyBvb
X-Proofpoint-ORIG-GUID: Gpkoxbm4_lMfrIfIwJce-msFe3yKyBvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_035511_491594_00E2FEE2 
X-CRM114-Status: GOOD (  18.02  )
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

insert_crashkernel_resources() adds crash memory to iomem_resource if
generic crashkernel reservation is enabled on an architecture.

On PowerPC, system RAM is added to iomem_resource. See commit
c40dd2f766440 ("powerpc: Add System RAM to /proc/iomem").

Enabling generic crashkernel reservation on PowerPC leads to a conflict
when system RAM is added to iomem_resource because a part of the system
RAM, the crashkernel memory, has already been added to iomem_resource.

The next commit in the series "powerpc/crash: use generic crashkernel
reservation" enables generic crashkernel reservation on PowerPC. If the
crashkernel is added to iomem_resource, the kernel fails to add
system RAM to /proc/iomem and prints the following traces:

CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc2+
snip...
NIP [c000000002016b3c] add_system_ram_resources+0xf0/0x15c
LR [c000000002016b34] add_system_ram_resources+0xe8/0x15c
Call Trace:
[c00000000484bbc0] [c000000002016b34] add_system_ram_resources+0xe8/0x15c
[c00000000484bc20] [c000000000010a4c] do_one_initcall+0x7c/0x39c
[c00000000484bd00] [c000000002005418] do_initcalls+0x144/0x18c
[c00000000484bd90] [c000000002005714] kernel_init_freeable+0x21c/0x290
[c00000000484bdf0] [c0000000000110f4] kernel_init+0x2c/0x1b8
[c00000000484be50] [c00000000000dd3c] ret_from_kernel_user_thread+0x14/0x1c

To avoid this, an architecture hook is added in
insert_crashkernel_resources(), allowing the architecture to decide
whether crashkernel memory should be added to iomem_resource.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/crash_reserve.h | 11 +++++++++++
 kernel/crash_reserve.c        |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index 1fe7e7d1b214..f1205d044dae 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -18,6 +18,17 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+
+#ifndef arch_add_crash_res_to_iomem
+static inline bool arch_add_crash_res_to_iomem(void)
+{
+	return true;
+}
+#endif
+
+#endif
+
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index aff7c0fdbefa..190104f32fe1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -460,6 +460,9 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
 #ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
+	if (!arch_add_crash_res_to_iomem())
+		return 0;
+
 	if (crashk_res.start < crashk_res.end)
 		insert_resource(&iomem_resource, &crashk_res);
 
-- 
2.47.1


