Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B160A261F
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YYnKqElw;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k0fjca5N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bPv+WMWcyhJBfMpWVwqvVEabR827fX5uGDPeWoliS18=; b=YYnKqElwhXtk+rMam0hX8zeYs7
	Lj3fweZ8TM2M1yeXuU0BNc9DaJkdsPygGUm8ras6ovFCgL+Klb3+fBHVvr6h7wKvTu+RTYSXL/nDj
	SJeo7SPBjjIbgyS3n0AXplFx8uGY3FXvHWPEL5WBP0JRxCp5eH2EGwyQIrfdXrBO9uIUk/XySA2Wo
	P9wVMgoSCsqkjytfGmPmpQZmrpIhPrPgD+CZuErniJpkYLNwYNqMcUe2Z+QHgGXqmTR/l0a3ks5JG
	rx5fbUOzgqhnV6G5T3kpQcgNShdIqedNeo3D0eKdK27bBRA79nqKvgAwqZ5TumPBSkmrXYVSbpPcW
	EAfiB/fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8W-00000005Ius-3EIL;
	Wed, 11 Nov 2026 00:24:24 +0000
Received: from mail-ot1-x347.google.com ([2607:f8b0:4864:20::347])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8Q-00000005Ik4-1v90
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:22 +0000
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-84c4dce8182so3553197a34.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356657; x=1794961457; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPv+WMWcyhJBfMpWVwqvVEabR827fX5uGDPeWoliS18=;
        b=k0fjca5NPcmFp2PiWu2+6KXLDG90sEpp7rNASOw8gKtwY4Kv/v2BzoKXqdm97KkSNK
         fmtEqKuyFbg/eM4vzDMlvIpqvYfSZkqKRMFTQifLadPBGpY1ii+V2nzGellYLs889Dm+
         M1xSStSy3BwbDhR+EpOiBkP3i6vgWthw++3Z8TCBfsV+G1kdcplthiV6ZAjlInte/UDu
         SMiFcjS/sIRFCL5du6zhhgxGM6QmKmQuphKZdLBH9PUe7w+8aupy1mH2DnKjQsSbmRIp
         Eh+P2lwpMHYQcou8a5WanWrPK+szdWxVRct1hn+jLNQszifR4SSDO4nvlGSxBEuD/8RG
         aQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356657; x=1794961457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPv+WMWcyhJBfMpWVwqvVEabR827fX5uGDPeWoliS18=;
        b=oCRClbAvINSBR5pGmXup+8azG8M7iRRo1Uj8hA+O5xqwtG0cvk5Ri3ZX9IH5ChU0xw
         PILbaWpN+QIeJg7bnWpbBgcBWMdnEzFFwdooSS0kBM83njwz/17Qolk5CePPmUHWNEjl
         pFKZr5QSWTe3tX6F4hbOhO8kXtChgZU667DkADcny99ZbwpSLogMxUZx7q6Vw3WtYI3i
         fjTxihdtP//Kps7bXdRs1+COEKQTLCgmTA3nHTT9k0RCht6g5Q+/nSO1XlvgBnJ/DxOs
         /HA28kRfN+Hs58cC08YLeczCTTJBGWIxzpelTnJ/HiVBXoKAmjtghUjjbIJpBLP2AVtC
         QN1Q==
X-Gm-Message-State: APuU4Z9S20n0ohbyW7vTqiauP/aTT85tMEUgdkTzJwkR8ZB1Bz2vs6KL
	AkvAmxDvau4oWlCJhPjqRqbSj32Jscnq+eRGTe0w5OuRzwtkvb7s7Uw7NlDdtkuiSaPTIiT17eF
	71DNxI5lRMl4w+17t4B9A64387zXaXJKncE3gRZcQy2sLh0A440yer/nnLTTtYtEuc9h1IK+az2
	vZhwzLslByym/2rP7KAGPn5N579pJXL0Q2qNYn5Uaq+FaXagNx0js=
X-Received: from iocow25-n1.prod.google.com ([2002:a05:6602:c5d9:10b0:9cb:8099:40ad])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:e88:b0:4e6:db9c:9a7c with SMTP id 5614622812f47-56b9891f794mr602405b6e.63.1794356656227;
 Tue, 10 Nov 2026 16:24:16 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:45 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-8-dmatlack@google.com>
Subject: [PATCH v4 07/19] liveupdate: Add helpers to track the files that LUO manages
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
X-CRM114-CacheID: sfid-20261110_162418_512108_F9477CBF 
X-CRM114-Status: GOOD (  13.68  )
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
index e5d333649f76..91a2b74f71cb 100644
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
@@ -306,14 +319,13 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
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
@@ -345,8 +357,8 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
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
@@ -395,8 +407,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
-		xa_erase(&luo_preserved_files,
-			 luo_get_id(luo_file->fh, luo_file->file));
+		luo_untrack_file(luo_file->fh, luo_file->file);
 		module_put(luo_file->fh->ops->owner);
 
 		list_del(&luo_file->list);
@@ -668,9 +679,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		return err;
 	}
 
-	err = xa_insert(&luo_preserved_files,
-			luo_get_id(luo_file->fh, args.file), args.file,
-			GFP_KERNEL);
+	err = luo_track_file(luo_file->fh, args.file);
 	if (err) {
 		/* A retrieved file is new, so it can't be tracked already. */
 		WARN_ON_ONCE(err == -EBUSY);
@@ -788,8 +797,7 @@ int luo_file_finish(struct luo_file_set *file_set)
 		luo_file_finish_one(file_set, luo_file);
 
 		if (luo_file->file) {
-			xa_erase(&luo_preserved_files,
-				 luo_get_id(luo_file->fh, luo_file->file));
+			luo_untrack_file(luo_file->fh, luo_file->file);
 			fput(luo_file->file);
 		}
 		module_put(luo_file->fh->ops->owner);
-- 
2.56.0.542.g3ef89b7020-goog


