Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C26E81BC1
	for <kexec@archiver.kernel.org>; Mon,  9 Feb 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E99UjzahJoh/VA4vXZ/zEs5mNIw9KoG7wg4twFUubKg=; b=IAD+KVbOd8I3mOxbfVZs0hE9qH
	y4NAZJA0w43Sxg26SdlG2RNKQLs/5EXG9xQ30F3Kq2afMJaVu7oec92xDbpldt+ayVJITWOxYqHgv
	NuK02w5yvf6aptpMweyNyCoM686UXyK2uoTlETwfHXGGeoMl7NFf93zjtbxXMwWt5U2Maonk4UZOk
	axQv00iBG/TYGEsBjCin9v0uDS2Tk2U75z+fTDoQqtAJT+r0OoU3N4S3HkDPfOTnSJSamEkiaC8fK
	DvWq9ubfISuUQWyEtwiS9HYiq+lXMdVhovHkDvC+ubDZxm1PfbXePL2zyF3NvthZimJIQp/T135tw
	qeOWVeiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpROD-0000000FRkg-0vg9;
	Mon, 09 Feb 2026 13:33:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpRO9-0000000FRk3-3L4d
	for kexec@lists.infradead.org;
	Mon, 09 Feb 2026 13:33:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618HPHqb4037824;
	Mon, 9 Feb 2026 13:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=E99UjzahJoh/VA4vXZ/zEs5mNIw9KoG7wg4twFUub
	Kg=; b=mL0aa1jchipFnQtVKJaFEWsvWyj6VxHHltjTzC+dc4tMmQR6vXI6HEtAF
	KyVrJMH/b5CMA0UEO4p2HcELrFqLZFz/gbs3VuGtD3Dx774v8A284Dx2N8kMRdC5
	E1UBpOa1xeYvb20dOiz4HszqwxFYELYpuXBOX5FbCs1UfSvwsh3W8uzQUrCf/8w/
	/6IaVzipkJtV6FT2TOMZbrDP7xuGMFPrxaVCq/qJeTxuVveeim8Ir6c8qH56MSse
	HvTq8KiggzH+/kQNld/5RlA8jeTrqQRQ/NT+jcfvdtpOb8d6opcP+MCcu2+Xg04h
	zZVyWy6hdvBhyQnIlZErIB7ZNU3eA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u79jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 13:33:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619Cm1ix008404;
	Mon, 9 Feb 2026 13:33:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y5cuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 13:33:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619DX8xv29294886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 13:33:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC1720043;
	Mon,  9 Feb 2026 13:33:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6776520040;
	Mon,  9 Feb 2026 13:33:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 13:33:08 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: kexec@lists.infradead.org
Subject: [RESEND PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n
Date: Mon,  9 Feb 2026 14:33:08 +0100
Message-ID: <20260209133308.118364-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=6989e217 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=PG3QJfdP8arlf4ZJmCEA:9
X-Proofpoint-ORIG-GUID: 6otux3NwWeWGvEugXBEgH08Cm3jXXNeO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMiBTYWx0ZWRfX6wh6cT/oWEf/
 4Iz9ISml5A1hisU6lY8/ECJnXHYLg2qW1WXMv1jl1UEPVVznNO6TZApAe6/O8UyBO0vCEV1TZnA
 kkET9PS6DCvxlPsUwIHEO0gLAltSXr0XKhIWM9opxJKWKocK/pKyFcxlw5tATWGlkbB4WJ7/l6t
 qPDe5fDiu17CEE4NKt1uIDI7Hy9QeYNh/4SMroRqcnljjAANaAK5inG45x8PgdC00WMhzaFssMs
 MQwtzu3YuWn42Vpz4OeSsV2uJPE9rqgR3mOPiAtlw4c85RGeTrqigh4w1t4W9FpXmSQu+4ikRiP
 JvGrpwMYx8/0EzfFopn3Hx7Pr9immUV+/L6JY6yCiyTOtPmt/+pqypn/AuyBCJ630WUwEyIYyjm
 m1ScL09OtpV2BmVTOH/0B245BFyfymRup4c/n3lY0UWvbHyzWvEeeKTW826OOf4QTkH1u0C57rk
 wdd8r1SZsI3nlqMeODg==
X-Proofpoint-GUID: 6otux3NwWeWGvEugXBEgH08Cm3jXXNeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_053317_911231_1258E8BB 
X-CRM114-Status: GOOD (  17.16  )
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

The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
in s390 kernels built with MODULES=n if nothing else selects
MODULE_SIG_FORMAT.

Furthermore, the signature verification in s390 kexec does not require
MODULE_SIG_FORMAT because it requires only the struct module_signature and,
therefore, does not depend on code in kernel/module_signature.c.

But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
is also incorrect because it makes KEXEC_SIG available on s390 only
if some other arbitrary option (for instance a file system or device driver)
selects it directly or indirectly.

To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
as well as MODULES=n _and_ also not depend on arbitrary options selecting
SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.

Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 arch/s390/Kconfig    | 2 +-
 kernel/Kconfig.kexec | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c2c7bf974397..385c1052cf45 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -313,7 +313,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool MODULE_SIG_FORMAT
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool y
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..df97227cfca9 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -50,6 +50,7 @@ config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG
 	depends on KEXEC_FILE
+	select SYSTEM_DATA_VERIFICATION if S390
 	help
 	  This option makes the kexec_file_load() syscall check for a valid
 	  signature of the kernel image. The image can still be loaded without
-- 
2.51.0


