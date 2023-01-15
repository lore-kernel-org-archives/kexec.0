Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D0EC677F1
	for <kexec@archiver.kernel.org>; Sun, 15 Jan 2023 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwMSGOWHhBUE4xdm/AWzQE83KztPBDRQxXzC1RHlB/o=; b=nKvP2k85Kxym13
	jt0wWMuNfPwXlJN0Ds6kBGYAjVGtRC7lh5SQCrzk8w7Gt4Er9naxAs+2mI19tJSd+QCYkIjCB5xAq
	WoMrQIX2z+v5vWUuISdniwD9u7fzN1sbb/zi1quoFN3v800pu/p4W9SxNYLBpOiqxnOSc/lp3er5F
	NiQQNAuk7btDNiDFBqQP0Owu2YMv/GjiYD6YBOYbUPEgFTIJQXR4pHYkBRBvkhtDoDDOkieYoyLl1
	ARKL+nNDfdzCUO7xYjfDSp2llrdXFdGCs51iekQFh5yaT0IAo+vSLPsXr0zzMRm0U3bsRw96RxsAs
	C6Gm1kLhqOmfy0gb+XrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wn-007Wv7-Ku; Sun, 15 Jan 2023 15:02:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wh-007Wtt-49
	for kexec@lists.infradead.org; Sun, 15 Jan 2023 15:02:28 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FA0ZE3003271;
	Sun, 15 Jan 2023 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OCFumllfuBLc2VhtMqLZU9am/tzTi/zOyqgoHLCsWvA=;
 b=KiGfIgeCRrRHX8M2JnRx791fPvWdMTX/EpEb0Pvghqndc+r8QIQIlRSqXjbhXTGGsEAB
 rPomPDm4Wyh4p1slhGh7+KsLTBuMwh+e2Bavf/ePFCdblumwi9PFIyjUIA99NudB2c+l
 aoT2BJpLW0lpb+0DY6BGCPTzy94oinjN0BELnWlXrTLYsKt4I8E4iu4jfQYGyej6Fbog
 qmIV9ScHOJmDNRAJBB3nEtG2E5FCISY5QvtlS/Npho9FN0Ej0kdScG83RGKicdn+RMBg
 9CbRB0wel4byUCsSh/qYP4KbAuD2nmDQlmKXQzRD3gAsUAlgfVGxbL+fzGRSwruKxh29 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4aphyfuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:24 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30FF0Ac0021872;
	Sun, 15 Jan 2023 15:02:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4aphyftr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30F1sdg4004735;
	Sun, 15 Jan 2023 15:02:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16hd2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30FF2ItM24052422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jan 2023 15:02:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1604F20040;
	Sun, 15 Jan 2023 15:02:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBB62004B;
	Sun, 15 Jan 2023 15:02:15 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.71.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jan 2023 15:02:14 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v7 2/8] powerpc/crash hp: introduce a new config option CRASH_HOTPLUG
Date: Sun, 15 Jan 2023 20:32:00 +0530
Message-Id: <20230115150206.431528-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zmd5Gzrv5l-2szG-pB8auxfFRS8f5pCa
X-Proofpoint-GUID: JbF89hEym_y-0TN0WtS4VN2mdPeF1C6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301150116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_070227_185722_20834375 
X-CRM114-Status: GOOD (  15.68  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The config option CRASH_HOTPLUG enables in kernel update to kexec
segments due to CPU/Memory hotplug events. By default it is disabled.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b8c4ac56bddc5..57d18cc5d27c5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -668,6 +668,18 @@ config CRASH_DUMP
 	  The same kernel binary can be used as production kernel and dump
 	  capture kernel.
 
+config CRASH_HOTPLUG
+	bool "Update crash capture system on CPU/Memory hotplug event"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  In kernel update to relevant kexec segments due to change
+	  in system configuration, rather reloading all the kexec
+	  segments again from userspace by monitoring CPU/Memory
+	  hotplug event in userspace using udev.
+
+	  If unsure, say Y.
+
 config FA_DUMP
 	bool "Firmware-assisted dump"
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
-- 
2.39.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
