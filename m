Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB360A261E
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YWS4g+iZ;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OUFNZrBw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wY3MtbwEI65ANl7uiD47g3ph74JfuhEnWdITM5snLF0=; b=YWS4g+iZjNSIq22vTx21ahIJzh
	x/+WjHuk1FGZ4DrfsX7LWY7BDiEsY/tvCT4Og+cYTTD9/SqdYkp6uzj3bahIXLgyu1nOfZwWcDwz8
	F3QfhlYOG++sTpW9AkDMk3DgP8PQZ/Otyd3b9POGGaFWuzvv9w6V4vRZM6zuosjEdb3jabLfdolOH
	yaoX6b7C7Dsjn/ogRlErNs3d1vnUPhQI+qX8zuG1snWqZv2yRdg6kAX0wEtOr7t4iXpRn4aOTbqmR
	THwRwqNw4l0q6Ls0hXa1McORgmzHKzcaF53sr13ab1CLCBU7Ufq4SreLkAW0kN5MatxoJWJ8c7Bcx
	7+j52sHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8W-00000005Iu3-29sw;
	Wed, 11 Nov 2026 00:24:24 +0000
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8P-00000005Iit-06Tl
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:20 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4fb73e868aaso3640421b6e.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356655; x=1794961455; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wY3MtbwEI65ANl7uiD47g3ph74JfuhEnWdITM5snLF0=;
        b=OUFNZrBw5jAuzk2Sa7PwVvScyW549ff5u3sFIbPc9S785gbfMfmC7kitiqUFtEFyMl
         CrqU2pS5maG/kr0ZlQ2uQ3DrWn5JybNBma7BbMOyqP4POcSOwL+Y6H8UjjbTfYBzsCtR
         wgtQKCTxc8XHqj0kFDoJYKFKitMl3Q0jhcn6SAXdTjzeWmdu3ZAEC/jtFkfgGB8sLKym
         W6A+dLB+xSsmQevp/Ls21hQ5zczGqqNbs00UEWxq0hFjz93jc5bDCBfXbjtdwmeGgo10
         m5MGCmm95YL2BYqwxcohjN3aYlqN+wBaXCiaWElvHyI/BAeQNWnKh2f9WHWifLZbdNd9
         ahOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356655; x=1794961455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wY3MtbwEI65ANl7uiD47g3ph74JfuhEnWdITM5snLF0=;
        b=0bH8maLFaaYisEPUj1cDHfXf1R8HfFtd7ds4OUkNKzPqAR7/MZkd3HWIIOJrY3U/Pv
         KG0UzUQ755EabXzmNpZPgKL4aaSj5clxzaFrivCtgtn8D6LGec3uxsOkqeYJvujzWM8I
         Gy2vJYeBOoCABMVbbZILsKeHREgLICeDvdIdw8qshbanxZkaKMFt705H5PhWLrxU2ZQD
         wCWALs1lEvDZWzGv090KW+w60DpChj9aMoqyOGQP63SoiTLQ1TD/yZR9cJkdX9WNIzl1
         0oTY68QH+YBSuaIBa96/O4ERHNF+IhyC2iy93NozKRd+zXv1bpH6WT3GVcbFexT5qPSi
         fIFw==
X-Gm-Message-State: APuU4Z+AX5kfqV+wGb7IX1SJ2O3W2bpb12j3snhpreYeWCmgI36z+kMu
	aBNV/pmGcJTo4OJaB+zOBNUp+LkYF4atlu8pr1Jig00dcvLRR2XWgYNcvoUhy7ubJK7zjrPDJwy
	ioZKl4hQyWF6nVFPOVYPdhiEQF8aFOrJnyy1Ao/KmjI2PlzwqLWSVdmu93gTKQgAd6rMup75lz+
	IJjOPJUzJofgVM+5XdXgmywcQ9mIJ7q7QA2pr+nBgY1Kk+sH9ON7E=
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:523:5388:be99])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4443:b0:4cb:f21b:6f91 with SMTP id 5614622812f47-56b9771429emr677558b6e.36.1794356655005;
 Tue, 10 Nov 2026 16:24:15 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:44 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-7-dmatlack@google.com>
Subject: [PATCH v4 06/19] liveupdate: Don't WARN if tracking a retrieved file fails
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
X-CRM114-CacheID: sfid-20261110_162417_073858_CEC30A6B 
X-CRM114-Status: GOOD (  18.31  )
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

Handle a failure to add a retrieved file to luo_preserved_files instead
of triggering a WARN_ON(). Make the failure permanent, and keep the file
until the file set is finished, like any other retrieved file. Only warn
if the file is already tracked (-EBUSY), which would be a kernel bug,
since a retrieved file is always a new file.

xa_insert() can fail with -ENOMEM, and userspace can trigger that with
LIVEUPDATE_SESSION_RETRIEVE_FD, so warning about it lets userspace crash
systems with panic_on_warn.

The handler has already consumed the preserved state when this happens,
so the retrieve can't be retried. Keeping the file ensures that its
resources are not released before the file set is finished. Finishing
the file set then erases the file from luo_preserved_files, which does
nothing for a file that was never added.

Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 0c9a3b6921d1..e5d333649f76 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -668,14 +668,28 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		return err;
 	}
 
+	err = xa_insert(&luo_preserved_files,
+			luo_get_id(luo_file->fh, args.file), args.file,
+			GFP_KERNEL);
+	if (err) {
+		/* A retrieved file is new, so it can't be tracked already. */
+		WARN_ON_ONCE(err == -EBUSY);
+
+		/*
+		 * The handler has consumed the preserved state, so the retrieve
+		 * can't be retried. Keep the file until the file set is
+		 * finished, so that its resources are released at the same
+		 * time as those of other retrieved files.
+		 */
+		luo_file->file = args.file;
+		luo_file->retrieve_status = err;
+		return err;
+	}
+
 	luo_file->file = args.file;
 	/* Get reference so we can keep this file in LUO until finish */
 	get_file(luo_file->file);
 
-	WARN_ON(xa_insert(&luo_preserved_files,
-			  luo_get_id(luo_file->fh, luo_file->file),
-			  luo_file->file, GFP_KERNEL));
-
 	*filep = luo_file->file;
 	luo_file->retrieve_status = 1;
 
-- 
2.56.0.542.g3ef89b7020-goog


