Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB5606AAA4
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZOXtWvX8;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U0eLOF0D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oDGpajhrmdSjBCrv+9z48USF9DLlcre7dauJ37omj8M=; b=ZOXtWvX8pMQL9EJBWlE3OgE+Zc
	6Dn/MOqwSsXaSDD2+TTEvYWvfKLJO7OAC69XFPeDiiOXMHMnkko5qK2QRX7wMOXHvq6nV0qCRsLql
	NOYrOIx5ToGZGefa+xshAke3y82DYFf86ASOHkVoF2uUlAct4aQ53gOXDPolMgU6D7aI/6AI1K5L9
	/xHgsijpsf2mlkpcFLDofY1XbJRkShcdWZkWY9hKH6aIvtlFtXw2FRsx7GDP3lo6t2vIqWItxtW8m
	mvCs7mRVbUVLhggDT/HwcixJ10F9S+6opFZuI/jN5UwKHzMaGBett12VQV7HVwiuCXXb1ThVu+dnE
	jTm/3avw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8e-00000005J6t-2Fbk;
	Wed, 11 Nov 2026 00:24:32 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8U-00000005IpC-1vPa
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:26 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-567ac848d83so3147194b6e.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356660; x=1794961460; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDGpajhrmdSjBCrv+9z48USF9DLlcre7dauJ37omj8M=;
        b=U0eLOF0DssXD8ssOPqkF4kHKp9krYTgPQe0SgdxhrRUE+KnUwdDdDihuQIlTl1ZAWj
         9rTWNlAfTAWxXqqf5qrpzeE+P//fzw57owNV0a+4dFeL4NMu/0YoHykkltf6nARCIoLN
         v485xLiCRsedT6yxhJRl3CGbuId6DaKOx1j7h9UJrb2aEkwUAlP/6zRc6+Tw8eXiDn7t
         CZ79IcPuyxYgUtXxM24GRrirpwLxik0cLl4ft4vfUPmomMn0Dp8TjWc7ZQx6hqfqt1me
         RTeK+peIsotIBM+ujqse27ToDU9krYq7Pcx38cxeH1VQC1Sbtgl5IjT/uebThZG9KHIF
         OqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356660; x=1794961460;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDGpajhrmdSjBCrv+9z48USF9DLlcre7dauJ37omj8M=;
        b=YbaeXpSyu231JCBVVvHTt4qoqQgBaMX/qape3XDhAuKjd9dSt4PkB10x6PcbTlgO0D
         96JyeXhpV3HFc+cEgcKjfg1alKxvnUefDghMQubriaQqgzB8NZaXEt3lbESuyuTplptM
         2l9rsvh1LGh2CE3P0oKhIBcaGmugWwb4EDeHbhvIdb0V+0AhJaEWNzLQ4bb3Zi7Gri4j
         OMRh+PdZUa1aitmNZ2/tKlbuMoGJwy5yuaLfwVtNfo8YGxb5USpGg739Ohd6CzsmaNTI
         7BtQ1GUkS5jgcqDJ/sWMBgA3vwrMDqMGGRsNtgJzHXtwNcdd6/81FLbtmYg6o1vETb63
         sYeA==
X-Gm-Message-State: APuU4Z8/KeNZoocmDH3b5OiF7aEDJBXoM/Ipuxok4blIfvbxnqhRB1jG
	7P3Do2X5bdA2Vyr7WcopZHaGSBzJ30CsaZMcUbHR2rIyecSn+00GqzBzWZy/iFRj8CwYyTnxFQQ
	JTGqiG/TUaKv5J8frzgqX9FvxfuLeOAVdfah+CJlZgdcg33k4nndUxSQkfpuqqoaHQB16RxtzXE
	1Z/kG8hq1qT5nGJK7hcM9vmCWaGLUKelJW/T2L9ZZfIBO3ONY8SMQ=
X-Received: from iobgl21.prod.google.com ([2002:a05:6602:4f15:b0:9c7:70d7:1521])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1581:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-56b98727e41mr556110b6e.58.1794356660168;
 Tue, 10 Nov 2026 16:24:20 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:48 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-11-dmatlack@google.com>
Subject: [PATCH v4 10/19] mm/shmem_luo: Don't make early retrieve failures permanent
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
X-CRM114-CacheID: sfid-20261110_162422_516627_483B8627 
X-CRM114-Status: GOOD (  14.07  )
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
help, so keep that failure permanent, so that every later retrieve
returns the same error.

Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/shmem_luo.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index b48d7f460493..dc6ede528822 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -552,6 +552,14 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (ser->seals & ~SHMEM_LUO_ALL_SEALS)
 		return -EOPNOTSUPP;
 
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
@@ -571,6 +579,9 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	i_size_write(file_inode(file), ser->size);
 
+	/* The preserved state is consumed from here on. */
+	args->retryable = false;
+
 	err = shmem_luo_restore_folios(file, ser);
 	if (err)
 		goto put_file;
-- 
2.56.0.542.g3ef89b7020-goog


