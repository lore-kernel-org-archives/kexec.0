Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B056AEA795E
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E99UjzahJoh/VA4vXZ/zEs5mNIw9KoG7wg4twFUubKg=; b=3XniD3myxENLrfuT5boqsivlzR
	Z+UHo9ONSxfxl6yRTtSuynuJ+qY3joiOkT2GRZvMoqE5H3RhcZewO3RP1auhGQcXYuHV+C888dB5d
	aLRU6xmws9/1kfwrdb1RSYqZ1od3BN511/OjXWNVNj6W61OifpOuKIxlTbr2sYdfDfwc/CJGj65rO
	v/KfyhxZpxEhpFJvbb3v4upy8VqlbDl61FQtUCzHzZpzQzjIRYhCrGi6t527UUEJAt0GPNeDz7k0H
	u5znMM0Cjzcao+qy/e1F0j5cls/HbNkf0K/6s0+P4GdFeZGq9R+JUkVibRlR+JIwGmOpFXwm96TNW
	7TfxQ3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voIZC-0000000B8Eb-3l4Y;
	Fri, 06 Feb 2026 09:55:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voIZA-0000000B8Dm-01So
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 09:55:57 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6162qaf7004012
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2026 09:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=E99UjzahJoh/VA4vXZ/zEs5mNIw9KoG7wg4twFUub
	Kg=; b=QD7k5VhX1GM2MmQCFZwsq9mn1oRAKu0qShmbedyDRKxlfK+/7ocMFjp82
	5Q86006WuCdJ9SG9SzgZ2geYFE/Tr+e0ExbD1tZI04WeBMaVv7nqppicVyPSgoin
	xhYRgKCWl5uOzQ4A6XMXt8I+WbgxSbj/JFJuAs5a1PL3E4zPfSdMEqzXy6jA/fwF
	L/eeC5T7ozbvsjFHXjT1zteDn9uQnl8shxCFhxzrL+ad5bqo5JQT5pRYwgwaO508
	KvDWjzqYdtFFtI5+gi35lyb3GOoSjp1jIzhVAHoW1zngkwCIVpj/HMDWkzPVUk+f
	LjW2OoRieIoqfnc92z73zuBikryZA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6u05w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 06 Feb 2026 09:55:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6168Fd4q027419
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2026 09:55:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs1nb2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 06 Feb 2026 09:55:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6169tpCO37224824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2026 09:55:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F0A20043
	for <kexec@lists.infradead.org>; Fri,  6 Feb 2026 09:55:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C43320040
	for <kexec@lists.infradead.org>; Fri,  6 Feb 2026 09:55:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <kexec@lists.infradead.org>; Fri,  6 Feb 2026 09:55:51 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n
Date: Fri,  6 Feb 2026 10:55:51 +0100
Message-ID: <20260206095551.2819451-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l7Hg-af3JM-ubylcVR4qWfnqLam2YWJw
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6985baaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=PG3QJfdP8arlf4ZJmCEA:9
X-Proofpoint-ORIG-GUID: l7Hg-af3JM-ubylcVR4qWfnqLam2YWJw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NiBTYWx0ZWRfXzAjbTYnD3VRm
 cao1CdfP0T3+VtCXaXlMV6/HeiWZQPl/krSYYxm17pN/2Py5g6Jts2W46Q+BQmA2SiXrrYMVW9L
 7JqKGdiNPSJQ77dqd9t0NwLV4Btd0ZGyXYJqkqRIXgSz3vKQ/AC7xlnrH2QqDO7y67qnDOytyxI
 /yasghx4zjDi88tM+en57bq0dQehWExLiNso9qxJCv3rTM5tIrIEdr8qhHnCGG4a5Kfkc8lKrJb
 KoydntbX4srFPo0Cgz96CBcSqbLk798ilfnowlAilcptGANERd8wYipvafO6B8ne/17HTYZJx9T
 k6mDYu1pdx8JkqBWUUbrSknlQ7GRVYruwNXmV8cfAUuusyM9OUYIPKtQNI80+ZXN8j5B28tEW0Y
 pyifzKdyL6c+ZdfMARF4m2sAwW50EL5uQZJ5cg1JxErRmK+qz0xDdMZ2H9TvMx7dd9sT5daFZ6T
 M0U/iznwRgvKTFeeIsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_015556_050486_9189E8D8 
X-CRM114-Status: GOOD (  17.75  )
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


