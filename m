Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF010CCA480
	for <kexec@archiver.kernel.org>; Fri,  1 Jul 2022 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8nirD0kTNL1k3q/z7aGCkhnB1yRUDf0Irmdkz2443xs=; b=VDmEG8q0cu6m1+
	/rIV5MQm7IZaDL2RreBsnvKAUWx9/QAk7VUkR95ml3RIq0mU3uIgt6Z97ao9zvCSQooOLztStPtkP
	V5yMy3ySjJMR60a0Lyc03xiau541d0V24rQiggBR3Ngth/ds62OMBG54bPh2ro/UMNaNCecZ1h1yn
	wFfi3nkQtiFCyWmWksuCquUT3pVQrJew22oO+0X8qS7wz0Te3RKwL6P5rhLUzVWEo6SeO6blifX4A
	NfSp2wKlNl1IrsOAvj+iglRARVO9lmL3haKF1hmOkJTehe71ZZ940gGRbaCdI9Mrxu2iY97dmepBv
	1u28Pr+Z9QvtgGCrG4/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7BBv-003QmH-Cy; Fri, 01 Jul 2022 07:35:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7BBs-003Qkz-No
	for kexec@lists.infradead.org; Fri, 01 Jul 2022 07:35:50 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2617SWWV018675;
	Fri, 1 Jul 2022 07:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D9OHcfb93Pj/IW6lNx/Xhp4ticOpC2dC5rYerIAcxmg=;
 b=Re01c+SmNy09FtpQPwDAsnI5UQLS/pKYKlrXcrC56s9ID5z6OcPPTurgO7/krFVmQFrf
 3VFECVXC6qJZj1XQW/m3BhPI8ZQm/nFAthsjE9dH4mAK5c0dvsddYlSNfTxmrdmI4VDX
 lsKA5aHJyMhat4v5192/qbfkc2LbHzzo0YfRysIF9v6NPmnzTEFqWqb0l2s81L8+rA+n
 8Ml4Je3olFPtNMiPYTllorW/KSUahOixR++RmOfEoEzG872VV+N9azPuew0kw3b9k/uc
 P1XsBrECVBs11ZkvweJ3JMHKrs2778NhRomRri4CZPdw+rt0saSX7chuuxiTWh6I9Dfv NQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1vjpg7a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 07:35:47 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2617RUlA028080;
	Fri, 1 Jul 2022 07:35:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma06fra.de.ibm.com with ESMTP id 3gwsmhy0bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 07:35:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2617Zhqr21889378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Jul 2022 07:35:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7937F4C044;
	Fri,  1 Jul 2022 07:35:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0193C4C040;
	Fri,  1 Jul 2022 07:35:42 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.100.5])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  1 Jul 2022 07:35:41 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 2/2] kexec: Drop weak attribute from functions
Date: Fri,  1 Jul 2022 13:04:05 +0530
Message-Id: <c0f6219e03cb399d166d518ab505095218a902dd.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JOfm5ORcMPbe_Y3wQHduPeqQKM5D3Fxi
X-Proofpoint-GUID: JOfm5ORcMPbe_Y3wQHduPeqQKM5D3Fxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=851 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220701_003548_953531_D831EA0B 
X-CRM114-Status: GOOD (  23.40  )
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

Drop __weak attribute from functions in kexec_core.c:
- machine_kexec_post_load()
- arch_kexec_protect_crashkres()
- arch_kexec_unprotect_crashkres()
- crash_free_reserved_phys_range()

Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm64/include/asm/kexec.h   | 16 ++++++++++++++--
 arch/powerpc/include/asm/kexec.h |  5 +++++
 arch/s390/include/asm/kexec.h    | 11 +++++++++++
 arch/x86/include/asm/kexec.h     |  6 ++++++
 include/linux/kexec.h            | 32 ++++++++++++++++++++++++++++----
 kernel/kexec_core.c              | 27 ---------------------------
 6 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 78d272b26ebd11..559bfae267153d 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -84,16 +84,30 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 extern bool crash_is_nosave(unsigned long pfn);
 extern void crash_prepare_suspend(void);
 extern void crash_post_resume(void);
+
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
+#define crash_free_reserved_phys_range crash_free_reserved_phys_range
 #else
 static inline bool crash_is_nosave(unsigned long pfn) {return false; }
 static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+struct kimage;
+
 #if defined(CONFIG_KEXEC_CORE)
 void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
 		      unsigned long arg2);
+
+int machine_kexec_post_load(struct kimage *image);
+#define machine_kexec_post_load machine_kexec_post_load
+
+void arch_kexec_protect_crashkres(void);
+#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
+
+void arch_kexec_unprotect_crashkres(void);
+#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
@@ -113,8 +127,6 @@ struct kimage_arch {
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
-struct kimage;
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 1e5e9b6ec78d9d..d6f4edfe4737ba 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -98,6 +98,11 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
 
 void kexec_copy_flush(struct kimage *image);
 
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
+#define crash_free_reserved_phys_range crash_free_reserved_phys_range
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_elf64_ops;
 
diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 8886aadc11a3a6..1bd08eb56d5fc7 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -85,6 +85,17 @@ struct kimage_arch {
 extern const struct kexec_file_ops s390_kexec_image_ops;
 extern const struct kexec_file_ops s390_kexec_elf_ops;
 
+#ifdef CONFIG_CRASH_DUMP
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
+#define crash_free_reserved_phys_range crash_free_reserved_phys_range
+
+void arch_kexec_protect_crashkres(void);
+#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
+
+void arch_kexec_unprotect_crashkres(void);
+#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info;
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5ec359c1b50cb3..a3760ca796aa24 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -186,6 +186,12 @@ extern int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages,
 extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 #define arch_kexec_pre_free_pages arch_kexec_pre_free_pages
 
+void arch_kexec_protect_crashkres(void);
+#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
+
+void arch_kexec_unprotect_crashkres(void);
+#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info;
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5e0bc3f9eac3e9..c358c51c10708d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -390,7 +390,10 @@ extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
-int machine_kexec_post_load(struct kimage *image);
+
+#ifndef machine_kexec_post_load
+static inline int machine_kexec_post_load(struct kimage *image) { return 0; }
+#endif
 
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
@@ -423,10 +426,21 @@ extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
-void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
-void arch_kexec_protect_crashkres(void);
-void arch_kexec_unprotect_crashkres(void);
+#ifndef arch_kexec_protect_crashkres
+/*
+ * Protection mechanism for crashkernel reserved memory after
+ * the kdump kernel is loaded.
+ *
+ * Provide an empty default implementation here -- architecture
+ * code may override this
+ */
+static inline void arch_kexec_protect_crashkres(void) { }
+#endif
+
+#ifndef arch_kexec_unprotect_crashkres
+static inline void arch_kexec_unprotect_crashkres(void) { }
+#endif
 
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
@@ -456,6 +470,16 @@ static inline phys_addr_t boot_phys_to_phys(unsigned long boot_phys)
 }
 #endif
 
+#ifndef crash_free_reserved_phys_range
+static inline void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
+{
+	unsigned long addr;
+
+	for (addr = begin; addr < end; addr += PAGE_SIZE)
+		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
+}
+#endif
+
 static inline unsigned long virt_to_boot_phys(void *addr)
 {
 	return phys_to_boot_phys(__pa((unsigned long)addr));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce41..acd029b307e42d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -591,11 +591,6 @@ static void kimage_free_extra_pages(struct kimage *image)
 
 }
 
-int __weak machine_kexec_post_load(struct kimage *image)
-{
-	return 0;
-}
-
 void kimage_terminate(struct kimage *image)
 {
 	if (*image->entry != 0)
@@ -1020,15 +1015,6 @@ size_t crash_get_memory_size(void)
 	return size;
 }
 
-void __weak crash_free_reserved_phys_range(unsigned long begin,
-					   unsigned long end)
-{
-	unsigned long addr;
-
-	for (addr = begin; addr < end; addr += PAGE_SIZE)
-		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
-}
-
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
@@ -1225,16 +1211,3 @@ int kernel_kexec(void)
 	mutex_unlock(&kexec_mutex);
 	return error;
 }
-
-/*
- * Protection mechanism for crashkernel reserved memory after
- * the kdump kernel is loaded.
- *
- * Provide an empty default implementation here -- architecture
- * code may override this
- */
-void __weak arch_kexec_protect_crashkres(void)
-{}
-
-void __weak arch_kexec_unprotect_crashkres(void)
-{}
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
