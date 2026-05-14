Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502FBCD4F46
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQqqDxa74bXnO1ngkkwE1THWbm/MOk0NCF6+LcpRWdU=; b=ecISZxetdF8IJEMpVvhZMcuJCA
	eUwBdytZuTojDRNRO3uOMxU2WlVQaoAGKJ97sdN2GnULPPnBwwecFGrshveo0hnd5k0ReTGimE2tB
	ySDzvQKabeIJMy7LWuA7L5W/eHFfw80oUZplx8Q+RmWREqsrqizhm6J8zB91C2A+RF/NAm9bsO+DW
	+7K2zEAWya+15cCR0U/2AGuTQqAwnRmAiOBXd8v1GX5gLD/jKvB9fks4WBC/Cv+Kgc3HlJHhOtp5Y
	D9f3hogiTgMzUx/oq10acX9sSBtRUeWIe5oC4V8e25gHXQkSKbgW98hrUTUvyLMM2SCQRRciHLhiL
	fjDnsWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW0-00000006iOl-1rH5;
	Thu, 14 May 2026 22:26:48 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVx-00000006iLf-2xmY
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:46 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50d7c12e48eso3369351cf.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797605; x=1779402405; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQqqDxa74bXnO1ngkkwE1THWbm/MOk0NCF6+LcpRWdU=;
        b=Qj21b7El6ChZpUOwQTrlmegmO/9jrFzPjn8jDPGe54Z6TJR/AELRwdrcw5bocIsWHT
         zo3rJ3W5+scT1dyC+RoppUX0O+ZExjKrhnfbobG/Yj3avm42k5S8Qn7IEGvdxl7CAiop
         v+hbd+IdIby9PmVRP925gFVN8pmwZEa1UFktb+pk0313KsZUSYLCKHVTBWOYNPbVHQsk
         296YAGoozRPm39bDR7UPF2WIXq+5HWUA8+6qrvvOUG7NBb/sj1QPNFobR0kPUBgkuJ6j
         5QdsTpKI0X6NbJfNXBh7noIZOCIgabKFtA8A/4Gk1IP0c1GdHro/vSDbejoO27Lc5ym9
         +5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797605; x=1779402405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQqqDxa74bXnO1ngkkwE1THWbm/MOk0NCF6+LcpRWdU=;
        b=H5bqXkC6Qy3EfVMdnow/WVFuZkz0FoCjXmAWTZB5fJe18a/qbb56x4wVwjC9sNpY4Y
         lXz/LNvq8s648ajw2BvJXP28yTBX3yuqpNH/5wut69O+CX9tDrfEpDpHXSsH+STk6vlB
         5Y9gVbgdfcNxQxM8d0mOFG7oAzV15tiCTsU6OhU8G8W8VIaepXA41op/W/GRKU4OmqIt
         SQlqTGEShy+9Taoo0usJ0HuNWVgTHcRU94HJHorQVtHvsx5ihYrsn2GLN5GG5sRSTQWN
         gZ4zK+D33xWk+F4D0oeaATADMFxBYEsvtIvufFJItUcaBoBjniC5zb0drLaTlqLQHqRu
         2bZw==
X-Forwarded-Encrypted: i=1; AFNElJ91tIw2Ysph6R+h4sBYIjtcrnfD4xIUtKvNy87NIv4BlKTJnwEVSmcKorITv2+supuW9EIVgg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzc4P9EXT7kgXclA80iAFkRWaxDKTvXl0fLyoRUIfsKuYGlKWIT
	eguncH6KKbpWnQv8/QsqG2hiTnPo29mtPU6PM6SFV1Y8C03Yx1byENWOpp/t9fHX7AM=
X-Gm-Gg: Acq92OFt9DYRQQoo6oz4OuN9Q6Xib9iMpuTuP7KfKX46YPiEkgwxDq88Q6ggZ+hUZGt
	SGwPzCKWY6nhgN0fl24XMfCo/v1FWbADwOU4sCuRW9b/mIefxWC7+oibvMtvsunHqDCEXKlqZkw
	G3BJnEk+g70YGKDu/gqf/glxQwf/Vnm6woeARgaO4hd5S40KdgMO+ix10lXaCv9zYfsdtho641+
	q1A/k4DXj/hT7My83/IT7B74vuzIIfcGEIoYcjfLU8S/KaDkrMgoHD0Da3BbAmJLrpULoSkOoNS
	pH3qUuqtB08dR32uURnuNxLhqJ9nLod7T/tsta6DCRgkmwS13Yov4w75YEfbzSkMhFT5BIBlDM7
	M4mBCl0S5IWqMz9fVfCPwfhr9GZ8rWGvlSsxXrF2JMKZceHxbnLn0r/fAekmWJMGfy4PHeKNVuA
	tRv0uFUJJotnQtmf8a/2ISKHRLE5ioT9Ps8khu/d9UA1MSDsNW/rWF6alfGti1WQ==
X-Received: by 2002:a05:622a:254:b0:50f:39f4:3a2b with SMTP id d75a77b69052e-51641967867mr73061401cf.41.1778797604725;
        Thu, 14 May 2026 15:26:44 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:43 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v2 07/10] liveupdate: Remove limit on the number of files per session
Date: Thu, 14 May 2026 22:26:25 +0000
Message-ID: <20260514222628.931312-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152645_776100_28592002 
X-CRM114-Status: GOOD (  26.43  )
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

To remove the fixed limit on the number of preserved files per session,
transition the file metadata serialization from a single contiguous
memory block to a chain of linked blocks.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h      |  13 +--
 kernel/liveupdate/luo_file.c     | 142 +++++++++++++++----------------
 kernel/liveupdate/luo_internal.h |   5 +-
 3 files changed, 77 insertions(+), 83 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index a643193a379c..59677dc9cdd1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -56,8 +56,8 @@
  *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
- *     to another preserved memory block containing an array of
- *     `struct luo_file_ser` for all files in that session.
+ *     to the first `struct luo_block_header_ser` for all files in that session.
+ *     Multiple blocks are linked via the `next` field in the header.
  *
  *   - struct luo_file_ser:
  *     Metadata for a single preserved file. Contains the `compatible` string to
@@ -85,7 +85,7 @@
  */
 #define LUO_FDT_SIZE		PAGE_SIZE
 #define LUO_FDT_KHO_ENTRY_NAME	"LUO"
-#define LUO_FDT_COMPATIBLE	"luo-v3"
+#define LUO_FDT_COMPATIBLE	"luo-v4"
 #define LUO_FDT_ABI_HEADER	"luo-abi-header"
 
 /**
@@ -138,9 +138,10 @@ struct luo_file_ser {
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
- * @files:   The physical address of a contiguous memory block that holds
- *           the serialized state of files (array of luo_file_ser) in this file
- *           set.
+ * @files:   The physical address of the first `struct luo_block_header_ser`.
+ *           This structure is the header for a block of memory containing
+ *           an array of `struct luo_file_ser` entries. Multiple blocks are
+ *           linked via the `next` field in the header.
  * @count:   The total number of files that were part of this session during
  *           serialization. Used for iteration and validation during
  *           restoration.
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a2510563469a..e2ab7834963d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -118,11 +118,6 @@ static LIST_HEAD(luo_file_handler_list);
 /* Keep track of files being preserved by LUO */
 static DEFINE_XARRAY(luo_preserved_files);
 
-/* 2 4K pages, give space for 128 files per file_set */
-#define LUO_FILE_PGCNT		2ul
-#define LUO_FILE_MAX							\
-	((LUO_FILE_PGCNT << PAGE_SHIFT) / sizeof(struct luo_file_ser))
-
 /**
  * struct luo_file - Represents a single preserved file instance.
  * @fh:            Pointer to the &struct liveupdate_file_handler that manages
@@ -174,39 +169,6 @@ struct luo_file {
 	u64 token;
 };
 
-static int luo_alloc_files_mem(struct luo_file_set *file_set)
-{
-	size_t size;
-	void *mem;
-
-	if (file_set->files)
-		return 0;
-
-	WARN_ON_ONCE(file_set->count);
-
-	size = LUO_FILE_PGCNT << PAGE_SHIFT;
-	mem = kho_alloc_preserve(size);
-	if (IS_ERR(mem))
-		return PTR_ERR(mem);
-
-	file_set->files = mem;
-
-	return 0;
-}
-
-static void luo_free_files_mem(struct luo_file_set *file_set)
-{
-	/* If file_set has files, no need to free preservation memory */
-	if (file_set->count)
-		return;
-
-	if (!file_set->files)
-		return;
-
-	kho_unpreserve_free(file_set->files);
-	file_set->files = NULL;
-}
-
 static unsigned long luo_get_id(struct liveupdate_file_handler *fh,
 				struct file *file)
 {
@@ -276,16 +238,15 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (luo_token_is_used(file_set, token))
 		return -EEXIST;
 
-	if (file_set->count == LUO_FILE_MAX)
-		return -ENOSPC;
+	err = luo_block_grow(&file_set->block_set, file_set->count);
+	if (err)
+		return err;
 
 	file = fget(fd);
-	if (!file)
-		return -EBADF;
-
-	err = luo_alloc_files_mem(file_set);
-	if (err)
-		goto  err_fput;
+	if (!file) {
+		err = -EBADF;
+		goto err_shrink;
+	}
 
 	err = -ENOENT;
 	down_read(&luo_register_rwlock);
@@ -300,7 +261,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 
 	/* err is still -ENOENT if no handler was found */
 	if (err)
-		goto err_free_files_mem;
+		goto err_fput;
 
 	err = xa_insert(&luo_preserved_files, luo_get_id(fh, file),
 			file, GFP_KERNEL);
@@ -343,10 +304,10 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	xa_erase(&luo_preserved_files, luo_get_id(fh, file));
 err_module_put:
 	module_put(fh->ops->owner);
-err_free_files_mem:
-	luo_free_files_mem(file_set);
 err_fput:
 	fput(file);
+err_shrink:
+	luo_block_shrink(&file_set->block_set, file_set->count);
 
 	return err;
 }
@@ -391,13 +352,14 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 			 luo_get_id(luo_file->fh, luo_file->file));
 		list_del(&luo_file->list);
 		file_set->count--;
+		luo_block_shrink(&file_set->block_set, file_set->count);
 
 		fput(luo_file->file);
 		mutex_destroy(&luo_file->mutex);
 		kfree(luo_file);
 	}
 
-	luo_free_files_mem(file_set);
+	luo_block_destroy(&file_set->block_set);
 }
 
 static int luo_file_freeze_one(struct luo_file_set *file_set,
@@ -453,7 +415,7 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 		luo_file_unfreeze_one(file_set, luo_file);
 	}
 
-	memset(file_set->files, 0, LUO_FILE_PGCNT << PAGE_SHIFT);
+	luo_block_set_clear(&file_set->block_set);
 }
 
 /**
@@ -492,19 +454,23 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser)
 {
-	struct luo_file_ser *file_ser = file_set->files;
 	struct luo_file *luo_file;
+	struct luo_block_it it;
 	int err;
-	int i;
 
 	if (!file_set->count)
 		return 0;
 
-	if (WARN_ON(!file_ser))
-		return -EINVAL;
+	luo_block_it_init(&it, &file_set->block_set);
 
-	i = 0;
 	list_for_each_entry(luo_file, &file_set->files_list, list) {
+		struct luo_file_ser *file_ser = luo_block_it_next(&it);
+
+		if (!file_ser) {
+			err = -ENOSPC;
+			goto err_unfreeze;
+		}
+
 		err = luo_file_freeze_one(file_set, luo_file);
 		if (err < 0) {
 			pr_warn("Freeze failed for token[%#0llx] handler[%s] err[%pe]\n",
@@ -513,16 +479,21 @@ int luo_file_freeze(struct luo_file_set *file_set,
 			goto err_unfreeze;
 		}
 
-		strscpy(file_ser[i].compatible, luo_file->fh->compatible,
-			sizeof(file_ser[i].compatible));
-		file_ser[i].data = luo_file->serialized_data;
-		file_ser[i].token = luo_file->token;
-		i++;
+		strscpy(file_ser->compatible, luo_file->fh->compatible,
+			sizeof(file_ser->compatible));
+		file_ser->data = luo_file->serialized_data;
+		file_ser->token = luo_file->token;
 	}
+	luo_block_it_finalize(&it);
 
 	file_set_ser->count = file_set->count;
-	if (file_set->files)
-		file_set_ser->files = virt_to_phys(file_set->files);
+	if (!list_empty(&file_set->block_set.blocks)) {
+		struct luo_block *block;
+
+		block = list_first_entry(&file_set->block_set.blocks,
+					 struct luo_block, list);
+		file_set_ser->files = virt_to_phys(block->ser);
+	}
 
 	return 0;
 
@@ -740,14 +711,12 @@ int luo_file_finish(struct luo_file_set *file_set)
 		}
 		list_del(&luo_file->list);
 		file_set->count--;
+		luo_block_shrink(&file_set->block_set, file_set->count);
 		mutex_destroy(&luo_file->mutex);
 		kfree(luo_file);
 	}
 
-	if (file_set->files) {
-		kho_restore_free(file_set->files);
-		file_set->files = NULL;
-	}
+	luo_block_destroy(&file_set->block_set);
 
 	return 0;
 }
@@ -821,16 +790,18 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser)
 {
 	struct luo_file_ser *file_ser;
+	struct luo_block_it it;
 	int err;
-	u64 i;
 
 	if (!file_set_ser->files) {
 		WARN_ON(file_set_ser->count);
 		return 0;
 	}
 
-	file_set->count = file_set_ser->count;
-	file_set->files = phys_to_virt(file_set_ser->files);
+	file_set->count = 0;
+	err = luo_block_restore(&file_set->block_set, file_set_ser->files);
+	if (err)
+		return err;
 
 	/*
 	 * Note on error handling:
@@ -847,25 +818,48 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	 * userspace to detect the failure and trigger a reboot, which will
 	 * reliably reset devices and reclaim memory.
 	 */
-	file_ser = file_set->files;
-	for (i = 0; i < file_set->count; i++) {
-		err = luo_file_deserialize_one(file_set, &file_ser[i]);
+	luo_block_it_init(&it, &file_set->block_set);
+	while ((file_ser = luo_block_it_read(&it))) {
+		err = luo_file_deserialize_one(file_set, file_ser);
 		if (err)
-			return err;
+			goto err_destroy_blocks;
+		file_set->count++;
+	}
+
+	if (file_set->count != file_set_ser->count) {
+		pr_warn("File count mismatch: expected %llu, found %ld\n",
+			file_set_ser->count, file_set->count);
 	}
 
 	return 0;
+
+err_destroy_blocks:
+	while (!list_empty(&file_set->files_list)) {
+		struct luo_file *luo_file;
+
+		luo_file = list_first_entry(&file_set->files_list,
+					    struct luo_file, list);
+		list_del(&luo_file->list);
+		module_put(luo_file->fh->ops->owner);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+	}
+	file_set->count = 0;
+	luo_block_destroy(&file_set->block_set);
+	return err;
 }
 
 void luo_file_set_init(struct luo_file_set *file_set)
 {
 	INIT_LIST_HEAD(&file_set->files_list);
+	luo_block_set_init(&file_set->block_set, sizeof(struct luo_file_ser));
 }
 
 void luo_file_set_destroy(struct luo_file_set *file_set)
 {
 	WARN_ON(file_set->count);
 	WARN_ON(!list_empty(&file_set->files_list));
+	WARN_ON(!list_empty(&file_set->block_set.blocks));
 }
 
 /**
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 090078ad771c..901483e6e4ad 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -89,14 +89,13 @@ struct luo_block_it {
  * struct luo_file_set - A set of files that belong to the same sessions.
  * @files_list: An ordered list of files associated with this session, it is
  *              ordered by preservation time.
- * @files:      The physically contiguous memory block that holds the serialized
- *              state of files.
+ * @block_set:  The set of serialization blocks.
  * @count:      A counter tracking the number of files currently stored in the
  *              @files_list for this session.
  */
 struct luo_file_set {
 	struct list_head files_list;
-	struct luo_file_ser *files;
+	struct luo_block_set block_set;
 	long count;
 };
 
-- 
2.53.0


