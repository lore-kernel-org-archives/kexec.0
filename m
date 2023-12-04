Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BAC46CA0
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 05:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x/HW/qWRRymvDlB+K1ZWZJ5DdRVCVjLnL+brYA+PrUk=; b=1sHSU9jamxuxNf
	bh8FO+HhvTdQjGEWL7St6rg7GOK0P+8hPz3ppP27+5G6/7WTOSUz+qumHI1/Gm49wMkDrlAOUaP4l
	Bcnroym9MwDiZ79g6+vt5q28tzQKVkGvQAfay8QH9v1VUzalyBb5NLw9h0atJw06/aSUkvgqV1jZx
	dhucREDWIESEI+HGny9FzGdhDu8FQ/i8/IO3H51BQZhV5kM/Tj5C76RmQtB15mTMpzkqbhgLc4q7U
	z3v03kHuFdqUyBSZWga+IsPHCa5oaUIqJkU971xko4MFHmUWlQtkNGjQLYX3HL6vyaVWSpRT6oBRe
	uoFwJLCwp5NDLXZWV8MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1ac-0032zO-0S;
	Mon, 04 Dec 2023 05:33:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1aV-0032xf-1n
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 05:33:49 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B42S9kX020247;
	Mon, 4 Dec 2023 05:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VEXj9O5D5jJrFYj0aClnCK51ZbUYD+SO5EgLxc9ORsc=;
 b=hQFeN/mcdaTi1xGF7sWaTu5rxiJyV+gO8jSG7CiK9uiIX+V3c9PUUcS0mcYdC1+vJTya
 y31X5auVL+4SbihANMb6uStLXmgdZryPlqCAsFZTjVxjCVn6fFnXGHgKQ9ORCeM8lr8x
 TMcVMvhsmX5CcZB3xC/g4TC4Ht/3W5fjT5gnDJpAR+JZUpKO9dM/sc55zgvLTvXXyH46
 /zQIU67psjXl37GAymcQ1HblzsO15+h4K1Cbfii3J4ZQQYu0ixTyyQE4Eh4Q4RnIbvLJ
 KsfqOA3jTpp53HrKuyfI6KaTrdmr17e+ACPc0/uvu90V85EYKa0uMCSmSuXWTTRjwZty eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us142av84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B44i7uO019549;
	Mon, 4 Dec 2023 05:33:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us142av7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44neo7019461;
	Mon, 4 Dec 2023 05:33:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewt6g3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B45X9tk20644554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 05:33:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786AD20043;
	Mon,  4 Dec 2023 05:33:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE2620040;
	Mon,  4 Dec 2023 05:33:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.c4p-in.ibmmobiledemo.com (unknown [9.43.24.184])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 05:33:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v13 1/6] crash: forward memory_notify arg to arch crash hotplug handler
Date: Mon,  4 Dec 2023 11:02:48 +0530
Message-ID: <20231204053253.25305-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
References: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6IiUOwniGi2DcEsfYWPVu0i5FISy1G23
X-Proofpoint-GUID: 9dR6rrsb3Pbz00T0Btl_ZM8ENlsUbwhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_213347_597119_70B0A1FB 
X-CRM114-Status: GOOD (  25.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In the event of memory hotplug or online/offline events, the crash
memory hotplug notifier `crash_memhp_notifier()` receives a
`memory_notify` object but doesn't forward that object to the
generic and architecture-specific crash hotplug handler.

The `memory_notify` object contains the starting PFN (Page Frame Number)
and the number of pages in the hot-removed memory. This information is
necessary for architectures like PowerPC to update/recreate the kdump
image, specifically `elfcorehdr`.

So update the function signature of `crash_handle_hotplug_event()` and
`arch_crash_handle_hotplug_event()` to accept the `memory_notify` object
as an argument from crash memory hotplug notifier.

Since no such object is available in the case of CPU hotplug event, the
crash CPU hotplug notifier `crash_cpuhp_online()` passes NULL to the
crash hotplug handler.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Akhil Raj <lf32.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/kexec.h |  2 +-
 arch/x86/kernel/crash.c      |  3 ++-
 include/linux/kexec.h        |  2 +-
 kernel/crash_core.c          | 14 +++++++-------
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c9f6a6c5de3c..9bb6607e864e 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -208,7 +208,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 extern void kdump_nmi_shootdown_cpus(void);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image);
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..0d7b2657beb6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -428,10 +428,11 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
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
index 8227455192b7..ee28c09a7fb0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -483,7 +483,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
 
 int crash_check_update_elfcorehdr(void);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..b9190265fe52 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -935,7 +935,7 @@ int crash_check_update_elfcorehdr(void)
  * list of segments it checks (since the elfcorehdr changes and thus
  * would require an update to purgatory itself to update the digest).
  */
-static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
 {
 	struct kimage *image;
 
@@ -997,7 +997,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	image->hp_action = hp_action;
 
 	/* Now invoke arch-specific update handler */
-	arch_crash_handle_hotplug_event(image);
+	arch_crash_handle_hotplug_event(image, arg);
 
 	/* No longer handling a hotplug event */
 	image->hp_action = KEXEC_CRASH_HP_NONE;
@@ -1013,17 +1013,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	crash_hotplug_unlock();
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
@@ -1036,13 +1036,13 @@ static struct notifier_block crash_memhp_nb = {
 
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
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
