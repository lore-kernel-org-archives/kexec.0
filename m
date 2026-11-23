Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D0606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K/QOgGMk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvl/uopy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aPK7OR8CzM9eLpteSO+lvQgKJGtTEcPn8rI1ujD6sP4=; b=K/QOgGMkftSdKa
	kWvnU1ASWdOjAirLnGd4DBL6fJpUFz0Idg/KfJ8nThVUmeHC01XQaCJhHVetmQ8SmEdM0llAWWuBC
	CwizYlQx29vJPZDD3j6Ucn7fX19WBz+ytUVxe/YYUso8Z0NgOASOr7PVWbIcNMAc0wy5klOBXWife
	p28OFQxN8cz7GNt+mUDruAMuqeDwuUqrVuWQS+ivHb37ERaMcshawQWjgJe4jtuI9MHsRptq8PaXd
	g3vOe/jTlrODCRplV61p4YBtnyE7clfAgUatwcVP5eXbhurOd7LtOtsquMRIWER4198GRikcQ0Bmf
	ysM8PDyrcEJIvE5tdh3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTjs-00000003W5z-0Azz;
	Mon, 23 Nov 2026 13:05:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTjS-00000003W0A-1Bs2
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 13:05:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 106E1456A1;
	Mon, 23 Nov 2026 13:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2125B1F000E1;
	Mon, 23 Nov 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439118;
	bh=aPK7OR8CzM9eLpteSO+lvQgKJGtTEcPn8rI1ujD6sP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vvl/uopyu0VvgPP4uP38bzkxkZ1rfqoTtfRseS6r4oEvY3wFx/Xshiy7IGBESPgDI
	 bVPrRhiNvIqyn/K1cUdLQkKbnj6wYeCjejwZz4Q+/a7K/WwWoJFRkG7KpyGWjjMJ5q
	 LK6jPzXUb3s9b1/Bu8xzI4vRDMOsXRf+KDFkvVE6RxfatEULmDnKgXnVfnoODcQ93n
	 nJRSNHCfH1kKG6VIUT3v7XlKS1R/VCoeRJ/DLBpcBimPQE7Q7ZFC2afOPpILWwmJj3
	 9mSP2zTSTD4a/WNeA/Njjie9eb2nCC4oeq7j26NYQY4EtstC2AY9LzGbIy8surydY1
	 bdoSpJozUNlpw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Chris Down <chris@chrisdown.name>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/2] liveupdate: luo_file: allow keeping private_data from retrieve until finish
Date: Mon, 23 Nov 2026 13:05:07 +0000
Message-ID: <20261123130509.4032642-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123130509.4032642-1-pratyush@kernel.org>
References: <20261123130509.4032642-1-pratyush@kernel.org>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/liveupdate.h   | 11 +++++++----
 kernel/liveupdate/luo_file.c | 11 ++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..f01e9ab68d99 100644
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
index a39992da504f..9bda37b0dc4f 100644
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
2.56.1.750.gf70dc682cf-goog


