Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C1606EEBB
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Us0hsbVT;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zue9DK98
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7I0mAJcE66JF6RmNkJWZGa5rIBu7EHzJOM3NkpUE8Fo=; b=Us0hsbVTDz4bOzy3nwDo3Wkyc2
	9RBNfFvxVg0SIC+utx7TDs4dYq4K0cCyFAqMYe7e2jPkM2T6ZwY0QypeuMdY5+p2vG89ndENIfHvC
	Ut91LuVsxbb8DpjBr5ZgIbDkGhD21lnDsEnx8LpX/PMCHTqYxOzVYOKaKJbc6yghbVSUSo3H1tq17
	1stFZ56Lcce9GVQfPiqCQXb6dMguHyixircVlLDMEEzcGscAHaOsIHbOdYx1oRzw0EOnRSoFkopKb
	ndg5cjmZu8i7bVoZ5VYkyNLwjp44WEaWmxYxV6VP5mQIKTdHD0j7tw4nPNYbJN8sDXQ+mLbm79WEP
	daxjqDvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v7-00000000mIb-3v74;
	Tue, 03 Nov 2026 01:02:37 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v4-00000000mAx-0H7Y
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 01:02:35 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2eac6e96bd4so54425695ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667753; x=1794272553; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7I0mAJcE66JF6RmNkJWZGa5rIBu7EHzJOM3NkpUE8Fo=;
        b=Zue9DK98NqglgKMGP/UtycxoiT/K6l7GMBX65SW/P18/Pt7XwFCtc0R5WILefWlzMb
         YcBFBvpwShp4qnhjDKg1YpFmeVIDvz0gRIV6tuNQwJMwQ9245o8Jn0kgVvI04UWwiLJ9
         5cNDELrXqscbyXhx587WrcAM0S5eGHjEdoU0SSxpYQBTK+6I/junI3CgH1F5toBvcCV/
         BUf5fgAh1q5Gv6cBb71GBLLmJ1/aqk2f1w+HxN0sr9QdjtbvoUbU2qdxu0v5U9lsHyuR
         Rjc1sEos66fACv+sLzaUxUFGgv/OxOz+37zGo3pD4fFw/CaWOHT1xGnKF1Bq5BwbSOYa
         OWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667753; x=1794272553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7I0mAJcE66JF6RmNkJWZGa5rIBu7EHzJOM3NkpUE8Fo=;
        b=hhMP3N/Bz4OUIOEfIdsG1rOqK6uMHi9L8QadUMfF02W0IlcLwN1vzjAl4GlmUX6Dhr
         ArwKRZGN4w/4MjpnSSsr0c/Ks6M+JN40ph65OGQVH2URfyOXKkwP5ZI5a34W74ep3bej
         724GjusDUiAubJP/Qw71kyUR1sZvcpELn+0e9rdrPUWCYAbZb8BGDHE7gwQR3DS9s36X
         vjzWYv1snyaR8lgOWtG+B7mDOTEhkD2KEXy2LYv/0ggS4CQHdrAEPBPz45LC1z9Zf4Xm
         lPiHQPA/CyDDB5f+WsSKMUx7iA+EIRzITCX6YfCsSEUeZsEbyCpBXjo4rOMoP6y1f036
         X0Xg==
X-Gm-Message-State: APuU4Z/6TkXOpEoW3ynxCvgJIemKkCmvl4p6GsCIK73zMpW1Rdkc3w19
	DT5qXmcIgBUbBObOza8hf7g+Jx1uLi7OhjBbguMPTQw8LinSpNpXNWXUNQFJ/PVpElCfYXrcj85
	bix/gQufMx9Uyd5y2MRVk1OQDG0hoaF59j/v9eD6O66kiSkrq2eTREZlHC6s6PBSy+mty0ggkpp
	zO3+0yHF5TMcX08sUUJYn9l1WW6Sw8Aisog6KAsRWnBqAM1EsDI9M=
X-Received: from plil13.prod.google.com ([2002:a17:903:17cd:b0:2eb:515:b000])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e74a:b0:2e7:4a2f:68e6 with SMTP id d9443c01a7336-2eb364d1882mr123516745ad.39.1793667752259;
 Mon, 02 Nov 2026 17:02:32 -0800 (PST)
Date: Tue,  3 Nov 2026 01:02:15 +0000
In-Reply-To: <20261103010216.3447716-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103010216.3447716-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103010216.3447716-10-dmatlack@google.com>
Subject: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files with O_RDONLY
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
X-CRM114-CacheID: sfid-20261102_170234_120975_08593712 
X-CRM114-Status: GOOD (  22.52  )
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
like before, then reopen it read-only with dentry_open() using the flags
of the writable file, which file_open_root() normalized, and drop the
writable file. Like open(), which grants the requested access to a new
file regardless of its mode, don't check permission for the read-only
open.

Retrieving a file read-only allows a restored binary to be executed
before the session is finished. LUO keeps the retrieved file open until
then, and executing a binary that is open for writing fails with
-ETXTBSY. Being able to execute restored binaries right away matters
when they are needed to finish restoring the system, e.g. to bring up
the services that retrieve and finish the remaining sessions.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/uapi/linux/liveupdate.h |  6 +++---
 mm/shmem_luo.c                  | 34 ++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 10 deletions(-)

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
index 0c012f242fc5..c669416a8a59 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -113,9 +113,10 @@
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
@@ -661,7 +662,9 @@ static struct file *shmem_luo_create_memfd(const struct liveupdate_shmem_retriev
 static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_retrieve_arg *arg,
 						unsigned int seals)
 {
-	struct file *file;
+	struct file *file, *ro_file;
+	bool rdonly;
+	int flags;
 	int err;
 
 	if (!arg)
@@ -685,10 +688,16 @@ static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_re
 
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
 
@@ -706,7 +715,18 @@ static struct file *shmem_luo_create_tmpfs_file(const struct liveupdate_shmem_re
 	}
 	SHMEM_I(file_inode(file))->seals = seals;
 
-	return file;
+	if (!rdonly)
+		return file;
+
+	/*
+	 * Reopen the file with the flags of the writable file, which
+	 * file_open_root() normalized, e.g. by dropping O_CLOEXEC.
+	 */
+	ro_file = dentry_open(&file->f_path,
+			      (file->f_flags & ~O_ACCMODE) | O_RDONLY,
+			      current_cred());
+	fput(file);
+	return ro_file;
 }
 
 static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
-- 
2.56.0.385.gac671c819a-goog


