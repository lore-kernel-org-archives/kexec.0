Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E69606A6BA
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hdrQmw1F;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RDJOXpco
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0U5hcBRCn7DYeLCXQ7hEVh/crdm6HmQ04G7xSZHONUs=; b=hdrQmw1Fz7FUxdW+Li2ZucDtT0
	lju1Ds/kSFdXJ1TMGXWc+yn5bYaxmpto9CdzZ8LVeilYq6WRARkKGZmPK8yRoxkCaVqeW0Fk6pFX4
	r5aw0E5tDvEgZt+NKjYGai36COyCEHchQ4v7GLhUZD8ZbkBk7fQySkNhQrQFbN4Z9xZH8kILK8Hi9
	d2J9K/UMDo4wn611dV/LHSdTm7UAlsMI0SEBt6SJ0ht6YkI6TS2kp1j3Lk6zkxfs8MnOnUzhLQ6iR
	BBAdEjQ+RC8VLruP93RdxrZ0j0UblXrySE4gAJDojSmT0OH1K0NZwJbId3oeHSnZUalBRgOCYKs9j
	zFYYCWag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddS-00000005BZh-0MMQ;
	Mon, 23 Nov 2026 23:39:46 +0000
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddN-00000005BQi-26Vc
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:42 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-5384e381fbbso3538209b6e.2
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477179; x=1796081979; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0U5hcBRCn7DYeLCXQ7hEVh/crdm6HmQ04G7xSZHONUs=;
        b=RDJOXpco+pGNQZxWvyFw/Y+McyPCtm9h/xR8Wqn9rc4+6QvtwxJRHbcIUOVlCwLHz/
         mn7etSl196REm2tYeSBq9YTy72wQlocSEd9Um6Ym68q+w1KhSCtkEGOxKrwTVpv4R+T6
         WCsAeKN7rbGqzTkoTdMYH9w65putCGpF9iOTYt2g7zDL26GaBdM9IpHsOAr+QvpRTwVS
         TwcPP9qEQOb6NaKQSLVGyUOpnW7rR54ehJt4PQkp2uCwMhlWK+KU8voAXrWMvSl8o3lX
         w5ORBrsd/1c2bj2O6lYrAnTmn4KtrNQFLMZkv2tUmGRSxSN8b6UZVMaMkIFRFsCbLzVY
         s0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477179; x=1796081979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0U5hcBRCn7DYeLCXQ7hEVh/crdm6HmQ04G7xSZHONUs=;
        b=k8mDtLgSsYf4vlbBXM1fmzoVMZx/pVDESj6OHAZToQus6gPMZc7KhQOyLG8lMchdd/
         +KBs/GkhfBzQhgNRAaCK/Njp5muSS4vEDnv2HxNQTuio67KUP4kx4EAHqrGbeKuZQ4C7
         YF4wfInBrHvjw3JGZTzGLLncGlwXtKmFerw2xoye6L7eTXak23Gia0W1bJVqN+cbX/95
         Ld6Cn1UxKge4k31fLN93LBm7noKqLTu4yvipdc2PF7uwslgdKlan+Hv7gMSeTObhULza
         wShEgS+NprDBmtfsagl5JXQQ9AKdjfcwHM4BR4vMPVc+9s/PsmK4fhIyeLoB7wxjfZRJ
         LoaQ==
X-Gm-Message-State: APuU4Z805OmYUJtJYuTRGILYx9BlI4YZjSjbs9BTB2ae0f+2iIMi2DCt
	rw4/Vw2OEd+9P/3SmzflwQ7yedg19wej70tSKa29XEq5UHTOn64VHrs9weddsVMvTUJ9adOVTWE
	v1NtHrHXSssriDXL8lFoxj7gpRc7nReVd5qi9X9k5oWGGx6u9O6frSH44cJyP9coMuzF+I9WCse
	EIrRFsVCU+odOfeGVlAYvzcJPcyBd1DoYsu3TzI66LglfP3GqczOU=
X-Received: from ioi10-n2.prod.google.com ([2002:a05:6602:c64a:20b0:9c7:7dbd:f35a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fc9:b0:573:4ad5:7e4d with SMTP id 5614622812f47-57a0ac2fa3bmr15601210b6e.35.1795477179082;
 Mon, 23 Nov 2026 15:39:39 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:12 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-8-dmatlack@google.com>
Subject: [PATCH v5 07/18] liveupdate: Add helpers to track the files that LUO manages
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
X-CRM114-CacheID: sfid-20261123_153941_559065_D1873E36 
X-CRM114-Status: GOOD (  14.16  )
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

Add luo_track_file() and luo_untrack_file(), which add a file to and
remove it from luo_preserved_files, and use them instead of open-coding
xa_insert() and xa_erase() with luo_get_id() for preserved and retrieved
files.

The next commit lets file handlers make LUO track the file they retrieve
into, which adds more users. The helpers keep the key and the -EBUSY
behavior in one place.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_file.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 0755a6478aec..d51bd75723fa 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -192,6 +192,19 @@ static unsigned long luo_get_id(struct liveupdate_file_handler *fh,
 	return fh->ops->get_id ? fh->ops->get_id(file) : (unsigned long)file;
 }
 
+/* Make LUO manage @file, or fail with -EBUSY if it already does. */
+static int luo_track_file(struct liveupdate_file_handler *fh, struct file *file)
+{
+	return xa_insert(&luo_preserved_files, luo_get_id(fh, file), file,
+			 GFP_KERNEL);
+}
+
+static void luo_untrack_file(struct liveupdate_file_handler *fh,
+			     struct file *file)
+{
+	xa_erase(&luo_preserved_files, luo_get_id(fh, file));
+}
+
 static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
 {
 	struct luo_file *iter;
@@ -312,14 +325,13 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
 	if (err)
 		goto err_module_put;
 
-	err = xa_insert(&luo_preserved_files, luo_get_id(fh, file),
-			file, GFP_KERNEL);
+	err = luo_track_file(fh, file);
 	if (err)
 		goto err_free_arg;
 
 	err = luo_flb_file_preserve(fh);
 	if (err)
-		goto err_erase_xa;
+		goto err_untrack;
 
 	luo_file = kzalloc_obj(*luo_file);
 	if (!luo_file) {
@@ -351,8 +363,8 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
 	kfree(luo_file);
 err_flb_unpreserve:
 	luo_flb_file_unpreserve(fh);
-err_erase_xa:
-	xa_erase(&luo_preserved_files, luo_get_id(fh, file));
+err_untrack:
+	luo_untrack_file(fh, file);
 err_free_arg:
 	kfree(args.arg);
 err_module_put:
@@ -401,8 +413,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
-		xa_erase(&luo_preserved_files,
-			 luo_get_id(luo_file->fh, luo_file->file));
+		luo_untrack_file(luo_file->fh, luo_file->file);
 		module_put(luo_file->fh->ops->owner);
 
 		list_del(&luo_file->list);
@@ -675,9 +686,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		return err;
 	}
 
-	err = xa_insert(&luo_preserved_files,
-			luo_get_id(luo_file->fh, args.file), args.file,
-			GFP_KERNEL);
+	err = luo_track_file(luo_file->fh, args.file);
 	if (err) {
 		/* A retrieved file is new, so it can't be tracked already. */
 		WARN_ON_ONCE(err == -EBUSY);
@@ -796,8 +805,7 @@ int luo_file_finish(struct luo_file_set *file_set)
 
 		/* Only a successfully retrieved file was tracked. */
 		if (luo_file->retrieve_status > 0)
-			xa_erase(&luo_preserved_files,
-				 luo_get_id(luo_file->fh, luo_file->file));
+			luo_untrack_file(luo_file->fh, luo_file->file);
 		if (luo_file->file)
 			fput(luo_file->file);
 		module_put(luo_file->fh->ops->owner);
-- 
2.56.1.809.ga0b61035b5-goog


