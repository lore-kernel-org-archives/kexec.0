Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258D5CDB47F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMLGHTfZnEaHrHkry5MnHfUQ+INjPp4I0JJX2E/+AAw=; b=GEbb3rKfR77KzCWRMx6ccomxhY
	sZKp+xcP7VzdlSJPuN0oYHgKMxNQTcgRqfaSjedcSC7CR8VVpdQ20ezmOiyDY1tpfr3LPvIbrFrCE
	Xpz0bgVEqWdR1uE8rYstZuAx7styso8oh1dEgQyDcd8uoAB4ycQEzBEH8q6yQ3RvvqSrBxMsohdCe
	GarrfswZ6sggsK5otWAoszZpZGdmj9ybZe0xexqvnWoj2hToGCgyOsIwLdjfE+h+U6j1S8L2yZI7d
	B9y61AZBSiQTwk7H0LbGCyIR3KKP34FIqcNMi0M3JSpHzBwsrX8502qnqp28KdkDCX9jPaZvq6prW
	LvjLmMlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjm-0000000671u-11L6;
	Tue, 23 Jun 2026 10:52:14 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyji-000000066zE-03g7
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:52:11 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68f9ee927fcso4679295a12.3
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782211927; x=1782816727; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMLGHTfZnEaHrHkry5MnHfUQ+INjPp4I0JJX2E/+AAw=;
        b=KqKB2WdlhiUuvKRh2xK8DSrnZzfy9GY7SXhS16hQT97U4DJltC9JslyC9u8sZjbJqN
         x/ff26cH1m4zsHgWHc8OlOAXlS+JyweSe204Zr7Qq7YmNobtRP+gL40qv3DzzlZ2wQqi
         9ejiKJjFbiimuh4eJSQNxlhBthJiEPtaGZoIqSePPVCNeIhn7fY526Cx1fhCaUDeq4ob
         JJ2COiGoNk+3twfx2KoODxrY94HRq/G+d/x4oNVCeOmdC1kdu+i1d/cIQyz2BmDYGRxI
         POqTD1NvpzU+YbDupfS7+eElnRy9xOLS/o1HiZlDhWIo1YzgaSUoppScqFysDbFze2YE
         6rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211927; x=1782816727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMLGHTfZnEaHrHkry5MnHfUQ+INjPp4I0JJX2E/+AAw=;
        b=nJn3cxQOEhcX5KLo8N3tZM6PIWXJfvq8xHhDe8073hICW9xlIVI0E555mfROKw4Sek
         H6Ub/cI0GkzDSN6f4iMtN5k5w6dlBgazHfvzEwlb/M81EsjCOf30MNwvi7ndctOvoPOn
         vHKNGzNOHCtaRcfmCj3oXxNMGH0hwEYBb28lVGj0jnsqIAL4Kthy5leqrBLQRUHWP3e5
         bR5BwjRzom0QNmXGLHuwCKRLNj/wdMs0EQaJyP7vAhGByKWLxX+5S3B0s0TkwZg9OEEf
         KZOFevbMCaLPpKYpg9VmUFlRJ/ASeKl4YC5WEXP2DWD8tOt2v2NI3ToalEKP6NlOeBz0
         pa/w==
X-Gm-Message-State: AOJu0YzpbDihZyD6STHx/y+AQB/3/JPFvKTA8t8DKsf+R60p/pmeSe18
	8YsFWGMxWDa/C6gIn/18IyE0lWKgsQrXLabZCBiYiW5Ma3jtGr4MhnQ435fS2LJ3RJSiDN4xtHj
	eA4KCXkajlJiHLSSFbA==
X-Received: from edxb16.prod.google.com ([2002:a05:6402:2d0:b0:695:a1ca:4c01])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3488:b0:68f:c62d:b36d with SMTP id 4fb4d7f45d1cf-697dbafa348mr1069828a12.27.1782211926922;
 Tue, 23 Jun 2026 03:52:06 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:52:01 +0000
In-Reply-To: <20260623105201.3724592-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260623105201.3724592-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623105201.3724592-4-tarunsahu@google.com>
Subject: [PATCH v5 3/3] luo: Update serialized data to use KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_035210_102428_041BC0ED 
X-CRM114-Status: GOOD (  19.87  )
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
This series also takes care of resolving the bug with memfd of using
phys_to_virt before checking the args->serialized_data value.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kho/abi/luo.h  |  5 +++--
 include/linux/liveupdate.h   |  4 ++--
 kernel/liveupdate/luo_file.c | 24 ++++++++++++------------
 mm/memfd_luo.c               | 20 +++++++++++---------
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..d5b3b1c0fec1 100644
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
+ * @serialized_data:  The serialized pointer union for this file
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
index 88722e5caf02..480d638b7d18 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -33,7 +33,7 @@ struct file;
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
- * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
+ * @serialized_data:  The serialized pointer union, preserve/prepare/freeze may update
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
index c39f96961a85..aecf19033f95 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -125,7 +125,7 @@ static DEFINE_XARRAY(luo_preserved_files);
  * @file:          Pointer to the kernel's &struct file that is being preserved.
  *                 This is NULL in the new kernel until the file is successfully
  *                 retrieved.
- * @serialized_data: The opaque u64 handle to the serialized state of the file.
+ * @serialized_data: The serialized pointer union to the serialized state of the file.
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
index 10f3983b0060..852b61678229 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -257,6 +257,7 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *);
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
@@ -309,7 +310,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	KHOSER_STORE_PTR(sd, ser);
+	KHOSER_COPY_PTR(args->serialized_data, sd);
 
 	return 0;
 
@@ -325,11 +327,10 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
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
@@ -344,14 +345,13 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
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
 
@@ -397,7 +397,8 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	if (!args->serialized_data)
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (!ser)
 		return;
 
 	ser = phys_to_virt(args->serialized_data);
@@ -523,7 +524,8 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	if (!args->serialized_data)
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
+	if (!ser)
 		return -EINVAL;
 
 	ser = phys_to_virt(args->serialized_data);
-- 
2.55.0.rc0.786.g65d90a0328-goog


