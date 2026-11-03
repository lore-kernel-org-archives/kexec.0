Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18684606D816
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vWLbDykr;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bpnF1NO6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f7jy8MubX3hGHk5TxpJrbkUXvzo9K2tHVQ0bkJ4pbKo=; b=vWLbDykrqkTZmtaDbfMJ14EsW4
	H6E3FHjmrfzCpHR4AcylYAo9WhlMXyr51s1fwF19AGjLF3xVvhJdKK/t5LoaZU/0pdGSd+hjnlgnF
	Oo9h4DpB5Es0pIvSjOVekcWat4sdejRabEX1BsWVuuLK271tPk5LFCMFfT7YVxLWLWdURNwJibhJQ
	bzEOBU9mjUJFDy7syaqrszpvVlWBc0AXscMnWc2KDGq1cE4mqjr31KD3KEHWipgjn8KhSu0B5Cl2A
	V3HB6yId5N+rNN8mIrFzuf4qm8IbXptZmF7aejRBoSO2NoXXcJQdvXSKDvRrbkQ/r3lTqrgKPKYfm
	EgljkE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v7-00000000mIF-398Z;
	Tue, 03 Nov 2026 01:02:37 +0000
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v3-00000000mAF-1iQe
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 01:02:34 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso4401811a91.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667752; x=1794272552; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7jy8MubX3hGHk5TxpJrbkUXvzo9K2tHVQ0bkJ4pbKo=;
        b=bpnF1NO6w3wXXT/8x1220lydWRvwiBJpsfHkgvjlhWLckhLat05rsfZ4ti0mHl1pbe
         WhBOej04kSFQc31y8DtCGIci7VO7T5C9K6KqaiQdpa7bWPoJFP+L+IxrrBAZY40bvCGu
         z/fpZOwd6988UOUKLsUszMNM+wEMETTiEec7vjmfVutkOkeMNHubV3pvRim4UlrTTvD/
         aMMLsoMMOSclvNPTO3lFNJTED/6y4Ou44iBX2o2dEALp+UT79GIMW6H3d96sZgAGv44L
         2kEYUwOxwURWFRNTHPTzOAFURoaUUBGLiIYkoV18T/JCvih940A/kzQ8nZnQ9fGymptl
         3DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667752; x=1794272552;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7jy8MubX3hGHk5TxpJrbkUXvzo9K2tHVQ0bkJ4pbKo=;
        b=otVvNBn9JAkrohev3WQ4+eYYeL/CCMLMuFWt1YWby8cU1RqEN9ZKjs9Ss/j2ZDvaVa
         uwLrWYj4erCPak45YU9gfuatNagSzIJZUGItIGkTY1/0SXrzhtu8AKwcGCQXlreJpais
         0llRokp6v6N5JoamnSO/LKBtUGnGErG3ME0PyDfYib4Fp2nU8sm9G3AF9yCiwb2CqLnA
         FSKcpVxdGM3Yq+/r43VlsHQWNkaqBQRDQufMpF0GZtahkZfdM1VNpFqc7CAWsGbfXuBv
         cduIrVsrKtL62cdYniP4/Y0JAjv9lUuylskv0R1e6cMJKExmN41Zi4Y6DL9uQWBGQPbE
         4VCA==
X-Gm-Message-State: APuU4Z+m8GEwhhc1tyhJcZZAbMQnBi+QYudmKMPozwlUbFTH/JCbUGBx
	YhJu0yKGY8v3DnJEEqq0BDMSkbo8/j8qSx3z0LGyBryryxUc914RZyB57EuCmLu9UnqclOFCgO9
	VfQX9UKkYnJ9FUAvmLnTDQuwdkgI2V1f5apVbHBxriXxKNUBSGugQ9vqRFFArshHtG6m7zj/JcA
	cfX/7sCbN4fFTx1K9SEcBoCC8OrIlAKhnQzgweb/8wVBnUnNUHBOE=
X-Received: from pjqg15.prod.google.com ([2002:a17:90a:a80f:b0:3aa:f38e:cb2d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8b:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3ae8970fd9dmr9928947a91.13.1793667751455;
 Mon, 02 Nov 2026 17:02:31 -0800 (PST)
Date: Tue,  3 Nov 2026 01:02:14 +0000
In-Reply-To: <20261103010216.3447716-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103010216.3447716-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103010216.3447716-9-dmatlack@google.com>
Subject: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files that are
 still linked
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
X-CRM114-CacheID: sfid-20261102_170233_463239_2401E25B 
X-CRM114-Status: GOOD (  28.25  )
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

Allow preserving tmpfs files that are still linked. To preserve any
file, require permission to write to it and the file to be opened for
reading, and reject append-only files.

shmem_luo already accepts any shmem file without links, which includes
unlinked tmpfs files and files created with O_TMPFILE. Accepting linked
files means that userspace doesn't have to unlink files to preserve them
and can keep using them by path until the live update.

The path of the file isn't preserved. Like other files from tmpfs
mounts, a linked file is retrieved onto a tmpfs mount chosen by
userspace, which can then link it at the path it wants.

While a file is preserved, its size is frozen, so truncating it,
fallocate() and writes past its end fail with -EPERM. For a linked file,
this affects everyone who opens the file by its path, so a caller that
can only read the file, e.g. a world-readable file in /dev/shm, could
use it to break the owner of the file. So require permission to write to
the file to preserve it, for all files. Like FS_IOC_ENABLE_VERITY, don't
require a file opened for writing, so that binaries that are being
executed can still be preserved through read-only fds. Also don't
require a writable mount, since preserving a file doesn't write to the
filesystem. If the size of the file can't change anyway, because it is
immutable or on a read-only superblock, also let its owner preserve it.
Don't let others do that, since the size could change again once the
file is made writable. Like FS_IOC_ENABLE_VERITY, reject append-only
files, since their writers can only append to them, and freezing their
size would stop all appends.

Also like FS_IOC_ENABLE_VERITY, require the file to be opened for
reading. The retrieved file can be read, so otherwise a caller that can
only write to a file could preserve it to read its contents.

Preserving a file also fills its holes, but don't require any permission
for that. Anyone who can read a tmpfs file can already fill its holes by
faulting them in through a read-only mapping, also on read-only mounts
and for immutable files.

Document the frozen size and the permission requirements.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/shmem_luo.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index ecbeb37d33a8..0c012f242fc5 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -28,6 +28,24 @@
  * the file are preserved. All others are reset to default. The preserved
  * properties are described below.
  *
+ * A tmpfs file can be preserved even if it is linked, but its path is not
+ * preserved. Userspace chooses where to put the file when retrieving it, as
+ * described in "Retrieving Tmpfs Files" below.
+ *
+ * Preserving a file requires it to be opened for reading, since the retrieved
+ * file can be read. It also requires permission to write to the file, since
+ * preserving it affects all of its users, as described below. But the file
+ * doesn't need to be opened for writing. For example, a binary that is being
+ * executed can be preserved through a read-only file descriptor. The owner of
+ * a file whose size can't change anyway, because it is immutable or on a
+ * read-only superblock, may also preserve it. The file can be preserved
+ * through a read-only mount. Append-only files can't be preserved.
+ *
+ * While a file is preserved, its size can't change and no holes can be punched
+ * into it. Truncating the file, ``fallocate()`` and writes past the end of the
+ * file fail with ``-EPERM``. This applies to all users of the file, including
+ * users that open it by its path.
+ *
  * .. note::
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
  *    or tmpfs file are also not stable and are subject to backwards
@@ -298,6 +316,45 @@ static void shmem_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
+/*
+ * Check whether the caller may preserve @file. The retrieved file can be read,
+ * so require @file to be opened for reading, like FS_IOC_ENABLE_VERITY does.
+ *
+ * Preserving the file freezes its size until it is unpreserved, for all users
+ * of the file, so require permission to write to the file. Like
+ * FS_IOC_ENABLE_VERITY, don't require a file opened for writing, so that e.g.
+ * a binary that is being executed can be preserved. Also don't require a
+ * writable mount, since preserving the file doesn't write to the filesystem.
+ * If the size of the file can't change anyway, because it is on a read-only
+ * superblock or immutable, its owner may also preserve it. The size could only
+ * change again after the file is made writable, which is up to the owner or
+ * root. Reject append-only files: Their writers can only append to them, and
+ * freezing the size would stop all appends.
+ *
+ * Preserving the file also fills its holes, but that doesn't need any more
+ * permission: Anyone who can read the file can fill its holes by faulting
+ * them in through a read-only mapping.
+ */
+static int shmem_luo_may_preserve(struct file *file)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct inode *inode = file_inode(file);
+	int err;
+
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+
+	if (IS_APPEND(inode))
+		return -EPERM;
+
+	err = inode_permission(idmap, inode, MAY_WRITE);
+	if (err && (sb_rdonly(inode->i_sb) || IS_IMMUTABLE(inode)) &&
+	    inode_owner_or_capable(idmap, inode))
+		return 0;
+
+	return err;
+}
+
 static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
@@ -307,6 +364,11 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	int err = 0, seals;
 
 	inode_lock(inode);
+
+	err = shmem_luo_may_preserve(args->file);
+	if (err)
+		goto err_unlock_inode;
+
 	shmem_freeze(inode, true);
 
 	/* Allocate the main serialization structure in preserved memory */
@@ -362,6 +424,7 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	kho_unpreserve_free(ser);
 err_unlock:
 	shmem_freeze(inode, false);
+err_unlock_inode:
 	inode_unlock(inode);
 	return err;
 }
@@ -710,9 +773,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 static bool shmem_luo_can_preserve(struct liveupdate_file_handler *handler,
 				   struct file *file)
 {
-	struct inode *inode = file_inode(file);
-
-	return shmem_file(file) && !inode->i_nlink;
+	return shmem_file(file);
 }
 
 static unsigned long shmem_luo_get_id(struct file *file)
-- 
2.56.0.385.gac671c819a-goog


