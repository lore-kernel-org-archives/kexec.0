Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D5EC43458
	for <kexec@archiver.kernel.org>; Sun, 28 Jun 2026 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3M9J9XOVcczJl+Z2kGqS39ArQMOVpPdk3Lu1iqM0IEA=; b=VIpfQ38oz7bc7N1lpFSjs5pkJ/
	LzfemqeMKPunmYYN6bwrRQwwHdC5c6Y1QpHd4qtV8YdO1zbR1MhrwvtmkvO72pIY/PieJhoQNrJoF
	AMnS5m3VvrSZ+9JEUMHlfcWg+oPLjq/svZS+r4Cjajgqx7cCPzYxWq4pGulP0xG7l4njjVR2XPuLd
	YBeNnYrUGDeljH5FZCS9LO7lQEslotcr0FHezSL9PmfaVAVgvPUla+dUxHx0UBrdoLYIeNcPRmzb3
	a8LThplnUWJKFI4q/IOvLi7sDBFj1Rjox6DniVzZNxbWbub4Ac4ouvCuTziIyvj48sac8nz/Qp+DR
	eKxhugZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7O-0000000CqB5-3tB5;
	Sun, 28 Jun 2026 00:11:26 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7L-0000000Cq8e-09AG
	for kexec@lists.infradead.org;
	Sun, 28 Jun 2026 00:11:24 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-c12518f7c22so7747966b.2
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 17:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782605480; x=1783210280; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M9J9XOVcczJl+Z2kGqS39ArQMOVpPdk3Lu1iqM0IEA=;
        b=TuGJPzdrZBHMEXIKfmp/fE9BiLCrBc9AVQjT1CSjfiz/qkiTeU/d7dboqEyzCsO5Cc
         4DkeHnmK0d/JqwpEl+Je7YCC8UiBEUX1Fnhvk2K6Q71sq5zugR9jFCJGcdi1TK5HoYUw
         FtPj9gzxqiZHn3Kydhx1x+hsdMh3/Kb4F4mUNrexwmNxoNqi6QnpeIoF1lS3DqYUGyUW
         VsBoGdsxLpVruC9hotoNboQ/c7q7jEdpyfFiO9WGYsQVqFUWSseUxb7AiziNZHjoo+NR
         A04oUP7/MRXksnlh2EBYC5Jgi+Ghi20y72/eKw5pwghTnPtRwzwV+8xckEwsJc54zdq3
         vCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605480; x=1783210280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M9J9XOVcczJl+Z2kGqS39ArQMOVpPdk3Lu1iqM0IEA=;
        b=B5jxB4IQKKsEVifoJe2nfZ/Slnl8y8FIl1ruDMZC+5E9wKTQGFOgB6MOjpzvEcL3ct
         cVv8Me5RFIVAonNYAJi0S0tbg9V7Bimc4SL2GFjuQGDJMfLMjrk7qtUWekuO5wDkx5M0
         QGmUGSYIL0skUjZFOGRi/XJCDZLESdOsIwHq0vL4zpusfzFUSkuazCW+vEh6/Vqejv/c
         ++xz+ZQqhBZ4h8WbK70ZyBju2NaPW+OryRiIc/JzafARBKEIUQnU+za5OJSm19MOP8eJ
         n8qUHA7+m1oKRdLWuvEoo4dT3q/ktcPXFNCJgfY6Z1Zm55/hv96dSrkYTh8pbywCMO7g
         XDNg==
X-Gm-Message-State: AOJu0YxiEVpA4uzkViMRPS18Ce8+oSK0JyOpkJvVDqccVirhxpRYlnE8
	20wQjDv7yoZUxYqGRZ+G9v+RhRHJAqEG81BaQB4X3fqWikx1TM2+L70vdyFhUaqRiGnml4vuMJH
	esw42ORMa3Zz2/K049Q==
X-Received: from ejsh21.prod.google.com ([2002:a17:906:5855:b0:c01:db91:5d49])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:fd83:b0:c12:30dd:de2 with SMTP id a640c23a62f3a-c1230dd138bmr301464866b.16.1782605479913;
 Sat, 27 Jun 2026 17:11:19 -0700 (PDT)
Date: Sun, 28 Jun 2026 00:11:14 +0000
In-Reply-To: <20260628001114.1869564-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260628001114.1869564-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260628001114.1869564-4-tarunsahu@google.com>
Subject: [PATCH v6 3/3] luo: Update serialized data to use KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_171123_114381_E67C4189 
X-CRM114-Status: GOOD (  20.23  )
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

Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kho/abi/luo.h  |  5 +++--
 include/linux/liveupdate.h   |  4 ++--
 kernel/liveupdate/luo_file.c | 24 ++++++++++++------------
 mm/memfd_luo.c               | 22 +++++++++-------------
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..9e78625cfdc1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -59,6 +59,7 @@
 
 #include <linux/align.h>
 #include <linux/kho/abi/block.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
@@ -89,14 +90,14 @@ struct luo_ser {
 /**
  * struct luo_file_ser - Represents the serialized preserves files.
  * @compatible:  File handler compatible string.
- * @data:        Private data
+ * @serialized_data:  The serialized KHO pointer for this file
  * @token:       User provided token for this file
  *
  * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
-	u64 data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	u64 token;
 } __packed;
 
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 88722e5caf02..3bcb6890548d 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -33,7 +33,7 @@ struct file;
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
- * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
+ * @serialized_data:  The serialized KHO pointer, preserve/prepare/freeze may update
  *                    this field.
  * @private_data:     Private data for the file used to hold runtime state that
  *                    is not preserved. Set by the handler's .preserve()
@@ -47,7 +47,7 @@ struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
 	int retrieve_status;
 	struct file *file;
-	u64 serialized_data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	void *private_data;
 };
 
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index c39f96961a85..5c62d5c32935 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -125,7 +125,7 @@ static DEFINE_XARRAY(luo_preserved_files);
  * @file:          Pointer to the kernel's &struct file that is being preserved.
  *                 This is NULL in the new kernel until the file is successfully
  *                 retrieved.
- * @serialized_data: The opaque u64 handle to the serialized state of the file.
+ * @serialized_data: The serialized KHO pointer to the serialized state of the file.
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
@@ -161,7 +161,7 @@ static DEFINE_XARRAY(luo_preserved_files);
 struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
-	u64 serialized_data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	void *private_data;
 	int retrieve_status;
 	struct mutex mutex;
@@ -289,7 +289,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto err_kfree;
 
-	luo_file->serialized_data = args.serialized_data;
+	KHOSER_COPY_PTR(luo_file->serialized_data, args.serialized_data);
 	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
 	file_set->count++;
@@ -342,7 +342,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
@@ -375,12 +375,12 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
-			luo_file->serialized_data = args.serialized_data;
+			KHOSER_COPY_PTR(luo_file->serialized_data, args.serialized_data);
 	}
 
 	return err;
@@ -396,7 +396,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
@@ -483,7 +483,7 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 		strscpy(file_ser->compatible, luo_file->fh->compatible,
 			sizeof(file_ser->compatible));
-		file_ser->data = luo_file->serialized_data;
+		KHOSER_COPY_PTR(file_ser->serialized_data, luo_file->serialized_data);
 		file_ser->token = luo_file->token;
 	}
 
@@ -587,7 +587,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
-	args.serialized_data = luo_file->serialized_data;
+	KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
 		/* Keep the error code for later use. */
@@ -621,7 +621,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 		args.retrieve_status = luo_file->retrieve_status;
 		can_finish = luo_file->fh->ops->can_finish(&args);
 	}
@@ -638,7 +638,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 
 	args.handler = luo_file->fh;
 	args.file = luo_file->file;
-	args.serialized_data = luo_file->serialized_data;
+	KHOSER_COPY_PTR(args.serialized_data, luo_file->serialized_data);
 	args.retrieve_status = luo_file->retrieve_status;
 
 	luo_file->fh->ops->finish(&args);
@@ -748,7 +748,7 @@ static int luo_file_deserialize_one(struct luo_file_set *file_set,
 
 	luo_file->fh = fh;
 	luo_file->file = NULL;
-	luo_file->serialized_data = ser->data;
+	KHOSER_COPY_PTR(luo_file->serialized_data, ser->serialized_data);
 	luo_file->token = ser->token;
 	mutex_init(&luo_file->mutex);
 	list_add_tail(&luo_file->list, &file_set->files_list);
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 10f3983b0060..a83360551cc5 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -309,7 +309,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	KHOSER_STORE_PTR(args->serialized_data, ser);
 
 	return 0;
 
@@ -325,11 +325,10 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_ser *ser;
 
-	if (WARN_ON_ONCE(!args->serialized_data))
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (WARN_ON_ONCE(!ser))
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
-
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
 	 * same.
@@ -344,14 +343,13 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_ser *ser;
 
-	if (WARN_ON_ONCE(!args->serialized_data))
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (WARN_ON_ONCE(!ser))
 		return;
 
 	inode_lock(inode);
 	shmem_freeze(inode, false);
 
-	ser = phys_to_virt(args->serialized_data);
-
 	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
 				    ser->nr_folios);
 
@@ -397,11 +395,10 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	if (!args->serialized_data)
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (!ser)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser)
@@ -523,11 +520,10 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	if (!args->serialized_data)
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (!ser)
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
-
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


