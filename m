Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DD606A32D
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KA1VGdJw;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jS+wla7a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpLETcnXXO36AVr/tmwkcOayG5UMVZkcW1XDfCXB7rY=; b=KA1VGdJwNtZLttawszmednH9X7
	74kM3UgjMa0eABfYGiO6/IL39J2ftJSafjUgn18oQkJYiulby0dxJt3eoEIR2RabH85CNxspxcP7e
	epSmmtr6OAtXuQ87MTe1GcHpDnWA39BfgoWmpvqXrHxOGFf6BzRIzn7uatU8TWy8ECNwEsTxA5aj5
	KHrzLbXEwNObyHSnziSLZpOV1EvJcPK3HyYcEFfGxZAJX3cWDu5SR2kfesgW/9r+EE+dudDwtXn5s
	OZl/KJJvBNdQNKCvjVbPgaMQy0Lk06daMB9fHma8Vjch5fS/XhwI8wSB3/XKbUWpLRFacc5Ya8JAD
	3N7G3orA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi50-0000000DAMx-2kCX;
	Thu, 22 Oct 2026 01:58:54 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi4v-0000000DALf-1DyJ
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:58:50 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-93cb9e9405fso69788985a.2
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792634328; x=1793239128; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpLETcnXXO36AVr/tmwkcOayG5UMVZkcW1XDfCXB7rY=;
        b=jS+wla7a3A1xI7wgUlWAYrZfKwF0fdN+uvv+WyTbqDblRcfJsAWczrY8ZT8S4o3m8+
         938SgOUJZvuC1fp6NAWLMwxMCh4zmpx9ZE/Dh3Aw2Qe+SQuqSJ4/1QNwdrN5bUtDzDaz
         owGZu+HvAT4/kROmOD0vf9f61g6KSVX+q46Wc+badhLUgI23GNINwDrOXKSn/U9lDr9F
         rILQpELnkOfwYjIq9qzFFiuWrzkFmiM7zTte1O4fj8+2uBGJXKu76x+ZkLXS7Xa4UGGp
         loTT6OhvVd0dUAi3FU8p0jbWfuLIXLz8vT7KH0Sy48QHxAxKSOoBK4ss6iRj3EPrKZcJ
         7Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634328; x=1793239128;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpLETcnXXO36AVr/tmwkcOayG5UMVZkcW1XDfCXB7rY=;
        b=wKT0aO3CnpW7KLFUZ6+JpJ0Hsuj5da5MiyHlbbV/nrK/EzznE01DTJJWlAgDxoIetk
         vgzXa4e5vy+WQs5xJsEKFLovtxvRfefG+ypTrX8FSwUBGEvlI/xu0jMo6vRkRLtScV3l
         WGfjFJBwvT1+NLlerjjH14qyJFNrm0crvWi4s8GDpYD9flyAkksjm2KVD9VVws7k7tho
         6Sr4XOt625TG2VkKkhXOFa1EJF6TQOJU3GeYYEZJhVIBv7RbYNJMRIIzWNbEKAoAZomS
         HPS9HBIEd6yMeJRGXLpDcPirvVr989ftBU36mcbK2K77Dx6+0TOWIAfHrRC5ECrlCWyz
         eVTA==
X-Forwarded-Encrypted: i=1; AKwUvBzSiLNcCzHhPtWgepzfT6jTF25TjF2/NfinwYSGtPE8cyVmCu8Akn3TfBmbaseGj1tjMEZ2Ew==@lists.infradead.org
X-Gm-Message-State: AFq9FYKzgmrscb6t21EOYdLZhYXzwRk7+r+NVtT4N7S0sth4KM/fN/XH
	S1smGgpTROPkwwdr7zQr7RiUlTZSSZr1XOkxWVIUKuz2B/GiiwKEpereWlhnbgVST88=
X-Gm-Gg: AYBFou0sJSuBUCuCs5amoi7eZduxZCPgQf/afh+F28B1IpW3yeeo6Cwl+i1yes6o0q6
	rXG3ZoJ31odIVvi4PiwuSM/3Ty5zXCvGnIholV4D3hIFXJVaIT7gdNBQDJppi14qZgzh99+NqEN
	u+zsOrU9F734DdTUbf2IZ2rW4gcPoK/9DMB+o6ne0kDPIQQRmTSF3GnoJBGZYWUm0y1VRvB7rFZ
	z3NCSODeVX7cz9QzNr4mRjJdqA3bE1kygIaw32/vaOjhaQbutGjuMxFYsWBfBuC56UyfHNbrYB0
	V819JsPMyb5m4+ySrJiKcY1xStnBtTZKUUqPeVKqOJPl2WrOMWL0K/5Qnkz2R6+NZUUlq7RvDOU
	nmAzzHLnSE3dOvQgs/4jxKOlPyeX0DsCH15Ve2xeYjBTHE/cSNB9O2EUcjPtnagzS/JuoBYjjmb
	l5U99Ed2rmOoZ2ZxdhZEUt+SZgokBFjRnI+DAT0id0C+kw1m/eLhbEMT3R1H/QRBFVKnlmVQQi5
	+bObaK60zrZ64fUPMBaIiT+PzXNbE4ACklYaq56RJpdSkJ6ISEhBnG/FcHsoXgRSdYmUU2dAOzz
	pUf86Fqg84BvXBNDknMUHqrz6Q+jXAUkBBwEEjWa4sv0Smb3z9u3zTdbX/P7WRKBKdw7yaUq+4T
	R
X-Received: by 2002:a05:620a:2a0a:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-93f57f7b630mr755824085a.31.1792634327936;
        Wed, 21 Oct 2026 18:58:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e247ffsm397383285a.39.2026.10.21.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:47 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v3 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions early
Date: Wed, 21 Oct 2026 21:58:39 -0400
Message-ID: <20261022015844.2795816-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
References: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_185849_651336_C7DD121C 
X-CRM114-Status: GOOD (  27.66  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, LUO sessions are frozen automatically only inside the
reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
iterates through all outgoing sessions under global write locks and
freezes them serially during shutdown. Allowing userspace to decide when
to freeze a session once it is done with it (and to freeze multiple
sessions in parallel, since luo_session_freeze() only acquires the
per-session mutex) avoids postponing this work to kexec shutdown and
reduces blackout time.

Introduce LIVEUPDATE_SESSION_FREEZE on session file descriptors to freeze
a session early. The ioctl runs .freeze() across all preserved files in the
session and serializes their metadata. Once frozen, no additional files can
be added to the session, and subsequent freeze calls return -EBUSY. Freeze
is only valid on outgoing sessions and returns -EINVAL on incoming ones.

During kexec, sessions that were already frozen early are skipped, while
sessions that did not invoke this ioctl auto-freeze as before. If an
early-frozen session is released before kexec, its files are rolled back
via .unfreeze() before being unpreserved.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h       |  3 +-
 include/uapi/linux/liveupdate.h  | 25 +++++++++
 kernel/liveupdate/luo_file.c     | 73 ++++++++++++---------------
 kernel/liveupdate/luo_internal.h |  9 ++--
 kernel/liveupdate/luo_session.c  | 87 ++++++++++++++++++++++++++------
 mm/memfd_luo.c                   |  5 +-
 6 files changed, 139 insertions(+), 63 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..851692571e13 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -59,7 +59,8 @@ struct liveupdate_file_op_args {
  *                compatible with the given file.
  * @preserve:     Required. Performs state-saving for the file.
  * @unpreserve:   Required. Cleans up any resources allocated by @preserve.
- * @freeze:       Optional. Final actions just before kernel transition.
+ * @freeze:       Optional. Prepares final state before kexec (via
+ *                LIVEUPDATE_SESSION_FREEZE or during reboot).
  * @unfreeze:     Optional. Undo freeze operations.
  * @retrieve:     Required. Restores the file in the new kernel.
  * @can_finish:   Optional. Check if this FD can finish, i.e. all restoration
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 4043d4038712..1644c502521e 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -60,6 +60,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
 	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
+	LIVEUPDATE_CMD_SESSION_FREEZE = 0x44,
 };
 
 /**
@@ -236,4 +237,28 @@ struct liveupdate_session_get_name {
 #define LIVEUPDATE_SESSION_GET_NAME					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
 
+/**
+ * struct liveupdate_session_freeze - ioctl(LIVEUPDATE_SESSION_FREEZE)
+ * @size:     Input; sizeof(struct liveupdate_session_freeze)
+ * @reserved: Input; Must be zero. Reserved for future use.
+ *
+ * Freezes the session early from userspace before the reboot kexec phase.
+ *
+ * When this ioctl is called, the kernel executes the .freeze() callback on all
+ * preserved files in the session and serializes their metadata. Once frozen,
+ * no further files can be preserved in the session.
+ *
+ * During the subsequent reboot kexec, this session is recognized as already
+ * frozen and is skipped from the late auto freeze.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_freeze {
+	__u32		size;
+	__u32		reserved;
+};
+
+#define LIVEUPDATE_SESSION_FREEZE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FREEZE)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..7f79890beb31 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -31,9 +31,9 @@
  *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
  *     if the preservation process is aborted before the reboot (i.e. session is
  *     closed).
- *   - freeze(): A final pre-reboot opportunity to prepare the state for kexec.
- *     We are already in reboot syscall, and therefore userspace cannot mutate
- *     the file anymore.
+ *   - freeze(): Prepares the final state for kexec. Invoked either early via
+ *     the LIVEUPDATE_SESSION_FREEZE ioctl once userspace is done modifying
+ *     the session's files, or during the reboot() syscall.
  *   - unfreeze(): Undoes the actions of .freeze(), called if the live update
  *     is aborted after the freeze phase.
  *   - retrieve(): Reconstructs the file in the new kernel from the preserved
@@ -48,7 +48,8 @@
  *    handler, calls its .preserve() operation, and creates an internal &struct
  *    luo_file to track the live state.
  *
- * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
+ * 2. Freeze (Pre-Reboot): Either explicitly via LIVEUPDATE_SESSION_FREEZE or
+ *    just before the kexec during reboot(), luo_file_freeze() is called.
  *    It iterates through all preserved files, calls their respective .freeze()
  *    operation, and serializes their final metadata (compatible string, token,
  *    and data handle) into a contiguous memory block for KHO.
@@ -74,15 +75,16 @@
  *
  * 1. Abort Before Reboot: If the userspace agent aborts the live update
  *    process before calling reboot (e.g., by closing the session file
- *    descriptor), the session's release handler calls
- *    luo_file_unpreserve_files(). This invokes the .unpreserve() callback on
- *    all preserved files, ensuring all allocated resources are cleaned up and
- *    returning the system to a clean state.
+ *    descriptor), the session's release handler unfreezes the files if the
+ *    session was already frozen and calls luo_file_unpreserve_files(). This
+ *    invokes the .unpreserve() callback on all preserved files, ensuring all
+ *    allocated resources are cleaned up and returning the system to a clean
+ *    state.
  *
- * 2. Freeze Failure: During the reboot() syscall, if any handler's .freeze()
- *    op fails, the .unfreeze() op is invoked on all previously *successful*
- *    freezes to roll back their state. The reboot() syscall then returns an
- *    error to userspace, canceling the live update.
+ * 2. Freeze Failure: During LIVEUPDATE_SESSION_FREEZE or the reboot() syscall,
+ *    if any handler's .freeze() op fails, the .unfreeze() op is invoked on all
+ *    previously *successful* freezes to roll back their state, and an error is
+ *    returned to userspace.
  *
  * 3. Finish Failure: In the new kernel, if a handler's .finish() op fails,
  *    the luo_file_finish() operation is aborted. LUO retains ownership of
@@ -440,12 +442,11 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
- * @file_set:     The file_set whose files are to be frozen.
- * @file_set_ser: Where to put the serialized file_set.
+ * @file_set: The file_set whose files are to be frozen.
  *
- * This function is called from the reboot() syscall path, just before the
- * kernel transitions to the new image via kexec. Its purpose is to perform the
- * final preparation and serialization of all preserved files in the file_set.
+ * This function is called from LIVEUPDATE_SESSION_FREEZE or from the reboot()
+ * syscall path. Its purpose is to perform the preparation and serialization of
+ * all preserved files in the file_set.
  *
  * It iterates through each preserved file in FIFO order (the order of
  * preservation) and performs two main actions:
@@ -457,22 +458,20 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  *
  * 2. Serializes Metadata: After a successful freeze, it copies the final file
  *    metadata—the handler's compatible string, the user token, and the final
- *    private data handle—into the pre-allocated contiguous memory buffer
- *    (file_set->files) that will be handed over to the next kernel via KHO.
+ *    private data handle—into the pre-allocated serialization blocks
+ *    (file_set->block_set) that will be handed over to the next kernel via KHO.
  *
  * Error Handling (Rollback):
  * This function is atomic. If any handler's .freeze() operation fails, the
- * entire live update is aborted. The __luo_file_unfreeze() helper is
- * immediately called to invoke the .unfreeze() op on all files that were
- * successfully frozen before the point of failure, rolling them back to a
- * running state. The function then returns an error, causing the reboot()
- * syscall to fail.
+ * __luo_file_unfreeze() helper is immediately called to invoke the .unfreeze()
+ * op on all files that were successfully frozen before the point of failure,
+ * rolling them back to an unfrozen state, and an error is returned to the
+ * caller.
  *
- * Context: Called only from the liveupdate_reboot() path.
+ * Context: Called from LIVEUPDATE_SESSION_FREEZE or the liveupdate_reboot() path.
  * Return: 0 on success, or a negative errno on failure.
  */
-int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser)
+int luo_file_freeze(struct luo_file_set *file_set)
 {
 	struct luo_file *luo_file;
 	struct kho_block_set_it it;
@@ -506,9 +505,6 @@ int luo_file_freeze(struct luo_file_set *file_set,
 		file_ser->token = luo_file->token;
 	}
 
-	file_set_ser->count = file_set->count;
-	file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
-
 	return 0;
 
 err_unfreeze:
@@ -519,28 +515,25 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
- * @file_set:     The file_set whose files are to be unfrozen.
- * @file_set_ser: Serialized file_set.
+ * @file_set: The file_set whose files are to be unfrozen.
  *
  * This function rolls back the state of all files in a file_set after the
- * freeze phase has begun but must be aborted. It is the counterpart to
- * luo_file_freeze().
+ * freeze phase has begun. It is the counterpart to luo_file_freeze().
  *
  * It invokes the __luo_file_unfreeze() helper with a NULL argument, which
- * signals the helper to iterate through all files in the file_set and call
- * their respective .unfreeze() handler callbacks.
+ * signals the helper to iterate through all files in the file_set, call their
+ * respective .unfreeze() handler callbacks, and clear the serialized blocks.
  *
  * Context: This is called when the live update is aborted during
- *          the reboot() syscall, after luo_file_freeze() has been called.
+ *          the reboot() syscall, after luo_file_freeze() has been called,
+ *          or when an early-frozen session is released before kexec.
  */
-void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser)
+void luo_file_unfreeze(struct luo_file_set *file_set)
 {
 	if (!file_set->count)
 		return;
 
 	__luo_file_unfreeze(file_set, NULL);
-	memset(file_set_ser, 0, sizeof(*file_set_ser));
 }
 
 /**
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..c78b8e37d513 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -64,6 +64,8 @@ struct luo_file_set {
  *              previous kernel) sessions.
  * @retrieved:  A boolean flag indicating whether this session has been
  *              retrieved by a consumer in the new kernel.
+ * @user_frozen: A boolean flag indicating whether this session has been
+ *               frozen early from userspace.
  * @file_set:   A set of files that belong to this session.
  * @mutex:      protects fields in the luo_session.
  */
@@ -71,6 +73,7 @@ struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct list_head list;
 	bool retrieved;
+	bool user_frozen;
 	struct luo_file_set file_set;
 	struct mutex mutex;
 };
@@ -103,10 +106,8 @@ int luo_session_deserialize(void);
 
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
-int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser);
-void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser);
+int luo_file_freeze(struct luo_file_set *file_set);
+void luo_file_unfreeze(struct luo_file_set *file_set);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..59f4bd9af831 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -34,10 +34,11 @@
  * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
  *     new, empty session and receives a file descriptor for it.
  *
- * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
- *     made, `luo_session_serialize()` is called. It iterates through all
- *     active sessions and writes their metadata into a memory area preserved
- *     by KHO.
+ * 2.  Freeze / Serialization: Sessions may be frozen early from userspace
+ *     via `LIVEUPDATE_SESSION_FREEZE`. When the `reboot(LINUX_REBOOT_CMD_KEXEC)`
+ *     syscall is made, `luo_session_serialize()` is called to freeze any
+ *     remaining active sessions and write all session metadata into a memory
+ *     area preserved by KHO.
  *
  * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
  *     runs, reading the serialized data and creating a list of `struct
@@ -218,18 +219,38 @@ static int luo_session_finish_one(struct luo_session *session)
 	return luo_file_finish(&session->file_set);
 }
 
-static void luo_session_unfreeze_one(struct luo_session *session,
-				     struct luo_session_ser *ser)
+static void luo_session_unserialize_one(struct luo_session *session,
+					struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+	/*
+	 * Only unfreeze sessions that were auto-frozen by
+	 * luo_session_serialize_one(); sessions frozen explicitly by
+	 * userspace stay frozen until the session FD is closed.
+	 */
+	if (!session->user_frozen)
+		luo_file_unfreeze(&session->file_set);
+	memset(ser, 0, sizeof(*ser));
 }
 
-static int luo_session_freeze_one(struct luo_session *session,
-				  struct luo_session_ser *ser)
+static int luo_session_serialize_one(struct luo_session *session,
+				     struct luo_session_ser *ser)
 {
+	int err;
+
 	guard(mutex)(&session->mutex);
-	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+	if (!session->user_frozen) {
+		err = luo_file_freeze(&session->file_set);
+		if (err)
+			return err;
+	}
+
+	strscpy(ser->name, session->name, sizeof(ser->name));
+	ser->file_set_ser.count = session->file_set.count;
+	ser->file_set_ser.files =
+		kho_block_set_head_pa(&session->file_set.block_set);
+
+	return 0;
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -249,8 +270,11 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		}
 		sh = &luo_session_global.incoming;
 	} else {
-		scoped_guard(mutex, &session->mutex)
+		scoped_guard(mutex, &session->mutex) {
+			if (session->user_frozen)
+				luo_file_unfreeze(&session->file_set);
 			luo_file_unpreserve_files(&session->file_set);
+		}
 		sh = &luo_session_global.outgoing;
 	}
 
@@ -267,6 +291,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	int err;
 
 	guard(mutex)(&session->mutex);
+	if (session->user_frozen)
+		return -EBUSY;
+
 	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
@@ -340,11 +367,40 @@ static int luo_session_get_name(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_freeze(struct luo_session *session,
+			      struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_freeze *argp = ucmd->cmd;
+	int err;
+
+	if (argp->reserved)
+		return -EINVAL;
+
+	guard(mutex)(&session->mutex);
+	if (session->user_frozen)
+		return -EBUSY;
+
+	err = luo_file_freeze(&session->file_set);
+	if (err)
+		return err;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err) {
+		luo_file_unfreeze(&session->file_set);
+		return err;
+	}
+
+	session->user_frozen = true;
+
+	return 0;
+}
+
 union ucmd_buffer {
 	struct liveupdate_session_finish finish;
 	struct liveupdate_session_preserve_fd preserve;
 	struct liveupdate_session_retrieve_fd retrieve;
 	struct liveupdate_session_get_name get_name;
+	struct liveupdate_session_freeze freeze;
 };
 
 /* Type of sessions the ioctl applies to. */
@@ -382,6 +438,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
 		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
+	IOCTL_OP(LIVEUPDATE_SESSION_FREEZE, luo_session_freeze,
+		 struct liveupdate_session_freeze, reserved, LUO_IOCTL_OUTGOING),
 };
 
 static bool luo_ioctl_type_valid(struct luo_session *session,
@@ -656,13 +714,11 @@ int luo_session_serialize(void)
 			goto err_undo;
 		}
 
-		err = luo_session_freeze_one(session, ser);
+		err = luo_session_serialize_one(session, ser);
 		if (err) {
 			kho_block_set_it_prev(&it);
 			goto err_undo;
 		}
-
-		strscpy(ser->name, session->name, sizeof(ser->name));
 	}
 
 	if (sh->count > 0)
@@ -675,8 +731,7 @@ int luo_session_serialize(void)
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
 
-		luo_session_unfreeze_one(session, ser);
-		memset(ser->name, 0, sizeof(ser->name));
+		luo_session_unserialize_one(session, ser);
 	}
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..a3bf872b3a03 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -43,8 +43,9 @@
  *   allocating pages for them during preservation.
  *
  * File Position
- *   The current file position is preserved, allowing applications to continue
- *   reading/writing from their last position.
+ *   The file position at the time the session is frozen is preserved,
+ *   allowing applications to continue reading/writing from their last
+ *   position.
  *
  * File Status Flags
  *   memfds are always opened with ``O_RDWR`` and ``O_LARGEFILE``. This property
-- 
2.56.0.218.g1ec904b173-goog


