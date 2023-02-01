Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08097C636D4
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1snwNmdg4GKLmVgYZ/GW2o8jDVSZZbQYUr5gRlFRFLQ=; b=PYb6Cg2mRNxzKr
	/6IAxFmEIqBUtDpbExpM6qbxbp2bH+7eAEhiA0kK5/EDeY3NoPGOxAav9uFIxX5w/89xb+lQ4awnJ
	Ij4GIGe9sjaIbRNtuaww/X6ePs5G3K/DmL6HlTfMGM+TXAoyCgTOsucEMyH7Z9JL4N0WB4TUsWdmk
	2wvGV007yh+ewq4yTkvr/LOp7DZLk+Q1Fx3PILbGnqxjLZyWyvhIxQyswAPF87nQj9KdMrz7PDSmI
	+VCn4hSbEBw4HfeOw52+5RhTkcpCp5ynPXZ04vvfP15Tkz3RlwQpFBaYSqLxwNy4FiH7L40goCxF8
	dd0sZ1mKLMzcqugq9tnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6lt-00AU9t-D4; Wed, 01 Feb 2023 06:39:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6lp-00AU70-US
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 06:39:03 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116WkgT030548;
	Wed, 1 Feb 2023 06:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m65mGdxTxz0vZ2S6XQxir16/8e9Co28R2vcwboa4HDY=;
 b=JRiQwoRS4AGPYqQRt6jEEAz7dcXs4Vc/8+T+ZMnGplekXiXRxAvYznxvsn4JBSvTRR8X
 gFkcpUdAE/sq8Lz7Q9u0Vxv5V/p9+qw/65ceRoNfGt8cqid8A7oxc1VflHwMdlcFbEd2
 7q5GZjtQRIWZcR0SPdQkhADwSKX65478Cp8GWdr3Enz+5dxtEUBhiWPjIMXshR/n8214
 e7HBDsKmIWAxvOigxtrlts0K90nuJhsfMlCbo7XnkGMK7rz2bvgwGByEKj1UUWZfU9ud
 0oUvoxolV66WeqIXNEU76ZvUjESVCqso6LyBDCnUV0PIIceALfN65m2Cr4j0R2pHkOwu hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjwer46v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:54 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3116csah015077;
	Wed, 1 Feb 2023 06:38:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjwer465-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDk6w8013332;
	Wed, 1 Feb 2023 06:38:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtycd7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3116cmFT38732272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Feb 2023 06:38:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316F42004D;
	Wed,  1 Feb 2023 06:38:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 702F72004B;
	Wed,  1 Feb 2023 06:38:46 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.109.52])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Feb 2023 06:38:46 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v8 2/8] powerpc/crash hp: introduce a new config option CRASH_HOTPLUG
Date: Wed,  1 Feb 2023 12:08:35 +0530
Message-Id: <20230201063841.965316-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AELjHUX4EhuFHV5SxPFH2scW34GgrbwN
X-Proofpoint-ORIG-GUID: atahs6EZRJHil5zkF2O3Og8z-1aZ7BV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_223902_005981_1780FE5F 
X-CRM114-Status: GOOD (  16.79  )
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
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
