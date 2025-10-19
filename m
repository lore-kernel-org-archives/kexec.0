Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D97CCD1A5
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLqqJGV/L+ji7bkggNzrd9CKo82o255TTwQERVGyCig=; b=kIMSsdBsdBVbEfQgZocZB0er8U
	mFtbML2LgQlBtkJBRMGdCR/JWOZnv+Rg5sFnilmoxDdtwlS7Ank0LgXOIFAxZNRD2V6WwXAczkGpq
	itFMmPRoTL79vm0cI202+eudoY87l6wlX9ZcDLO+miQmmT+rET3eQtWxT+j6S8uyn0DQlLTL8ngl8
	QiNFWOuu3PJbmACknudrxwGLOqcjYmIQ4qufEh5QdB9LvTyjsKzLHhgjKs2yB1Kv5wYuBVyiBQ8XG
	AofNKnIBOwFn4iffaz4DavT3I28luIzlsW+oSK9wsNQBGqvb0F+yYMaFJHxPvruL1WQuHnEoX0pNu
	2CU6U6jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj6-0000000Aj8u-0KLT;
	Sun, 19 Oct 2025 06:17:08 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj2-0000000Aj5S-2P1F
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:06 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-781206cce18so3353032b3a.0
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854624; x=1761459424; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLqqJGV/L+ji7bkggNzrd9CKo82o255TTwQERVGyCig=;
        b=EbsYR3hAXVlbjt/2B4/z0uXz8jIArpOUuf+68nqfxWAk859qaz5NMYu9OJk+O9G2J/
         zZH5P02LWBTb+ZJmr0xo+36jhVvDeUk94jQCfcsEKfhKXWBfhR1ftbFFl76+ZI2ihY37
         K07Ax+Om2GlK90+SmOkJJWxy7+9Gw6FvAnyhkKcCZwaG+wRzhwVmXnEnm+gvV4XKZNoT
         UqEJWVhMU0hkIahyadTGCegrOhfIrAJB9yIsgIj0zb8Rqo12DHYYo0niATz3anmi8oUn
         YUe01oP0uQEClV8GGmAkVkEWF6OIO1buiiyEQaylNEHCTiajO9ydoFe3ChHt2qESO877
         DLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854624; x=1761459424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLqqJGV/L+ji7bkggNzrd9CKo82o255TTwQERVGyCig=;
        b=YcKEKSOdifr6msiAw2ENi1+LNRZmsBmfGeD7HZriKZ9VlsLWQpaIh+VGMcxH0YN+Ol
         b7071UVQJ7EMEwVJCDbXpiwLZbvnBa1y7Sik1GuRjzbrJc5Satm0vDRUIuJ4ab5TQtSu
         38Ls/TlKSwtDohipWpGQS5Sap6ksTfayGy0e9MUtuz6XiMbyZ53Lij7sZ+TVPgLrx6JX
         G567Vc+JDmfF2XexMJnSvxy9gcPnLp+rt8oILYAF9KSboj+AtNi8n3b20goFIGJMom81
         GoRh9COM4N5vcT8Rt5bgyrs6jCm330MYqS2fv5hk1h3QFKDGEb5tTrFgv0bFavHOijF5
         thkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBUEJBLWK9+kdcBPIM8kQ/1JQrZGVXX/Shkkl/p08C8V7LQLnmHdy/Hfrv9+8BWlruGcV63g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaZ8t6ncQAm3Yj3qddnvrBrx0O/6nuWocYe4HrDLi6JzwT+3YU
	uyb64PlWIdWRDrqzOR/O5ttpONA61empNYmlBF/dlarxh+9y5OsV7uUc
X-Gm-Gg: ASbGncst248C+INoN8Y71GYvTGggnU1Igtsj5nDeoCE1fvaQUKOVOdtiYD8a+kD8ZxM
	Vr8UoBvCBgKGbq3izqYS+2DszgO2+BDqsV1nPxof1q9SyKNYmrOVo9TdIvZaEu8bWjz2TeuNP9h
	CAiKhT3pvKgLeKbzYYzO40WbwFo5GszJieH5x5ptFWfQ1hds80lqBIUPlgzrraHeWjkauthF93I
	kSa2+FQ+XSA4OmqSNT7JZsuuPKmWeVea8beI6C6GKJddgTjH/qO3YbW81DtKjxV74f/t0CXkjjh
	7Skv2jfdHSPs/CjpvA+wo3tJCQMfAV+M/H8eUMermzaQf4dorFYBNu1kHSpvWc1GcO0Lza89Fp2
	QR+75m+/M9bWKlaTlOLWT4UCT9sLnLRwWXMXJ9vpJQMCO0Rid/piehkwp4F/jKkI8W6PmCW0Rap
	wTyVdISiSbq7/+reU=
X-Google-Smtp-Source: AGHT+IHnfm9cDhxkKo6634pD1Qrn3qveTjwFz5affIoqxA2b6S+MUJtfZj8poS0j4agHQFerUWJNwQ==
X-Received: by 2002:a05:6a20:3d84:b0:278:bc13:d83e with SMTP id adf61e73a8af0-334a787d9c2mr12210119637.11.1760854623674;
        Sat, 18 Oct 2025 23:17:03 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:03 -0700 (PDT)
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
Subject: [RFC Patch v2 07/16] kexec: Implement dynamic kimage tracking
Date: Sat, 18 Oct 2025 23:16:21 -0700
Message-Id: <20251019061631.2235405-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231704_638748_998FBCE9 
X-CRM114-Status: GOOD (  31.16  )
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
 arch/powerpc/kexec/crash.c |  8 ++--
 arch/x86/kernel/crash.c    |  4 +-
 include/linux/kexec.h      | 13 ++++++
 kernel/kexec.c             | 60 ++++++++++++++++++++++++++--
 kernel/kexec_core.c        | 81 ++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c        | 33 ++++++++++++++--
 6 files changed, 187 insertions(+), 12 deletions(-)

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
index 335fd2ee9766..a81f91d4352d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -559,9 +559,9 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
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
index edf64bc98ed5..69877db5360b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -431,6 +431,9 @@ struct kimage {
 	/* dm crypt keys buffer */
 	unsigned long dm_crypt_keys_addr;
 	unsigned long dm_crypt_keys_sz;
+
+	/* For multikernel support: linked list node */
+	struct list_head list;
 };
 
 /* kexec interface functions */
@@ -534,6 +537,16 @@ extern bool kexec_file_dbg_print;
 
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
+extern void kimage_list_multikernel_images(void);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..74b8df4670e0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -114,7 +114,31 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
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
@@ -124,7 +148,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
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
@@ -164,7 +192,33 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
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
+		if (image)
+			kimage_add_to_list(image);
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
index 7d89d00e2cde..449096060fe8 100644
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
@@ -248,6 +252,9 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+	/* Initialize the list node for multikernel support */
+	INIT_LIST_HEAD(&image->list);
+
 #ifdef CONFIG_CRASH_HOTPLUG
 	image->hp_action = KEXEC_CRASH_HP_NONE;
 	image->elfcorehdr_index = -1;
@@ -580,6 +587,13 @@ void kimage_free(struct kimage *image)
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
@@ -1096,6 +1110,72 @@ void kimage_unmap_segment(void *segment_buffer)
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
@@ -1112,6 +1192,7 @@ static struct kexec_load_limit load_limit_panic = {
 	.limit = -1,
 };
 
+/* Compatibility: maintain pointers to current default and crash images */
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a9794242..2d9d5626c8da 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -400,8 +400,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
@@ -457,7 +462,29 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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


