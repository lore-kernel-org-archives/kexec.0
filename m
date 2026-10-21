Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27360A3825
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xro9HxES;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JaKvrs/o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=; b=Xro9HxESblU+sPS6x4G7HFQMFU
	dRZ11t012YXcEeGaTMES48riDFFltD83lyFy75hJ8J4nGB5w0wzKlz8tPK06PRz8sdhYGEj+0MmsQ
	BHBpAsDq7oFFW3FfObK663MSrK2L9Qc7BgLo1dEFMoT6Etol5Y8bTVJzIvTBPfG33P6H/r/E7E0/o
	5kMWFRNrWSqUz3bh24SlihLCH6hkFFpbycj9ZMHufOTq6RPF1F6lZPuwyEP9qiExWGjHip184m+Kg
	66mK1gIqhA9RQRGGBDCYSwt4m2AZ+R5Fdticl5gJrTXjDkDeKWpj4/IataxNxVAzUCGiMdUA7Ol2E
	pyP4/c7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYC8-0000000CFZQ-1msr;
	Wed, 21 Oct 2026 15:25:36 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYC5-0000000CFWS-3dGR
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 15:25:35 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c3a4da6437bso84034666b.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596332; x=1793201132; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=JaKvrs/oADM+EV/z325Gf1Ri0kxboH53xhU/TUDfQvg4IgViQQq/2ZRvV7GTSrnuAa
         3zQNE2VE+KqXTiayuj9Fo97Hv4YEAMdp3SAvMmori0r9zoyzyTGp2kOLFrQiUhSoZfNI
         VWOsSGD3SwjwzIg+TqriJbUEXut8UsEZ+Owzwhutgt1HQjJiDbOcfyeKIU51KBcOq58/
         Ei3N21zOqhxzRFCRProbhehsi6wz2umtIFDQtTZkxQkjHfR7JlLAoat/HEiEmUEFhywL
         DlecEeq925y8DRwU9G5cRRssLYIIuFlHr4vIMflCX3lOyeevQspLM9yWxIJXUwI0SGOf
         ZAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596332; x=1793201132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=jrTqP9JsP8ZfFMMRLTkPL6OVkVpCTMpYTKvGebDnb9MXJakj9DyYjruDBn6znCb+Dj
         U1UgrjI6X7cmsOwdnMIqjy9WQju70F/PEql6lH/2FbCpwdIXFU3s4TKmpxpbOusIboZM
         yRQehHq0Bvg95A2iH4XY1XraScPROcFyewUs9vIJeoxvS6YvObJrPJ+OWZ1jhXUAlH6v
         C279dUUMVhGTn4BfZ2PGAjV2SA+7/I9K8U0tN3sS5tuHXITo9c9DEb6ew9yVZ19mTL/5
         5cQVpQjCVIwYd5vWT9C5maIijPFoR6Gd0LH19wJLRj/smoXeS8zwHF/jBeRbgJ2NRxws
         VvCg==
X-Forwarded-Encrypted: i=1; AKwUvBybko3VfVlxrQ8LYa3N/OAWeq1uIow3TRlG2ZKKmvEg20cKQz4vODfG0pVfBdmw3SLmw8GJ1Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYKhe/npjvqs2pSmzOODeF3+WH0gp4gFvsHj4PPx2zhERZfNn4OY
	NaSZ29EWT0wMFw4CIinWnty7EDQfh1eW5GZDTS49s1/uPUXhNBfi36GXy3SL5FSwuAolV+GVSrC
	gOcY6QIggKCCRTf8g6w==
X-Received: from ejbgw26.prod.google.com ([2002:a17:906:f15a:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d40a:b0:c45:d8aa:6ae5 with SMTP id a640c23a62f3a-c46799bdbb7mr204058966b.42.1792596331473;
 Wed, 21 Oct 2026 08:25:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:25 +0000
In-Reply-To: <20261021152527.375070-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-3-tarunsahu@google.com>
Subject: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_082533_952913_31102DAB 
X-CRM114-Status: GOOD (  21.36  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently luo_preserve_file() iterates over luo_file_handler_list and
picks the first registered handler whose .can_preserve() callback
returns true. When a subsystem introduces a new, backwards-incompatible
file handler alongside an existing one for the same file type, userspace
has no way to choose which handler preserves a file descriptor, nor can
the kernel keep the existing rollback-safe handler as the default while
allowing callers to opt into the new handler.

Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
liveupdate_session_preserve_fd immediately after token, keeping
IOCTL_OP min_size at offsetofend(..., token) so callers passing the
original 16-byte structure continue to work:
- When handler is empty (all-zero, or zero-filled when userspace
  passes the 16-byte structure), luo_preserve_file() selects the first
  registered handler whose .can_preserve() callback accepts the fd.
- When handler is non-empty, it must be null-terminated within
  LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
  luo_preserve_file() looks up the registered handler with that exact
  name (returning -ENOENT if unknown) and verifies that its
  .can_preserve() callback accepts the fd (returning -EINVAL if not).

The retrieve ioctl is unchanged because the handler is identified by the
name stored in the serialized payload from the source kernel.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/uapi/linux/liveupdate.h  | 12 +++++++++---
 kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
 kernel/liveupdate/luo_internal.h |  3 ++-
 kernel/liveupdate/luo_session.c  |  7 ++++++-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 509c6236720d..2413b19dabc1 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
 
 /**
  * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
- * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
- * @fd:    Input; The user-space file descriptor to be preserved.
- * @token: Input; An opaque, unique token for preserved resource.
+ * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
+ * @fd:      Input; The user-space file descriptor to be preserved.
+ * @token:   Input; An opaque, unique token for preserved resource.
+ * @handler: Input; Optional null-terminated file handler name (max length
+ *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) selecting
+ *           which registered handler preserves @fd. If empty (all-zero, or
+ *           omitted when passing the 16-byte structure), the kernel selects
+ *           the first registered handler whose .can_preserve() accepts @fd.
  *
  * Holds parameters for preserving a file descriptor.
  *
@@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
 	__u32		size;
 	__s32		fd;
 	__aligned_u64	token;
+	char		handler[LIVEUPDATE_HNDL_NAME_LENGTH];
 };
 
 #define LIVEUPDATE_SESSION_PRESERVE_FD					\
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index fb81239bedf3..be20e0f1e0aa 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  * @file_set: The file_set to which the preserved file will be added.
  * @token:    A unique, user-provided identifier for the file.
  * @fd:       The file descriptor to be preserved.
+ * @handler:  Optional NUL-terminated handler name. If NULL or empty, the first
+ *            registered handler whose .can_preserve() accepts @fd is selected.
  *
  * This function orchestrates the first phase of preserving a file. Upon entry,
  * it takes a reference to the 'struct file' via fget(), effectively making LUO
@@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  *         -EBUSY if the file descriptor is already preserved by another session.
  *         -EBADF if the file descriptor is invalid.
  *         -ENOSPC if the file_set is full.
- *         -ENOENT if no compatible handler is found for the file type.
+ *         -ENOENT if no matching handler is registered or accepts @fd.
+ *         -EINVAL if the named handler cannot preserve @fd.
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
@@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	err = -ENOENT;
 	down_read(&luo_register_rwlock);
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (handler && handler[0]) {
+			if (strcmp(fh->name, handler))
+				continue;
+			if (!fh->ops->can_preserve(fh, file)) {
+				err = -EINVAL;
+				break;
+			}
+			if (try_module_get(fh->ops->owner))
+				err = 0;
+			break;
+		}
+
 		if (fh->ops->can_preserve(fh, file)) {
 			if (try_module_get(fh->ops->owner))
 				err = 0;
@@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	}
 	up_read(&luo_register_rwlock);
 
-	/* err is still -ENOENT if no handler was found */
 	if (err)
 		goto err_fput;
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..911ffedec9f3 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
 
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..194ef45907c1 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
 	int err;
 
+	if (strnlen(argp->handler, sizeof(argp->handler)) ==
+	    sizeof(argp->handler))
+		return -EINVAL;
+
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd,
+				argp->handler);
 	if (err)
 		return err;
 
-- 
2.56.0.212.g129ede20d9-goog


