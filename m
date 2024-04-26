Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EC6C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 06:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10dRvQZoL3zB1D/Lt8CoRzmlSwQmbG0JcCjYFzmvPFg=; b=STZISrX5Cyd+Hv
	WpxSx2i4S2vz98PSQUB7X5SBiaKdKsS5ZzwNapxbAuIQ8pR4xk9xvxXF0RFsVnoXBNwagvSi9hThm
	b2LC3gwNRmP9d8mEc0to67tKTaXD/eqe5/84HAjQsglPI8jJmwXgszjYYSi2fZ8lnZxpMUmDov+GW
	m9hQv1Pj/h/9kJmt7H6DYeaybwO03cCLOLdMLkZ/0krXGchnugQo+p+Ay3Q/E+Cz/uItEWFGNJn1e
	NPNXzr6HyBWSru0gwNkKiWzgzurhaG0wsowYy8YHkbtyR6UV/sdUU/aLPH8ocq8F0nrqGYu8WvD9l
	fgaZ5tvB9Sbs652zIFtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0ElS-0000000BFZY-3oYD;
	Fri, 26 Apr 2024 06:08:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0ElR-0000000BFYe-2onS
	for kexec@bombadil.infradead.org;
	Fri, 26 Apr 2024 06:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bfBaZTg/l44VwTtHdGryt8ZFGjiRPBw8Tc3sZ2Nmsmw=; b=oLhTt723gITjQMK/lsY59M/R59
	ZmoNJVEdcm/QgnGiMqqVWwwHcKP1WR02OnCDkQBYS6aXAwLWtJbq+EPgEQMEn2Zdiq40CUbCj02mh
	ieTt3IwtavGc1GKfcDkRb4xVv+4XtunyKuDWzcVSveNhRFghqTzJQb5MJOfSwPy5jA9aUKTP0hIH3
	34Y/H0brMhFLmE+VNmzUm+UKtmD1DjGg0KJezFxnlhYd6oZVCvpwn7teotLYjqO0SHtLRtt69DlDZ
	w9Glwlu+GVg4tWcpWoQIDMbonHqumOhPiOh9exMQGa90zmam0jaq91KXshI16G3wTTYVvBlQ3b1of
	vlrlaxnw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0ElM-0000000FDdQ-3pFz
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 06:08:51 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q61xw0023438;
	Fri, 26 Apr 2024 06:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bfBaZTg/l44VwTtHdGryt8ZFGjiRPBw8Tc3sZ2Nmsmw=;
 b=I0jSXTEwUurkiWSqGnaTGnUMWoyyRYlmKf9RJdcEDp3z6GNn8QzQt9WDxfv22hZo4mGZ
 dZwxnwoPtfherGL9+k1pVP07raWJ3sHWptJkN+wJTOSXrahbuhuq3PwFrPW+o8rXINVh
 lpsIn7fefj6ctmZXI2toYFtE69Jh4WnvuutASKfJ2ERFDE+KMy3Ao7mZoBtkaLzYj8Bd
 tCZAMc3jdAb8rNowfanzNna0YuSGNb+aesBFhIWRRxOJuVd3IZzqDZIHNGOJok3y2lT9
 GigW/VfViIfGua2Fz1wMgaHnzW2/HwQWeHZTLBPNzqAXdRDR3KFms9XCX9gjep9Yov/u pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr6mqg0kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:08:14 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q68DgR001154;
	Fri, 26 Apr 2024 06:08:13 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr6mqg0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:08:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q468rC028315;
	Fri, 26 Apr 2024 06:08:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2wnan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:08:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q687iX14483714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 06:08:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2F02004F;
	Fri, 26 Apr 2024 06:08:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F82420063;
	Fri, 26 Apr 2024 06:07:58 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.111.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 06:07:57 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v19 2/6] crash: add a new kexec flag for hotplug support
Date: Fri, 26 Apr 2024 11:37:24 +0530
Message-ID: <20240426060728.559753-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426060728.559753-1-sourabhjain@linux.ibm.com>
References: <20240426060728.559753-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lzTbJ6nSvwdgthWSvw6tPbTiNVShKLPZ
X-Proofpoint-ORIG-GUID: HJm-K4pOChsNr2jh2czhNi-rfoC8lF70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_070849_929039_AAFBC2C3 
X-CRM114-Status: GOOD (  35.47  )
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

Commit a72bbec70da2 ("crash: hotplug support for kexec_load()")
introduced a new kexec flag, `KEXEC_UPDATE_ELFCOREHDR`. Kexec tool uses
this flag to indicate to the kernel that it is safe to modify the
elfcorehdr of the kdump image loaded using the kexec_load system call.

However, it is possible that architectures may need to update kexec
segments other then elfcorehdr. For example, FDT (Flatten Device Tree)
on PowerPC. Introducing a new kexec flag for every new kexec segment
may not be a good solution. Hence, a generic kexec flag bit,
`KEXEC_CRASH_HOTPLUG_SUPPORT`, is introduced to share the CPU/Memory
hotplug support intent between the kexec tool and the kernel for the
kexec_load system call.

Now we have two kexec flags that enables crash hotplug support for
kexec_load system call. First is KEXEC_UPDATE_ELFCOREHDR (only used in
x86), and second is KEXEC_CRASH_HOTPLUG_SUPPORT (for all architectures).

To simplify the process of finding and reporting the crash hotplug
support the following changes are introduced.

1. Define arch specific function to process the kexec flags and
   determine crash hotplug support

2. Rename the @update_elfcorehdr member of struct kimage to
   @hotplug_support and populate it for both kexec_load and
   kexec_file_load syscalls, because architecture can update more than
   one kexec segment

3. Let generic function crash_check_hotplug_support report hotplug
   support for loaded kdump image based on value of @hotplug_support

To bring the x86 crash hotplug support in line with the above points,
the following changes have been made:

- Introduce the arch_crash_hotplug_support function to process kexec
  flags and determine crash hotplug support

- Remove the arch_crash_hotplug_[cpu|memory]_support functions

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Cc: Akhil Raj <lf32.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
---

* No changes in v19.

 arch/x86/include/asm/kexec.h | 11 ++---------
 arch/x86/kernel/crash.c      | 28 +++++++++++++++++-----------
 drivers/base/cpu.c           |  2 +-
 drivers/base/memory.c        |  2 +-
 include/linux/crash_core.h   | 13 ++++++-------
 include/linux/kexec.h        | 11 +++++++----
 include/uapi/linux/kexec.h   |  1 +
 kernel/crash_core.c          | 15 ++++++---------
 kernel/kexec.c               |  4 ++--
 kernel/kexec_file.c          |  5 +++++
 10 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index cb1320ebbc23..ae5482a2f0ca 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -210,15 +210,8 @@ extern void kdump_nmi_shootdown_cpus(void);
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
-#ifdef CONFIG_HOTPLUG_CPU
-int arch_crash_hotplug_cpu_support(void);
-#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
-#endif
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-int arch_crash_hotplug_memory_support(void);
-#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
-#endif
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
+#define arch_crash_hotplug_support arch_crash_hotplug_support
 
 unsigned int arch_crash_get_elfcorehdr_size(void);
 #define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2a682fe86352..f06501445cd9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -402,20 +402,26 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
-/* These functions provide the value for the sysfs crash_hotplug nodes */
-#ifdef CONFIG_HOTPLUG_CPU
-int arch_crash_hotplug_cpu_support(void)
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
 {
-	return crash_check_update_elfcorehdr();
-}
-#endif
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-int arch_crash_hotplug_memory_support(void)
-{
-	return crash_check_update_elfcorehdr();
-}
+#ifdef CONFIG_KEXEC_FILE
+	if (image->file_mode)
+		return 1;
 #endif
+	/*
+	 * Initially, crash hotplug support for kexec_load was added
+	 * with the KEXEC_UPDATE_ELFCOREHDR flag. Later, this
+	 * functionality was expanded to accommodate multiple kexec
+	 * segment updates, leading to the introduction of the
+	 * KEXEC_CRASH_HOTPLUG_SUPPORT kexec flag bit. Consequently,
+	 * when the kexec tool sends either of these flags, it indicates
+	 * that the required kexec segment (elfcorehdr) is excluded from
+	 * the SHA calculation.
+	 */
+	return (kexec_flags & KEXEC_UPDATE_ELFCOREHDR ||
+		kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT);
+}
 
 unsigned int arch_crash_get_elfcorehdr_size(void)
 {
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 56fba44ba391..c61ecb0c2ae2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -306,7 +306,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
 }
 static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c0436f46cfb7..67858eeb92ed 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -535,7 +535,7 @@ static DEVICE_ATTR_RW(auto_online_blocks);
 static ssize_t crash_hotplug_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
 }
 static DEVICE_ATTR_RO(crash_hotplug);
 #endif
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 647e928efee8..44305336314e 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -40,14 +40,13 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
 
-int crash_check_update_elfcorehdr(void);
+int crash_check_hotplug_support(void);
 
-#ifndef crash_hotplug_cpu_support
-static inline int crash_hotplug_cpu_support(void) { return 0; }
-#endif
-
-#ifndef crash_hotplug_memory_support
-static inline int crash_hotplug_memory_support(void) { return 0; }
+#ifndef arch_crash_hotplug_support
+static inline int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
+{
+	return 0;
+}
 #endif
 
 #ifndef crash_get_elfcorehdr_size
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 060835bb82d5..5b93a5767413 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -319,8 +319,10 @@ struct kimage {
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
 #ifdef CONFIG_CRASH_HOTPLUG
-	/* If set, allow changes to elfcorehdr of kexec_load'd image */
-	unsigned int update_elfcorehdr:1;
+	/* If set, it is safe to update kexec segments that are
+	 * excluded from SHA calculation.
+	 */
+	unsigned int hotplug_support:1;
 #endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
@@ -391,9 +393,10 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
+			KEXEC_CRASH_HOTPLUG_SUPPORT)
 #endif
 
 /* List of defined/legal kexec file flags */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index c17bb096ea68..5ae1741ea8ea 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -13,6 +13,7 @@
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
+#define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 70fa8111a9d6..394db3ebe835 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -493,10 +493,10 @@ static DEFINE_MUTEX(__crash_hotplug_lock);
 
 /*
  * This routine utilized when the crash_hotplug sysfs node is read.
- * It reflects the kernel's ability/permission to update the crash
- * elfcorehdr directly.
+ * It reflects the kernel's ability/permission to update the kdump
+ * image directly.
  */
-int crash_check_update_elfcorehdr(void)
+int crash_check_hotplug_support(void)
 {
 	int rc = 0;
 
@@ -508,10 +508,7 @@ int crash_check_update_elfcorehdr(void)
 		return 0;
 	}
 	if (kexec_crash_image) {
-		if (kexec_crash_image->file_mode)
-			rc = 1;
-		else
-			rc = kexec_crash_image->update_elfcorehdr;
+		rc = kexec_crash_image->hotplug_support;
 	}
 	/* Release lock now that update complete */
 	kexec_unlock();
@@ -552,8 +549,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 
 	image = kexec_crash_image;
 
-	/* Check that updating elfcorehdr is permitted */
-	if (!(image->file_mode || image->update_elfcorehdr))
+	/* Check that kexec segments update is permitted */
+	if (!image->hotplug_support)
 		goto out;
 
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
diff --git a/kernel/kexec.c b/kernel/kexec.c
index bab542fc1463..a6b3f96bb50c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -135,8 +135,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		image->preserve_context = 1;
 
 #ifdef CONFIG_CRASH_HOTPLUG
-	if (flags & KEXEC_UPDATE_ELFCOREHDR)
-		image->update_elfcorehdr = 1;
+	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
+		image->hotplug_support = 1;
 #endif
 
 	ret = machine_kexec_prepare(image);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2d1db05fbf04..3d64290d24c9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -376,6 +376,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
+		image->hotplug_support = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
