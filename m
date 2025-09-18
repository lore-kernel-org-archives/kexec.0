Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7449BCAC597
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmD63BbCvLw1+b6tWETrdoM1eyA9FzYJ5sTU3sUEEu0=; b=XUeqlAr2OB/+lUQPypjZuYpEGt
	mWRdshCzmHrXf0UTUwXCQuPbUPCitbV0IUfyeWYSkZthF4E1duLDzWWxHPM5uELCNbfoKIFB3rqsD
	mdZNlLY3LENH4q5s1yP2dxxtmKzA6N1wXB43bYLH4AG/Y2aHmhL/crV8Rd6mlDn+AeVZ7wGU/Hzpo
	WRjMWOKarw8vaSOn0IQH6NpTp6RResztMYInBZ7Ypv6YucZURrtNj+P3YGzdfTsNX/LFUCMRBSKA0
	/kJGIzbC4FBVFdGqqOXGYEaxA4KDkRg7Ba55D9YyFnY7w+usLZb6maKx82Le4Xb72KZ71yzDrq4CE
	yyAS4KHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5G-00000001KQo-3gAO;
	Thu, 18 Sep 2025 22:26:34 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5D-00000001KMi-3k4r
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:33 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1540478b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234391; x=1758839191; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmD63BbCvLw1+b6tWETrdoM1eyA9FzYJ5sTU3sUEEu0=;
        b=Awr/m90qAEAl2pYpzF+7uwPX6NozQlQyQ8KQf9RoHL/xlmsI0CYuUD44NGEr4DTWUY
         QUdilsph4eJZM2kHIfggeEtLnFFsachiYqo1YJJAP4B56vBD5kvA7mTG8YZJin/pi6yv
         BXNNtUyn8dfEdUudBV4lIb26EVeiEu/XShsMB3kB057RF5xDrqlywFui76WfSyCVbjL/
         FmnHDnshlssr2VWiRQ7GS6WAh3iyzOz4CdjainZxgYXtXAAmp9D/oYBpYpdBYloZvILS
         wbrXvOVAdDSc0odtns/maJC82nRPz7j0d4v1rYa42LLK5haAsGNu8/inmUhuyZsk/zXR
         TMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234391; x=1758839191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmD63BbCvLw1+b6tWETrdoM1eyA9FzYJ5sTU3sUEEu0=;
        b=brOPxk10P6wIIt9GpaYjYxGO8IB78uMD8FABSLRuKpCosXjSv0kw1xfCBzQkZrpQUT
         NrTV+olQNWP1gJbdUlPAPme0atXEKQ+kVeuFZxjOAMdSV9b+NJtfowx8oX5E/yatA6OC
         +b8LzwasqflHcaAANvCGQt6UBq9ZF0OjYQwQSBC8hRTpW3ofQLGmxSqrYtVhrHH4Ofel
         X9XN9Vy/C7wKVl6a9UM7hSAaLBODjq0DXm6FxAFIboCnZg89Yw9s8/c7ku6jNKQJW/PC
         ZjUkk18648gU/t34aRA64qR7wDXNfIOFbU1PfVtqwYajao0y5NWBhBM6J3g5BSdtH484
         eh9A==
X-Forwarded-Encrypted: i=1; AJvYcCXH3jWN/798vDx8G8ghG1B7VV5f7DTCZSWMPtNc1JrEohSppKOEyP/B/kmNF0FtIpv5wC69zA==@lists.infradead.org
X-Gm-Message-State: AOJu0YybY+yPhSbfX0Ri+qHVE5zSBo1pbzXS1YO052qxnppUrLu2t/ew
	/qToIWdcEm7nQFjzVtEibO4nzjFug4ixdo7syCxaYTcWB554a2qHzkOM
X-Gm-Gg: ASbGnct11SY0INrOpJ2ySQvZriE4bgmCqadlkoVDq5WSMqTnbonNkhsqy6ZVVhs6kq9
	kMzub/NHc1/BV3TfgUV+Qm+KA9fFuLnRY4LzMbdN82ip1szBX+AIbfSymjJwOaC0wsQpT1r22fI
	Vev1huUzvegMxhoNz9utmpm0e0fFMQd8ikLC2YDF7/nfJSwCHP3bTd0X4NEjsb8tQb6SPMBNRVP
	yKonT8NxbSdl3jmpD2C2/rOGqRwiAqdJflIt8cur7js+xy7xXP4iigTe6JqebMnndGKzRci7I89
	Lg//RPYb3lelWTdSndDDkLDlP2uK8W+1ss3i7LyeAhS+aORGMIYwfmzz6CqB6Cxlms4kTMl25bN
	Ctg1Sfe5Bb7RJ2VAgrdE+iN0tnOJi8DCho9ms5UIwKKtaM7y89kPHyjMfEA==
X-Google-Smtp-Source: AGHT+IHHwLBA5GlUoOvD4xD7+nuj+LIGVESRzM/UopIIETfrLPNF1NwNONMXXiHPjNBi/2zForUYOw==
X-Received: by 2002:a05:6a20:3c8e:b0:262:c083:bb47 with SMTP id adf61e73a8af0-2925c552ae1mr1736118637.14.1758234391195;
        Thu, 18 Sep 2025 15:26:31 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:30 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 6/7] kexec: Implement dynamic kimage tracking
Date: Thu, 18 Sep 2025 15:26:05 -0700
Message-Id: <20250918222607.186488-7-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152631_963292_4DDAE984 
X-CRM114-Status: GOOD (  32.10  )
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

Replace static kexec_image and kexec_crash_image globals with a dynamic
linked list infrastructure to support multiple kernel images. This change
enables multikernel functionality while maintaining backward compatibility.

Key changes:
- Add list_head member to kimage structure for chaining
- Implement thread-safe linked list management with global mutex
- Update kexec load/unload logic to use list-based APIs for multikernel
- Add helper functions for finding and managing multiple kimages
- Preserve existing kexec_image/kexec_crash_image pointers for compatibility
- Update architecture-specific crash handling to use new APIs

The multikernel case now properly uses list-based management instead of
overwriting compatibility pointers, allowing multiple multikernel images
to coexist in the system.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/powerpc/kexec/crash.c |   8 +-
 arch/x86/kernel/crash.c    |   4 +-
 include/linux/kexec.h      |  16 ++++
 kernel/kexec.c             |  62 +++++++++++++-
 kernel/kexec_core.c        | 165 ++++++++++++++++++++++++++++++++++++-
 kernel/kexec_file.c        |  33 +++++++-
 6 files changed, 274 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index a325c1c02f96..af190fad4f22 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -477,13 +477,13 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	ptr = __va(mem);
 	if (ptr) {
 		/* Temporarily invalidate the crash image while it is replaced */
-		xchg(&kexec_crash_image, NULL);
+		kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
 
 		/* Replace the old elfcorehdr with newly prepared elfcorehdr */
 		memcpy((void *)ptr, elfbuf, elfsz);
 
 		/* The crash image is now valid once again */
-		xchg(&kexec_crash_image, image);
+		kimage_update_compat_pointers(image, KEXEC_TYPE_CRASH);
 	}
 out:
 	kvfree(cmem);
@@ -537,14 +537,14 @@ static void update_crash_fdt(struct kimage *image)
 	fdt = __va((void *)image->segment[fdt_index].mem);
 
 	/* Temporarily invalidate the crash image while it is replaced */
-	xchg(&kexec_crash_image, NULL);
+	kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
 
 	/* update FDT to reflect changes in CPU resources */
 	if (update_cpus_node(fdt))
 		pr_err("Failed to update crash FDT");
 
 	/* The crash image is now valid once again */
-	xchg(&kexec_crash_image, image);
+	kimage_update_compat_pointers(image, KEXEC_TYPE_CRASH);
 }
 
 int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c6b12bed173d..fc561d5e058e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -546,9 +546,9 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Temporarily invalidate the crash image while the
 	 * elfcorehdr is updated.
 	 */
-	xchg(&kexec_crash_image, NULL);
+	kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
 	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
-	xchg(&kexec_crash_image, image);
+	kimage_update_compat_pointers(image, KEXEC_TYPE_CRASH);
 	kunmap_local(old_elfcorehdr);
 	pr_debug("updated elfcorehdr\n");
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a3ae3e561109..3bcbbacc0108 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -428,6 +428,9 @@ struct kimage {
 	/* dm crypt keys buffer */
 	unsigned long dm_crypt_keys_addr;
 	unsigned long dm_crypt_keys_sz;
+
+	/* For multikernel support: linked list node */
+	struct list_head list;
 };
 
 /* kexec interface functions */
@@ -531,6 +534,19 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
+
+/* Multikernel support functions */
+extern struct kimage *kimage_find_by_type(int type);
+extern void kimage_add_to_list(struct kimage *image);
+extern void kimage_remove_from_list(struct kimage *image);
+extern void kimage_update_compat_pointers(struct kimage *new_image, int type);
+extern int kimage_get_all_by_type(int type, struct kimage **images, int max_count);
+extern void kimage_list_lock(void);
+extern void kimage_list_unlock(void);
+extern struct kimage *kimage_find_multikernel_by_entry(unsigned long entry);
+extern struct kimage *kimage_get_multikernel_by_index(int index);
+extern int multikernel_kexec_by_entry(int cpu, unsigned long entry);
+extern void kimage_list_multikernel_images(void);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 49e62f804674..3d37925ee15a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -147,7 +147,31 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	if (nr_segments == 0) {
 		/* Uninstall image */
-		kimage_free(xchg(dest_image, NULL));
+		if (flags & KEXEC_ON_CRASH) {
+			struct kimage *old_image = xchg(&kexec_crash_image, NULL);
+			if (old_image) {
+				kimage_remove_from_list(old_image);
+				kimage_free(old_image);
+			}
+		} else if (flags & KEXEC_MULTIKERNEL) {
+			/* For multikernel unload, we need to specify which image to remove */
+			/* For now, remove all multikernel images - this could be enhanced */
+			struct kimage *images[10];
+			int count, i;
+
+			count = kimage_get_all_by_type(KEXEC_TYPE_MULTIKERNEL, images, 10);
+			for (i = 0; i < count; i++) {
+				kimage_remove_from_list(images[i]);
+				kimage_free(images[i]);
+			}
+			pr_info("Unloaded %d multikernel images\n", count);
+		} else {
+			struct kimage *old_image = xchg(&kexec_image, NULL);
+			if (old_image) {
+				kimage_remove_from_list(old_image);
+				kimage_free(old_image);
+			}
+		}
 		ret = 0;
 		goto out_unlock;
 	}
@@ -157,7 +181,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		 * crashes.  Free any current crash dump kernel before
 		 * we corrupt it.
 		 */
-		kimage_free(xchg(&kexec_crash_image, NULL));
+		struct kimage *old_crash_image = xchg(&kexec_crash_image, NULL);
+		if (old_crash_image) {
+			kimage_remove_from_list(old_crash_image);
+			kimage_free(old_crash_image);
+		}
 	}
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
@@ -199,7 +227,35 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		goto out;
 
 	/* Install the new kernel and uninstall the old */
-	image = xchg(dest_image, image);
+	if (flags & KEXEC_ON_CRASH) {
+		struct kimage *old_image = xchg(&kexec_crash_image, image);
+		if (old_image) {
+			kimage_remove_from_list(old_image);
+			kimage_free(old_image);
+		}
+		if (image) {
+			kimage_add_to_list(image);
+			kimage_update_compat_pointers(image, KEXEC_TYPE_CRASH);
+		}
+		image = NULL; /* Don't free the new image */
+	} else if (flags & KEXEC_MULTIKERNEL) {
+		if (image) {
+			kimage_add_to_list(image);
+			pr_info("Added multikernel image to list (entry: 0x%lx)\n", image->start);
+		}
+		image = NULL; /* Don't free the new image */
+	} else {
+		struct kimage *old_image = xchg(&kexec_image, image);
+		if (old_image) {
+			kimage_remove_from_list(old_image);
+			kimage_free(old_image);
+		}
+		if (image) {
+			kimage_add_to_list(image);
+			kimage_update_compat_pointers(image, KEXEC_TYPE_DEFAULT);
+		}
+		image = NULL; /* Don't free the new image */
+	}
 
 out:
 #ifdef CONFIG_CRASH_DUMP
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 35a66c8dd78b..4e489a7031e6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -56,6 +56,10 @@ bool kexec_in_progress = false;
 
 bool kexec_file_dbg_print;
 
+/* Linked list of dynamically allocated kimages */
+static LIST_HEAD(kexec_image_list);
+static DEFINE_MUTEX(kexec_image_mutex);
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
@@ -275,6 +279,9 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+	/* Initialize the list node for multikernel support */
+	INIT_LIST_HEAD(&image->list);
+
 #ifdef CONFIG_CRASH_HOTPLUG
 	image->hp_action = KEXEC_CRASH_HP_NONE;
 	image->elfcorehdr_index = -1;
@@ -607,6 +614,13 @@ void kimage_free(struct kimage *image)
 	if (!image)
 		return;
 
+	/* Remove from linked list and update compatibility pointers */
+	kimage_remove_from_list(image);
+	if (image == kexec_image)
+		kimage_update_compat_pointers(NULL, KEXEC_TYPE_DEFAULT);
+	else if (image == kexec_crash_image)
+		kimage_update_compat_pointers(NULL, KEXEC_TYPE_CRASH);
+
 #ifdef CONFIG_CRASH_DUMP
 	if (image->vmcoreinfo_data_copy) {
 		crash_update_vmcoreinfo_safecopy(NULL);
@@ -1123,6 +1137,72 @@ void kimage_unmap_segment(void *segment_buffer)
 	vunmap(segment_buffer);
 }
 
+void kimage_add_to_list(struct kimage *image)
+{
+	mutex_lock(&kexec_image_mutex);
+	list_add_tail(&image->list, &kexec_image_list);
+	mutex_unlock(&kexec_image_mutex);
+}
+
+void kimage_remove_from_list(struct kimage *image)
+{
+	mutex_lock(&kexec_image_mutex);
+	if (!list_empty(&image->list))
+		list_del_init(&image->list);
+	mutex_unlock(&kexec_image_mutex);
+}
+
+struct kimage *kimage_find_by_type(int type)
+{
+	struct kimage *image;
+
+	mutex_lock(&kexec_image_mutex);
+	list_for_each_entry(image, &kexec_image_list, list) {
+		if (image->type == type) {
+			mutex_unlock(&kexec_image_mutex);
+			return image;
+		}
+	}
+	mutex_unlock(&kexec_image_mutex);
+	return NULL;
+}
+
+void kimage_update_compat_pointers(struct kimage *new_image, int type)
+{
+	mutex_lock(&kexec_image_mutex);
+	if (type == KEXEC_TYPE_CRASH) {
+		kexec_crash_image = new_image;
+	} else if (type == KEXEC_TYPE_DEFAULT) {
+		kexec_image = new_image;
+	}
+	mutex_unlock(&kexec_image_mutex);
+}
+
+int kimage_get_all_by_type(int type, struct kimage **images, int max_count)
+{
+	struct kimage *image;
+	int count = 0;
+
+	mutex_lock(&kexec_image_mutex);
+	list_for_each_entry(image, &kexec_image_list, list) {
+		if (image->type == type && count < max_count) {
+			images[count++] = image;
+		}
+	}
+	mutex_unlock(&kexec_image_mutex);
+	return count;
+}
+
+void kimage_list_lock(void)
+{
+	mutex_lock(&kexec_image_mutex);
+}
+
+void kimage_list_unlock(void)
+{
+	mutex_unlock(&kexec_image_mutex);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
@@ -1139,6 +1219,7 @@ static struct kexec_load_limit load_limit_panic = {
 	.limit = -1,
 };
 
+/* Compatibility: maintain pointers to current default and crash images */
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
@@ -1339,8 +1420,49 @@ int kernel_kexec(void)
 	return error;
 }
 
+/*
+ * Find a multikernel image by entry point
+ */
+struct kimage *kimage_find_multikernel_by_entry(unsigned long entry)
+{
+	struct kimage *image;
+
+	kimage_list_lock();
+	list_for_each_entry(image, &kexec_image_list, list) {
+		if (image->type == KEXEC_TYPE_MULTIKERNEL && image->start == entry) {
+			kimage_list_unlock();
+			return image;
+		}
+	}
+	kimage_list_unlock();
+	return NULL;
+}
+
+/*
+ * Get multikernel image by index (0-based)
+ */
+struct kimage *kimage_get_multikernel_by_index(int index)
+{
+	struct kimage *image;
+	int count = 0;
+
+	kimage_list_lock();
+	list_for_each_entry(image, &kexec_image_list, list) {
+		if (image->type == KEXEC_TYPE_MULTIKERNEL) {
+			if (count == index) {
+				kimage_list_unlock();
+				return image;
+			}
+			count++;
+		}
+	}
+	kimage_list_unlock();
+	return NULL;
+}
+
 int multikernel_kexec(int cpu)
 {
+	struct kimage *mk_image;
 	int rc;
 
 	pr_info("multikernel kexec: cpu %d\n", cpu);
@@ -1352,13 +1474,52 @@ int multikernel_kexec(int cpu)
 
 	if (!kexec_trylock())
 		return -EBUSY;
-	if (!kexec_image) {
+
+	mk_image = kimage_find_by_type(KEXEC_TYPE_MULTIKERNEL);
+	if (!mk_image) {
+		pr_err("No multikernel image loaded\n");
 		rc = -EINVAL;
 		goto unlock;
 	}
 
+	pr_info("Found multikernel image with entry point: 0x%lx\n", mk_image->start);
+
+	cpus_read_lock();
+	rc = multikernel_kick_ap(cpu, mk_image->start);
+	cpus_read_unlock();
+
+unlock:
+	kexec_unlock();
+	return rc;
+}
+
+int multikernel_kexec_by_entry(int cpu, unsigned long entry)
+{
+	struct kimage *mk_image;
+	int rc;
+
+	pr_info("multikernel kexec: cpu %d, entry 0x%lx\n", cpu, entry);
+
+	if (cpu_online(cpu)) {
+		pr_err("The CPU is currently running with this kernel instance.");
+		return -EBUSY;
+	}
+
+	if (!kexec_trylock())
+		return -EBUSY;
+
+	/* Find the specific multikernel image by entry point */
+	mk_image = kimage_find_multikernel_by_entry(entry);
+	if (!mk_image) {
+		pr_err("No multikernel image found with entry point 0x%lx\n", entry);
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	pr_info("Using multikernel image with entry point: 0x%lx\n", mk_image->start);
+
 	cpus_read_lock();
-	rc = multikernel_kick_ap(cpu, kexec_image->start);
+	rc = multikernel_kick_ap(cpu, mk_image->start);
 	cpus_read_unlock();
 
 unlock:
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 91d46502a817..d4b8831eb59c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -399,8 +399,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	 * same memory where old crash kernel might be loaded. Free any
 	 * current crash dump kernel before we corrupt it.
 	 */
-	if (flags & KEXEC_FILE_ON_CRASH)
-		kimage_free(xchg(&kexec_crash_image, NULL));
+	if (flags & KEXEC_FILE_ON_CRASH) {
+		struct kimage *old_crash_image = xchg(&kexec_crash_image, NULL);
+		if (old_crash_image) {
+			kimage_remove_from_list(old_crash_image);
+			kimage_free(old_crash_image);
+		}
+	}
 
 	ret = kimage_file_alloc_init(&image, kernel_fd, initrd_fd, cmdline_ptr,
 				     cmdline_len, flags);
@@ -456,7 +461,29 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	 */
 	kimage_file_post_load_cleanup(image);
 exchange:
-	image = xchg(dest_image, image);
+	if (image_type == KEXEC_TYPE_CRASH) {
+		struct kimage *old_image = xchg(&kexec_crash_image, image);
+		if (old_image) {
+			kimage_remove_from_list(old_image);
+			kimage_free(old_image);
+		}
+		if (image) {
+			kimage_add_to_list(image);
+			kimage_update_compat_pointers(image, KEXEC_TYPE_CRASH);
+		}
+		image = NULL; /* Don't free the new image */
+	} else {
+		struct kimage *old_image = xchg(&kexec_image, image);
+		if (old_image) {
+			kimage_remove_from_list(old_image);
+			kimage_free(old_image);
+		}
+		if (image) {
+			kimage_add_to_list(image);
+			kimage_update_compat_pointers(image, KEXEC_TYPE_DEFAULT);
+		}
+		image = NULL; /* Don't free the new image */
+	}
 out:
 #ifdef CONFIG_CRASH_DUMP
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
-- 
2.34.1


