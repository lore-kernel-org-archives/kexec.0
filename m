Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4B60A2614
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q4c7pvYo;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cjJLmUj7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M8wkRoJDHKCl2H3ues/+67+xXGDD9mtv8dtHSiakNgQ=; b=q4c7pvYoz0ZJLvEDvdAp8t7tsz
	N0wZU5wBK0KKXEr2tWH5v1PEqLgggydZeWIkzyj2uoOacD+rVn9oF9YudfTrBReDQNz1n5wnCgETV
	X4eo4nzAZ/ZJ76mviEyAg8Sn7CZdjZ2W2veuK1Y//Mzdku7uU5rQEpRgiGP+4Zah385Hi6Tm1YLTn
	4GUtNbFo1rOa8PGi58gUmSHVbXbO2wTYPKvmngMX+hgC6kefKs5dkRGbtYRbeeABEfnf5OvbvVNKi
	2F/k37bvr+5dnLlN7jmTDpQCVmlL1QMVbsNJJX4PZUfCPExxgyHICA0UiPrkWNy4cHicxQqT/380V
	YEuUpsrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cm-0000000F6AT-2lJZ;
	Thu, 22 Oct 2026 22:51:04 +0000
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1ch-0000000F64W-1wPd
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 22:51:02 +0000
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cd0e92d64a1so141711a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709458; x=1793314258; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8wkRoJDHKCl2H3ues/+67+xXGDD9mtv8dtHSiakNgQ=;
        b=cjJLmUj7WiK0QDCMq/8V45Umn2+AvzONz/MT0F+1cJx0IGG6rccnNLEBQ2UJzdUNZW
         /GaaamscrHczJiVsFOGuJ2PkkmyhG/vgHzMMNlQ792Xo9liFU+R/WUhextc8YSTKkJ3t
         S1qMAk/RkMbI0F9yJMDyZaWupIOhIXlWkW3sItLa0HrjlKFSl3z+i6Thx7dMTL/veJf+
         e0A3g7GSvPJTMHo/N1f7zzsooCVzphuGqAk6jSQ9/MOFK193RtXbEXvzZYXh415NrdNt
         NkdXYtTmspOjOuY6GUJUbG5kVLaPCfNmfC5zDSr9WF7B3q3fXvrKDO9YS64D9EoEYIF4
         qqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709458; x=1793314258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8wkRoJDHKCl2H3ues/+67+xXGDD9mtv8dtHSiakNgQ=;
        b=22k2PG26Jq50Wf58wVxNhT6QdBy94p8GKkyuVPBgrT1VO/Vmq2UziXWro3kI1zjayB
         fEBVnAr80qWRxa6U9zB0/LJc8pzig5Px/priYLSzICaGfM9AiAALMO4bEDBv7AKR1VfN
         T7BtgHQF2m4VxvyPZ83miIF/05mq5OGG3wl+RHLFzYyvaiCQf+v6oqpYxzYhOyOl8ntN
         H9xEIWzb6OEtzjxtBy25eSgEOIWnSrCkrOYMKBSNXRlndz/LIsxRrMM+dNRloEYeHlGw
         VRT/dAaQ/pFBBhCoYRur48lOr0F+IO3ehUhNSmb2Vru2jbg3/8T/GicEI1eAM/GbaCJv
         V0sQ==
X-Gm-Message-State: AFq9FYLCcYknhp9xbrsu/O5DopkKtPlSOaFQS3nYzsEFhGavdYVqJgno
	0eqvg3PjFhwsSo/43oKioTrvAHGHE6g2TNIqLt8CDH10V5KMO/AXzWI+p0LVHngSKotIg0EVPpz
	pw/5mt5sttA8bjives7NxWDt7eHHiFlZP/Uxz/NjY+7WJg3mKTGgmDZPfKCXWTbD2giUE9rl1o9
	Mr8cxDj5UKWnmsSVTxw6IeaTpvWJbUNkfbelHJYuVw6ODy2oHnS6s=
X-Received: from pgbm22-n2.prod.google.com ([2002:a05:6a02:6196:20b0:cd6:a6ae:1ba0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:8001:b0:3e2:78bf:63d6 with SMTP id adf61e73a8af0-3e2a0c4a3a0mr1802376637.46.1792709457482;
 Thu, 22 Oct 2026 15:50:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:33 +0000
In-Reply-To: <20261022225035.377445-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022225035.377445-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022225035.377445-9-dmatlack@google.com>
Subject: [PATCH v2 08/10] mm/shmem_luo: Allow preserving tmpfs files that are
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
X-CRM114-CacheID: sfid-20261022_155100_481377_6B691E71 
X-CRM114-Status: GOOD (  26.03  )
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

shmem_luo already accepts any shmem file without links, which includes
unlinked tmpfs files and files created with O_TMPFILE. Also accept tmpfs
files that are still linked, so that userspace doesn't have to unlink
files to preserve them and can keep using them by path until the live
update.

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
executed can still be preserved through read-only fds, nor a writable
mount. If the size of the file can't change anyway, because it is
immutable or on a read-only superblock, also let its owner preserve it.
Don't let others do that, since the size could change again once the
file is made writable.

Preserving a file also fills its holes, but don't require any permission
for that. Anyone who can read a tmpfs file can already fill its holes by
faulting them in through a read-only mapping, also on read-only mounts
and for immutable files.

Document the frozen size and the permission requirement.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/shmem_luo.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index ecbeb37d33a8..aba2bc1f18c5 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -28,6 +28,23 @@
  * the file are preserved. All others are reset to default. The preserved
  * properties are described below.
  *
+ * A tmpfs file can be preserved even if it is linked, but its path is not
+ * preserved. Userspace chooses where to put the file when retrieving it, as
+ * described in "Retrieving Tmpfs Files" below.
+ *
+ * Preserving a file requires permission to write to it, since preserving it
+ * affects all of its users, as described below. But the file doesn't need to
+ * be opened for writing. For example, a binary that is being executed can be
+ * preserved through a read-only file descriptor. The owner of a file whose
+ * size can't change anyway, because it is immutable or on a read-only
+ * superblock, may also preserve it. The file can be preserved through a
+ * read-only mount.
+ *
+ * While a file is preserved, its size can't change and no holes can be punched
+ * into it. Truncating the file, ``fallocate()`` and writes past the end of the
+ * file fail with ``-EPERM``. This applies to all users of the file, including
+ * users that open it by its path.
+ *
  * .. note::
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
  *    or tmpfs file are also not stable and are subject to backwards
@@ -298,6 +315,34 @@ static void shmem_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
+/*
+ * Check whether the caller may preserve @file. Preserving the file freezes its
+ * size until it is unpreserved, for all users of the file, so require
+ * permission to write to the file. Like FS_IOC_ENABLE_VERITY, don't require a
+ * file opened for writing, so that e.g. a binary that is being executed can be
+ * preserved, nor a writable mount. If the size of the file can't change
+ * anyway, because it is on a read-only superblock or immutable, its owner may
+ * also preserve it. The size could only change again after the file is made
+ * writable, which is up to the owner or root.
+ *
+ * Preserving the file also fills its holes, but that doesn't need any
+ * permission: Anyone who can read the file can fill its holes by faulting
+ * them in through a read-only mapping.
+ */
+static int shmem_luo_may_preserve(struct file *file)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct inode *inode = file_inode(file);
+	int err;
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
@@ -307,6 +352,11 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	int err = 0, seals;
 
 	inode_lock(inode);
+
+	err = shmem_luo_may_preserve(args->file);
+	if (err)
+		goto err_unlock_inode;
+
 	shmem_freeze(inode, true);
 
 	/* Allocate the main serialization structure in preserved memory */
@@ -362,6 +412,7 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	kho_unpreserve_free(ser);
 err_unlock:
 	shmem_freeze(inode, false);
+err_unlock_inode:
 	inode_unlock(inode);
 	return err;
 }
@@ -710,9 +761,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
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
2.56.0.257.gf7497c7d27-goog


