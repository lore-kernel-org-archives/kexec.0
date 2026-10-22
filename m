Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF760A2611
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t7hvoZw9;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vv1nj7fu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tveVWO7bpJoIkcGyu5OICWvMrLDi2sKmFxgN2k+RxPA=; b=t7hvoZw9+eckH9DaAQaUyripV7
	WPxfR9t62mFEUrDO0+tzHIcPvvayy74Zwpl2SkLxKjsf4fOPHAT8eUjvPAjAC+rULbEezYPOv95Bx
	lnf6sWlLvH8cfaVjngVrbF69qCbvd7qK1gv53E+3sezGqZpEwD5jPuCIXJc7hfkevZux+5s/T0Nkt
	pTLiwrBCdSIK/QjrOSaUFSA8OJdwFxe/koTq76i6NAmgRpHy/m8ltCmNk8NO3sfXrWln7Wejlw2fc
	ka0rTrcqZ9HEIWG7x7O6YHz9MNUKxoyJaGWo80ywAbG64xGoHM0tZg6+pIyPdCHJsAL0T3zBml4Gq
	rrIaRnDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1ck-0000000F67F-0UOD;
	Thu, 22 Oct 2026 22:51:02 +0000
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1ch-0000000F64Y-31zt
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 22:51:01 +0000
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so336393b3a.2
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709458; x=1793314258; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tveVWO7bpJoIkcGyu5OICWvMrLDi2sKmFxgN2k+RxPA=;
        b=Vv1nj7fuWYKHn93RBltDEnHLkRsJcX9yppyeSoXz/oR9JkCD3Bg1tOf6tH/PpgGejZ
         6M26Ne1C2poPQ5JX08tLVZmmAIw+vYu2I+eSpU0ak1MREeRZ+xFEoJ3jJjjkoQZ+J/+V
         cdOUQ1m6X/vq84wxnn1dMzvPCAyzWCmkQFjKcwpUj9qfvjWtbAuySyyggljdmoB/k77V
         VFAXKTRqUdyr82y1J3NWEu26nGLhFYHZFkdWkkdXNzO2GfivQvLSw9rtk+56R3Nqnkok
         mDrRH91K54WNOekhEm1ywujAYOQ/8k0/CGqyTspACNJ+leC9TI9fhxe1EzpfwTA4dopg
         dclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709458; x=1793314258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tveVWO7bpJoIkcGyu5OICWvMrLDi2sKmFxgN2k+RxPA=;
        b=OZYSBS8b20bti/5wDT7uhlKqHsiDektx85gevImHkXlzqF2MMUUC5svOdjC4T6xo5Z
         Lo00FmSDOjZPBkEcPeewuSrVPtxViq+5q176WuQnUoxd+Fk9eb4A7TPadS3/+0G1N+q3
         TMQcfhTjgF4F4x+z8awxSuvAqGuSN8+7wEhOyLojXaC4NVWuX16JJqyi09RIg5q3HmSu
         AMYpz6m5EMN8gX6s8vBOftWN5TIV5MTJFLpq5mfZYENVN7UMqvFo/UsAFlv1TkIVG5qY
         jEduHBcdEbN7V6EhupsZD4dhoreYWC+WXfnesd6MMhvkZ3AhBO8I+7ng34tB3ZceDMut
         goWg==
X-Gm-Message-State: AFq9FYJdGuzE8M7ydvoedu2i9jNwESnUl95O9Q2BB4A7tq0w69P9r1aS
	KkMHSoP8GpJ4Y08Np84rMyVlpuRX2aFQ+t5+huKgY+WPpAD3Jr5bB9tO0WGmGUa7ALW5qzVJY8y
	FSeNFV/BzV5Po9nRth8wiz/rqVdZqMZ+eQMBVx4uW3aGTMS+KnzTRHN4XgkFDVzJdUuEibnZ9MR
	QgCk3rD4Xy6V9H8lLKylK23wVG36hc/UrFgzHFMQvh5rJGaISy6kg=
X-Received: from pgww26-n1.prod.google.com ([2002:a05:6a02:2c9a:10b0:cd6:1195:61cb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:8a0e:b0:3e2:335b:1a5d with SMTP id adf61e73a8af0-3e3767c3067mr249935637.71.1792709458271;
 Thu, 22 Oct 2026 15:50:58 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:34 +0000
In-Reply-To: <20261022225035.377445-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022225035.377445-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022225035.377445-10-dmatlack@google.com>
Subject: [PATCH v2 09/10] mm/shmem_luo: Allow retrieving tmpfs files with O_RDONLY
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
X-CRM114-CacheID: sfid-20261022_155100_375947_1BDE8B2B 
X-CRM114-Status: GOOD (  22.10  )
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

Allow userspace to pass O_RDONLY in struct liveupdate_shmem_retrieve_arg
to retrieve a tmpfs file read-only.

open() requires write access for O_TMPFILE, so create the file writable
like before, then reopen it read-only with dentry_open() using the same
flags, and drop the writable file. Like open(), which grants the
requested access to a new file regardless of its mode, don't check
permission for the read-only open.

Retrieving a file read-only allows a restored binary to be executed
before the session is finished. LUO keeps the retrieved file open until
then, and executing a binary that is open for writing fails with
-ETXTBSY. Being able to execute restored binaries right away matters
when they are needed to finish restoring the system, e.g. to bring up
the services that retrieve and finish the remaining sessions.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/uapi/linux/liveupdate.h |  6 +++---
 mm/shmem_luo.c                  | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index a9dcc4fcc87b..790742a247e8 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -265,9 +265,9 @@ struct liveupdate_session_get_name {
  *
  * The kernel creates a new file as if by openat(@dirfd, ".", O_TMPFILE |
  * @flags, @mode), fills it with the preserved contents, and returns it in
- * &struct liveupdate_session_retrieve_fd.fd. Like any O_TMPFILE file, the file
- * is not linked into the filesystem. Userspace can link it with linkat(),
- * unless @flags contains O_EXCL.
+ * &struct liveupdate_session_retrieve_fd.fd. Unlike open(), O_RDONLY is
+ * allowed. Like any O_TMPFILE file, the file is not linked into the filesystem.
+ * Userspace can link it with linkat(), unless @flags contains O_EXCL.
  *
  * If @flags contains unknown flags or O_PATH, if @mode contains unknown mode
  * bits, or if @dirfd is not on a tmpfs mount, the retrieve fails with -EINVAL.
diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index aba2bc1f18c5..0b4a9d6e2968 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -112,9 +112,10 @@
  *
  * Like any ``O_TMPFILE`` file, the new file is not linked into the filesystem.
  * Userspace can link it at the path it wants with ``linkat()``, unless it asked
- * for ``O_EXCL``. Like with ``open()``, the file must be opened for writing.
- * LUO keeps the file open until the session is finished, so a retrieved binary
- * can't be executed until then.
+ * for ``O_EXCL``. Unlike ``open()``, the file can be retrieved with
+ * ``O_RDONLY``. LUO keeps the file open until the session is finished, so a
+ * binary retrieved with ``O_RDWR`` or ``O_WRONLY`` can't be executed until
+ * then.
  *
  * The blocks of the file are charged to the target mount, so the size limit
  * and quotas of the mount apply. If the file doesn't fit, the retrieve fails
@@ -649,7 +650,9 @@ static struct file *shmem_luo_create_memfd(const struct liveupdate_shmem_retriev
 static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_retrieve_arg *arg,
 						unsigned int seals)
 {
-	struct file *file;
+	struct file *file, *ro_file;
+	bool rdonly;
+	int flags;
 	int err;
 
 	if (!arg)
@@ -673,10 +676,16 @@ static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_re
 
 	/*
 	 * Create the file like open(O_TMPFILE) does, so that it gets the same
-	 * flag checks, permission checks, owner and security labels.
+	 * flag checks, permission checks, owner and security labels. open()
+	 * requires write access for O_TMPFILE, so create the file writable and
+	 * reopen it read-only below if that is what userspace asked for. LUO
+	 * keeps the file until the session is finished, and a file opened for
+	 * writing couldn't be executed until then.
 	 */
+	flags = O_TMPFILE | O_LARGEFILE | arg->flags;
+	rdonly = (flags & O_ACCMODE) == O_RDONLY;
 	file = file_open_root(&fd_file(dir)->f_path, ".",
-			      O_TMPFILE | O_LARGEFILE | arg->flags, arg->mode);
+			      flags | (rdonly ? O_RDWR : 0), arg->mode);
 	if (IS_ERR(file))
 		return file;
 
@@ -694,7 +703,12 @@ static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_re
 	}
 	SHMEM_I(file_inode(file))->seals = seals;
 
-	return file;
+	if (!rdonly)
+		return file;
+
+	ro_file = dentry_open(&file->f_path, flags, current_cred());
+	fput(file);
+	return ro_file;
 }
 
 static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
-- 
2.56.0.257.gf7497c7d27-goog


