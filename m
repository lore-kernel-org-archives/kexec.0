Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8E606A32C
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VeFxonzR;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U3D0r/p5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7LV8lhNkJFfTRLs461bEq0N2TyeH7KvDdqPK2bQlIlc=; b=VeFxonzRT5WG752EN/YZPjTaVe
	B5WsDzb0aLZy5Bq0tEIfMUgoflMp3Fi4BVu6VpFleAFh9inrFp5kx4yLW8HZYh64ziQEO6mWuNdcM
	R7FOJBgSCFu4tUE2C3IlbzeqOr2bj2EOMW3WxWyXO8/is6Q1cFFJePnRd+BwuI2zmtJKEVQBh7a1S
	qeWQ/FQO+LlQ8Khi764V9PAEoigOyqPtyXEnY7l1wl9Z0ni+dbhcM18FQ6ckJ23+zXgUS6DQDtq0B
	LGqz3I+OC7lrfXHgVzJx4osQX3JNwQso3Tblrc+aOjn5CUJ3p/x51W+C/t8og9n0ylmTpTlc8QyH6
	kmHSZ/yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddY-00000005Bgv-3bsX;
	Mon, 23 Nov 2026 23:39:52 +0000
Received: from mail-ot1-x346.google.com ([2607:f8b0:4864:20::346])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddQ-00000005BUg-0hoP
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:45 +0000
Received: by mail-ot1-x346.google.com with SMTP id 46e09a7af769-862b2e1885cso4486724a34.3
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477182; x=1796081982; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LV8lhNkJFfTRLs461bEq0N2TyeH7KvDdqPK2bQlIlc=;
        b=U3D0r/p5dQmuLDXwxPmSQwrc7jF1Jg0gqA7MRQeSRJUYmwtrH1UpbBkTx8wQbaQIbX
         6QVgSSp8o7K3tSCZxhQDTKR52FTlJPJhDCHkd2gVKk7Qt5SHg9Y2ZlXCZvqmVRJxQKhR
         /S970HbVHvgI8MqPVudQKEK6g1deUEanfEBee1W+J/o2sAveETrwCbdJXGBfHx+e6GwX
         j7afxzNnYP2IaEbg0R6zdVRpoKNQQU8UIlRA34UJHRCAa0iPfN7owKMU7uCmgbaiQg+N
         sR3KsGXZrk2A4uAy2NODHKJ/+8k4yVY0H2cHCOgL/GhNiFnaRsRVStA52ETPK+sS9Z8k
         CCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477182; x=1796081982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LV8lhNkJFfTRLs461bEq0N2TyeH7KvDdqPK2bQlIlc=;
        b=DB4Caf/nq6GTsRuqoTMjKT9pOQxTBUVUwtwkbJKLpUCfND6h9CzxDa+m8cyxTnGsbp
         aJO+mcYrGRM6fiTTBmxYWlgWUI7FprZ1kxnQUW+RZqrA+yHBDb2mM7OII1g7uD9SFkFI
         bKUzcAM1h1BW3IaR6wtQQpWpF6JrYaDaFz+iSqMKGF+Hp+rPY5AISFGUWIXFud3ehmVC
         alVkvOrKndPWGC1ZsuEfXRN3YwsgGk80aC6ztPV+TmfOVzgXNt53Dc3ZR5HYmCI82fis
         nHTQFodGYVUifqEwwr2kdzQZ1LdptFxZ0OL5gsnSFYN6DBVojavQqkxzSGr1XRpsmM0y
         SwEA==
X-Gm-Message-State: APuU4Z+q5VUIUCj7kdZnIGXjhYzokgFJtwKcdyRIoKbdAGowEyn7XQXy
	U9C5KEUtoQdN2V8qiRsoaU6utxlG8e7IKc4+GvxkbMQvrK+2xyxB6N4etkD6xXqXmB5x98Av2Ht
	ubFUKu/PAHr/OXBXa3SRVuCrBbHhOdbVmFCWfEKBSj5aYC9P8T65c4wKd+lVCSUdu6mukBPVOSx
	3yVcTr63cecpbjrnLszKBK54Syi2DBRASfCxLsT4HV/SnOwnYxFEc=
X-Received: from jahq23-n2.prod.google.com ([2002:a05:6638:e017:20b0:620:2968:9641])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6711:b0:4c4:a240:9c3a with SMTP id 5614622812f47-57a077151demr13100240b6e.4.1795477181670;
 Mon, 23 Nov 2026 15:39:41 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:14 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-10-dmatlack@google.com>
Subject: [PATCH v5 09/18] mm/shmem_luo: Don't make early retrieve failures permanent
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
X-CRM114-CacheID: sfid-20261123_153944_217367_ADF72C1E 
X-CRM114-Status: GOOD (  14.99  )
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

Mark failures in shmem_luo_retrieve() before it starts restoring the
folios as retryable. If no retrieve succeeds, finish() frees the
preserved state, like it does for a file that was never retrieved.

Until the folios are restored, nothing has consumed the preserved state.
Leave it for another retrieve, which may succeed, e.g. if
memfd_alloc_file() failed with -ENOMEM.

The exception is a preserved file that this kernel can't restore, e.g.
because it has seals that this kernel doesn't support. Retrying can't
help, so keep that failure permanent: every later retrieve returns the
same error.

Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/shmem_luo.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index e747a0442295..46b33a00c2a2 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -532,6 +532,14 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 		goto free_ser;
 	}
 
+	/*
+	 * Nothing consumes the preserved state until the folios are restored
+	 * below. If the retrieve fails before that, leave the state for another
+	 * retrieve, or for finish() to free. The checks above can't succeed on
+	 * a retry, so they fail permanently.
+	 */
+	args->retryable = true;
+
 	/*
 	 * The seals are preserved. Allow sealing here so they can be added
 	 * later.
@@ -539,19 +547,22 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
-		err = PTR_ERR(file);
-		goto free_ser;
+		return PTR_ERR(file);
 	}
 
 	err = memfd_add_seals(file, ser->seals);
 	if (err) {
 		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
-		goto put_file;
+		fput(file);
+		return err;
 	}
 
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	i_size_write(file_inode(file), ser->size);
 
+	/* The preserved state is consumed from here on. */
+	args->retryable = false;
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser) {
-- 
2.56.1.809.ga0b61035b5-goog


