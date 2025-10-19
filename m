Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00130CCD184
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0wsGtkMDP+lGhx28p+RHXRkJ0fALFx2Ca8PburHIFc=; b=oFZ0tV+LxqgP+436JPLkp40Q5i
	5dU/skZ5LAqHbirrMx/tmX24wEpAnmv2zM5Di1kD2lgohNVZbSSzWp2w/CjkjI8hbHrF6gd8bEyz7
	y/rVWc2ZE+PsAGrcG5QT/fIqRtpZsoIxC5vsUBanD5cGVGbxUSny/uNXk6Dmhy1elzCxarjITYDNz
	QDTvEUDHEvd7UnI70Wers5UYQjV6Kvt9jUtuqfA+P3mdw+ZeVUlcAHkZWzahNq1IP9kcGXCZ37m4o
	kh+BMhrnXnfmLN2cS3U0h8Rv8Diq2OBWAVN1v+VEjq6p8xCpmhBv2Kc69s/hqEvS44lK/n/5rLB/D
	39XoU1jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj9-0000000AjBD-1kTt;
	Sun, 19 Oct 2025 06:17:11 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj7-0000000Aj9X-0hdR
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:10 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-290cd62acc3so27174895ad.2
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854628; x=1761459428; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0wsGtkMDP+lGhx28p+RHXRkJ0fALFx2Ca8PburHIFc=;
        b=S+GP7AO88POh3sdLcF6e7asDYNnUhDrakM4K27Uvqz8DdwOYTSfKaLwOr8oNVKYFy0
         HoLzBAuRLoAM53rPEZySqcoU2rBFZyd9lBobHuLah87+LbvTgRMAS2A5q+ZUa3GNdW7t
         v61rhxAqDIU4MsfkI7jvuGmDXr+L6a/BDCwdCsp9fYKn0WcT0Uf3tBRp53emeMLB86A0
         il48TrPNN05q7YdQwvZ1cgLpL7mnMLcmn9aiO83MoNdAxQYhIjHEjD2x9YihN30VbVUi
         HAPIv+AdJaFT1WptSIkkYhJvLQcG/1wRWJhb85CKSANAZfWvDZS5QKs1RvtfFvfM5RnZ
         3p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854628; x=1761459428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0wsGtkMDP+lGhx28p+RHXRkJ0fALFx2Ca8PburHIFc=;
        b=WHTOQRxUIOMTK7OWD+dmber6mMhRWAFxf5P6EK8VEFtvbK0CoqCPz5/G3ZVq/sSDnW
         QeIAcJxJHd9VWoe9Fl9l2XG5cbTURydkYvIZ4KRuS5qsx6o/vb39C5jjFCNFmeP/eyPA
         icM1zmAJZuP23Z1kZKrt7cAOFBcHwUzJ0fityu+H+gcBHx2xx54s0HQyFpSgL45EydpL
         SgY1TyM4LFFacdBFREW3ycOor2AFOqE1DWFmcOTIDCuNVDfx2zV2xqzmFzQvG4F6OAzG
         yx5RjVk3FwbQfr4U24Aq15SSDk/AnvxlyRbWmlJX2O8MK0/nLhTUsQk73kDO9CPVElPr
         7Uyg==
X-Forwarded-Encrypted: i=1; AJvYcCVBKo/slIB8CJABzsCHOvezMo9ClI4gtE11EfGMN/v0xfqajxaCQp1UAvPtC8g0j20iWtnWGw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8BP8DSSOxT0xFtUCP8v0nV/Gr0NspPYepYfkVDlNYgNldfnUn
	M3O7veez7zAU05iUbJYxamrqfl+8yiyz/yHEmqHLV7L/g2zK6x/loAn9
X-Gm-Gg: ASbGncv9ksXBM/UXYfTvBx+YzAKWrFHKcuCx2eXI8rzgymH6ZTLCDKF71hD7nMMyw56
	kUbb+ywwRjitJXKoL9/zaGJ4sG/Sy8sDx3RVBN//EfvL96uVvyfY5OzGwg2WeAmvuTnF/8LSvei
	w0Gmp2cgB2hKYsfSuMtQucDpVoHR/nVPhSb4fv/m3N6jucFhu9+xnY+59+Lf3sAO2U3X3INcdH7
	Sh8Dkw4ButPEmqDHvRWgWzsXPDr9NsjHjh2XEsX/zzkYayjKwQdiAUsPRTdKIghoaDG0fKInJws
	a/Seaj555HjE5rbyGLHON2YTG526cjEwymXF0+YEHQpmpOdCapxiXK6RO1mjqpFAmP9wCjkG7x6
	Ck+u3kROn+tlJxZK7eQMtwj/VniupOwIJC61M7LYCQiLor5oF37APaN4QYyhxKdz08FeF7N/LkS
	lT1xzQ
X-Google-Smtp-Source: AGHT+IGu67uE2s3blbKf/o2fKnuxlQtS3znzk8IIHkaEnUlKNNl2NW2CaX6Hyb7Xbj4GWxwVqCqcDg==
X-Received: by 2002:a17:903:230a:b0:290:c3a6:822c with SMTP id d9443c01a7336-290c9d1b50dmr103427605ad.15.1760854628322;
        Sat, 18 Oct 2025 23:17:08 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:07 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 09/16] kexec: Integrate multikernel instance management with kexec subsystem
Date: Sat, 18 Oct 2025 23:16:23 -0700
Message-Id: <20251019061631.2235405-10-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231709_224312_1DC002EA 
X-CRM114-Status: GOOD (  24.72  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Cong Wang <cwang@multikernel.io>

Establish bidirectional integration between the kexec subsystem and
multikernel instance management, enabling proper lifecycle tracking
and resource coordination for multikernel operations.

This commit introduces:

* Enhanced kimage structure with multikernel-specific fields including
  mk_id for unique multikernel identification and mk_instance pointer
  for cross-referencing with the multikernel instance management
  system, enabling proper state synchronization.

* UAPI extensions in include/uapi/linux/kexec.h that define multikernel
  ID encoding within kexec flags using KEXEC_MK_ID_MASK and
  KEXEC_MK_ID_SHIFT, providing up to 2047 unique multikernel instances
  with proper bit field management macros.

* Multikernel image lookup infrastructure through kimage_find_by_id()
  that leverages the mk_instance system for efficient image retrieval
  by multikernel ID, replacing CPU-based lookup with proper instance
  management.

* Refactored multikernel_kexec() interface from CPU-based to ID-based
  operation (multikernel_kexec_by_id()) that uses instance CPU
  assignments from device tree configuration rather than manual CPU
  specification, improving safety and consistency.

* Proper resource lifecycle management in kimage_free() that clears
  cross-references, updates instance states, and handles reference
  counting when multikernel images are freed, preventing resource
  leaks and dangling pointers.

* Updated reboot syscall interface that accepts multikernel instance
  IDs instead of CPU numbers in LINUX_REBOOT_CMD_MULTIKERNEL,
  providing a more intuitive and safer user interface.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/kexec.h       | 10 ++++-
 include/linux/multikernel.h |  3 ++
 include/uapi/linux/kexec.h  |  4 ++
 kernel/kexec_core.c         | 75 +++++++++++++++++++++++++++++++++----
 kernel/reboot.c             |  4 +-
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 69877db5360b..5e9e9ad1dfeb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -132,6 +132,7 @@ struct purgatory_info {
 };
 
 struct kimage;
+struct mk_instance;
 
 typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
 typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
@@ -434,6 +435,12 @@ struct kimage {
 
 	/* For multikernel support: linked list node */
 	struct list_head list;
+
+	/* Multikernel unique ID (0 = current kernel, >0 = multikernel images) */
+	int mk_id;
+
+	/* Multikernel instance cross-reference */
+	struct mk_instance *mk_instance;
 };
 
 /* kexec interface functions */
@@ -441,7 +448,8 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
-extern int multikernel_kexec(int cpu);
+extern int multikernel_kexec_by_id(int mk_id);
+extern struct kimage *kimage_find_by_id(int mk_id);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index 75cbb316d565..c65d39a66b84 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -102,6 +102,9 @@ struct mk_instance {
 	void *dtb_data;                 /* Device tree blob data */
 	size_t dtb_size;                /* Size of DTB */
 
+	/* Kexec integration */
+	struct kimage *kimage;          /* Associated kimage object */
+
 	/* Sysfs representation */
 	struct kernfs_node *kn;            /* Kernfs node for this instance */
 
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 346e0ff4e663..82a562ae6ac1 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -15,6 +15,10 @@
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
 #define KEXEC_MULTIKERNEL	0x00000010
+#define KEXEC_MK_ID_MASK	0x0000ffe0
+#define KEXEC_MK_ID_SHIFT	5
+#define KEXEC_MK_ID(id)		(((id) << KEXEC_MK_ID_SHIFT) & KEXEC_MK_ID_MASK)
+#define KEXEC_GET_MK_ID(flags)	(((flags) & KEXEC_MK_ID_MASK) >> KEXEC_MK_ID_SHIFT)
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 449096060fe8..ed5c97b4531e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/multikernel.h>
 #include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
 
@@ -255,6 +256,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list node for multikernel support */
 	INIT_LIST_HEAD(&image->list);
 
+	/* Initialize multikernel ID (0 = current kernel, will be assigned later for multikernel) */
+	image->mk_id = 0;
+
+	/* Initialize multikernel instance cross-reference */
+	image->mk_instance = NULL;
+
 #ifdef CONFIG_CRASH_HOTPLUG
 	image->hp_action = KEXEC_CRASH_HP_NONE;
 	image->elfcorehdr_index = -1;
@@ -594,6 +601,16 @@ void kimage_free(struct kimage *image)
 	else if (image == kexec_crash_image)
 		kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
 
+	/* Remove from IDR if it's a multikernel image */
+	if (image->type == KEXEC_TYPE_MULTIKERNEL && image->mk_instance) {
+		/* Clear cross-reference and update state */
+		image->mk_instance->kimage = NULL;
+		mk_instance_set_state(image->mk_instance, MK_STATE_READY);
+		mk_instance_put(image->mk_instance);
+		image->mk_instance = NULL;
+		pr_info("Freed multikernel ID %d\n", image->mk_id);
+	}
+
 #ifdef CONFIG_CRASH_DUMP
 	if (image->vmcoreinfo_data_copy) {
 		crash_update_vmcoreinfo_safecopy(NULL);
@@ -1393,26 +1410,68 @@ int kernel_kexec(void)
 	return error;
 }
 
-int multikernel_kexec(int cpu)
+/*
+ * Find a multikernel image by ID using mk_instance lookup
+ */
+struct kimage *kimage_find_by_id(int mk_id)
 {
-	int rc;
+	struct mk_instance *instance;
+	struct kimage *image = NULL;
 
-	pr_info("multikernel kexec: cpu %d\n", cpu);
+	if (mk_id <= 0)
+		return NULL;
 
-	if (cpu_online(cpu)) {
-		pr_err("The CPU is currently running with this kernel instance.");
-		return -EBUSY;
+	/* Use mk_instance system to find the associated kimage */
+	instance = mk_instance_find(mk_id);
+	if (instance) {
+		image = instance->kimage;
+		mk_instance_put(instance); /* Release reference from find */
 	}
 
+	return image;
+}
+
+int multikernel_kexec_by_id(int mk_id)
+{
+	struct kimage *mk_image;
+	struct mk_instance *instance;
+	int cpu = -1;
+	int rc;
+
 	if (!kexec_trylock())
 		return -EBUSY;
-	if (!kexec_image) {
+
+	mk_image = kimage_find_by_id(mk_id);
+	if (!mk_image) {
+		pr_err("No multikernel image found with ID %d\n", mk_id);
 		rc = -EINVAL;
 		goto unlock;
 	}
 
+	instance = mk_image->mk_instance;
+	if (instance->cpus_valid && !cpumask_empty(instance->cpus)) {
+		cpu = cpumask_first(instance->cpus);
+		pr_info("multikernel kexec: using assigned CPU %d from instance cpumask %*pbl\n",
+			cpu, cpumask_pr_args(instance->cpus));
+	} else {
+		pr_err("No CPU assignment found for multikernel instance %d - CPU assignment is required\n",
+		       mk_id);
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	if (cpu_online(cpu)) {
+		pr_err("CPU %d is currently online and cannot be used for multikernel instance %d\n",
+		       cpu, mk_id);
+		rc = -EBUSY;
+		goto unlock;
+	}
+
+	pr_info("Using multikernel image with ID %d (entry point: 0x%lx) on CPU %d\n",
+		mk_image->mk_id, mk_image->start, cpu);
+
 	cpus_read_lock();
-	rc = multikernel_kick_ap(cpu, kexec_image->start);
+	rc = multikernel_kick_ap(cpu, mk_image->start);
 	cpus_read_unlock();
 
 unlock:
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f3ac703c4695..bff6d3603a17 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -718,7 +718,7 @@ EXPORT_SYMBOL_GPL(kernel_power_off);
 DEFINE_MUTEX(system_transition_mutex);
 
 struct multikernel_boot_args {
-	int cpu;
+	int mk_id;
 };
 
 /*
@@ -807,7 +807,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	case LINUX_REBOOT_CMD_MULTIKERNEL:
 		if (copy_from_user(&boot_args, arg, sizeof(boot_args)))
 			return -EFAULT;
-		ret = multikernel_kexec(boot_args.cpu);
+		ret = multikernel_kexec_by_id(boot_args.mk_id);
 		break;
 #endif
 
-- 
2.34.1


