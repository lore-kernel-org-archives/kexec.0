Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7668606A6AB
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jgdct8sh;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ksiNGGjM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1AwhDL8d9Iaq27a1JowEPw9jFEWG4nyWIagv2/If4Hg=; b=jgdct8shlhmp0PvdiutvEWC56i
	MHrxLGhJSTnwuiOouou5nI1pNoegQZD84QmLAeAPVUW+x9HgwPmJKyOaSdIkqOdeAGOXak8TdN3FR
	MHHVF034AeaEKNYE+n466uu/tCLQ3ehALyoD3XXzBKeWXFQBl0hCDgMoatyVxA4jAcROMlMvYwp60
	8P848YxOis1gKRboS18/3n5KA+k3Ip80Gup3ZkLhSZTeQ59RJgHcTLs2Rj4H4RAwNXtWEJrHmVtbI
	Np/Qp9UrqFH/kPD7H4BtIreKEa6ORQ4M5L/JUuZgVhIXp2cAC76IZLouatecH8oTvGygDIA+NtLbC
	XTsMFi5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddN-00000005BRd-0zYk;
	Mon, 23 Nov 2026 23:39:41 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddH-00000005BMz-39bv
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:36 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4ea2c058e67so4396921b6e.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477174; x=1796081974; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AwhDL8d9Iaq27a1JowEPw9jFEWG4nyWIagv2/If4Hg=;
        b=ksiNGGjM3Sf0rGVIe2IsJ23xfXXJPhaE7a0m9bOlUZ1lbj+cSd44e3U+b6OoKAkMbl
         ZVgqwwNtRJzgEbLL55NtOl/YG5ntxt3Diq0+uuHkh6lwOdYRr5/9pUyMdXSDCbM5scXF
         Inx2PZfcs4/OX+sFZF3OJw/7ZDIADVw70sS/D3jU9UYLQInViMHJwHM4LWxeHmcGBaiP
         lfUQTf4/klH+eL/lTTjNoFjz/IxrvagRxSa/EfGogeZ5FRes6JEOD6cJ14/tFNxGmWnF
         kyADkQxIrV/U9G786jHFyN2zB4IIYDJSo+edR14PZq0NSkXyno0Nuyq8VGWr7QTrtdm4
         6WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477174; x=1796081974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AwhDL8d9Iaq27a1JowEPw9jFEWG4nyWIagv2/If4Hg=;
        b=SE/hua9mwiihQsK3d8mmgS/PJ4vPTk1PrfEP2BvLpExLy408LrZOAnYGeOF+1IYttI
         pT5j85+Vc/BA+MFIRwV1gDJJIccNWR+T3v0GYt8/JSia0T0ErGwtstgfLMXxM2gJ9DGz
         q5WGrbn/BK2Fqirl4MXX3bgTM2WnXRog3Qweh2DTGAwk+IHJVs3fC6dp6VSHjIICuukw
         ZhLpO4vyqzFI7sRfioJDHunO4yLtZztsiFHajqOJI3kM1CnQcxyHksg8JQqD3nQ/BD9F
         uuORhOJ/kT4+4q3LTSBMm0kPT+bfq3rtL63gjO0/3bE30WbH+G4AZq/XPt8+3aioEhJ6
         bWBQ==
X-Gm-Message-State: APuU4Z+cEtoZ68/ePE2oh0XnNpqvDPI+r+4V32HmgNjU8GW8NFf0RmD9
	CNP+njTheTq9/BekQBHXZ6ysKbKbVBsRnweIdhbs4fZSFlY1X1830R5gySflfYIy/7KgjvaNIQ4
	jl7pYT8rFkmMF/KqABb2jqHBlRdVZu6dl7WE8F5c7Wpo4/G+TOgItICZ7BoQlzQJa+PjEizcTEU
	bNNc7D1iCVVkS2vndRlitX/HB0GRzJeMzbNk6Bn7ZzKIZqgDX1Dg8=
X-Received: from iofz21-n1.prod.google.com ([2002:a05:6602:8515:10b0:9ca:727a:80b2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1310:b0:56a:608:c445 with SMTP id 5614622812f47-57a0b95a622mr12887442b6e.51.1795477174130;
 Mon, 23 Nov 2026 15:39:34 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:09 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-5-dmatlack@google.com>
Subject: [PATCH v5 04/18] liveupdate: Allow file handlers to mark retrieve
 failures as retryable
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
X-CRM114-CacheID: sfid-20261123_153935_820907_506EE3C5 
X-CRM114-Status: GOOD (  29.06  )
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

Add a retryable output flag to struct liveupdate_file_op_args, which a
handler's .retrieve() can set on error to tell LUO that it hasn't
consumed the preserved state. LUO then lets userspace retry the
retrieve, and .finish() still releases the preserved state if the file
is never retrieved.

When luo_retrieve_file() invokes a handler's .retrieve() callback and it
returns an error, LUO currently records the error in
luo_file->retrieve_status and blocks any subsequent retrieve attempts.
This is necessary when the handler has already partially consumed or
freed the preserved KHO state.

However, with user arguments passed to .retrieve(), a handler may fail
early while validating caller-supplied parameters, such as a missing or
invalid argument, before touching any preserved KHO state. In such
cases, userspace should be able to fix the argument and retry
LIVEUPDATE_SESSION_RETRIEVE_FD.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/liveupdate.h      | 11 ++++++++---
 include/uapi/linux/liveupdate.h |  8 +++++---
 kernel/liveupdate/luo_file.c    | 20 ++++++++++++++------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 7543f5d648d3..e4ad0bf78a5c 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -58,9 +58,13 @@ struct liveupdate_arg_spec {
  * @session:          The session this file belongs to.
  * @retrieve_status:  The retrieve status for the 'can_finish / finish'
  *                    operation. A value of 0 means the retrieve has not been
- *                    attempted, a positive value means the retrieve was
- *                    successful, and a negative value means the retrieve failed,
- *                    and the value is the error code of the call.
+ *                    attempted (or only failed with a retryable error), a
+ *                    positive value means the retrieve was successful, and a
+ *                    negative value means the retrieve permanently failed, and
+ *                    the value is the error code of the call.
+ * @retryable:        For .retrieve(): [OUT] Set to true by the callback on
+ *                    error when the preserved state has not been consumed and
+ *                    retrieval may be retried.
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
@@ -83,6 +87,7 @@ struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
 	struct liveupdate_session *session;
 	int retrieve_status;
+	bool retryable;
 	struct file *file;
 	u64 serialized_data;
 	void *private_data;
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index a460f4cdb608..38ba1cf23d2c 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -178,9 +178,11 @@ struct liveupdate_session_preserve_fd {
  * associated with the token and populates the @fd field with a new file
  * descriptor referencing the restored resource in the current (new) kernel.
  * This operation must be performed *before* signaling completion via
- * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails, subsequent
- * attempts to retrieve the token fail with the same error code. Failed
- * retrieves are not retried.
+ * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails after consuming
+ * preserved state, subsequent attempts to retrieve the token fail with the
+ * same error code. A file handler may instead leave the token intact on errors
+ * that occur before it consumes the preserved state, e.g. an invalid @arg, so
+ * that the retrieve can be retried. See the documentation of the file handler.
  *
  * Retrieving a token that was already retrieved successfully returns a new file
  * descriptor for the same file. Passing a non-zero @arg in that case fails
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 3987ab86a3c1..9d98438b0166 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -152,9 +152,10 @@ static DEFINE_XARRAY(luo_preserved_files);
  * @retrieve_status: Status code indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts. A value of 0 means a retrieve()
- *                 has not been attempted, a positive value means the retrieve()
- *                 was successful, and a negative value means the retrieve()
- *                 failed, and the value is the error code of the call.
+ *                 has not been attempted (or only failed with a retryable
+ *                 error), a positive value means the retrieve() was successful,
+ *                 and a negative value means the retrieve() permanently failed,
+ *                 and the value is the error code of the call.
  * @mutex:         A mutex that protects the fields of this specific instance
  *                 (e.g., @retrieved, @file), ensuring that operations like
  *                 retrieving or finishing a file are atomic.
@@ -594,7 +595,9 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
  * The operation is idempotent: if a file has already been successfully
  * retrieved, this function will simply return a pointer to the existing
  * 'struct file' and report success without re-executing the retrieve
- * operation. This is handled by checking the 'retrieved' flag under a lock.
+ * operation. If a previous retrieve failed permanently, it returns that
+ * saved error code; if a previous retrieve failed with a retryable error
+ * before consuming preserved state, the retrieve operation is re-attempted.
  *
  * File retrieval can happen in any order; it is not bound by the order of
  * preservation.
@@ -662,8 +665,13 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	err = luo_file->fh->ops->retrieve(&args);
 	kfree(args.arg);
 	if (err) {
-		/* Keep the error code for later use. */
-		luo_file->retrieve_status = err;
+		/*
+		 * Keep the error code for later use unless the handler marked
+		 * the failure as retryable (e.g. invalid user argument before
+		 * preserved state was consumed).
+		 */
+		if (!args.retryable)
+			luo_file->retrieve_status = err;
 		return err;
 	}
 
-- 
2.56.1.809.ga0b61035b5-goog


