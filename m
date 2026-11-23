Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22194606A321
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yFCUKn3t;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehMQY0Lk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PdON3gXs/6uQsPuxGzIPmKwz1/GfU1B3j8DG4CMn1QI=; b=yFCUKn3tzhlMt13HkWEmQCVwkM
	1TdrqVFjzFK7lXaT2vgxzFlvg0xP2KDrW32oZ1cr+TxqwalDdTsrEcUAKwLzBNg9nfYCXDRtCqmhd
	LakwDZLO7dFgEdVUDkRPN73Jx/9tG2GwUFK+CujyghehlUwQZ4I/X9XQfOumyvJUyTdNctlnlZ+4M
	h0e/BiP3NtOSKcZoF3wNrkJgTS5ScrHtYQp9flDDuN6d37uToLyiX3i+B/IHmgmj89RrfQ2MkE3Ef
	VdIYh23dBn/2u7okKRonE0Fc5T8tyAQQIbKctV7a7cRyCqVMRdDNfqOjnP706NXvv7sC2m6WUcISY
	AAALphfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVdlM-00000005D9D-3Z1x;
	Mon, 23 Nov 2026 23:47:56 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVdlJ-00000005D8Q-1KPN
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:47:54 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2f03aa5ff3bso52186705ad.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477671; x=1796082471; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdON3gXs/6uQsPuxGzIPmKwz1/GfU1B3j8DG4CMn1QI=;
        b=ehMQY0Lk25gbUJOdEJVPO6Yp3SIcO4Y103UZVGW9x/TIY5f6pFmXM5f66rQ7SwgMue
         q5n+L0Twadkc7gWV4gIbrKuHlHlc2gL1DuybJSuowJf6pSHviriQqq0xMJJlZmERLY7f
         5iCwy5MZ6ILn0nUGC43UhSoIgjtMjkDYFJWkz3oNrTbCbQFiNWUh5Y3CkkZAykXfrROp
         w+SV15fiPdEFxDR4P0NFTt8lD0/kdzZylC42iFge8haArsakY9dFmMrZ0Cf3iUvF2cp1
         rm8rZoaHTPsgJ/l0yTOLozEsaqAxw8mRyQJSo+PiEdBfwf80TwfDyPxu02Xr2p5zfhx/
         cKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477671; x=1796082471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdON3gXs/6uQsPuxGzIPmKwz1/GfU1B3j8DG4CMn1QI=;
        b=efiH+p02vs2CoJ1uhYu5FFdZ6dfuiRI7Umx72STMppYiE3e4YNpnCdtv9bQHKG2xiO
         cWpMo8V+pTSNzE5LqAjYPiPD9wx2P1b89uOcL3DMeLBvJkswAb5iIsdLhsRX0F/zxOMY
         gjTzokTRFF+5W9p1gwx2xYGtqazKS/qZC1Jx48Suh0qxEuHGy4oSI2oQ8UQ2HGtD7/KI
         dPyhvWbpYFoxUMJU/wuPp7fThxCafh2j9nLfcVfzr2AaOEerCMKMeqqZ3eFbIoL2c/z3
         yNqGBvTIM9Y0KlQjJyXNCI6bPX+n1WbKiaZdxz5/z4R3N7ta4dpPN8cmu3kaPy3A0wtW
         z07Q==
X-Gm-Message-State: APuU4Z8NiceJwlvtd/7CEc6NTg0QARgY2W580XKacCL8rvTv6N/L4DOM
	TG9L7T3COBRsXUhPJWsKa3raRwKtRaOFn0ZBfBxdgrk6Qoj97Ol+UCxhsSoPG8DLcU28JVneuB6
	rxjlcMlwaM5QhKdA3+SyjUCXh3lNT7Uq9Pt6sU47sfN/fRcujY7A7cpuEVk8wAes93ImUEv7Hqj
	Xke/QdVo8Is+vLF9b9+q8CJbQ+LabUZPHTav1QFDtFZFfL8PQak2I=
X-Received: from jabio27.prod.google.com ([2002:a05:6638:831b:b0:608:c2f0:a34d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1507:b0:4f5:20:d847 with SMTP id 5614622812f47-57a0b64ef2fmr14660562b6e.36.1795477180255;
 Mon, 23 Nov 2026 15:39:40 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:13 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-9-dmatlack@google.com>
Subject: [PATCH v5 08/18] liveupdate: Let file handlers retrieve into an
 existing file
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
X-CRM114-CacheID: sfid-20261123_154753_415373_4E8E0D81 
X-CRM114-Status: GOOD (  23.48  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add liveupdate_claim_file() and liveupdate_unclaim_file(), which a file
handler's .retrieve() callback can use to make LUO manage a file before
restoring the preserved state into it.

LUO starts managing a retrieved file after .retrieve() returns it, and
fails the retrieve if it already manages the file. That works for new
files. The shmem file handler will restore tmpfs files into an existing
file, though, and such a handler has to know that LUO accepts the file
before it modifies it, not after the preserved state is consumed.
Otherwise, it could restore into a file that is preserved in an outgoing
session, or into a file that was already retrieved. Since preserve also
makes LUO manage the file before calling the handler, claiming the file
also keeps a concurrent preserve of the same file from racing with the
retrieve.

If .retrieve() claimed the file it returns, LUO doesn't track it again.
A callback that fails after claiming a file must unclaim it.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/linux/liveupdate.h   | 20 +++++++++++
 kernel/liveupdate/luo_file.c | 67 ++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index e4ad0bf78a5c..03ac06a2b24a 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -79,6 +79,8 @@ struct liveupdate_arg_spec {
  *                    to the handler's expected argument size with any trailing
  *                    bytes beyond the user-supplied size zero-filled. Valid
  *                    only for the duration of the callback.
+ * @claimed:          For .retrieve(): Set while the callback has claimed a file
+ *                    with liveupdate_claim_file(). Private to LUO.
  *
  * This structure bundles all parameters for the file operation callbacks.
  * The 'data' and 'file' fields are used for both input and output.
@@ -92,6 +94,7 @@ struct liveupdate_file_op_args {
 	u64 serialized_data;
 	void *private_data;
 	const void *arg;
+	bool claimed;
 };
 
 /**
@@ -306,6 +309,12 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
 
+/* For .retrieve() callbacks that restore into an existing file */
+int liveupdate_claim_file(struct liveupdate_file_op_args *args,
+			  struct file *file);
+void liveupdate_unclaim_file(struct liveupdate_file_op_args *args,
+			     struct file *file);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
@@ -370,5 +379,16 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline int liveupdate_claim_file(struct liveupdate_file_op_args *args,
+					struct file *file)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void liveupdate_unclaim_file(struct liveupdate_file_op_args *args,
+					   struct file *file)
+{
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index d51bd75723fa..82ec05c7d3ce 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -676,6 +676,9 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	err = luo_file->fh->ops->retrieve(&args);
 	kfree(args.arg);
 	if (err) {
+		/* A handler that fails must unclaim the file it claimed. */
+		WARN_ON_ONCE(args.claimed);
+
 		/*
 		 * Keep the error code for later use unless the handler marked
 		 * the failure as retryable (e.g. invalid user argument before
@@ -686,9 +689,14 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		return err;
 	}
 
-	err = luo_track_file(luo_file->fh, args.file);
+	/* A file that the handler claimed is already tracked. */
+	if (!args.claimed)
+		err = luo_track_file(luo_file->fh, args.file);
 	if (err) {
-		/* A retrieved file is new, so it can't be tracked already. */
+		/*
+		 * A retrieved file that the handler didn't claim is new, so it
+		 * can't be tracked already.
+		 */
 		WARN_ON_ONCE(err == -EBUSY);
 
 		/*
@@ -1093,3 +1101,58 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 				 token, NULL, filep);
 }
 EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);
+
+/**
+ * liveupdate_claim_file - Claim the file that the preserved state is restored
+ *                         into.
+ * @args: The arguments of the .retrieve() callback.
+ * @file: The existing file that the callback restores the preserved state into.
+ *
+ * LUO starts managing the file that .retrieve() returns after the callback,
+ * and a file can only be managed once. A handler that restores the preserved
+ * state into an existing file, instead of a new one, must call this before
+ * modifying @file, so that a file that LUO already manages is rejected before
+ * the preserved state is consumed. For example, @file could be preserved in an
+ * outgoing session, or be another retrieved file.
+ *
+ * After a successful claim, the callback must either return @file in
+ * @args->file, or call liveupdate_unclaim_file() and fail.
+ *
+ * Context: Can only be called from a .retrieve() callback.
+ * Return: 0 on success, -EBUSY if LUO already manages @file, or another
+ *         negative errno on failure.
+ */
+int liveupdate_claim_file(struct liveupdate_file_op_args *args,
+			  struct file *file)
+{
+	int err;
+
+	if (WARN_ON_ONCE(args->claimed))
+		return -EINVAL;
+
+	err = luo_track_file(args->handler, file);
+	if (err)
+		return err;
+
+	args->claimed = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(liveupdate_claim_file);
+
+/**
+ * liveupdate_unclaim_file - Undo liveupdate_claim_file().
+ * @args: The arguments of the .retrieve() callback.
+ * @file: The file that was claimed.
+ *
+ * Context: Can only be called from a .retrieve() callback.
+ */
+void liveupdate_unclaim_file(struct liveupdate_file_op_args *args,
+			     struct file *file)
+{
+	if (WARN_ON_ONCE(!args->claimed))
+		return;
+
+	luo_untrack_file(args->handler, file);
+	args->claimed = false;
+}
+EXPORT_SYMBOL_GPL(liveupdate_unclaim_file);
-- 
2.56.1.809.ga0b61035b5-goog


