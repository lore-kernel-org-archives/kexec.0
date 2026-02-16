Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3C1E63F25
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 06:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sLdy+1+jDG8t7qH8K8wqnya/kQPdeXMTNShmHEWAGRE=; b=BMZXtcf75leOaoTF7a04lb3l8H
	JGAUvwTwHx0gN1xC1A9XQwvNHgakVOmScOm5S4QgDoM9c0npxPUi4YQmlNhZNaAIWU+MR8Ay6R86Y
	k5eYopVYkjxwHyzUdvXuB3KmUYgGU/NsHnDhvtFXzxNJ3FdBFNqUy873PAirehFCO+XuI/kXEHfEj
	FUBQGAIoWsqy5mL1UsyH6h8/AlVefJBIkMQDfRWAgXeWyK9u2bAbKR3M0ebcbpOFFIQqiSjq+dAXe
	gjYHizKVi8QcW3Mk8MTJ9SwBAdaDJ133LBsP/9mUO3TOIM4X9zFvEWAAjX/mOBGgRiGBmkCHhlG/7
	RLps01SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrs6o-000000062Iq-1PxS;
	Mon, 16 Feb 2026 06:29:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrs6m-000000062IP-1RI9
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 06:29:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FLeRP53631665;
	Mon, 16 Feb 2026 06:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sLdy+1+jDG8t7qH8K8wqnya/kQPdeXMTNShmHEWAG
	RE=; b=CwkCukL6b4+W33UhhTDVCDII5QuxJfupxjK0NvBlfbYCRJBLZy+NL/wYe
	pxSvWRSb9/IYcJxxtBTIgSCq9yC6qyjAHpnzHiFZjCm5Cj0j2y69IsMneOvXPDjI
	xOtGGJmpCWcAJmrTz3gLjb3eSUka5WqcI2yD9IUTlhNb32fSjHrdT7yEHbC92Xki
	QWPALnk6JPC8rLS2U1Dvde1LygisC19FLEGMBvD0yc+WZpZb8v8JoxUgxGN6XpjI
	mvwzXQD2dzMLQAX7QrwHBiY5wElByOfVruywsOkUCZdBmL+cBzH75ipOHUsLt6zb
	OuMV371vLfrSLm1nog6V9yey9ksAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj60qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:29:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G3P2tS029073;
	Mon, 16 Feb 2026 06:29:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb63140tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:29:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G6THAL31260978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 06:29:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F5720043;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3CD520040;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: akpm@linux-foundation.org, bhe@redhat.com, gor@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n
Date: Mon, 16 Feb 2026 07:29:16 +0100
Message-ID: <20260216062916.818071-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rqyoeAl6rPuKv2bmwXPx0AsqhJcm9Qme
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992b941 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=xCAFoSNEsD0Fk5WBT_MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1MCBTYWx0ZWRfX7Wel10NfqARt
 9SdTaNdwbeeqhFyX4ePgfLq/QVcBZDexeJnzQamyvJ7vhZMeCtsh37qVjkQdrE8VNDDORKH0tU7
 QtSGhBGiSpKgg+OLC7njNRThCysoZqrfyW8ltHHPxoNUh3y1dprQeVdW5v00n4i3cDYBkU19Go2
 um0xlPYpUZ4CQFTxj20OSbmvb38F3BUuNo8T7g/8/EajRaU6zOG6V4LNx1DFCbNOb1ctD5inHXc
 NJcEcosiJgYknbAo/38MIE0xXOnR4m5IWiXzxNAXt1U1bBPm42qcGTvER5M06G1FiS3Q1iDXU0G
 CJiduBIS5fv0x4Qijt9TRJ3VTa5Iicx1HzCe0LHm5EyVLGN6RrxAtRFOQkLVujs4/GyPNcEr/ga
 3Kghp9ZkaADravFqpUlyJ2YmVrR+wWPoYIqNc1VOsVMqeUtvOXZpKL2IstgxDseWI2fx6BcZxS5
 V96ZEz6Vw6pQ7zQ1OkA==
X-Proofpoint-GUID: rqyoeAl6rPuKv2bmwXPx0AsqhJcm9Qme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_222924_499475_4DB3C685 
X-CRM114-Status: GOOD (  14.48  )
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
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

Changes v1 -> v2:
- Let S390 config option select SYSTEM_DATA_VERIFICATION if KEXEC_SIG is selected

 arch/s390/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c2c7bf974397..edc927d9e85a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -279,6 +279,7 @@ config S390
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
+	select SYSTEM_DATA_VERIFICATION if KEXEC_SIG
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
@@ -313,7 +314,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool MODULE_SIG_FORMAT
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool y
-- 
2.51.0


