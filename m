Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE86BC10F05
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 05:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jW2iohWJyJWzAoIK16pXrfphcDmshHgwGjMPTrABUvE=; b=SoMCoJTrIFNnn3
	lMjCmvHIKcIo4ptiBhMrBpj/CQ1nXus/OIts3tVsI5oOdgaOV48TzOuYWuY88A4JcZchmZxCUw0AN
	uRPkLIcrXTIg62CVvLNkgVoCyvfEHQ6lemHl061YudiDcn9q7QeVfXzVg8Q+RKYeNYyIWIAiqb2Fg
	ymYRvXIWuR65rIZKNzAVPcpOdzpO76NzMUgytvQuzVcaIo2CJoN8XckSPzFZbsX3xdjhWjM1pimC4
	RX2hvyfYa9ze5OJgUMpov7I+s0SFxR3Q6pw5LKFxE7R9l9V+bTsN43PfMUW/h1Ih8O7Fp8DeJgOOh
	QXjsz5/YiQwH5vZdvM/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1ae-00330M-0R;
	Mon, 04 Dec 2023 05:33:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1aZ-0032ya-1g
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 05:33:53 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44Jg42032412;
	Mon, 4 Dec 2023 05:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IpdWCv0SQiN9CpdQGaa0kagJcfQn/DHrCULs3Thlv8s=;
 b=FrqfnwcobfBjVJJxvapnxCJEiIQwtCa4uBPvW9saZbYNWOFrVb8r9ItzkwZLTXhG3BW1
 owvROqrIaQQKMN9NzYLXGHdUyM4ZUVju7Ky462YR1dOJFT8beklC5hHKlJ8U5kSG+1WU
 sWxmWKke9JXvnts3W4dmhwnNrNYNK6JCO49wWpFrMXlaqcXq5eh3Vd5zAJvOTVu4J7GQ
 lUO1U4aGmeag7u4odRoP4P8MtnvwslQRuO+BiLkx5OWGz1sNfclACPxieBPB/rKNvrU8
 FCQKvYsTI0FKEj+LrG3EZ1EC4jF2iNRgs5Tm/k/w10y0bQaB7VX8o6N5jgqmpmkPGJ7+ GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us7n0suqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:27 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B44lsGk003192;
	Mon, 4 Dec 2023 05:33:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us7n0suq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44nU0e025204;
	Mon, 4 Dec 2023 05:33:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdkp7ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B45XLmS21430900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 05:33:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C5420043;
	Mon,  4 Dec 2023 05:33:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9221120040;
	Mon,  4 Dec 2023 05:33:15 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.c4p-in.ibmmobiledemo.com (unknown [9.43.24.184])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 05:33:15 +0000 (GMT)
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
Subject: [PATCH v13 2/6] crash: make CPU and Memory hotplug support reporting flexible
Date: Mon,  4 Dec 2023 11:02:49 +0530
Message-ID: <20231204053253.25305-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
References: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6gmgtJNkT0agchej6C3q8RKoCs-ZSeU4
X-Proofpoint-GUID: iIdl77HRPuSekrW-M_5rIFaNqOtSd-Wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_213351_672781_1378B40B 
X-CRM114-Status: GOOD (  28.70  )
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

Architectures' specific functions `arch_crash_hotplug_cpu_support()` and
`arch_crash_hotplug_memory_support()` advertise the kernel's capability
to update the kdump image on CPU and Memory hotplug events to userspace
via the sysfs interface. These architecture-specific functions need to
access various attributes of the `kexec_crash_image` object to determine
whether the kernel can update the kdump image and advertise this
information to userspace accordingly.

As the architecture-specific code is not exposed to the APIs required to
acquire the lock for accessing the `kexec_crash_image` object, it calls
a generic function, `crash_check_update_elfcorehdr()`, to determine
whether the kernel can update the kdump image or not.

The lack of access to the `kexec_crash_image` object in
architecture-specific code restricts architectures from performing
additional architecture-specific checks required to determine if the
kdump image is updatable or not. For instance, on PowerPC, the kernel
can update the kdump image only if both the elfcorehdr and FDT are
marked as updatable for the `kexec_load` system call.

So define two generic functions, `crash_hotplug_cpu_support()` and
`crash_hotplug_memory_support()`, which are called when userspace
attempts to read the crash CPU and Memory hotplug support via the sysfs
interface. These functions take the necessary locks needed to access the
`kexec_crash_image` object and then forward it to the
architecture-specific handler to do the rest.

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
 arch/x86/include/asm/kexec.h |  8 ++++----
 arch/x86/kernel/crash.c      | 20 +++++++++++++++-----
 include/linux/kexec.h        | 13 +++++++------
 kernel/crash_core.c          | 23 +++++++++++++++++------
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9bb6607e864e..5c88d27b086d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,13 +212,13 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-int arch_crash_hotplug_cpu_support(void);
-#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(struct kimage *image);
+#define arch_crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_crash_hotplug_memory_support(void);
-#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(struct kimage *image);
+#define arch_crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
 
 unsigned int arch_crash_get_elfcorehdr_size(void);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0d7b2657beb6..ad5941665589 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -398,18 +398,28 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
-/* These functions provide the value for the sysfs crash_hotplug nodes */
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_hotplug_support(struct kimage *image)
+{
+	if (image->file_mode)
+		return 1;
+
+	return image->update_elfcorehdr;
+}
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
-int arch_crash_hotplug_cpu_support(void)
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+int arch_crash_hotplug_cpu_support(struct kimage *image)
 {
-	return crash_check_update_elfcorehdr();
+	return crash_hotplug_support(image);
 }
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int arch_crash_hotplug_memory_support(void)
+int arch_crash_hotplug_memory_support(struct kimage *image)
 {
-	return crash_check_update_elfcorehdr();
+	return crash_hotplug_support(image);
 }
 #endif
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ee28c09a7fb0..0f6ea35879ee 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -486,16 +486,17 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
 
-int crash_check_update_elfcorehdr(void);
-
-#ifndef crash_hotplug_cpu_support
-static inline int crash_hotplug_cpu_support(void) { return 0; }
+#ifndef arch_crash_hotplug_cpu_support
+static inline int arch_crash_hotplug_cpu_support(struct kimage *image) { return 0; }
 #endif
 
-#ifndef crash_hotplug_memory_support
-static inline int crash_hotplug_memory_support(void) { return 0; }
+#ifndef arch_crash_hotplug_memory_support
+static inline int arch_crash_hotplug_memory_support(struct kimage *image) { return 0; }
 #endif
 
+extern int crash_hotplug_cpu_support(void);
+extern int crash_hotplug_memory_support(void);
+
 #ifndef crash_get_elfcorehdr_size
 static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 #endif
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b9190265fe52..b621f03c1104 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -892,12 +892,14 @@ DEFINE_MUTEX(__crash_hotplug_lock);
 #define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
 #define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
 
+#define CPU_HOTPLUG	0
+#define MEM_HOTPLUG	1
 /*
  * This routine utilized when the crash_hotplug sysfs node is read.
  * It reflects the kernel's ability/permission to update the crash
  * elfcorehdr directly.
  */
-int crash_check_update_elfcorehdr(void)
+static int crash_hotplug_support(int hotplug)
 {
 	int rc = 0;
 
@@ -909,18 +911,27 @@ int crash_check_update_elfcorehdr(void)
 		return 0;
 	}
 	if (kexec_crash_image) {
-		if (kexec_crash_image->file_mode)
-			rc = 1;
-		else
-			rc = kexec_crash_image->update_elfcorehdr;
+		if (hotplug == CPU_HOTPLUG)
+			rc = arch_crash_hotplug_cpu_support(kexec_crash_image);
+		else if (hotplug == MEM_HOTPLUG)
+			rc = arch_crash_hotplug_memory_support(kexec_crash_image);
 	}
 	/* Release lock now that update complete */
 	kexec_unlock();
 	crash_hotplug_unlock();
-
 	return rc;
 }
 
+int crash_hotplug_cpu_support(void)
+{
+	return crash_hotplug_support(CPU_HOTPLUG);
+}
+
+int crash_hotplug_memory_support(void)
+{
+	return crash_hotplug_support(MEM_HOTPLUG);
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
