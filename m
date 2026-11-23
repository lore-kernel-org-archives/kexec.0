Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185C606A691
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VAasLkXl;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eCECb9np
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jD/Uo5Sm8+i/ieJeV7+ABTYqLpoO7saGHVcOyMdie6k=; b=VAasLkXljH5Y3xBLIh4xnN5p9I
	srIZFzE8tQmegmkVNJGySm3wMtrL2FbYB57+1tV8ufTmwr1K4OsGWibtiU9/cohU7vEFUqmDF765W
	grJGipzzGmeSPV51cc4fEOK451y9s6UrrA/9Mo76dt0uJiCr9aZPFLI0WfGqywJ8Rl+Y8NqBOv7pd
	gczSluqvfadxuWkeXIswcGzodvRWnxpf3zOrd/WkGaHPF+3/J67QEMgFeAAGlCfD3xzXkjFLqLyR6
	IX8TK8MDE1G4EO4NDE7LU0StvbvuMx5p//NWvAepY24aoyShg0m0cdYLb8snTV8B++xY4pi3bMjcH
	0ZOIayzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddK-00000005BPU-2a6x;
	Mon, 23 Nov 2026 23:39:38 +0000
Received: from mail-ot1-x345.google.com ([2607:f8b0:4864:20::345])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddF-00000005BM2-1UbS
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:34 +0000
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-83edc5c5ae9so4058288a34.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477172; x=1796081972; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jD/Uo5Sm8+i/ieJeV7+ABTYqLpoO7saGHVcOyMdie6k=;
        b=eCECb9npaI95eS82HhgeJ+3F9a/tE78HqhY1NnrDobGn+xg3F8HQ2O14gsWXmrQlKa
         rdqP6i+J4OiNvZNFDGepzBpsMf0gr32q6hlXUIUr4sexRSQvyoNFighRoUuwN5rIRgrt
         BYXzhd9ZwMgxqrGQlHFCeo4OvGEnHR4maKbaW/edKkEu1sjNbEl4agyYTEZ+UDGS+WWx
         xOiL0gB+9UaLdM/7U10nM809sCgfmtwLVYqUuJz0cPTvGp/8eEZQ4d0GO31P7BeBWUZM
         Fp3/+BV1ITnr5j6tQdQcYIGnEBAHy5hjSUokN5SFz5LWe/30Iwjn9eF+xj5bHFXutTuA
         Eqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477172; x=1796081972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jD/Uo5Sm8+i/ieJeV7+ABTYqLpoO7saGHVcOyMdie6k=;
        b=0vdQcDpLa+38YsJ7ir43/AQcovdd71B5TSPwI/JDe60dRTKigcRAaBrv53IuSc7vYG
         ZqJx2eE16tpYVBl3rsn3E1FzZUP/4fBMdBfRk46B5ZOBnHg3BCLBAJbfYzS5hK0ELj6D
         cf+LbwZgHM7wL1f3VIi3ylDD715X16KP4jbBzqETEL8J96pbQObUq080umBrnnBX7IQh
         UXjNJPDgFyucsNSD8JnfjTsUWrt74aWd8wuN/7OQHmRi0AdlpfQiQHU3LudPFk+7erw0
         lO0GQX2jowZoioSW8eYR3ZH/26QmQXQjakh2jeeeEFxWHALWAJvQEGLWC17SRiX3t3JW
         Ys2w==
X-Gm-Message-State: APuU4Z8Mr4TcpsrmyKvZMmIgnf7BT+KUJN30McHoagCB12g1tTCG6HFI
	K38Jm+QCrYyS7B8x7hmA/Vrq+TOY4il3V2ZqHU4t7rAAB7jEQCSzsVsN0BcDT9ofb72nMPNleYA
	myMJ14BtiWM7pXNUu1iiNyvPdxRpZPD3g5OpRg2HYFrk+m+c/1uMucbb6JKPxfcgaUDeT9dugXA
	flvXBAkYRRDIMzTkTV4pmQXpF3kidCfeZASGPJpa8DcHIqc9Q6tok=
X-Received: from ilnv16.prod.google.com ([2002:a92:c810:0:b0:549:aa38:c185])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a0c:b0:573:1dfa:f0cc with SMTP id 5614622812f47-57a0b245af5mr15842784b6e.41.1795477171636;
 Mon, 23 Nov 2026 15:39:31 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:07 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-3-dmatlack@google.com>
Subject: [PATCH v5 02/18] liveupdate: Pass user argument to file preserve and retrieve
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_153933_453673_9365A37E 
X-CRM114-Status: GOOD (  30.94  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Allow userspace to pass a file-handler-specific argument structure when
preserving or retrieving an FD via LUO. File handlers may need
additional context during preservation or retrieval, such as the file to
restore into on retrieve, or other handler-specific parameters, without
introducing separate ioctls for each file type. Whether the argument is
required, optional, or unused is defined by the file handler.

Extend struct liveupdate_session_preserve_fd and
struct liveupdate_session_retrieve_fd with a 64-bit arg field pointing
to a handler-defined argument structure that begins with a 32-bit size
field. Because IOCTL_OP validates a minimum size up to the token field,
existing callers passing the 16-byte struct remain compatible and have
arg zero-filled by copy_struct_from_user().

Add parg and rarg (struct liveupdate_arg_spec) to
struct liveupdate_file_ops, initialized via LIVEUPDATE_ARG(_struct,
_min_last), which records the full struct size and minimum required size
while enforcing at compile time that handler argument structures begin
with a 32-bit size field. When arg is non-zero, LUO validates the
minimum size and copies the user argument via copy_struct_from_user() up
to the handler's expected size and passes the kernel copy in
struct liveupdate_file_op_args, or returns -EOPNOTSUPP if the handler
does not accept an argument.

The argument only applies to the retrieve that restores the file.
Retrieving a token that was already retrieved returns the existing file,
so fail with -EBUSY if a non-zero argument is passed then, instead of
silently ignoring it.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/liveupdate.h       | 44 +++++++++++++++++++
 include/uapi/linux/liveupdate.h  | 14 +++++++
 kernel/liveupdate/luo_file.c     | 72 ++++++++++++++++++++++++++++++--
 kernel/liveupdate/luo_internal.h |  5 ++-
 kernel/liveupdate/luo_session.c  |  6 ++-
 5 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..7543f5d648d3 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -22,6 +22,36 @@ struct liveupdate_flb;
 struct liveupdate_session;
 struct file;
 
+/**
+ * struct liveupdate_arg_spec - Specification of a file handler user argument.
+ * @size:     Full size of the argument structure in the current kernel.
+ * @min_size: Minimum valid user-supplied size (offsetofend of the last
+ *            required field).
+ */
+struct liveupdate_arg_spec {
+	size_t size;
+	size_t min_size;
+};
+
+/**
+ * LIVEUPDATE_ARG - Validated specification of a file handler argument struct.
+ * @_struct:   The argument structure type.
+ * @_min_last: The last required member in @_struct.
+ *
+ * All file handler argument structures passed via
+ * &liveupdate_session_preserve_fd.arg or &liveupdate_session_retrieve_fd.arg
+ * must begin with a 32-bit @size field so they can be extended compatibly.
+ * Use this macro to initialize &liveupdate_file_ops.parg and
+ * &liveupdate_file_ops.rarg.
+ */
+#define LIVEUPDATE_ARG(_struct, _min_last)				\
+	{								\
+		.size = sizeof(_struct) +				\
+			BUILD_BUG_ON_ZERO(offsetof(_struct, size) != 0) + \
+			BUILD_BUG_ON_ZERO(sizeof_field(_struct, size) != sizeof(u32)), \
+		.min_size = offsetofend(_struct, _min_last),		\
+	}
+
 /**
  * struct liveupdate_file_op_args - Arguments for file operation callbacks.
  * @handler:          The file handler being called.
@@ -40,6 +70,11 @@ struct file;
  *                    is not preserved. Set by the handler's .preserve()
  *                    callback, and must be freed in the handler's
  *                    .unpreserve() callback.
+ * @arg:              Kernel copy of the user-provided argument for .preserve()
+ *                    and .retrieve(), or %NULL if none was provided. Allocated
+ *                    to the handler's expected argument size with any trailing
+ *                    bytes beyond the user-supplied size zero-filled. Valid
+ *                    only for the duration of the callback.
  *
  * This structure bundles all parameters for the file operation callbacks.
  * The 'data' and 'file' fields are used for both input and output.
@@ -51,6 +86,7 @@ struct liveupdate_file_op_args {
 	struct file *file;
 	u64 serialized_data;
 	void *private_data;
+	const void *arg;
 };
 
 /**
@@ -68,6 +104,12 @@ struct liveupdate_file_op_args {
  *                resources in the session.
  * @finish:       Required. Final cleanup in the new kernel.
  * @get_id:       Optional. Returns a unique identifier for the file.
+ * @parg:         Optional. Specification of the user argument structure
+ *                accepted by @preserve, initialized via LIVEUPDATE_ARG(). If
+ *                unset, non-zero user arguments are rejected with -EOPNOTSUPP.
+ * @rarg:         Optional. Specification of the user argument structure
+ *                accepted by @retrieve, initialized via LIVEUPDATE_ARG(). If
+ *                unset, non-zero user arguments are rejected with -EOPNOTSUPP.
  * @owner:        Module reference
  *
  * All operations (except can_preserve) receive a pointer to a
@@ -84,6 +126,8 @@ struct liveupdate_file_ops {
 	bool (*can_finish)(struct liveupdate_file_op_args *args);
 	void (*finish)(struct liveupdate_file_op_args *args);
 	unsigned long (*get_id)(struct file *file);
+	struct liveupdate_arg_spec parg;
+	struct liveupdate_arg_spec rarg;
 	struct module *owner;
 };
 
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 4043d4038712..a460f4cdb608 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -126,6 +126,10 @@ struct liveupdate_ioctl_retrieve_session {
  * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
  * @fd:    Input; The user-space file descriptor to be preserved.
  * @token: Input; An opaque, unique token for preserved resource.
+ * @arg:   Input; User-space pointer to a file-handler-specific argument
+ *         structure starting with a 32-bit size field, or 0 if unused.
+ *         If the size is larger than the kernel supports and the extra
+ *         bytes are not zero, the ioctl fails with -E2BIG.
  *
  * Holds parameters for preserving a file descriptor.
  *
@@ -149,6 +153,7 @@ struct liveupdate_session_preserve_fd {
 	__u32		size;
 	__s32		fd;
 	__aligned_u64	token;
+	__aligned_u64	arg;
 };
 
 #define LIVEUPDATE_SESSION_PRESERVE_FD					\
@@ -160,6 +165,10 @@ struct liveupdate_session_preserve_fd {
  * @fd:    Output; The new file descriptor representing the fully restored
  *         kernel resource.
  * @token: Input; An opaque, token that was used to preserve the resource.
+ * @arg:   Input; User-space pointer to a file-handler-specific argument
+ *         structure starting with a 32-bit size field, or 0 if unused.
+ *         If the size is larger than the kernel supports and the extra
+ *         bytes are not zero, the ioctl fails with -E2BIG.
  *
  * Retrieve a previously preserved file descriptor.
  *
@@ -173,12 +182,17 @@ struct liveupdate_session_preserve_fd {
  * attempts to retrieve the token fail with the same error code. Failed
  * retrieves are not retried.
  *
+ * Retrieving a token that was already retrieved successfully returns a new file
+ * descriptor for the same file. Passing a non-zero @arg in that case fails
+ * with -EBUSY, since @arg only applies to the retrieve that restores the file.
+ *
  * Return: 0 on success, negative error code on failure (e.g., invalid token).
  */
 struct liveupdate_session_retrieve_fd {
 	__u32		size;
 	__s32		fd;
 	__aligned_u64	token;
+	__aligned_u64	arg;
 };
 
 #define LIVEUPDATE_SESSION_RETRIEVE_FD					\
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a42b60356d52..3987ab86a3c1 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -126,6 +126,7 @@
 #include <linux/xarray.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 #include "luo_internal.h"
 
 static LIST_HEAD(luo_file_handler_list);
@@ -202,11 +203,48 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
 	return false;
 }
 
+static int luo_copy_user_arg(const void __user *uptr, const void **argp,
+			     const struct liveupdate_arg_spec *spec)
+{
+	u32 user_size;
+	int err;
+
+	if (!uptr)
+		return 0;
+	if (!spec->size)
+		return -EOPNOTSUPP;
+
+	if (get_user(user_size, (const u32 __user *)uptr))
+		return -EFAULT;
+	if (user_size < spec->min_size)
+		return -EINVAL;
+	if (user_size > PAGE_SIZE)
+		return -E2BIG;
+
+	void *karg __free(kfree) = kmalloc(spec->size, GFP_KERNEL);
+	if (!karg)
+		return -ENOMEM;
+
+	err = copy_struct_from_user(karg, spec->size, uptr, user_size);
+	if (err)
+		return err;
+
+	/*
+	 * The size was fetched again with the rest of the argument, and may have
+	 * changed since it was checked. Give the handler the checked size.
+	 */
+	*(u32 *)karg = user_size;
+
+	*argp = no_free_ptr(karg);
+	return 0;
+}
+
 /**
  * luo_preserve_file - Initiate the preservation of a file descriptor.
  * @file_set: The file_set to which the preserved file will be added.
  * @token:    A unique, user-provided identifier for the file.
  * @fd:       The file descriptor to be preserved.
+ * @arg:      User-space pointer to the handler argument structure, or NULL.
  *
  * This function orchestrates the first phase of preserving a file. Upon entry,
  * it takes a reference to the 'struct file' via fget(), effectively making LUO
@@ -227,10 +265,13 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  *         -EBADF if the file descriptor is invalid.
  *         -ENOSPC if the file_set is full.
  *         -ENOENT if no compatible handler is found.
+ *         -EOPNOTSUPP if @arg is non-NULL and the handler takes no arg.
+ *         -EINVAL, -E2BIG or -EFAULT if @arg can't be copied.
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const void __user *arg)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
@@ -266,10 +307,14 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto err_fput;
 
+	err = luo_copy_user_arg(arg, &args.arg, &fh->ops->parg);
+	if (err)
+		goto err_module_put;
+
 	err = xa_insert(&luo_preserved_files, luo_get_id(fh, file),
 			file, GFP_KERNEL);
 	if (err)
-		goto err_module_put;
+		goto err_free_arg;
 
 	err = luo_flb_file_preserve(fh);
 	if (err)
@@ -293,6 +338,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto err_kfree;
 
+	kfree(args.arg);
 	luo_file->serialized_data = args.serialized_data;
 	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
@@ -306,6 +352,8 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	luo_flb_file_unpreserve(fh);
 err_erase_xa:
 	xa_erase(&luo_preserved_files, luo_get_id(fh, file));
+err_free_arg:
+	kfree(args.arg);
 err_module_put:
 	module_put(fh->ops->owner);
 err_fput:
@@ -535,6 +583,7 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
  * luo_retrieve_file - Restores a preserved file from a file_set by its token.
  * @file_set: The file_set from which to retrieve the file.
  * @token:    The unique token identifying the file to be restored.
+ * @arg:      User-space pointer to the handler argument structure, or NULL.
  * @filep:    Output parameter; on success, this is populated with a pointer
  *            to the newly retrieved 'struct file'.
  *
@@ -554,10 +603,13 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
  *          kernel.
  * Return: 0 on success. Returns a negative errno on failure:
  *         -ENOENT if no file with the matching token is found.
+ *         -EOPNOTSUPP if @arg is non-NULL and the handler takes no arg.
+ *         -EINVAL, -E2BIG or -EFAULT if @arg can't be copied.
+ *         -EBUSY if @arg is non-NULL and the file was already retrieved.
  *         Any error code returned by the handler's .retrieve() op.
  */
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
-		      struct file **filep)
+		      const void __user *arg, struct file **filep)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct luo_file *luo_file;
@@ -584,6 +636,13 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	if (luo_file->retrieve_status > 0) {
+		/*
+		 * The argument only applies to the retrieve that restores the
+		 * file. Don't silently ignore it.
+		 */
+		if (arg)
+			return -EBUSY;
+
 		/*
 		 * Someone is asking for this file again, so get a reference
 		 * for them.
@@ -593,10 +652,15 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		return 0;
 	}
 
+	err = luo_copy_user_arg(arg, &args.arg, &luo_file->fh->ops->rarg);
+	if (err)
+		return err;
+
 	args.handler = luo_file->fh;
 	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
+	kfree(args.arg);
 	if (err) {
 		/* Keep the error code for later use. */
 		luo_file->retrieve_status = err;
@@ -995,6 +1059,6 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 				 struct file **filep)
 {
 	return luo_retrieve_file(luo_file_set_from_session_locked(s),
-				 token, filep);
+				 token, NULL, filep);
 }
 EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..e0be84acb33b 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -101,14 +101,15 @@ int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
 
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const void __user *arg);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser);
 void luo_file_unfreeze(struct luo_file_set *file_set,
 		       struct luo_file_set_ser *file_set_ser);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
-		      struct file **filep);
+		      const void __user *arg, struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
 int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 74bc66929f4b..0d7533f0bde6 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -268,7 +268,8 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	int err;
 
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd,
+				u64_to_user_ptr(argp->arg));
 	if (err)
 		return err;
 
@@ -291,7 +292,8 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 		return argp->fd;
 
 	mutex_lock(&session->mutex);
-	err = luo_retrieve_file(&session->file_set, argp->token, &file);
+	err = luo_retrieve_file(&session->file_set, argp->token,
+				u64_to_user_ptr(argp->arg), &file);
 	mutex_unlock(&session->mutex);
 	if (err < 0)
 		goto err_put_fd;
-- 
2.56.1.809.ga0b61035b5-goog


