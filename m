Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A2CA0FFE
	for <kexec@archiver.kernel.org>; Tue,  5 Sep 2023 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XFpohTxM6T2fBHCvVYwGFEDtMsbBuymHbst6B901Q6k=; b=lfq1PnAIGrAC1k
	66W4UWwUQC/xmN+37qCuzQxdCSOLXY8ulqfiuyjUN68mAMI14J2t/gp0ncPLub6LzKZvzuTr7lIKS
	TuoYWJyR4lbIAHz5lgaPm85XJ+rvGpMVj2KQ5HSj1TqhlL9fSBOUKUC7rijRFwMoe7d7WqOy/51TY
	3CAA3WdcXqD/V/u2YvXp888n/oS8gv/evbIASinnekmM2Wf14a/kMCLTnwCSZTh/Ghh7huDFMmDEL
	q/vaTvEccpknNcTRl2AdQGQ1SAEsm5tLICyiD4i8qQlhHi/c+DdmwGmzdNPQtRQ6R7tmCXnGJobQw
	vn4ATZ0hZBlR4qnZvQjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdbIY-006aEC-2I;
	Tue, 05 Sep 2023 19:01:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdbIS-006aDO-1z
	for kexec@lists.infradead.org;
	Tue, 05 Sep 2023 19:01:12 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ioqli030192;
	Tue, 5 Sep 2023 19:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HvyTX23t2pOVcewRf3nAoZjwypivwsONmFIeeuU4W9g=;
 b=l1BeKBas8E6CamdCngZm2Mjtt2u+L/QAxetLp8dhD4paqr/EhBriCMWEymlhCJJ9O/oL
 0kQiM0xhawrI28NOdk2H+TdqUgql2gFJLWCljnVG2rMMUuc6yZl0d+J2Qgd7xIJHWKnw
 6QGeAmqxKVuQGNkzanZJw91JB7eiSWSYIQRGVB8WRIikK7YL+yPKPwp8n6bJVSPX3BKH
 SVTA3VHdORIwdgjDdMxrP9T4oHbwrIH8eJmSMwqg2lgC9rdaVt2uDGWvHPC3HASxgVa9
 AtcI0dKBCAe9/LKi1p62QdpFBPkJus127e5gch/Gmkw9gtEvn0fOeNE3O9jCuPzlT1VF 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9yj8ew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Sep 2023 19:01:01 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385IpmiB032287;
	Tue, 5 Sep 2023 19:01:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9yj8egf-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Sep 2023 19:01:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385Gk0xR026818;
	Tue, 5 Sep 2023 18:36:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcncy4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Sep 2023 18:36:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385IaCl935848664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Sep 2023 18:36:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 986AE20043;
	Tue,  5 Sep 2023 18:36:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7E220040;
	Tue,  5 Sep 2023 18:36:10 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.114.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Sep 2023 18:36:10 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/3] powerpc/fadump: make is_kdump_kernel() return false when fadump is active
Date: Wed,  6 Sep 2023 00:06:04 +0530
Message-ID: <20230905183604.568996-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905183604.568996-1-hbathini@linux.ibm.com>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sEYeUQ_oHj4_eNEvnwXeJyTGG5PRd7nD
X-Proofpoint-ORIG-GUID: 7ebkHgFSV3ndfIXSsck475kygx8x6FU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050161
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_120108_661561_D095BAF9 
X-CRM114-Status: GOOD (  15.55  )
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

Currently, is_kdump_kernel() returns true in crash dump capture kernel
for both kdump and fadump crash dump capturing methods, as both these
methods set elfcorehdr_addr. Some restrictions enforced for crash dump
capture kernel, based on is_kdump_kernel(), are specifically meant for
kdump case and not desirable for fadump - eg. IO queues restriction in
device drivers. So, define is_kdump_kernel() to return false when f/w
assisted dump is active.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  2 ++
 arch/powerpc/kernel/crash_dump.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index b760ef459234..f0b9c3fd0618 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -101,6 +101,8 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
 void kexec_copy_flush(struct kimage *image);
 
 #if defined(CONFIG_CRASH_DUMP)
+bool is_kdump_kernel(void);
+#define is_kdump_kernel			is_kdump_kernel
 #define is_fadump_active		is_fadump_active
 #if defined(CONFIG_PPC_RTAS)
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 9a3b85bfc83f..6d8e616ce3ce 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -92,6 +92,17 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	return csize;
 }
 
+/*
+ * Return true only when kexec based kernel dump capturing method is used.
+ * This ensures all restritions applied for kdump case are not automatically
+ * applied for fadump case.
+ */
+bool is_kdump_kernel(void)
+{
+	return !is_fadump_active() && elfcorehdr_addr != ELFCORE_ADDR_MAX;
+}
+EXPORT_SYMBOL_GPL(is_kdump_kernel);
+
 #ifdef CONFIG_PPC_RTAS
 /*
  * The crashkernel region will almost always overlap the RTAS region, so
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
