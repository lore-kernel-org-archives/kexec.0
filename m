Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33860700A6
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P975wdzP;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mhNBSAnJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vbpaElakptIh2hFwmXWUs/sq4k+QmnD2y26Qhgoo1AI=; b=P975wdzPTizU3j9wus62bk031O
	2iiY4MjDgE26ELCTeWO4Mh6V2az86agYlfYqhFHbTw44jJIeh6wDZNA4O4NhhNtW8UJr4XhyRE70N
	dO/yG8EXoc2TeFKhNeYScCH7ONGxbr1TPY9YRkTTn6gooDa5rMlPYHhn8XU2Hw28FTfLL6PqFrWSU
	HX/Hpr0UwBhW4WfTKsbLfV56UbhrBFrCPNWYXiR1H4Wc9Ian9Owej8P/6W2B/Sv9Ttzs58zJXXfRa
	kx7r1P+AloPjGTRSINHHAWvs+g3NdB/Eb5hGYbSJDqPaHkJYZzcxfDWOxLghbNzTKwGKj2fcH3j01
	OaXlOz6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8a-00000005IzC-0Yr9;
	Wed, 11 Nov 2026 00:24:28 +0000
Received: from mail-ot1-x347.google.com ([2607:f8b0:4864:20::347])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8S-00000005InR-2Tei
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:25 +0000
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-82315dbce25so1739116a34.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356659; x=1794961459; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbpaElakptIh2hFwmXWUs/sq4k+QmnD2y26Qhgoo1AI=;
        b=mhNBSAnJvbYaMLTEipLr6fQ+DLYFGrTyGE9ZOqZnM8sCGqBCMYWWV+yeNItjRnSfwX
         i18kWp1B9DybQX7jdOwCpEEwPzce1W7QZOHt2HjDrJJ+DJyLx3HrdSy+ATbSGJNUrGQK
         HraI7WDvju4TDZthjhj5MW3SMBMwKY9dvAJeDVyPd7iwDgiYe3GT6Yt2I9aq/w6H3Mwv
         HrtKTYgnP8SqEwblx3OM0fy5IvA5/PxT1giK5AOIkVuu0++phLIX+JPFngxkg21gwYce
         Q1mSKh60zw0GSy383FEDxVFDsGi2qZIjGUwRUILS11TClIS8hJOznJ+L4VAcFENZV7W4
         Qq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356659; x=1794961459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbpaElakptIh2hFwmXWUs/sq4k+QmnD2y26Qhgoo1AI=;
        b=gandjrWTbTFC0D4CHHMZq6+7Eav2PyD/Lj6XJW+h+sVrDHCBBMI8zpRRMgDJcjBBJc
         HZE4+oWrqcb8VpCZhjFBR6IH8MqjTxeYfAmm2VNq7xs66ZI3PboKthByix7CU1UIwut7
         GTKDsUW/93vLRg41/Ny6EW/tYnHtLuyCAt4GOnL+1QKaoGCXVqqvE8T+mXKK4DH4maln
         tuUYLSrMofAuksAk+proxUSIoH4CNSsvDkOGzcmASDlAlOhtT/1HGiFj1yMgKmdM7utZ
         xbPlGc8P2c4Tdud38BtM+58kaWBFbpbUTBTYKxCTAhS2DJcaT/JfAGqOejayLBAommUs
         Zfew==
X-Gm-Message-State: APuU4Z+P4F1Kewk6Y1+UU9JnQxUuc/i4xurHc8jgVoopT4rjSoc22sZa
	df18L+saSJvNPfN0bQkMjqmZAjdsJWhws+PG7SaLOIf1MXwN6NDdm+sArigKBC0yCgxHIae6xpV
	gFlRCJK3dQgb7KWRJn5wCIbCIFZIGJ0rYp0034xOwGhiyFoM1ceDUwmmu8MqhmhN9sbngMdqJKV
	LkWnZrFK5t2spNPNTjMOz90HDp6Y0gaAdEnFHfuilo3dZiBHpgIFA=
X-Received: from ilben19-n1.prod.google.com ([2002:a05:6e02:5113:10b0:524:c21c:a8de])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:19a8:b0:539:596f:6623 with SMTP id 5614622812f47-56b98228b8bmr731061b6e.64.1794356659004;
 Tue, 10 Nov 2026 16:24:19 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:47 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-10-dmatlack@google.com>
Subject: [PATCH v4 09/19] mm/shmem_luo: Leave freeing the preserved state to finish()
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
X-CRM114-CacheID: sfid-20261110_162420_675215_EE905FEB 
X-CRM114-Status: GOOD (  21.32  )
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

Don't free the serialized state in shmem_luo_retrieve(), whether the
retrieve succeeds or fails, and let finish() free whatever is left of
the preserved state of every file. Once retrieve() has restored the
folios, it sets nr_folios in the serialized state to 0, so that
finish() only frees the rest.

This fixes leaking the preserved folios when the retrieve fails before
it restores them, e.g. because the file has seals that this kernel
doesn't support, or because memfd_alloc_file() fails. The retrieve freed
the serialized state but not the folios, and finish() then skipped the
file because its retrieve had failed, so the folios were never freed.

Preserved folios may also be in use until the session is finished, e.g.
by a device that was preserved with DMA mappings of them, so they must
not be freed before finish().

Fixes: f85b1c6af5bc ("liveupdate: luo_file: remember retrieve() status")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/shmem_luo.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index e747a0442295..b48d7f460493 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -390,13 +390,10 @@ static void shmem_luo_finish(struct liveupdate_file_op_args *args)
 	struct shmem_luo_ser *ser;
 
 	/*
-	 * If retrieve was successful, nothing to do. If it failed, retrieve()
-	 * already cleaned up everything it could. So nothing to do there
-	 * either. Only need to clean up when retrieve was not called.
+	 * Preserved folios may be in use until the session is finished, so
+	 * retrieve() leaves freeing the preserved state to finish(), whether it
+	 * succeeds or not.
 	 */
-	if (args->retrieve_status)
-		return;
-
 	ser = phys_to_virt(args->serialized_data);
 	if (!ser)
 		return;
@@ -515,9 +512,34 @@ static int shmem_luo_retrieve_folios(struct file *file,
 	return err;
 }
 
-static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
+/*
+ * Restore the preserved folios into @file. This consumes them even if it fails,
+ * since they are then either in @file or freed, so make sure finish() doesn't
+ * free them again.
+ */
+static int shmem_luo_restore_folios(struct file *file,
+				    struct shmem_luo_ser *ser)
 {
 	struct shmem_luo_folio_ser *folios_ser;
+	u64 nr_folios = ser->nr_folios;
+	int err;
+
+	if (!nr_folios)
+		return 0;
+
+	ser->nr_folios = 0;
+
+	folios_ser = kho_restore_vmalloc(&ser->folios);
+	if (!folios_ser)
+		return -EINVAL;
+
+	err = shmem_luo_retrieve_folios(file, folios_ser, nr_folios);
+	vfree(folios_ser);
+	return err;
+}
+
+static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
+{
 	struct shmem_luo_ser *ser;
 	struct file *file;
 	int err;
@@ -527,10 +549,8 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 		return -EINVAL;
 
 	/* Make sure the file only has seals supported by this version. */
-	if (ser->seals & ~SHMEM_LUO_ALL_SEALS) {
-		err = -EOPNOTSUPP;
-		goto free_ser;
-	}
+	if (ser->seals & ~SHMEM_LUO_ALL_SEALS)
+		return -EOPNOTSUPP;
 
 	/*
 	 * The seals are preserved. Allow sealing here so they can be added
@@ -539,8 +559,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
-		err = PTR_ERR(file);
-		goto free_ser;
+		return PTR_ERR(file);
 	}
 
 	err = memfd_add_seals(file, ser->seals);
@@ -552,28 +571,15 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	i_size_write(file_inode(file), ser->size);
 
-	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
-		if (!folios_ser) {
-			err = -EINVAL;
-			goto put_file;
-		}
-
-		err = shmem_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
-		vfree(folios_ser);
-		if (err)
-			goto put_file;
-	}
+	err = shmem_luo_restore_folios(file, ser);
+	if (err)
+		goto put_file;
 
 	args->file = file;
-	kho_restore_free(ser);
-
 	return 0;
 
 put_file:
 	fput(file);
-free_ser:
-	kho_restore_free(ser);
 	return err;
 }
 
-- 
2.56.0.542.g3ef89b7020-goog


