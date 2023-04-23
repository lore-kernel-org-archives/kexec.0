Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061ADC77B73
	for <kexec@archiver.kernel.org>; Sun, 23 Apr 2023 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YgexruDU4FL/I6hiZBlEUiAR0p/T9XjqPAL4/ScTrU8=; b=Vp1omC8Hyy83vv
	Mbh0sYzahgthjPsqFAXtUWGCJeHPduJZZd3xxxDx5NFbsCxE2FYWVYK+q2NpDJNY/igMxMC/rL5uN
	jZZg9nG7+FvTLRZ/UvgqHFUsxGrM1S00I+ntjn5jRgiuWf5hJ54uI1Uyle7w8Gkod8GEt8x/WdHpw
	aUKIoBaHDuXlsJlqey7hYeDogvmGvA39lARCRALERMdOjFNYmSAfsKnWPHmxa8ReaMFdDBFJk3WrO
	5bjatiHePWgzgjjPrSz0/cZFhyIfLMxSVqQKNhBqoIQz0KoZZZcI0kDYzdE/rzllvkZbxrn+9W5pH
	92cf2JwrvTiUXfxsQ9iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKq-00EAwv-03;
	Sun, 23 Apr 2023 10:52:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKm-00EAvi-26
	for kexec@lists.infradead.org;
	Sun, 23 Apr 2023 10:52:46 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33NAbtmG030947;
	Sun, 23 Apr 2023 10:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jaBTtHQlYjdLSgDS1EzqiujrOFN3FjfNjeJldOmdLhI=;
 b=ro/0RB+ji75zqlA8gBM+F5zuxDE10p+Gp09hx1dPmxAynR+UK3n59ITxALj0VQoaCSRc
 WtWMNG7IoT/jIe0O76pS/7CnPyAsQtopNB8TYnb0SmW4I68g0N0WN8kyEmTbOCd+AJja
 NkTDHwyZJBVI76nMYEThX/Ji3pHK20Zu9pzgxXRMpvIT+edgAzIUNeVQ0L46d+ZGgwRa
 orh0i0efJ9pOehgp4gq70wiQwafV+rj9psf2frasimtm+xOIuWBC0HW6ftsWcMDBI2R2
 OgaCQqHTCdQ0tmebeJoYioDMMv+mMkTUMhcb0PEScX6lq1ev7YNaZqJ0Y9gLi3L+toqy SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:40 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33NAgn8F009903;
	Sun, 23 Apr 2023 10:52:40 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33N8qn03032207;
	Sun, 23 Apr 2023 10:52:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3q46ug0frs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33NAqY5B4719258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Apr 2023 10:52:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D6220043;
	Sun, 23 Apr 2023 10:52:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8002620040;
	Sun, 23 Apr 2023 10:52:31 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.22.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Apr 2023 10:52:31 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v10 4/5] crash: forward memory_notify args to arch crash hotplug handler
Date: Sun, 23 Apr 2023 16:22:12 +0530
Message-Id: <20230423105213.70795-5-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IfTWCo6qgTI6ONmMnS6ZTmDfamPZ_vDb
X-Proofpoint-ORIG-GUID: LQvFzE6yorEvxoQam_sbUVeeq5g7ADAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-23_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304230097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_035244_807227_FE71D00E 
X-CRM114-Status: GOOD (  26.94  )
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

On PowePC memblock regions are used to prepare elfcorehdr which
describes the memory regions of the running kernel to the kdump kernel.
Since the notifier used for the memory hotplug crash handler gets
initiated before the update of the memblock region happens (as depicted
below) the newly prepared elfcorehdr still holds the old memory regions.
If the elfcorehdr is prepared with stale memblock regions then the newly
prepared elfcorehdr will still be holding stale memory regions. And dump
collection with stale elfcorehdr will lead to dump collection failure or
incomplete dump collection.

The sequence of actions done on PowerPC when an LMB memory hot removed:

 Initiate memory hot remove
          |
          v
 offline pages
          |
          v
 initiate memory notify call
 chain for MEM_OFFLINE event  <---> Prepare new elfcorehdr and replace
 				    it with old one
          |
          v
 update memblock regions

Such challenges only exist for memory remove case. For the memory add
case the memory regions are updated first and then memory notify calls
the arch crash hotplug handler to update the elfcorehdr.

This patch passes additional information about the hot removed LMB to
the arch crash hotplug handler in the form of memory_notify object.

How passing memory_notify to arch crash hotplug handler will help?

memory_notify holds the start PFN and page count of the hot removed
memory. With that base address and the size of the hot removed memory
can be calculated and same can be used to avoid adding hot removed
memory region to get added in the elfcorehdr.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  2 +-
 arch/powerpc/kexec/core_64.c     |  3 ++-
 arch/x86/include/asm/kexec.h     |  2 +-
 arch/x86/kernel/crash.c          |  3 ++-
 include/linux/kexec.h            |  2 +-
 kernel/crash_core.c              | 14 +++++++-------
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index f01ba767af56e..7e811bad5ec92 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -104,7 +104,7 @@ struct crash_mem;
 int update_cpus_node(void *fdt);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
 #if defined(CONFIG_CRASH_HOTPLUG)
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 #endif
 #endif
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 611b89bcea2be..147ea6288a526 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -551,10 +551,11 @@ int update_cpus_node(void *fdt)
  * arch_crash_hotplug_handler() - Handle crash CPU/Memory hotplug events to update the
  *                                necessary kexec segments based on the hotplug event.
  * @image: the active struct kimage
+ * @arg: struct memory_notify handler for memory add/remove case and NULL for CPU case.
  *
  * Update FDT segment to include newly added CPU. No action for CPU remove case.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image)
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *fdt, *ptr;
 	unsigned long mem;
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 1bc852ce347d4..70c3b23b468b6 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -213,7 +213,7 @@ extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index ead602636f3e0..b45d13193b579 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -445,11 +445,12 @@ int crash_load_segments(struct kimage *image)
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: the active struct kimage
+ * @arg: struct memory_notify handler for memory add/remove case and NULL for CPU case.
  *
  * The new elfcorehdr is prepared in a kernel buffer, and then it is
  * written on top of the existing/old elfcorehdr.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image)
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long nr_mem_ranges;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0ac41f48de0b1..69765e6a92d0d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -506,7 +506,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
 
 #ifndef crash_hotplug_cpu_support
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4aa3c7a6b390f..7afe5f60d2bfe 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -718,7 +718,7 @@ subsys_initcall(crash_save_vmcoreinfo_init);
  * list of segments it checks (since the elfcorehdr changes and thus
  * would require an update to purgatory itself to update the digest).
  */
-static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
 {
 	struct kimage *image;
 
@@ -775,7 +775,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	image->hp_action = hp_action;
 
 	/* Now invoke arch-specific update handler */
-	arch_crash_handle_hotplug_event(image);
+	arch_crash_handle_hotplug_event(image, arg);
 
 	/* No longer handling a hotplug event */
 	image->hp_action = KEXEC_CRASH_HP_NONE;
@@ -789,17 +789,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	kexec_unlock();
 }
 
-static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
 {
 	switch (val) {
 	case MEM_ONLINE:
 		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
-			KEXEC_CRASH_HP_INVALID_CPU);
+			KEXEC_CRASH_HP_INVALID_CPU, arg);
 		break;
 
 	case MEM_OFFLINE:
 		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
-			KEXEC_CRASH_HP_INVALID_CPU);
+			KEXEC_CRASH_HP_INVALID_CPU, arg);
 		break;
 	}
 	return NOTIFY_OK;
@@ -812,13 +812,13 @@ static struct notifier_block crash_memhp_nb = {
 
 static int crash_cpuhp_online(unsigned int cpu)
 {
-	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu, NULL);
 	return 0;
 }
 
 static int crash_cpuhp_offline(unsigned int cpu)
 {
-	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu, NULL);
 	return 0;
 }
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
