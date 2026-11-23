Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F0606A698
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WR3uxeri;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DdEgakSz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/ZHoT97tqf5Dj8g+JDW8nW3DDYyt8I058/DSNhpOZoc=; b=WR3uxeribFjzdyIuGGh3jcgEkm
	4GvF7huKXxGgczrrwVzuvDHFUtHxFHbyaXA3XakPO9v4dX6TIJReki9VAWatT3JctfDIpBPzVbKH5
	+kjH6FVItdYdmouY1XYy5pQUN4+PnuZSPu2mIuidIw5/bBGevS9o9vOHIhzuao9qfPXI1cycySCgQ
	Wl9tGsolkEixwYsVjc9GUUhoJJ5i16TN9Sxk1/R2GZNZzx0k+IcwBfsdNX82QCTWRCqhLPtND69Sv
	ZXRAyuzY33YHZ92t+JEjSudXUduI6/FBQ3CQ075WOqIGiuBGlhzIMAF35cStvquA8FaalX0idxXyn
	mnoaIprg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddR-00000005BYJ-2hmp;
	Mon, 23 Nov 2026 23:39:45 +0000
Received: from mail-oa1-x47.google.com ([2001:4860:4864:20::47])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddM-00000005BOv-3vHX
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:42 +0000
Received: by mail-oa1-x47.google.com with SMTP id 586e51a60fabf-45e6091d8a1so2897937fac.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477177; x=1796081977; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZHoT97tqf5Dj8g+JDW8nW3DDYyt8I058/DSNhpOZoc=;
        b=DdEgakSz3DQyXWbkqfvx8nqa4aQdnU/9NYbakFaXPUAc0Us4yLmmyewWrA3q+InDw5
         4twsVTGHyBLznqEzq8H0YUJzw9vq082w7QzG5KPLlbUslRIulnIWi3B8oQXoF1m8+lD1
         uXWraX+0H6qkzQDvNKBq5oLDdH0l08BmP3IIHwZubaF7w9QiiQxogigTKKWRxvTe7s5k
         DfL0Jkp5QhvhIq0QI+XzoczCNUdUwgmap7Z8DQ+r10xxitHYl8XtL3oUKbSkdXfystYr
         CY0ky45jQcOZXjC6ohH6oelWL6M9HISqY+lfWK85ReM7cs03Q0wJTB8pJOvTg2FhCD6y
         bvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477177; x=1796081977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZHoT97tqf5Dj8g+JDW8nW3DDYyt8I058/DSNhpOZoc=;
        b=M7yYAuT0qFaLRc0cGz5Dmj56eFJP1sc8Aw755y+bKlftFE+ptE+soLjmHRLpP+w3x5
         W39Uzrr+yQ5ux/CeGanRPgy4QL0n1CQ8zOBWNkAKkwWxt7Ju7YoeYD3vkTpR77lNfKbe
         gFeMpms0qxH+arFqrte6Uw9fd4yeUVBm6qq4gv28qX66O5+MWfojvNAwu6KiFueYFOlF
         jKowVqKRc43aU1jY+VbNI/wSx6MRjgmFy9T63OksYacpzO8hU3ayp7jlgc2Z9BoZA0CH
         nYJU5NBpf1gpI5jX6Rag8+duRO+N9AuLsAxpX8DAp9q5+zw8/sZX6+Rf3ncAul7aiQ74
         WMVA==
X-Gm-Message-State: APuU4Z+pbSi3nzWvSd/U7pixr/Iy4xk7zVnTQ1W5cdDkhvnjdlWjt0nN
	T/VCpoZUbjZ9rUm0A3oFwy621w/pCTmQGlUGhbDWT8px9590F7feTUDhXpRhR+1PtQGptw7q1FU
	ik3ZdTqRyUBah6Q8nGvvd7fhfqXhdpaHES+BhmAm4q5C5VLwjlHUVr3HOtoKet2dW4DHRafs2w0
	QrtdBxAOb9zcOtRaJ7FgK5vIkyrtwik9F2d96sMak3kpdPswaAcGI=
X-Received: from ioi24-n1.prod.google.com ([2002:a05:6602:c658:10b0:9d3:b408:7991])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2381:b0:50a:7162:87df with SMTP id 5614622812f47-57a06b2491amr12786319b6e.2.1795477176976;
 Mon, 23 Nov 2026 15:39:36 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:11 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-7-dmatlack@google.com>
Subject: [PATCH v5 06/18] liveupdate: Don't WARN if tracking a retrieved file fails
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
X-CRM114-CacheID: sfid-20261123_153941_101983_E944568F 
X-CRM114-Status: GOOD (  18.81  )
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
resources are not released before the file set is finished. When
finishing the file set, only erase successfully retrieved files from
luo_preserved_files, so that the id of a file that was never added
doesn't erase the entry of another file.

Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/luo_file.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 9d98438b0166..0755a6478aec 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -675,14 +675,28 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
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
 
@@ -780,11 +794,12 @@ int luo_file_finish(struct luo_file_set *file_set)
 
 		luo_file_finish_one(file_set, luo_file);
 
-		if (luo_file->file) {
+		/* Only a successfully retrieved file was tracked. */
+		if (luo_file->retrieve_status > 0)
 			xa_erase(&luo_preserved_files,
 				 luo_get_id(luo_file->fh, luo_file->file));
+		if (luo_file->file)
 			fput(luo_file->file);
-		}
 		module_put(luo_file->fh->ops->owner);
 		list_del(&luo_file->list);
 		file_set->count--;
-- 
2.56.1.809.ga0b61035b5-goog


