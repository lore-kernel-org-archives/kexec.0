Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA4606A326
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xTDX9Z1e;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J1CWrN+N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cNS9XkUpb0odYgcS4hw74G9m0QCGpHkW7/U/VrcLoMQ=; b=xTDX9Z1evepCHbyhtR4NdvHcnm
	+Kl6EfeOvEZDqarB8YraWdVaeylxJUR7qEQ5MDJmJWkr5sTBDNY7cXT+pgdVuQ4ozz7mC0uxRVIdj
	Bevwbe4KSfSLoE06VtUP4EPADHyE97cWqrCUzauJU/U+zw7YBmrgyj5/ewblseTCozVd1syIQTB6A
	+GpFLR4NmytDB8ZGKUtb4GnHQexv+ei8qtyrJhUsh+GSIaZA5JQ4ATAxejoXuZoG6QP8oanAE27Jv
	koWKx5dF0kJQShrg9PPwtl+4TLRqQ4ReH1TZ+UJmLFatooO+LOzX6eWnAs5cjcIDWKQRUfYEWC+BR
	afR6nIpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v5-00000000mE9-1QJN;
	Tue, 03 Nov 2026 01:02:35 +0000
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v2-00000000m9S-1Vw5
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 01:02:33 +0000
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso2869391a91.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667750; x=1794272550; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNS9XkUpb0odYgcS4hw74G9m0QCGpHkW7/U/VrcLoMQ=;
        b=J1CWrN+NKEXiy75GxvLDocXC3Schsz6EgCMAEsDF7w7metiTe7hgZjpuGZuu7x9Vmc
         C03nEy/SabW1PQ6uOLcjYVjIK8neWN7MU5hxBhJcJIn2GEQ9kKAi7MW3BMmpIqomx2mE
         zgW0qKgheJzg5OoJ9WUmkD38yvVcNnQPozuJgy+CMRRs0sA+6CQ9MKxVMeAKlNY5Qd5o
         2v1RlY1+B58x0MMRHCUOvfrfJW8vJBkVg14nBc0cq/93KWPxqMEy8+ZQYyLc9ILXm3SD
         ZdhqoJ2J2bNTCcOx8xcNeLy98qEK/tJs1E8u5WAg89jUocCvrrf7H0Mz7g/8+vY8uLri
         qGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667750; x=1794272550;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cNS9XkUpb0odYgcS4hw74G9m0QCGpHkW7/U/VrcLoMQ=;
        b=thbEJbO/diBIYaeTjDSskX7Cvl+DN/7QkcEW5845izsbQJ1TR3hs6U2R/rgMjSyMuF
         nrKZv4yWalpY679jWhQ4QIF4im7QMexgwdwhvNCpvoCOk+SL8hyswQbCicgq8pUDHiSP
         vELhwfTVNHuWAV2ykHA+zGoX1LFIyh2mR2OZtY4KljBDCYICiYUsFspXlscXiG1VMBcR
         oGse0rvK8rE6plHeEHHpBOW8KQgdiJyIE8erQNbj3L3PSUAmUXP/CnLo8Yb+OIH8TMur
         jSvTDlEEXgVqTPm3hP12EFAaSGhQgZCL7yGIdW7UVP1352WxZfxTnNU6fNhKph1kEFvE
         xfMw==
X-Gm-Message-State: APuU4Z/7tr6UuGdTUA5pzxtyLzmsKGf2rsb1MAMzzNaZSPUi5aNv8hcN
	6Q3Rjrd1SlkJJ/5ulHA8PNma3hSwTI08KEXhnhY+PEFr61mVXk7y/Xw9o3Ag8xZk6j1qggzj8Xj
	+qXiUbq0ApBIdG0yyVVWSP9B1NJNmE868GNnxdFLDjTE7P7zXgusfgy4XIxuEEghKDOX0Kb2apt
	IKVYdQ9J85ZwSoRHUDPldww8Hndi/h+s7g+y9vn6JaDc8NCHyjHhU=
X-Received: from pjbgd1.prod.google.com ([2002:a17:90b:fc1:b0:3ad:5136:109b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b11:b0:3ad:4bfc:1e77 with SMTP id 98e67ed59e1d1-3ae897dd40fmr9335117a91.66.1793667749818;
 Mon, 02 Nov 2026 17:02:29 -0800 (PST)
Date: Tue,  3 Nov 2026 01:02:12 +0000
In-Reply-To: <20261103010216.3447716-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103010216.3447716-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103010216.3447716-7-dmatlack@google.com>
Subject: [PATCH v3 06/10] mm/shmem_luo: Don't make early retrieve failures permanent
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
X-CRM114-CacheID: sfid-20261102_170232_428563_EDE6DA55 
X-CRM114-Status: GOOD (  20.37  )
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
folios as retryable, and return the error without freeing the serialized
state. If no retrieve succeeds, finish() frees the preserved folios,
like it does for a file that was never retrieved.

Nothing has consumed the preserved state before the folios are
restored, so the retrieve can be tried again.

This also fixes leaking the preserved folios when one of these early
steps fails, e.g. because the file has seals that this kernel doesn't
support. The retrieve freed the serialized state but not the folios, and
finish() then skipped the file because its retrieve had failed. There is
no Fixes tag, since the fix relies on args->retryable, which was only
added earlier in this series.

Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
2.56.0.385.gac671c819a-goog


