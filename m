Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C6BC6FD19
	for <kexec@archiver.kernel.org>; Sun, 12 Mar 2023 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UrVLWEY38HbjeBzB5d4kZUTV8QXyMzdCr2ixhXkRgD0=; b=28HZdEhF/cxfPq
	s2ImBro/t48px2Z8t6P7LfT59rKJ/FinzspAxyiiarnbZIzTPNDWczqBmP5Ekp2v7i9rtrrg1/kTZ
	yOVsuYesxBOSbOQwU5kGsgBfaBNWCEZCO5Prx10mKiZujbEIOjaG/HAkljpWWdzZMOeK6Zi2SPSw8
	1sN6TbQQRYjtyLrV1XEfmhTYyioQ1vqmqIfxmK42F2+H2yGmyZJZPzUxq7LMZgK27MfD1QnptCTaO
	dIS3hUc9P0DiRTOoiktBgBVjrgRfAeoeVLURmQygQLKiq0N2KIs/cMHwCCFElF7Yd2+JQbt/7UfJp
	m/0NpWF43En/9hM+oNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQBa-003C8S-0O; Sun, 12 Mar 2023 18:12:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQB5-003Bv9-6Z
	for kexec@lists.infradead.org; Sun, 12 Mar 2023 18:12:20 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CDlg3Y032398;
	Sun, 12 Mar 2023 18:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v4+W7iLwDkENrMgS0t1GRZ5k52HErGpCeDnmSQgxtio=;
 b=Dyxbw7gdVm/Xdg+Mr3ZkipN9Svu3vTCK09J7orYv6eLvWzncHVsp9itGAn3APrLv1EyW
 IbBNa7OXTadfBYF8jiZcQGlpGmeerj2qKA7t7HbKRwaQhXHaNwJ10TuYRk4w+dRNlDDF
 Di1im9vjpXXiT/9/ZXhzeOoGG2/s4EUo1P0itMYH2YvrjGOffpe3mssYKhFzRqDMnemg
 uwsMjcBiyySHCcVyySNA+83gRtYE3amjYPhNx9j7f3Dx2auMcS8CkWtIBu71et4FxNG1
 1ELu/zQ2cnNvA4Zr9PNZFnE+M2TFmMLfiWINS4mJfkCqioAuJwCWmUPUqHbshGJjbluw eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k208j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:11 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32CICBjm010887;
	Sun, 12 Mar 2023 18:12:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k208hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32CAKcdg030084;
	Sun, 12 Mar 2023 18:12:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfa75t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32CIC4ej62062990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Mar 2023 18:12:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E866120049;
	Sun, 12 Mar 2023 18:12:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3E7620040;
	Sun, 12 Mar 2023 18:12:01 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.41.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Mar 2023 18:12:01 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v9 2/6] powerpc/crash: introduce a new config option CRASH_HOTPLUG
Date: Sun, 12 Mar 2023 23:41:50 +0530
Message-Id: <20230312181154.278900-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a1Ne6HjixoT2IZu1AI6a4PU2VfTeTsFZ
X-Proofpoint-GUID: CuLrYlyat7wI0Hr0KdAlOQaEhu9xY3Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303120157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_111215_389695_92417EEC 
X-CRM114-Status: GOOD (  23.94  )
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

Due to CPU/Memory hotplug events the system resources changes. A similar
change should reflect in the loaded kdump kernel image that describes
the state of the CPU and memory of the running kernel.

If the kdump kernel image is not updated after the CPU or Memory hotplug
events and it tries to collect the dump with the stale system resource
data this might lead to dump collection failure or an inaccurate dump
collection.

The current method to keep the kdump kernel up to date is by triggering
reload (i.e unload and load) the entire kdump kernel image whenever a
CPU or Memory hotplug event is observed by udev in the userspace.
Reloading the complete kdump kernel image is an expensive task. It can
be easily avoided by doing the in-kernel updates to specific kdump
kernel image components which are responsible for describing CPU and
Memory resources of the running kernel to the kdump kernel.

The kernel changes related to in-kernel update to the kdump kernel image
on CPU/Memory hotplug events are kept under the CRASH_HOTPLUG config
option.

Later in the series, a powerpc crash hotplug handler is introduced to
update the kdump kernel image on CPU/Memory hotplug events. This arch
specific handler is trigger from a generic crash handler that registers
with the CPU and memory notifiers.

The CRASH_HOTPLUG config option is enabled by default.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a6c4407d3ec83..2f45b3f5175cb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -681,6 +681,18 @@ config CRASH_DUMP
 	  The same kernel binary can be used as production kernel and dump
 	  capture kernel.
 
+config CRASH_HOTPLUG
+	bool "Update crash capture system on CPU/Memory hotplug event"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  In kernel update to relevant kexec segments due to change
+	  in the system configuration, rather reloading all the kexec
+	  segments again from userspace by monitoring CPU/Memory
+	  hotplug events in the userspace using udev.
+
+	  If unsure, say N.
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
