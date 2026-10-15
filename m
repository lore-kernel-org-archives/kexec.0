Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92462CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nt5koYeNjqdzKeqQpmJI32L3fCUQ2SB26pb7zJ3MlRw=; b=bTFiOMBU+GfpHKqkdBSKbIJVjj
	+BPtGXECU9JThGXLm5qXCKRa3YT4NA0PBRy03YmE23G/BsQs9Jr+EgGtr2H4Yq8IGMwafgDR15pJ4
	wS8GvdCx09rCzpFjpKZtfJncMZv3GE+Xi20Th25ZI9suaZP0cSGmu+DibZoLjoQlkJc4OZaRQpY1Q
	omKxdKJb4/Jvk7LSrjKuR0nHrZp78BlRh36tzrTRLL8lQr0vWSkP7MqDMg/MEa0/5/89ahurTXfmB
	im3U1fx3ALg0Jgz2YEkEC8gfwL7S3RcHcEsKc4gW/oAtzBMGVxfc/pTCQLRicpbQ9W1BsBUzV+/jg
	L0Ufd3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvQ-0000000HIB7-3KqJ;
	Thu, 15 Oct 2026 09:39:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvP-0000000HIAr-0iqa
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 09:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=Nt5koYeNjqdzKeqQpmJI32L3fCUQ2SB26pb7zJ3MlRw=; b=L5OXf/PLvJRc97vwR2lqG57cS4
	AJYBXScUkow19+n34j1yYDrGOP0VuSCBag/W2SiPWhUoZXsSa8xAeuzABYrzQJdpHnpGDlvrS77Ng
	ToM/lor/MTIlrwAmRWukr3fxsOoQFfi2jBEI1uptre7XYBpoLgsWvwb3Zh9/9cYy5IXyqYPnlkMoM
	g445T1KIErRalbIpCaEfPH3EXojetlXXDsmwXutjB1ORadu+WK6wVft7H1AxAuHpRlfqDpKSke4RN
	NMwZ8ew7jWm8ulmH15Qio22wvrQ1UmmReEgIufswXZRYj6OzHZzFAGsIjwgxRTFry2vepdSE+ZxC3
	4NVO5x5w==;
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHHv3-00000000BYk-3Wdz
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:38:56 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-7c6e6822b11so428124137.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057116; x=1792661916; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nt5koYeNjqdzKeqQpmJI32L3fCUQ2SB26pb7zJ3MlRw=;
        b=lLPleG6eGXXntCJtS4YSqJUO2dvSYzNpzm+IZzGHuq+iq1NfU8B4GlJLzJR2S48ryf
         cwj/nj5c100wgkP5WTERnyRZIZaL87e9Ob7KPSHXT68xAeNfnJbNiuuPOBDRE6hs61LZ
         uNk7FtD4+nZS2/mHYryrqBhP/XTiUp7rdCBgYRhcigpCqXYk3zsLDfo0Sh6Hi3PZZ/U/
         kLlALqdEdj0Z3Hja53wUJlWTJECcmlzHC+549Eggzy9TbvVERPucy4Cukt806+coyW0N
         Z2p0B7qDFGLK5KbmggWtetynKExgcU1gXQCx902P6j8Mflzt0Xk73VHeMaQsBIg0klO0
         SnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057116; x=1792661916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Nt5koYeNjqdzKeqQpmJI32L3fCUQ2SB26pb7zJ3MlRw=;
        b=0n4Vfpdvw0a36BJ0BsTQgKBlG5csTMwCUPwEbpOOze/BHtsb/IpFkOPayESUlUV/wU
         lf70PhGM8V7FbqSgvNd4f/MNGV+XxRikHjbUwPUoEnE46XuIO+q4NPAJSRhzL2Aj5NGo
         PTjItfHGLhm8SM3bxxXEtsTjhwp4ZDKVffFQlr4e0v5mXls8XKoBY2pSKhj7byhW3uDF
         plOBWvlHKGCNDNZwP65Ab1A3iw9Gy7wnWY6rYDNWAtjVzAJjRuAN8uZ2gb6mc0/ujV90
         U7uh8N1SC8B4+Ay2m/Pbkl0bxanG1Vjm56h5ayzPrK7eNBU9h4fd+tG0uNP+wbQMtArR
         MZow==
X-Forwarded-Encrypted: i=1; AKwUvBwct6T9SiQjaOzHuY+Lamac9HD/2zxvenGYBlDppQQP7hgiHnqP0m1abri30fWxtDPnjoik2w==@lists.infradead.org
X-Gm-Message-State: AFq9FYKj85cuQiajzfT4gEJ7+bD9ST+26/KlbIzVppmIeY0ENR3lKzSa
	OcfZ27tUUBUtFVH6SeMRXp9W2aPITV5ttojhbabrVpEiVXcjdeyxj3sj8qzCnmdONSo=
X-Gm-Gg: AYBFou2V93T383hbS27zA+SqYa31r+OcShNhVnlPQp8UBeTvnvRNbo2H0+nxuTGPDQM
	mVAk7UmhxUMkma61zt6hd7Ff5dvG1Zs1yy4VsWGlwK4v4RnRb6d97PPsPM5ULx6yk0oiC1HzXYX
	uPOHlLJFFUSwUl2c0WhDutuwXae9KlYUwBlVJUSbzeOdhn1bToMyoII3y87JizdIjjEraS9lbfs
	SNYBGLAgyiu5MCYSEb4zKyylgif1jrM4cJnV+OLJQuAye7LG4myAB+qt+68nvPGaosHN8WA1bVA
	3pWnmojg6E4XD5QU0KFZumV+S81EFH5Ifh2Man16VflceLkBKFIbHtUB4jBJeZTZREz5F6Xpac2
	/vJo6uhuZpv9gU8+zwY3JDD2fpe1N3WPhHzSkrK8/0y3xORDLTvon4JNfMRo+NDqmIjxBxpIaV7
	Lg8wZWLfSAmAtf+gDihn0XC4cQZF+Ds3+QN7SuM4cRLAuxUjyJ6Jmx3WGKzjDDoHDwtq1WGDuwS
	MkmTt+oaZaos+fkaVgIDf1RN2z6Dr+zfeDaA0f7t0HPzFK+TUYJn0cnhcW9HPT9W6OoElzZjZfy
	szZxODYUBdYPG5RVYBM=
X-Received: by 2002:a05:6102:448c:b0:7c3:1d7:f234 with SMTP id ada2fe7eead31-7cb36788160mr4679901137.2.1792057115645;
        Thu, 15 Oct 2026 02:38:35 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:35 -0700 (PDT)
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
Subject: [PATCH v1 6/7] mm/memfd_luo: Support tmpfs preservation and retrieval
Date: Thu, 15 Oct 2026 05:38:15 -0400
Message-ID: <20261015093816.2438942-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_103849_592330_689860C5 
X-CRM114-Status: GOOD (  30.84  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Matlack <dmatlack@google.com>

Relax memfd_luo_can_preserve() to allow general shmem-backed files beyond
unlinked memfd pseudofiles, enabling userspace to preserve standard
tmpfs files across kexec.

Record MEMFD_LUO_FLAG_TMPFS in struct memfd_luo_ser.flags when a linked
tmpfs file is preserved so that tmpfs files must be retrieved as tmpfs
files and anonymous memfd files must be retrieved as memfd files.

To support restoring preserved tmpfs folios to a newly created tmpfs
file on the post-kexec filesystem, introduce struct
liveupdate_memfd_retrieve_arg in the UAPI and wire it up via .rarg on
memfd_luo_file_ops. When retrieving a preserved tmpfs file,
memfd_luo_retrieve() requires this argument, validates that the
specified file descriptor is a writable, empty, linked tmpfs file not
already claimed by LUO, locks its inode, and populates its address space
with the preserved folios. Validation failures on the user-provided
retrieve argument are marked retryable so userspace can retry
LIVEUPDATE_SESSION_RETRIEVE_FD without losing the preserved state.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/memfd.h   |  13 ++-
 include/uapi/linux/liveupdate.h |  21 +++++
 mm/memfd_luo.c                  | 139 +++++++++++++++++++++++++-------
 3 files changed, 141 insertions(+), 32 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc8..47ff5ab967501 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -68,7 +68,18 @@ struct memfd_luo_folio_ser {
 			     F_SEAL_EXEC)
 
 /**
- * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * MEMFD_LUO_FLAG_TMPFS - The preserved file is a tmpfs file.
+ *
+ * Indicates the file was preserved from a linked tmpfs file rather than an
+ * anonymous memfd, and must be retrieved to an empty tmpfs file.
+ */
+#define MEMFD_LUO_FLAG_TMPFS		BIT(0)
+
+/* The set of flags this version supports preserving. */
+#define MEMFD_LUO_ALL_FLAGS		MEMFD_LUO_FLAG_TMPFS
+
+/**
+ * struct memfd_luo_ser - Main serialization structure for a memfd or tmpfs file.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 0ab28fd58fa5f..24e938d91392c 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -268,4 +268,25 @@ struct liveupdate_session_freeze {
 #define LIVEUPDATE_SESSION_FREEZE					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FREEZE)
 
+/**
+ * struct liveupdate_memfd_retrieve_arg - Argument for tmpfs file retrieval
+ * @size: Input; sizeof(struct liveupdate_memfd_retrieve_arg)
+ * @fd:   Input; Writable, empty, linked tmpfs file descriptor to restore into.
+ *
+ * Passed via &struct liveupdate_session_retrieve_fd.arg on
+ * %LIVEUPDATE_SESSION_RETRIEVE_FD. This argument is required when retrieving
+ * a preserved linked tmpfs file and is rejected with -EINVAL when retrieving
+ * an anonymous memfd.
+ *
+ * @fd must refer to a writable, empty, linked tmpfs file that is not already
+ * claimed by LUO. On success, the file is populated with the preserved folios,
+ * its size and f_pos are restored, and the file descriptor returned in
+ * &struct liveupdate_session_retrieve_fd.fd references the same underlying open
+ * file description as @fd.
+ */
+struct liveupdate_memfd_retrieve_arg {
+	__u32		size;
+	__s32		fd;
+};
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 26929495786e0..9d18f01191c07 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -9,14 +9,14 @@
  */
 
 /**
- * DOC: Memfd Preservation via LUO
+ * DOC: Memfd and Tmpfs Preservation via LUO
  *
  * Overview
  * ========
  *
- * Memory file descriptors (memfd) can be preserved over a kexec using the Live
- * Update Orchestrator (LUO) file preservation. This allows userspace to
- * transfer its memory contents to the next kernel after a kexec.
+ * Memory file descriptors and generic tmpfs files can be preserved over a
+ * kexec using the LUO file preservation. This allows userspace to transfer its
+ * memory contents to the next kernel after a kexec.
  *
  * The preservation is not intended to be transparent. Only select properties of
  * the file are preserved. All others are reset to default. The preserved
@@ -24,16 +24,17 @@
  *
  * .. note::
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
- *    are also not stable and are subject to backwards incompatible changes.
+ *    or tmpfs file are also not stable and are subject to backwards
+ *    incompatible changes.
  *
  * .. note::
- *    Currently a memfd backed by Hugetlb is not supported. Memfds created
+ *    Currently a file backed by Hugetlb is not supported. Memfds created
  *    with ``MFD_HUGETLB`` will be rejected.
  *
  * Preserved Properties
  * ====================
  *
- * The following properties of the memfd are preserved across kexec:
+ * The following properties of the memfd/tmpfs file are preserved across kexec:
  *
  * File Contents
  *   All data stored in the file is preserved.
@@ -300,6 +301,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 	ser->size = inode_size;
 	ser->seals = seals;
+	if (inode->i_nlink)
+		ser->flags |= MEMFD_LUO_FLAG_TMPFS;
 
 	err = memfd_luo_preserve_folios(args->file, &ser->folios,
 					&folios_ser, &nr_folios);
@@ -516,10 +519,60 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	return err;
 }
 
+static struct file *memfd_luo_get_tmpfs_file(struct liveupdate_file_op_args *args)
+{
+	const struct liveupdate_memfd_retrieve_arg *rarg = args->arg;
+	struct inode *inode;
+	struct file *file;
+	int err;
+
+	if (!rarg)
+		return ERR_PTR(-EINVAL);
+
+	file = fget(rarg->fd);
+	if (!file)
+		return ERR_PTR(-EBADF);
+
+	if (!(file->f_mode & FMODE_WRITE)) {
+		err = -EACCES;
+		goto put_file;
+	}
+
+	if (!shmem_file(file)) {
+		err = -EINVAL;
+		goto put_file;
+	}
+
+	inode = file_inode(file);
+	inode_lock(inode);
+	if (!inode->i_nlink) {
+		err = -EINVAL;
+		goto unlock_inode;
+	}
+
+	if (i_size_read(inode) != 0 || !mapping_empty(inode->i_mapping)) {
+		err = -EBUSY;
+		goto unlock_inode;
+	}
+
+	err = liveupdate_claim_file(args->handler, file);
+	if (err)
+		goto unlock_inode;
+
+	return file;
+
+unlock_inode:
+	inode_unlock(inode);
+put_file:
+	fput(file);
+	return ERR_PTR(err);
+}
+
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
+	struct inode *inode;
 	struct file *file;
 	int err;
 
@@ -527,50 +580,75 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
-	/* Make sure the file only has seals supported by this version. */
-	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
+	/* Make sure the file only has seals and flags supported by this version. */
+	if ((ser->seals & ~MEMFD_LUO_ALL_SEALS) ||
+	    (ser->flags & ~MEMFD_LUO_ALL_FLAGS)) {
 		err = -EOPNOTSUPP;
 		goto free_ser;
 	}
 
-	/*
-	 * The seals are preserved. Allow sealing here so they can be added
-	 * later.
-	 */
-	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
-	if (IS_ERR(file)) {
-		pr_err("failed to setup file: %pe\n", file);
-		err = PTR_ERR(file);
-		goto free_ser;
-	}
+	if (ser->flags & MEMFD_LUO_FLAG_TMPFS) {
+		file = memfd_luo_get_tmpfs_file(args);
+		if (IS_ERR(file)) {
+			args->retryable = true;
+			return PTR_ERR(file);
+		}
+		inode = file_inode(file);
+	} else {
+		if (args->arg) {
+			args->retryable = true;
+			return -EINVAL;
+		}
 
-	err = memfd_add_seals(file, ser->seals);
-	if (err) {
-		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
-		goto put_file;
-	}
+		/*
+		 * The seals are preserved. Allow sealing here so they can be
+		 * added later.
+		 */
+		file = memfd_alloc_file("", MFD_ALLOW_SEALING);
+		if (IS_ERR(file)) {
+			pr_err("failed to setup file: %pe\n", file);
+			err = PTR_ERR(file);
+			goto free_ser;
+		}
 
-	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
-	i_size_write(file_inode(file), ser->size);
+		err = memfd_add_seals(file, ser->seals);
+		if (err) {
+			pr_err("failed to add seals: %pe\n", ERR_PTR(err));
+			goto put_file;
+		}
+
+		inode = file_inode(file);
+		inode_lock(inode);
+	}
 
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser) {
 			err = -EINVAL;
-			goto put_file;
+			goto unclaim_file;
 		}
 
 		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
 		vfree(folios_ser);
 		if (err)
-			goto put_file;
+			goto unclaim_file;
 	}
 
+	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
+	i_size_write(inode, ser->size);
+	inode_unlock(inode);
+
 	args->file = file;
 	kho_restore_free(ser);
 
 	return 0;
 
+unclaim_file:
+	if (ser->flags & MEMFD_LUO_FLAG_TMPFS) {
+		shmem_truncate_range(inode, 0, (loff_t)-1);
+		liveupdate_unclaim_file(args->handler, file);
+	}
+	inode_unlock(inode);
 put_file:
 	fput(file);
 free_ser:
@@ -581,9 +659,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 				   struct file *file)
 {
-	struct inode *inode = file_inode(file);
-
-	return shmem_file(file) && !inode->i_nlink;
+	return shmem_file(file);
 }
 
 static unsigned long memfd_luo_get_id(struct file *file)
@@ -599,6 +675,7 @@ static const struct liveupdate_file_ops memfd_luo_file_ops = {
 	.unpreserve = memfd_luo_unpreserve,
 	.can_preserve = memfd_luo_can_preserve,
 	.get_id = memfd_luo_get_id,
+	.rarg = LIVEUPDATE_ARG(struct liveupdate_memfd_retrieve_arg, fd),
 	.owner = THIS_MODULE,
 };
 
-- 
2.56.0.385.gd3acb90ef8-goog


