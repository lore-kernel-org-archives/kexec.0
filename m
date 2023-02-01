Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB17FC63797
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 06:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IH74IH79q0n0jxLtVEii9qU20AiI/dBiioUGiQ7fqrE=; b=NHfA8S6q9MVYoO
	vOHUBnlANuK/fKGAvRnC3sXhp4Z8BhpuLhY3X5wgG19P2JIxcn3CnKt9BI/LxkeV30skC1MJ8xQWz
	/QVI0NAPcgCBqIkJnXYBwiTlzgAwZIHFOPnqc9HO5zjZ0xoKnKMcZx6E79Ik77pPT0BVGpsvt8Ol1
	TfvpCYACiHZug+gPcl9RYLRe/7wGm1Zc3Ot8vJANNBwvv7i5OhgyPK3IMcBx/Urnb+xfelng4i48U
	exZDJhSKgouWUiiTeWs6qL8Qky9Nk6S/2pH4Eyn7P+Mjv1xQvTrgMS2Q28s4H5TBjd7gzObT92WyC
	dyyRwpLZf+n3LVOg7z8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6ly-00AUDD-T7; Wed, 01 Feb 2023 06:39:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6lt-00AU9Y-1C
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 06:39:06 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116VYGJ023578;
	Wed, 1 Feb 2023 06:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dt44SeAqQ+9S+u8+HcpjiHEEVbTRRk0w0ucGCuiQHEI=;
 b=YTmdDBGV9SIR6g8Pba3F0OSKYdy7p9GFBvk4l8UeaggyzEROBrhN8DPw8Y+WsD4dwFJg
 WFMdF1A03tywgT2LxS/qWoy0shC3yV037H0G75Ju1TbdH9OW7Rp333j29apHuPk3bsQ7
 Mwoc3Gumwjxse1a6f43Vx2bg4eeEjLhU8dqjEsXi6cSMWoA21Po6u6VkBw2SFb/z9/w0
 djoY0U2steYdfzsnDCuYbb34o3OHRTby9ffg6aYBHRPwGuCRYB3HuqGgd5VywLcQUzcj
 OhLfAP217j2bavhzxEk4DYszGPHl6volvaX2JUKKEIH5sTfX7vwsbJf/wGJXdlJvYMLG vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw1078y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:39:01 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3116WH4o025813;
	Wed, 1 Feb 2023 06:39:01 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw1077v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:39:01 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGIEKi007795;
	Wed, 1 Feb 2023 06:38:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ncvuqu67e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3116csOO24183536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Feb 2023 06:38:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 866392004B;
	Wed,  1 Feb 2023 06:38:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF12420040;
	Wed,  1 Feb 2023 06:38:52 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.109.52])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Feb 2023 06:38:52 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v8 5/8] crash: pass hotplug action type to arch crash hotplug handler
Date: Wed,  1 Feb 2023 12:08:38 +0530
Message-Id: <20230201063841.965316-6-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uzq5Z4Rd3GxRsRXCjttZ24sLiHAsUz9f
X-Proofpoint-ORIG-GUID: OdtYJfzlEehMD3xFn9Pul1z3rTRZbP_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_223905_245645_E0EDE507 
X-CRM114-Status: GOOD (  22.07  )
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
index ba11c7e70edb1..c0b5afad37565 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -463,12 +463,13 @@ int crash_load_segments(struct kimage *image)
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
 	unsigned long nr_mem_ranges;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 881e8a43db89e..5461a4ad50e2a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -509,7 +509,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
 #endif
 
 #else /* !CONFIG_KEXEC_CORE */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 898d8d2fe2e2e..3aede7187c8b4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -789,7 +789,7 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 					cpu : KEXEC_CRASH_HP_INVALID_CPU;
 
 			/* Now invoke arch-specific update handler */
-			arch_crash_handle_hotplug_event(image);
+			arch_crash_handle_hotplug_event(image, hp_action);
 
 			/* No longer handling a hotplug event */
 			image->hotplug_event = false;
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
