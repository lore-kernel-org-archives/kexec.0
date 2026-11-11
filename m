Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8D607009D
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LsDVDEdY;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ESxN7l/d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/dKUASXcgtiRNT2+c3YhFYhMVcr51Eig0y+PlMV5erc=; b=LsDVDEdYc8NeYBITAP5PGgpeKE
	tN+5dLT0sarPPxF4rhOlySG3DDfanZtpH8CIH4GcXrWWIf9Z3oko5MqkR6JK2QoZs9bnO9OCchgWq
	85cI0jgT6Z9x4r849ougaoPksF3HaghL0Hh1dReZJM63H4INGNd2L0HO8DakpABej/Mcr4VDpxO4S
	xZmw7ncrlxvpsRMtS1siHpr9Onq3fuDB4009Q1iwfFW/ZDDKQL+Sp6rSCONsoZqLRXpOm4vidcDV6
	lyyaQpGSNr/VKxTW1OkG7UdPwJC0MV7t5ykJGi2FoaW434S7eT822lj308J9oQ8TzgmZn2jJMluDs
	TRNF3crQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8a-00000005Izr-1XMy;
	Wed, 11 Nov 2026 00:24:28 +0000
Received: from mail-ot1-x346.google.com ([2607:f8b0:4864:20::346])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8V-00000005IrC-0hM4
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:26 +0000
Received: by mail-ot1-x346.google.com with SMTP id 46e09a7af769-83c2311eb1dso3874004a34.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356662; x=1794961462; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/dKUASXcgtiRNT2+c3YhFYhMVcr51Eig0y+PlMV5erc=;
        b=ESxN7l/dKX8FZh0w4r4ijA0PjsQ0x+taMmmp3kxOxi3VlKlDosZMkAogONal7HOPJu
         XFw5XNuX1Mn8BnLRTeY5EE0heska44quM9UtCbTLwanLKCHaasZjIgv3rfPWPsz/5WIq
         a0rnsq9RxhtzzaPJdijVPuzSRuR/4659a77/6ijslowxcaoObOHyZ9KPeR/MWDNi7QVo
         tEZWtyqP1JmauloCY6UwiCQgdSFn50DjpIcUUp1t00aTpFm7pskpnvBFpWrfkjmcnfTQ
         pFWWCuXUFJku1LPLA7yLFql9xDnUQppNBoL5wHr92vDphUU7UU/YefaOITBaf8Rvi+3K
         Z6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356662; x=1794961462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dKUASXcgtiRNT2+c3YhFYhMVcr51Eig0y+PlMV5erc=;
        b=eA0WRVBw9hQwnfB+IUqzH4/CtUxDvM0bag1uqBp9rtK/ta7EjwFmmlizz59OrEGxpV
         BtN2wS+gEu762LmKkr+YdATIn9QlJj7dd5NhmldNoKlkFEhNrhlBBYlBzUPA7ymPN3RB
         AJxG25WNZcBLma/CsA6QXCNFCxtICDEcyOjA78twBSK3wl8aGejDmGl8/sqlWJdFrrU5
         xeql1LGp67JfDx8yzEb0BHFh4rLqQt5gj/fBNXagc2Aj2jJViHBaj9gv2evpmk1+05cx
         8mPQmOAzF9mGXPETE3AehGm4/XI9U7DjLOeVfIJrblGqo+EboQGX3DFOkHpr4IEPAjwX
         2tTg==
X-Gm-Message-State: APuU4Z8qjJUfH7j+oUbCymFQdyQJJpHCW1yOFgnQDiAwgULDazor2zOf
	tcWoMnerXO/9HDJzCmZ+nstao52azYWcHdfz3hxn7X0OwX551v2Er/t5/wZXfKqBltCCYQrLFca
	WDikQsExUobAoNGxBOK4EJvuXaUgk7MyEHNbcz/dAIqr8Auecua6XfP4nQPm9FEiNHrFwYfJzkn
	qt/8/RruimOAweEbhYge5pJMrIqbaLVbdVVIPmnpGOc/awCWTFzhw=
X-Received: from iocou21-n2.prod.google.com ([2002:a05:6602:c315:20b0:9c7:6af8:db91])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1246:b0:53b:f634:83b2 with SMTP id 5614622812f47-56b903e2f53mr602569b6e.0.1794356661391;
 Tue, 10 Nov 2026 16:24:21 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:49 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-12-dmatlack@google.com>
Subject: [PATCH v4 11/19] mm/shmem_luo: Require permission to preserve a file
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
X-CRM114-CacheID: sfid-20261110_162423_229248_AF391D89 
X-CRM114-Status: GOOD (  21.68  )
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

Require the file to be opened for reading and the caller to have
permission to write to it in order to preserve it. Also let the owner
preserve a file that is immutable or on a read-only superblock, and
reject append-only files.

While a file is preserved, its size is frozen for all of its users:
truncating it, fallocate() and writes past its end fail with -EPERM.
Today any process with an fd for a memfd can do that, even one that was
only given a read-only fd. Requiring write permission limits this to
callers that could truncate the file themselves. A file descriptor
opened for writing isn't required, since that would rule out preserving
a running binary, which can't be opened for writing. Only the permission
of the inode is checked, so the mount doesn't need to be writable
either. The size of an immutable file or of a file on a read-only
superblock can't change anyway, so its owner may also preserve it.
Append-only files are rejected, since their writers can only append to
them, and freezing the size would stop all writes.

The retrieved file can be read, so also require the file to be opened
for reading. Otherwise a caller with a write-only fd could preserve the
file to read its contents.

Document the frozen size and the permission requirements.

Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/shmem_luo.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index dc6ede528822..bdf90aac5820 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -27,6 +27,15 @@
  * the file are preserved. All others are reset to default. The preserved
  * properties are described below.
  *
+ * Preserving a file requires it to be opened for reading and the caller to have
+ * permission to write to it, but it doesn't need to be opened for writing. The
+ * owner of a file that is immutable or on a read-only superblock may also
+ * preserve it. Append-only files can't be preserved.
+ *
+ * While a file is preserved, its size can't change and no holes can be punched
+ * into it: Truncating the file, ``fallocate()`` and writes past the end of the
+ * file fail with ``-EPERM``. This applies to all users of the file.
+ *
  * .. note::
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
  *    are also not stable and are subject to backwards incompatible changes.
@@ -255,6 +264,30 @@ static void shmem_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
+/*
+ * Preserving a file freezes its size for all of its users, and the retrieved
+ * file can be read. So require a file opened for reading, and permission to
+ * write to the file or ownership of a file whose size can't change anyway.
+ * Reject append-only files, since freezing their size would stop all writes.
+ */
+static int shmem_luo_may_preserve(struct file *file)
+{
+	const struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct inode *inode = file_inode(file);
+
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+
+	if (IS_APPEND(inode))
+		return -EPERM;
+
+	if ((sb_rdonly(inode->i_sb) || IS_IMMUTABLE(inode)) &&
+	    inode_owner_or_capable(idmap, inode))
+		return 0;
+
+	return inode_permission(idmap, inode, MAY_WRITE);
+}
+
 static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
@@ -264,6 +297,11 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	int err = 0, seals;
 
 	inode_lock(inode);
+
+	err = shmem_luo_may_preserve(args->file);
+	if (err)
+		goto err_unlock_inode;
+
 	shmem_freeze(inode, true);
 
 	/* Allocate the main serialization structure in preserved memory */
@@ -317,6 +355,7 @@ static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 	kho_unpreserve_free(ser);
 err_unlock:
 	shmem_freeze(inode, false);
+err_unlock_inode:
 	inode_unlock(inode);
 	return err;
 }
-- 
2.56.0.542.g3ef89b7020-goog


