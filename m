Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC31EB64DA
	for <kexec@archiver.kernel.org>; Mon, 19 Jun 2023 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mcl/41aUrWVQRPrimKPY9/VERaW0+a+A+fCydjqdtIo=; b=qPWZXJwRGJda5y
	FOTlvz6lKzG36PZoK1jOlDjfzdsHks64anNhwRuUWfzchsgbGASA9ILCAJ+TItobtkuphJrHU4cRi
	1QKcyM8kV7NRcz9GvfuuyiSkx6S749bidMdY34J8TDdx0BSkezOUIE60+tDRfbOOoMIZRv7hh7E3j
	fp/+vWOo6U6h0gtq18IvZyCEEv+WtJR23g6dJCh5IGRj3k+0jHxnT0YBC3XaPoWXi4OVMKR/p4sQb
	Izxll1zy7AUnqTFGVHrVTdU1KSfNVtFSIw/ch1Amvf/dRbzE2BvE9vKs8HTGL8UkVpH/zbty/uk6b
	KqcxVByFhuZu3u0gRy7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qB4xq-007EoC-0F;
	Mon, 19 Jun 2023 02:49:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qB4xl-007EmY-0Z
	for kexec@lists.infradead.org;
	Mon, 19 Jun 2023 02:49:54 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J2H1KR017662;
	Mon, 19 Jun 2023 02:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pa5Xov1bEcF0Epei2SinLIX3/WwaS8NpO7t3EtShjQM=;
 b=DUIpmsxPqc1RaaJXgVudaUreUM/8TkVI5kXyzUTcHzGunuaxIJAkQ8wX6Inz2fQUPf2x
 q8V3yuLy6Bqe6cWQjQoMdGNYGLwjWwfDIng+moFmF44gRPNGSHtTR0mOfZdAEa0x9VFP
 4baxEpkbfpVTTVoRYmjlla7Ea1gec2zFvltM1iqr6CDgjZs+qgMhS7WmyFdPYeJbTdyq
 1z0xKr1IcDVoaVOl0Q0kgpIdEtDhnKW0/2yRdQv+8XtxZVHlcCMa0iBBl81jAU6xFwEb
 sFRkrGzcO2D1tIhXzA8319E/yXiRiWdm3ic9zCPhL3Omw176NnMJIu9h8xCX9YOBM9fr dA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rae3k0g96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 02:49:49 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J2cbD1013901;
	Mon, 19 Jun 2023 02:49:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f50tsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 02:49:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35J2nhOS29950396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jun 2023 02:49:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2519D2004B;
	Mon, 19 Jun 2023 02:49:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7354E20040;
	Mon, 19 Jun 2023 02:49:41 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.70.141])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jun 2023 02:49:41 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v11 3/4] crash: forward memory_notify args to arch crash hotplug handler
Date: Mon, 19 Jun 2023 08:19:33 +0530
Message-Id: <20230619024934.567046-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619024934.567046-1-sourabhjain@linux.ibm.com>
References: <20230619024934.567046-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZxjAStoijAJYNUU7Yogyfk5Wu3B6Yh4w
X-Proofpoint-GUID: ZxjAStoijAJYNUU7Yogyfk5Wu3B6Yh4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230618_194953_224457_3A67897A 
X-CRM114-Status: GOOD (  28.44  )
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
Cc: ldufour@linux.ibm.com, eric.devolder@oracle.com, kexec@lists.infradead.org, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On PowerPC, memblock regions is used to prepare the elfcorehdr. This
elfcorehdr describes the memory regions of the running kernel to the
kdump kernel. However, a challenge arises as the notifier for the memory
hotplug crash handler is triggered before the memblock region update
takes place. Consequently, the newly prepared elfcorehdr still retains
the outdated memory regions. If the elfcorehdr is generated with these
outdated memblock regions, it will contain inaccurate information about
the memory regions. This can result in failures or incomplete dump
collection when attempting to collect a dump using the outdated
elfcorehdr.

This challenge is specific to removing an LMB (Local Memory Block). It
does not apply when memory is added. During memory addition, the memory
regions are updated first, and then the memory notify function calls the
arch crash hotplug handler to update the elfcorehdr.

The flow diagram below depicts the series of action taken during memory
hot removal.

 Initiate memory hot remove
          |
          v
 offline pages
          |
          v
 initiate memory notify call
 chain for MEM_OFFLINE event
          |
          v
 Prepare new elfcorehdr and replace
 it with old one.
	  |
	  V
 update memblock regions

The arch crash hotplug handler function signature is updated to pass
additional argument as the struct memory_notify object to architectures.

The memory_notify object contains the starting PFN (Page Frame Number)
and the number of pages in the hot removed memory. By utilizing this
information, the base address and size of the hot removed memory is
calculated and used to avoid adding the hot removed memory region to
the elfcorehdr.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  2 +-
 arch/powerpc/kexec/core_64.c     |  3 ++-
 arch/x86/include/asm/kexec.h     |  2 +-
 arch/x86/kernel/crash.c          |  5 +++--
 include/linux/kexec.h            |  2 +-
 kernel/crash_core.c              | 14 +++++++-------
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 154759bf0759..d3ff481aa9f8 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -105,7 +105,7 @@ int update_cpus_node(void *fdt);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index cb38da1c6dbe..4d1c53cc9a90 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -551,10 +551,11 @@ int update_cpus_node(void *fdt)
  * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
  *				     necessary kexec segments based on the hotplug event.
  * @image: the active struct kimage
+ * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
  *
  * Update FDT segment to include newly added CPU. No action for CPU remove case.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image)
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *fdt, *ptr;
 	unsigned long mem;
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 3be6a98751f0..ca0bc9b12504 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -210,7 +210,7 @@ extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 18d2a18d1073..d80a63665436 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -456,11 +456,12 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
- * @image: a pointer to kexec_crash_image
+ * @image: the active struct kimage
+ * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
  *
  * Prepare the new elfcorehdr and replace the existing elfcorehdr.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image)
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long nr_mem_ranges;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index bb0e614f2a05..b3fcee14fea4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -502,7 +502,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
 
 int crash_check_update_elfcorehdr(void);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 7378b501fada..23a8ab9db5bb 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -745,7 +745,7 @@ int crash_check_update_elfcorehdr(void)
  * list of segments it checks (since the elfcorehdr changes and thus
  * would require an update to purgatory itself to update the digest).
  */
-static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
 {
 	struct kimage *image;
 
@@ -805,7 +805,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	image->hp_action = hp_action;
 
 	/* Now invoke arch-specific update handler */
-	arch_crash_handle_hotplug_event(image);
+	arch_crash_handle_hotplug_event(image, arg);
 
 	/* No longer handling a hotplug event */
 	image->hp_action = KEXEC_CRASH_HP_NONE;
@@ -820,17 +820,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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
@@ -843,13 +843,13 @@ static struct notifier_block crash_memhp_nb = {
 
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
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
