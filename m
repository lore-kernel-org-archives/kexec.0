Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E864C677F1
	for <kexec@archiver.kernel.org>; Sun, 15 Jan 2023 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+01ZXCtZdKypi9ytOkV/XnfXJSaWrC9LBMh7z3nE27k=; b=MhnIj3DdEdETwj
	orqFwN/zKW6M7sHdcUX0zzRqrVSuGEzELoLOLGqt1O/u/X+vdZO9qfsxgzPgkKIL2liuVUW2N897Q
	HFJxlyUOm//sEneHvztrjYQUUIJ/WmzuTZeJuNdaoiy6UGTnxkOYV9m/PUXbQpcq3+WY+rizpaVzd
	GdAO7xPgK78yUvqG8MW2mcF4lgUecgZEHxevsDLBrel/ft07XC7joUYY6ojhSHPa+9XmBFI+1UbQk
	DCVHBXnnZWrBFVmI15t1w1tK8/a0A3VGm6kGpeAgsW/YzvDjRr4gJmgnXOIEPDaYhnWHpVfqBTEUl
	G9Ly+KPEK4AjCBzrsZVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wu-007Wxu-3H; Sun, 15 Jan 2023 15:02:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Ws-007Wwa-5l
	for kexec@lists.infradead.org; Sun, 15 Jan 2023 15:02:39 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30F9tHmZ001570;
	Sun, 15 Jan 2023 15:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=t2qha38s4Y9vezBx/UmIzm/O0AJOOWRCFh0K/Ax2+Uo=;
 b=YLJMT+XkPXF8URwYfSWwwhC8xJ3iYr2ZToTp2vXgTbbIy/rCyPwcnRcLOsiVy7hwRlQV
 kdMkR7dmE/00lUgseUdu6cZ8qjF4yeCUgHf4dlTahzJfCAqW/VABbLGGG+R5DUDOE8lR
 /QGKfeXwWhBECYSsRNFLb3uEuS+oAxVVxb6krD8pohMFy14PWPJgjCkOjVpa+QZhJkMA
 ndhUlgh5SOO1XrIFEUdO83ofUnUwLrX5IPKgQAsx/NxmKTYiVj4vebqsHctXIdatXfIt
 Idqu8au+bGH8tVbLuUvRjpwB0AOxpE4mUQ0FCmgvjxL/NBcgzQoejlLMbsr5rr/t5FEg Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4f9bke8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:34 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30FF0aWk035505;
	Sun, 15 Jan 2023 15:02:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4f9bke8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30F1OOLV004686;
	Sun, 15 Jan 2023 15:02:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16hd33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30FF2SFw44433912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jan 2023 15:02:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F6A20043;
	Sun, 15 Jan 2023 15:02:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A243820040;
	Sun, 15 Jan 2023 15:02:25 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.71.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jan 2023 15:02:25 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v7 5/8] crash: pass hotplug action type to arch crash hotplug handler
Date: Sun, 15 Jan 2023 20:32:03 +0530
Message-Id: <20230115150206.431528-6-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D2hrQXzr7sCkl1a9ec32xyW4RCO86NXS
X-Proofpoint-GUID: vzjFFjPsFZ8ccoyhNBklxoPTxptQS9gT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301150112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_070238_350249_1D89966D 
X-CRM114-Status: GOOD (  19.91  )
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

On PowerPC, the crash update action for CPU and Memory hotplug events
is not the same. Since arch_crash_handle_hotplug_event is a common
crash hotplug handler for both CPU and Memory hot un/plug events,
it is hard to differentiate which hotplug event triggered the arch
crash hotplug handler and decide the crash update action accordingly.

Pass the hotplug action type to arch specific crash hotplug handler
so that corresponding crash update action can be taken based on the
hotplug action type.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/x86/include/asm/kexec.h | 2 +-
 arch/x86/kernel/crash.c      | 3 ++-
 include/linux/kexec.h        | 2 +-
 kernel/crash_core.c          | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 1bc852ce347d4..ec33a592a2ddd 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -213,7 +213,7 @@ extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 5186df48ce6c6..0026c5ad828d7 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -465,12 +465,13 @@ int crash_load_segments(struct kimage *image)
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
  *
  * To accurately reflect hot un/plug changes, the new elfcorehdr
  * is prepared in a kernel buffer, and then it is written on top
  * of the existing/old elfcorehdr.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image)
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long mem, memsz;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0b1ad1ac06e37..ea8ff85b0b436 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -509,7 +509,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
 #endif
 
 #ifndef crash_hotplug_cpu_support
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 19f987b3851e8..bdf8c363a90aa 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -707,7 +707,7 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 					cpu : KEXEC_CRASH_HP_INVALID_CPU;
 
 			/* Now invoke arch-specific update handler */
-			arch_crash_handle_hotplug_event(image);
+			arch_crash_handle_hotplug_event(image, hp_action);
 
 			/* No longer handling a hotplug event */
 			image->hotplug_event = false;
-- 
2.39.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
