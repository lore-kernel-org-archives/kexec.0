Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA4ECD98E7
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vEk+wmrFXeXruHfFEsfJwOEWHnGQlk3rAiCVWz123x8=; b=l7HEjWJUFkq3byj3zovP3tAoW5
	vpU7X7fGyXksZhdB384s3taASN8pUzx9WdF+MHtraAMzxlo4J/aMsL5DXF+XJF14ZAfHx7bzAL8Y8
	VD+E3pFUu6vXY+aSNZ5vgTrjUVYP6BPvF9xw09OocS5fqvJR/gCX6FvUZN5wq9DhVv0PYEIhQju8T
	xgxHKVswVgli0qBJ3Y6LSWyKyYrShn3qslSisgd0tOuGpLjNfWQ1Ah+e43yP5hTyrXl6UmHGiophm
	QGa3gIKjFQFDI/8VVw7rv+muhJWO330c/0K1+peDBp18Ve1nPlIbH6pxqv9aDI2B1+vZwsXHzDtlq
	w/hY3f5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTlr-0000000Fpj1-0lRJ;
	Tue, 16 Jun 2026 13:24:03 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTlm-0000000Fpfy-3VEw
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 13:24:00 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso24363325e9.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781616236; x=1782221036; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEk+wmrFXeXruHfFEsfJwOEWHnGQlk3rAiCVWz123x8=;
        b=sVM/udG8ZVWB5DJ1JPuMPnFL1AMkJnVZaTuJEZtN+iS+wFlDA8+SaUdGuj3kpyi27f
         6ng1hRWRBRrlEbMBo8z+nMC88ykCqmPxobsyETvKfvZpbml4HTwRYJlH4F4yYcIY+3Mu
         IKVwjwA4yV7pP/LLmlFToSLW8DolilPn3UuXL3cmN7kafy/Zq3W7f8jbDFjwV9aN+FcM
         evoUx0Rk71CUERLV6ujnRcAImCAj0kEewfAJDHKgsz7HteGSHDixice5mCF4eDolJocr
         dpzUwOoQk+d5EGkBFXhXVFwhGiPEEMXpeER6CzJ/7VvjDRSoNFNo41JLiqPRe90EJnM8
         XXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616236; x=1782221036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEk+wmrFXeXruHfFEsfJwOEWHnGQlk3rAiCVWz123x8=;
        b=YN8dlVtrFHAThGZWizmcHw0kfIdz5LqaokGUFgktmGEeCG8oAXzLOnwurFQOmjn2tt
         HYX2itVtFLpU5QzAeV6aehrETYTIIBJIQkigj1OZTdt00nEoY68Xe562ZMJfrvJx5QyV
         QJF09tIEQrmdZbIkhVODNB5lC3GxSxKFyw0qm8ghtV4NlcaZnkVr2vUyZRs1NQbmEyfn
         hcZSkI1QUB100XKg1IWAA/+2Hccq+zhswijfwtYYy1oMfXyEiw7PUjK4O7zrMiYEPOrg
         7hKOT21rb41wn1/1JEMY+p9ombAEBd+7K7Akr1ZjUFPoKoa+hb3jGgEelkvRfxSNI2AB
         oqEA==
X-Forwarded-Encrypted: i=1; AFNElJ9lldms9xgQ5twpT7zv8tkRfwvY7cGbaskOjREGsbt6il/GR294ePsLlOZmovv5XZx/upuqKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmMaNqZ+k4suBh6erOcExVhzGDLtiVFu5AULW2ylvkuGi/ul1l
	wPRq4Dg3zk3cOdQ6nO8O50XOH70ub+b0mKiQm9DaDYofMuMmCLvUOm1jTKhngw1ntOPyL8XW1Hh
	pAuyy75Ej3ymbNIIS1Q==
X-Received: from wmbfp27.prod.google.com ([2002:a05:600c:699b:b0:490:b360:5841])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a0c:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490ec50a221mr256551145e9.27.1781616236229;
 Tue, 16 Jun 2026 06:23:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:23:51 +0000
In-Reply-To: <cover.1781615759.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1781615759.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <7dc691529948f688204f6c6e626723be88fbc578.1781615759.git.tarunsahu@google.com>
Subject: [PATCH v2 2/2] luo: Update serialized data to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_062358_924019_D0ED8CD0 
X-CRM114-Status: GOOD (  21.94  )
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

Currently luo_file_ser, luo_file and liveupdate_file_op_args use the raw
serialized_data which stores the phys address of the serialized data. There
are two issues
1. It uses raw update, and there is not type safety check
2. user of liveupdate_file_op_args, uses virt_to_phys and phys_to_virt
   to convert the serializeable pointer to physical address and vice versa.
   User makes mistakes mistake to check the serializeable pointer/phys
   value check before converting like in memfd_luo.

Converting them to serializeable pointer enforce type safety check ( it has
its limitation as you can not have generic serializeable pointer for all
the subsystem. So only void * is the only choice, and updating it require
user to use KHOSER_COPY_TYPEUNSAFE) and the null value check.

This patch also updates the memfd_luo to use the newly introduced the
serializeable pointer. Which mitigates the issue of not checking
args->serialized_data pointer before using it.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h  |  6 ++++--
 include/linux/liveupdate.h   |  4 ++--
 kernel/liveupdate/luo_file.c | 24 ++++++++++++------------
 mm/memfd_luo.c               | 18 +++++++++---------
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 46750a0ddf88..6b08fbf7ad59 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -119,17 +119,19 @@
 
 #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
 
+#include <linux/kho/abi/kexec_handover.h>
+
 /**
  * struct luo_file_ser - Represents the serialized preserves files.
  * @compatible:  File handler compatible string.
- * @data:        Private data
+ * @serialized_data: Serializable pointer union for private data.
  * @token:       User provided token for this file
  *
  * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
-	u64 data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	u64 token;
 } __packed;
 
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 30c5a39ff9e9..8b3466801159 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -32,7 +32,7 @@ struct file;
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
- * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
+ * @serialized_data:  The serialized pointer union, preserve/prepare/freeze may update
  *                    this field.
  * @private_data:     Private data for the file used to hold runtime state that
  *                    is not preserved. Set by the handler's .preserve()
@@ -46,7 +46,7 @@ struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
 	int retrieve_status;
 	struct file *file;
-	u64 serialized_data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	void *private_data;
 };
 
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a0a419085e28..c50c8239a34d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -130,7 +130,7 @@ static DEFINE_XARRAY(luo_preserved_files);
  * @file:          Pointer to the kernel's &struct file that is being preserved.
  *                 This is NULL in the new kernel until the file is successfully
  *                 retrieved.
- * @serialized_data: The opaque u64 handle to the serialized state of the file.
+ * @serialized_data: The serialized pointer union to the serialized state of the file.
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
@@ -166,7 +166,7 @@ static DEFINE_XARRAY(luo_preserved_files);
 struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
-	u64 serialized_data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	void *private_data;
 	int retrieve_status;
 	struct mutex mutex;
@@ -328,7 +328,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto err_kfree;
 
-	luo_file->serialized_data = args.serialized_data;
+	KHOSER_COPY_TYPESAFE(luo_file->serialized_data, args.serialized_data);
 	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
 	file_set->count++;
@@ -381,7 +381,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
@@ -412,12 +412,12 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
-			luo_file->serialized_data = args.serialized_data;
+			KHOSER_COPY_TYPESAFE(luo_file->serialized_data, args.serialized_data);
 	}
 
 	return err;
@@ -433,7 +433,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
@@ -515,7 +515,7 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 		strscpy(file_ser[i].compatible, luo_file->fh->compatible,
 			sizeof(file_ser[i].compatible));
-		file_ser[i].data = luo_file->serialized_data;
+		KHOSER_COPY_TYPESAFE(file_ser[i].serialized_data, luo_file->serialized_data);
 		file_ser[i].token = luo_file->token;
 		i++;
 	}
@@ -621,7 +621,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
-	args.serialized_data = luo_file->serialized_data;
+	KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
 		/* Keep the error code for later use. */
@@ -655,7 +655,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
-		args.serialized_data = luo_file->serialized_data;
+		KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 		args.retrieve_status = luo_file->retrieve_status;
 		can_finish = luo_file->fh->ops->can_finish(&args);
 	}
@@ -672,7 +672,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 
 	args.handler = luo_file->fh;
 	args.file = luo_file->file;
-	args.serialized_data = luo_file->serialized_data;
+	KHOSER_COPY_TYPESAFE(args.serialized_data, luo_file->serialized_data);
 	args.retrieve_status = luo_file->retrieve_status;
 
 	luo_file->fh->ops->finish(&args);
@@ -837,7 +837,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 
 		luo_file->fh = fh;
 		luo_file->file = NULL;
-		luo_file->serialized_data = file_ser[i].data;
+		KHOSER_COPY_TYPESAFE(luo_file->serialized_data, file_ser[i].serialized_data);
 		luo_file->token = file_ser[i].token;
 		mutex_init(&luo_file->mutex);
 		list_add_tail(&luo_file->list, &file_set->files_list);
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..daf2c4c3da35 100644
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
+	KHOSER_COPY_TYPEUNSAFE(args->serialized_data, sd);
 
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
 
@@ -397,7 +397,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
 	if (!ser)
 		return;
 
@@ -522,7 +522,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
+	ser = KHOSER_LOAD_PTR(args->serialized_data);
 	if (!ser)
 		return -EINVAL;
 
-- 
2.54.0.1136.gdb2ca164c4-goog


