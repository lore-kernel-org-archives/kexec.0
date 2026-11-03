Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BD606EEA1
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dg+4zI52;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eD4ta0i3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Pqlok/L90zyySLepqQOJQncJ0sDMJpbHVdvROaPHHJ8=; b=Dg+4zI52ACWJURcMoG94opEdwj
	1A9l131qmvkYYhTAjBFjN+hhiARlQ7G73/8PlO1e3LAqxWkuSyjXJP+1FSVRUyPcuMVXyJJKfQwCB
	2oVRJnpzed/tjASicuiiIhpoohV0tQZgcuc0Wuldx0fBH33KeiOXJ/GgKp2qbMjnYLvFM6FQvgP8r
	IThREpBmez6ff1htyWIVwQki/mGNClJUZSjM8hH+X/s9nMBItssNSgqqs6kfx1wgrp0uKJYuMR/2Q
	4mKxg/E4QXUu8yxJLfJbBGDoYM5fFQIb+dY8x0cIGeqF7hSsKFDyXPaMJv9Va3++i1Bn00PlidI9/
	TR5wJCjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v5-00000000mDX-0QSp;
	Tue, 03 Nov 2026 01:02:35 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2v0-00000000m97-2D5n
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 01:02:32 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e869e00005so56775315ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667749; x=1794272549; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pqlok/L90zyySLepqQOJQncJ0sDMJpbHVdvROaPHHJ8=;
        b=eD4ta0i3sPsmRq+PxJr+USXTO1vCqxV0Ab7Qli0cfbjCAaysL4Lu6O7aneVDAdw9tP
         P77WK+aU7jCRUgM932V0z9EpfOg+igw+YMQqYGz0kd6JI2xVjr9NFcxW6KKfYNURvPd+
         wIst24fwBHBYES7wcGBcMwHAFJHl9v/Osm3qRczMNzNbwBMuUJfT8BLAvpWG6LHmlYbR
         Xchh1PzA4Ho0NrdY8oASmIds5LC1CeYtY/49AGxIzz+/aBMfAGaeZweEECbsy/26XJaG
         pXiu2YPZDvlOL6QDoZQmWvuSDFth3rfvPdvp3iWphEIHnWgpai0Q/BAQ8C9fCzldfGcO
         aH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667749; x=1794272549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pqlok/L90zyySLepqQOJQncJ0sDMJpbHVdvROaPHHJ8=;
        b=GMfWX4sGuTxkCinpmvEjd0HdYjSAfBvxQ1uhl52iJzlYhTJfhCzVj937+lTk+tmN50
         ribh9l4ARkBOZhEZ1N+Gy5p/7tE/si54P/gG40994/0+CUl08PoeHZMAHSN/IHIKIawC
         sp4jiZkZoWIUJYv40bAotnl2jMgM0PHF519Pg3+C0rVVPx3uhxx+7H8wbn/HeyZsEmd+
         VTeFFTFctNedkQjApS5wdgwCVRdL09CDg13G8GN69Big9fEANSni0JuaB7mYYeEBCXtv
         yx/YR8PwFnKC79nDtlJizpr3S2xTU8zRqSb6uGsLxnyTf6pQJIZTVsk4uiEdKN+P3mUM
         NS7g==
X-Gm-Message-State: APuU4Z8t9sgbRdHBBtf9qshymeQ631rOx4kwwVcQMkAafbUIgQ/WjcQ7
	eu8Y6WMwmU6F59dG/CNCWOgndHeiJi2895/XoeNr6Vc+YksG+j5COEYq/eay8/UEkMQ3aflGrpt
	ta1OuiTLN2vjsd8n/rp1JQGnYa7aDmoo+uplxIrOATP1tZTaPnyojveA6LPKF61clElselvW/x5
	hzjmVVrFhEs1oC8rypAW+1cQ2wbmx3hyuPScX5n2HJYomqymnEWvg=
X-Received: from plru1.prod.google.com ([2002:a17:902:b281:b0:2e8:f377:a4d4])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ace:b0:2e9:5714:6079 with SMTP id d9443c01a7336-2eb3643f7e5mr119975855ad.31.1793667748954;
 Mon, 02 Nov 2026 17:02:28 -0800 (PST)
Date: Tue,  3 Nov 2026 01:02:11 +0000
In-Reply-To: <20261103010216.3447716-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103010216.3447716-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103010216.3447716-6-dmatlack@google.com>
Subject: [PATCH v3 05/10] liveupdate: Don't WARN if tracking a retrieved file fails
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
X-CRM114-CacheID: sfid-20261102_170230_568561_D88B09CF 
X-CRM114-Status: GOOD (  16.78  )
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
until the file set is finished, like any other retrieved file.

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
 kernel/liveupdate/luo_file.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 908ae124ea5e..5a82e45b9062 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -684,14 +684,25 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 arg,
 		return err;
 	}
 
+	err = xa_insert(&luo_preserved_files,
+			luo_get_id(luo_file->fh, args.file), args.file,
+			GFP_KERNEL);
+	if (err) {
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
2.56.0.385.gac671c819a-goog


