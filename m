Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506BCCC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7I4Ah0JVOQm1OSF3+TCarpY5Fjoooqn/9uhkbG0e7FE=; b=HJH3vk1vq/m9kwBfWQlW7aXRoZ
	wp2BUYrRmF6ooGuFJrnno/i7FhYC6Dsznk+B5jDmXoNJTT0l/9blZTG8YbcYmISHWc1ayHgGXPfBP
	GRvveTdSDmkfv+nhndjIAwKAHPxsX1Ns2uJ7JneVlMdHcoxDjW8ROzmnjMhojPdb49fAQt9+pCooW
	GeH5+mEvKCiKaQ47BKQ1tpogSycUL7ow7f7G9UrHQrLIymu+09vx4gzcjQ8lIlgzGQub8I7Zg9F2R
	TAd5M7/IpD5MXByjD2AneiFEGqTJvSKN9PPZ/CJ49m9Q4Isl+dio5jxYOFzGJEG4IU7OZ+smZJ5zy
	epvTUv5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGq33-0000000ESTe-2lTK;
	Wed, 14 Oct 2026 03:53:01 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGq30-0000000ESSG-1l0X
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7I
	4Ah0JVOQm1OSF3+TCarpY5Fjoooqn/9uhkbG0e7FE=; b=QOqxztTaHU/KDDMRWs
	qdZKtJ2toFL5dv+B5weTvnVzxv2avWG41VGnDWsahaetTdIh0sO6FsWMAgyNIBmc
	gUIQf9aYxmyy06DWRCrQHYEovx/ZVyCJabckLRg4o/t/NpySTtzEpcSHWKoWm4W6
	tjKwe9RVueeEhgAEMlz4U4zZQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBncnaF_M5qUtfjEQ--.37990S3;
	Wed, 14 Oct 2026 11:52:41 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] mm/memfd_luo: reject kernel-private shmem files
Date: Wed, 14 Oct 2026 11:52:26 +0800
Message-ID: <20261014035228.473825-2-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014035228.473825-1-18766350203@163.com>
References: <20261014035228.473825-1-18766350203@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgBncnaF_M5qUtfjEQ--.37990S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1UXF4rZF4xZFWDKw48WFg_yoW5Kw1Dpr
	Z5K3WrCay8KFyI9a97Ar109asYva1fAF4agrZ0gw17C3WvvrnIqFyI9FyUuF4UJrZ5WFyY
	qr4YkryakF4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URmh7UUUUU=
X-Originating-IP: [2408:8418:c22:8000:1bbd:2550:438b:167e]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC0wmvd2rO-IlSxAAA3F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_205258_803544_B936FF8A 
X-CRM114-Status: GOOD (  17.21  )
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

memfd_luo_can_preserve() accepts any unlinked shmem file.  That includes
SysV SHM files, which are created with shmem_kernel_file_setup() and
marked S_PRIVATE: a privileged process can obtain a file descriptor for
an attached segment through /proc/<pid>/map_files and hand that
descriptor to LUO.

The preservation path then updates SHMEM_I(inode)->flags under the inode
lock when it sets SHMEM_F_MAPPING_FROZEN, while SHM_LOCK and SHM_UNLOCK
update the same word through shmem_lock(), serialized by
ipc_lock_object() instead.  Two read-modify-write cycles on one word with
no common lock can lose either the LUO frozen bit or SHMEM_F_LOCKED, so
the frozen state the handler depends on may quietly not be in effect.
The seal-state freeze this series adds (SHMEM_F_SEAL_STATE_FROZEN) has
the same synchronization requirement.

Reject S_PRIVATE shmem inodes from the memfd LUO handler.  Real memfds
are created with shmem_file_setup() without S_PRIVATE, while
shmem_kernel_file_setup() deliberately uses the flag for kernel-private
objects: SysV SHM, big_key payloads, the XFS buffer and scrub files, and
the anonymous /dev/zero mapping file.  Those must not be preserved as
memfds, and dropping them also removes the only concurrent writer of that
flags word from the handler's reach, so no shmem-wide locking change is
needed here.

The predicate is deliberately not narrowed to memfd_create() objects:
unlinked non-private shmem files stay eligible.  SHMEM_F_LOCKED is only
maintained for SysV segments, so they do not share this race and keep
being preserved as before.

Measured with QEMU runs on this tree, with CONFIG_CHECKPOINT_RESTORE and
CONFIG_SYSVIPC enabled and liveupdate=on, so that a descriptor for a
segment is reachable; memfd_luo is the only file handler registered in
that configuration:

  kernel                SysV SHM fd        memfd     unlinked tmpfs
  without this patch    accepted (0)       accepted  accepted
  with this patch       -ENOENT (errno 2)  accepted  accepted

The SysV descriptor came from /proc/self/map_files and reads back as
"/SYSV00000000 (deleted)"; the memfd and the unlinked tmpfs file are the
controls that show the ioctl path still works and that the check is
limited to kernel-private objects.  The SysV case is the same guarantee
that the pre-existing SHMEM_F_MAPPING_FROZEN bit relies on, so the
mismatch is older than this series; atomic flag updates or a shared lock
would be a change across shmem and ipc, and this patch removes the
handler's exposure to it instead.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-170776@kernel.org/
Assisted-by: Pi:glm-5.3-flash
Signed-off-by: Haolong Wang <18766350203@163.com>
---
 mm/memfd_luo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..6f8b84530995 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -582,7 +582,12 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 {
 	struct inode *inode = file_inode(file);
 
-	return shmem_file(file) && !inode->i_nlink;
+	/*
+	 * shmem_kernel_file_setup() marks kernel-private files S_PRIVATE.  In
+	 * particular, SysV SHM updates SHMEM_I(inode)->flags under its IPC lock,
+	 * which does not serialize with the inode lock used by LUO.
+	 */
+	return shmem_file(file) && !IS_PRIVATE(inode) && !inode->i_nlink;
 }
 
 static unsigned long memfd_luo_get_id(struct file *file)
-- 
2.56.0


