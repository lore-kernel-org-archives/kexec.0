Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D99C77B7C
	for <kexec@archiver.kernel.org>; Sun, 23 Apr 2023 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQSksYW5p4rY5xtrJazAAMBhi3Du1KnbV3DuyRu/cRM=; b=xOe68tYH9+JOGy
	vi5OnQw+7Wlv+fwh9RvFhKYoVpxUXLTkBVrmOsEtIhYjfpP4AMzhakktuxajPMY/mqvhHZax4hH0z
	z6O2OTT0yZE1mVpSW04kgwG+S883w48JGycnrL7fRKa0VvgbTRoJz6oLiFa44JQCfgCie463My2KL
	hJUrDFRdnqYAAI3egNHI7F4HwvQGu0waX0i3ngktjC/aE5b9z67tavR3DRPMUfTV0ESBvwqt0qQCo
	LEDEkjYwJrezLHCe+LZ3zEakZ1/e/HH1asIa1RIwSai/Jh0d67t1HIXNou6yVm0N9NmEs0pNrD60r
	HAJR3K1KtIMh2KnwBUHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKh-00EAu5-1h;
	Sun, 23 Apr 2023 10:52:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKe-00EAsq-2F
	for kexec@lists.infradead.org;
	Sun, 23 Apr 2023 10:52:38 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33NAbvGS030967;
	Sun, 23 Apr 2023 10:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=buqDzHLAFxsH4SxOQS7AgZWZ4bGNuNkFXJecuijWc9Q=;
 b=psYKhlkgyWIw8O1T9rZQx5+a/qIcwGDezYC2TvJ1KCs0u4lTah4p79VMgteqMOhPrkig
 EYi8Kjj2kBcTWmm7b1aKRWvi8enRVMAG9Z1xsZO+VicnDEsEic8b4sfqzln+viqFWAde
 C9JiaoU1h7yBeXiRyBXo0irfoRZfYypw6lW4neR5CqeAO5D5ls8I9BvIC2k6S1BT/pe4
 BjdT7KtZTvaTDHeMQz0WC9ESDJdv1B4yruqC23o7paUeHttiyQmPV5OpfzCJwrM8IJDC
 xMWjAacH8TsxiORtpKVRc1e5ZoAslxkGqy+Ngm8Pc591Lb0HJpNCNVERl2YIHPz/r3bG Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33NAidj1014139;
	Sun, 23 Apr 2023 10:52:32 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:32 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33NAnQ8I032151;
	Sun, 23 Apr 2023 10:52:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3q47770fvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33NAqQSW10224310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Apr 2023 10:52:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD4B20043;
	Sun, 23 Apr 2023 10:52:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F9120040;
	Sun, 23 Apr 2023 10:52:23 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.22.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Apr 2023 10:52:23 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v10 2/5] powerpc/crash: introduce a new config option CRASH_HOTPLUG
Date: Sun, 23 Apr 2023 16:22:10 +0530
Message-Id: <20230423105213.70795-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I4xUqsIW6nh5uw442fMtFxHIW2mBcK7d
X-Proofpoint-ORIG-GUID: XKOUMa_FE0WDGNmvglTm6Jp_Vts4kvx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-23_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304230097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_035236_853835_FFCEE683 
X-CRM114-Status: GOOD (  22.47  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, Laurent Dufour <laurent.dufour@fr.ibm.com>, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Due to CPU/Memory hot plug/unplug or online/offline events the system
resources changes. A similar change should reflect in the loaded kdump
kernel kexec segments that describes the state of the CPU and memory of
the running kernel.

If the kdump kernel kexec segments are not updated after the CPU/Memory
hot plug/unplug or online/offline events and kdump kernel tries to
collect the dump with the stale system resource data then this might
lead to dump collection failure or an inaccurate dump collection.

The current method to keep the kdump kernel kexec segments up to date is
by reloading the complete kdump kernel whenever a CPU/Memory hot
plug/unplug or online/offline event is observed in userspace. Reloading
the kdump kernel for every CPU/Memory hot plug/unplug or online/offline
event is inefficient and creates a large window where the kdump service
is not available. It can be improved by doing in-kernel updates to only
necessary kdump kernel kexec segments which describe CPU and Memory
resources of the running kernel to the kdump kernel.

The kernel changes related to in-kernel updates to the kdump kernel
kexec segments are kept under the CRASH_HOTPLUG config option.

Later in the series, a powerpc crash hotplug handler is introduced to
update the kdump kernel kexec segments on CPU/Memory hotplug events.
This arch-specific handler is triggered from a generic crash handler
that registers with the CPU/Memory add/remove notifiers.

The CRASH_HOTPLUG config option is enabled by default.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 arch/powerpc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a6c4407d3ec83..ac0dc0ffe89b4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -681,6 +681,18 @@ config CRASH_DUMP
 	  The same kernel binary can be used as production kernel and dump
 	  capture kernel.
 
+config CRASH_HOTPLUG
+	bool "In-kernel update to kdump kernel on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Quick and efficient mechanism to update the kdump kernel in the
+	  event of CPU/Memory hot plug/unplug or online/offline events. This
+	  approach does the in-kernel update to only necessary kexec segment
+	  instead of unload-reload entire kdump kernel from userspace.
+
+	  If unsure, say Y.
+
 config FA_DUMP
 	bool "Firmware-assisted dump"
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
