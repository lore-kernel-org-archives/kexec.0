Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885760A2617
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dk72NntD;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tkXdJJel
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XQzlgw3emE84DnnF0oN4ahYTo145Q34I7Y43hlPChX4=; b=Dk72NntDY0+lSIrHTseJBw7W1g
	uH7WbK4dK0Mb6b90IE9t50QaSSzsWZe2+VI0VtYAsswyL5XOB95FBMZ76mIXcFqnvmhJwmWqpSooc
	K5WkzH4rq1fS0EjiOn6h5L+EWeFryG2QYCJ279kYB0SOLlW7Yy4un7VC9zJ1arnlamVzWkf+P519M
	6+EWPJmYnhWrYiP0HgwQfDhX5Xkk1+b6v02rF2aNxcR2HSImwSUEgZXiiD36BI+NgrQeKkteWXr7A
	ssaTtO75bxjXhV8Ynq2gEI1/VgeuQ95r06OGWR4Diy0B0aBoCa6IXWAkDI/Rjx2tJH6PGNcYIgdd5
	0FhVeJOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cW-0000000F5xZ-3Nll;
	Thu, 22 Oct 2026 22:50:48 +0000
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cS-0000000F5sy-428p
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 22:50:46 +0000
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so394287a91.2
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709443; x=1793314243; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQzlgw3emE84DnnF0oN4ahYTo145Q34I7Y43hlPChX4=;
        b=tkXdJJel1RedL1xg9qqI2B5DdrxAgfjcRrr2vNuZEfhhHTuH9mHOdH5h+TSpWMmvjk
         hLUEEBwsyCKtzEk5SGqLddAlx83mH+JgvdPT5Lwa3pqHTCYzbBTIYTdfCzYCwOrhfZfA
         IC1gQqZCkNkyhU+v2c52L0KSBpw1x5EfgXmVe5icHflcUJmD4/vlV1lcEMiPkyXqYcN9
         WWDwY+crKw0Cxpnepbrew2p6XIIq9A16nxJ5N6Og8YdIXj3ldhfuzaZnwG5nLOTDuYnr
         BTNOyh0RNznM6JR49nq70xaNHxhoCxeflEU08iwDfad+unHJ75LXjSOx+py9BSkN5odP
         S7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709443; x=1793314243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQzlgw3emE84DnnF0oN4ahYTo145Q34I7Y43hlPChX4=;
        b=T9ZdOAA0EDWaTWG9MV4L0i5LSz3A/nVPufIZouXjg9HamX8nAv/ydfRQwdd4/Ok4nj
         YIPfLEfJvUNCsBv8J/4qkVz8KgiXniw6esZJF2aCUuy3aUma3OZt+OoxZUkeWn8TZnYQ
         2rFtqi176kN4N2l1xLmfJLzlv52jOdc/0/hf/NHZRVn5u2HveXksS3NUXaLoXOB6eq6B
         rtr1lspLLQcg/3Lw3wZSu11OVDrYCgeSPRBSIky3Hcak5GCozpGUVfRqMpZ7+JjK5a2J
         LMVhb0nsOIJqqXCl6LgmtULdwMs9ekGFm1rY68gYc0X4t0EEtvriGXSU2klFZfgJ+5KW
         YP1g==
X-Gm-Message-State: AFq9FYII8tQrxKTo8F8Z+begsCMkxvFOQ/iGi6ee4i09FX69OvTu+HEW
	45uah6oYacxGuiF6LByeyaONAE8gbBZ2MgDL3TcNI0e+bM7NPUdMU81Ctnzutm/EOAn1ggcXkiZ
	oPpocGLxH0JHoHLn6r0MTaSOD0V7iawkx6D3T2vOsJggvoDJt+QnDVVPKTSkCmdoHnFX8+lgjFg
	Mi2FOQRL+c71Hix7av7KHHOi4lzqJi6gwBoJChO5aZKbYireCggvg=
X-Received: from pglu36.prod.google.com ([2002:a63:1424:0:b0:cd6:b233:e4aa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2785:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3adce45d4b2mr203170a91.44.1792709443059;
 Thu, 22 Oct 2026 15:50:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:31 +0000
In-Reply-To: <20261022225035.377445-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022225035.377445-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022225035.377445-7-dmatlack@google.com>
Subject: [PATCH v2 06/10] mm/shmem_luo: Don't make early retrieve failures permanent
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
X-CRM114-CacheID: sfid-20261022_155045_060428_FE4FB107 
X-CRM114-Status: GOOD (  20.32  )
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,T_SPF_HELO_TEMPERROR,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If shmem_luo_retrieve() fails before it starts restoring the folios,
mark the failure as retryable and return the error without freeing the
serialized state. Nothing has consumed the preserved state at that
point, so the retrieve can be tried again. If no retrieve succeeds,
finish() frees the preserved folios, like it does for a file that was
never retrieved.

This fixes leaking the preserved folios when one of these early steps
fails, e.g. because the file has seals that this kernel doesn't support.
The retrieve freed the serialized state but not the folios, and finish()
then skipped the file because its retrieve had failed.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/shmem_luo.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index b8d86055912d..bcac1bbb3db3 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -390,9 +390,9 @@ static void shmem_luo_finish(struct liveupdate_file_op_args *args)
 	struct shmem_luo_ser *ser;
 
 	/*
-	 * If retrieve was successful, nothing to do. If it failed, retrieve()
-	 * already cleaned up everything it could. So nothing to do there
-	 * either. Only need to clean up when retrieve was not called.
+	 * If retrieve was successful, nothing to do. If it failed permanently,
+	 * retrieve() already cleaned up everything it could. So nothing to do
+	 * there either. Only need to clean up when the file was not retrieved.
 	 */
 	if (args->retrieve_status)
 		return;
@@ -526,11 +526,16 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
+	/*
+	 * Nothing has consumed the preserved state until the folios are
+	 * restored below, so failures before that can be retried. If no
+	 * retrieve succeeds, finish() frees the preserved state.
+	 */
+	args->retryable = true;
+
 	/* Make sure the file only has seals supported by this version. */
-	if (ser->seals & ~SHMEM_LUO_ALL_SEALS) {
-		err = -EOPNOTSUPP;
-		goto free_ser;
-	}
+	if (ser->seals & ~SHMEM_LUO_ALL_SEALS)
+		return -EOPNOTSUPP;
 
 	/*
 	 * The seals are preserved. Allow sealing here so they can be added
@@ -539,8 +544,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
-		err = PTR_ERR(file);
-		goto free_ser;
+		return PTR_ERR(file);
 	}
 
 	err = memfd_add_seals(file, ser->seals);
@@ -552,17 +556,20 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	i_size_write(file_inode(file), ser->size);
 
+	/* The preserved state is consumed from here on. */
+	args->retryable = false;
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser) {
 			err = -EINVAL;
-			goto put_file;
+			goto free_ser;
 		}
 
 		err = shmem_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
 		vfree(folios_ser);
 		if (err)
-			goto put_file;
+			goto free_ser;
 	}
 
 	args->file = file;
@@ -570,10 +577,10 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 
 	return 0;
 
-put_file:
-	fput(file);
 free_ser:
 	kho_restore_free(ser);
+put_file:
+	fput(file);
 	return err;
 }
 
-- 
2.56.0.257.gf7497c7d27-goog


