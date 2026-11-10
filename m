Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4860A260B
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4W0WQkpc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFsN1e/5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kasMDOcTvV0NYyrBnOBPw++vO4YiuCVgb2XxRtS1qvM=; b=4W0WQkpc6ctuIW
	G2P+rEj4Lk4QdarRSmNzgQ61BxKFjgJEO+VUlUfwVn/1+GfZ6oGxr/1/ewiSz08YcTdGbFplh9VOj
	VQ3ha+lumTBXhKzzuPhcc+DDweI+FNm8mKOW6h+l39AZxp8Gh0x8UtA9uhdRvawDXYO4bEIqWJ9ma
	G2Aj1kUDgyDr7TIWOu7zPx1OTmKpAUvRPQwM53RfTHsxkG1PY1h43anmRIDT3EGgiDwzrRu1+dHko
	pmuUFKaTPLy1YiM3LIafxHzJRHS6m9eTYVdxzJDzg8dObTTYIYPmAX9KXgUhpHdfKRaZec5wuoZhy
	IOTUnC6Hze0LtsLYTEJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7h-00000004kJN-1Yae;
	Tue, 10 Nov 2026 17:59:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7e-00000004kIl-3am7
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:59:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A2AC42386;
	Tue, 10 Nov 2026 17:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8701F008A3;
	Tue, 10 Nov 2026 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333546;
	bh=kasMDOcTvV0NYyrBnOBPw++vO4YiuCVgb2XxRtS1qvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFsN1e/5hDYrH56ZTnZw4RkCYmdJHwM1nMxBBY7ZSClYsmSuucVsBUlHN2IYqDlDC
	 LdzOYSbLn/HJXII+igJNAk1rTfminwVeW82CdICH/810OfiY0NlQZCtb1ptX+3C2W3
	 t72j0w8bjptIJc3yhzxsJsYGzFI/0iNEwDNQxDJ5+Ci23j1WHmyNal4r04x0nDsm9t
	 LF1gpP1E9Jhz5xSL3T+6kbsQPsV4kxVprErtVQzbYds7jC7ghYOSk6tau5rpDMCZNY
	 5KHu9jRr2PteO5L2rdG+G5EjWSYYajJ/EYO+NjTGlDpwTpl2UXSj7C3qXc9ehSnpLq
	 k1wV3z+ZPZsUw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] liveupdate: luo_file: allow keeping private_data from retrieve until finish
Date: Tue, 10 Nov 2026 18:58:52 +0100
Message-ID: <20261110175855.2437084-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
In-Reply-To: <20261110175855.2437084-1-pratyush@kernel.org>
References: <20261110175855.2437084-1-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

The private_data field of struct liveupdate_file_op_args lets file
handlers keep runtime state that is not preserved. It is set by
.preserve() and passed to the later outgoing callbacks, up to
.unpreserve(). But in the new kernel, nothing set by .retrieve() is
kept, and .can_finish() and .finish() always get a NULL private_data.

Handlers might need to keep runtime state from retrieve until finish.
For example, memfd will need to remember the folios it holds on to
until finish so it can release them there.

Save the private_data set by a successful .retrieve() in the luo_file,
and pass it to .can_finish() and .finish(). The handler must free it in
.finish().

While at it, update a stale comment under struct
liveupdate_file_op_args. There is no 'data', but there is
'serialized_data' and 'private_data'. Refer to them instead.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/liveupdate.h   | 11 +++++++----
 kernel/liveupdate/luo_file.c | 11 ++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612ce..f01e9ab68d996 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -37,12 +37,15 @@ struct file;
  * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
  *                    this field.
  * @private_data:     Private data for the file used to hold runtime state that
- *                    is not preserved. Set by the handler's .preserve()
- *                    callback, and must be freed in the handler's
- *                    .unpreserve() callback.
+ *                    is not preserved. For outgoing, set by the handler's
+ *                    .preserve() callback, and must be freed in the handler's
+ *                    .unpreserve() callback. For incoming, set by the handler's
+ *                    .retrieve() callback on success, and must be freed in the
+ *                    handler's .finish() callback.
  *
  * This structure bundles all parameters for the file operation callbacks.
- * The 'data' and 'file' fields are used for both input and output.
+ * The 'file', 'serialized_data' and 'private_data' fields are used for both
+ * input and output.
  */
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504fb..9bda37b0dc4f1 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -145,9 +145,11 @@ static DEFINE_XARRAY(luo_preserved_files);
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
  * @private_data:  Pointer to the private data for the file used to hold runtime
- *                 state that is not preserved. Set by the handler's .preserve()
- *                 callback, and must be freed in the handler's .unpreserve()
- *                 callback.
+ *                 state that is not preserved. For outgoing, set by the
+ *                 handler's .preserve() callback, and must be freed in the
+ *                 handler's .unpreserve() callback. For incoming, set by the
+ *                 handler's .retrieve() callback, and must be freed in the
+ *                 handler's .finish() callback.
  * @retrieve_status: Status code indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts. A value of 0 means a retrieve()
@@ -616,6 +618,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	luo_file->file = args.file;
+	luo_file->private_data = args.private_data;
 	/* Get reference so we can keep this file in LUO until finish */
 	get_file(luo_file->file);
 
@@ -643,6 +646,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		args.retrieve_status = luo_file->retrieve_status;
 		can_finish = luo_file->fh->ops->can_finish(&args);
 	}
@@ -661,6 +665,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
+	args.private_data = luo_file->private_data;
 	args.retrieve_status = luo_file->retrieve_status;
 
 	luo_file->fh->ops->finish(&args);
-- 
2.56.0.542.g3ef89b7020-goog


