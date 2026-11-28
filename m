Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E66606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OCeUC0oz;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lmGM98iF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:Cc
	:To:Subject:From:References:In-Reply-To:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S/tHl+2/aELrbIwf0Ksau3tprNWFE1rPE6zNQAZmUkc=; b=OCeUC0ozninugDkRpk/ZY2OwgB
	tpdtdI6+9nkZoe8nxwZNF2DFwox63ZbCLfIxRo6T0HTOMzVN1YpqqaX2oAicdecKe4hpPvfNf3fJm
	D36RZJwgWT0kUUS7EGhxprn8bHuxYbJVleKM2LPe6kvIJbjCTxjqxz99jz9KcsNhNdNcI6e6Bngyd
	cTX+iJWDVAIc5EBQDNqGZ0AC/x4xJp4Kqs0TmAPHc9urOazoV1S5E08Z79ls374uy8S87vWbXPprm
	3WE3CZUbYjMWYGqZYZohX29bup/gHeKg73fP1ww7b6MxBusxbVMRVlN3rXNFdH0wC6CAtCZkuZIwu
	c/r0Lk0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEdE-00000000ZfB-07Fi;
	Sat, 28 Nov 2026 09:22:08 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEd2-00000000Zar-3hih
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:22:01 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-67db23d8892so9341559d50.2
        for <kexec@lists.infradead.org>; Sat, 28 Nov 2026 01:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795857716; x=1796462516; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S/tHl+2/aELrbIwf0Ksau3tprNWFE1rPE6zNQAZmUkc=;
        b=lmGM98iFvf0XzaJuxPZCcQ50Bl6hRQm9TuagNxXySyf5+vO2sSXmXTRn4HpSxheCQ/
         /Bj6TYKtM4m1scWo1FZBLDB0V4f7z+IXF29yzcrMwY/cmHNTn1pxnxsEO+KymhMuo0Nm
         m31zANOwohKo70YP8dPvi3B51S2naKKFZkh3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795857716; x=1796462516;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/tHl+2/aELrbIwf0Ksau3tprNWFE1rPE6zNQAZmUkc=;
        b=2ilxTpSdXdjMvF74yZMujqjcFZbuq/8Zn0++1fkoLRMgDtoU3NoMEK/KNX7uUFduBu
         u8ti9bzceNQod1wN8NE+lNtcomioWBeHpQ0MIMExi5OwbFYLSgNrV/VnsC8Kzbn5J9Vt
         5BtW7v2s5EeQQqSGDGz6GpZ8qQu0qoG+fA9OZ/UnUtU8AdGpefNlGWJpw1xjGZphiHt1
         a+tcXM4UBKxhM0AeKZMghMXzeLBtIDhPKG37lFWrpPhGY8xOCzFcf5QJRImHED/3pT8q
         /gbAOYo6SVc05mwh2lTmAEGP3IrQGfYAFBjpQdzPWX+lTTtPyCi0NQJx7sJDUJQ7LKtL
         75cA==
X-Forwarded-Encrypted: i=1; AL+hErHdw21W208q8YhOpfLw0tJmjCpPS1CJqdkGlOnp2MUTU5VP7OdYpmRFpyVBdFsefbDUCGSN5w==@lists.infradead.org
X-Gm-Message-State: APuU4Z/pD/u2q1YTXOlsrUiqMmFO7vU3iDNmdW+xTbEbRdVtCVpG1eFW
	tVyXAwgWWQomruDdH3zOBIb6/3wof2Gu+rF8uKZryndRuZPMptw2tKYmjULTyTCqdm0=
X-Gm-Gg: AZFdTZd8AGwfPOf92lh98oGAUM2y+18WxtFduqtWCNMoYR/6kbM7xBciqtGbXH/VE0o
	z15qAGN/ez2c0vSsp125Aqtg9qaFgvOlxA/CFRuoDj13tM3ssiNZTVfmVftC4t7Zpt3zGfEFbrb
	mI277aB1xa1g2H0QA0nG7LIRG2pa56XBTUKDpItk8+a4HzI6m+F+kknZSekMXXq4OcL4P5S8Uky
	nRJdinrkoLso7ZCvpO8HZ6xRibjzxqHqx1fCYIzgUL/GIb1tZbl52NuDk7o2mL9NITCFR38QOy/
	b0zF9juZDY1kJxnX1sUmU+BMY5q2W83pxzzJEF72Ps1hi0i67vwbqAprObi5rma1o0afCinCwIM
	vfVKlpTo33fUQWuaRkCN7uha5lP429uBYFqrLWiUZN6WAGvpnGCYMn8hnA0jpTFQ2asoHJGDTpk
	fIWJdF7NPxTks5ghfj/QTx8FuhClaEU3M+4VGvwmib7yOB7dWNDNscxXbsmpeHM5k5+6aZ3ATiO
	LIg426xhU/f9OhN/vu0WXwX7sVgfad7GTTVPy66exMUcfNJAhUgha7FQaJCx+D3+hOJgoGXATlQ
	bKyOGVkpDbGfKxQPZTMwaQfrpt0LljFjDDKFtXJDpw0JDtLotlcyTNhOABs68aNeajp5qcPbQTI
	iKi9tQFHR6vGMlYYlPkXdgQ7zmkJeKPeDyzi0+ljRR5EUVulaXtr2nsUBjY563R76TUG/J+GfUi
	ou+fuZxP3L9MBq9FNfENYLT5i4wx7qCHVqKAz28jNSSZormhqW6I4QjNcpcKMBRYj8TQLPw9Kwr
	n7G6D7GdAifXzpqsww++0g=
X-Received: by 2002:a05:690e:b8d:b0:679:cc49:55cb with SMTP id 956f58d0204a3-67df44b8ae6mr13485805d50.99.1795857715699;
        Sat, 28 Nov 2026 01:21:55 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33e01e1sm12359048d50.23.2026.11.28.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:21:55 -0800 (PST)
Date: Sat, 28 Nov 2026 01:21:52 -0800
Message-ID: <ea408fb02711a52bdd9aef4650c7079945a2bb71.1795835884.git.chris@chrisdown.name>
In-Reply-To: <cover.1795835884.git.chris@chrisdown.name>
References: <cover.1795835884.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 2/2] kho: don't fail kho_init() when debugfs is disabled
To: rppt@kernel.org,
    pasha.tatashin@soleen.com,
    pratyush@kernel.org
Cc: graf@amazon.com,
    kexec@lists.infradead.org,
    linux-mm@kvack.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261128_012157_747502_8E9FAB24 
X-CRM114-Status: GOOD (  18.64  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_init() fails if kho_debugfs_init() or kho_out_debugfs_init() can't
create their debugfs entries, and a failed kho_init() turns KHO off.
That made sense while KHO could only be finalised through debugfs, but
commit 03d3963464a4 ("kho: make debugfs interface optional") made the
debugfs interface optional, and these days KHO doesn't need any of its
files to work.

This is a problem because debugfs can be disabled at boot with
debugfs=off, or by default with CONFIG_DEBUG_FS_ALLOW_NONE, in which
case every attempt to create a debugfs entry returns -EPERM. Given that
CONFIG_KEXEC_HANDOVER_DEBUGFS defaults to y when KHO is built in, KHO
and LUO can't be used at all on such a kernel. With kho=on liveupdate=on
debugfs=off, /dev/liveupdate never appears and a kexec hands nothing
over. kho_init() doesn't log why, so the only sign of it is the
WARN_ON_ONCE() that LUO then trips in kho_radix_add_key().

So, let's carry on without the debugfs entries when they can't be
created, as kho_in_debugfs_init() already does for the incoming FDT.

Two things then run without KHO's debugfs directories for the first
time. kho_debugfs_blob_add() would fail and trip the WARN_ON_ONCE() in
its callers, so let's make it do nothing when it has no directory to add
the blob to. kho_in_debugfs_init() would log an error on every KHO boot,
so let's make it return early when the kho directory doesn't exist.

With this applied, test_kho and luo_kexec_simple both get their state
back across a KHO kexec between two kernels booted with debugfs=off.

Fixes: 03d3963464a4 ("kho: make debugfs interface optional")
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/liveupdate/kexec_handover.c          |  9 ++-------
 kernel/liveupdate/kexec_handover_debugfs.c  | 19 +++++++++++--------
 kernel/liveupdate/kexec_handover_internal.h |  8 ++++----
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 663dd22e7172..4cee37ad9426 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1847,13 +1847,8 @@ static __init int kho_init(void)
 		goto err_free_kho_radix_tree;
 	}
 
-	err = kho_debugfs_init();
-	if (err)
-		goto err_free_fdt;
-
-	err = kho_out_debugfs_init(&kho_out.dbg);
-	if (err)
-		goto err_free_fdt;
+	kho_debugfs_init();
+	kho_out_debugfs_init(&kho_out.dbg);
 
 	err = kho_out_fdt_setup();
 	if (err)
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 3a91c47ad7a6..cedfc955391a 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -59,6 +59,10 @@ int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
 	else
 		dir = dbg->sub_fdt_dir;
 
+	/* The directories are NULL if they could not be created. */
+	if (!dir)
+		return 0;
+
 	return __kho_debugfs_blob_add(&dbg->fdt_list, dir, name, blob, size);
 }
 
@@ -101,6 +105,9 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
+	if (IS_ERR(debugfs_root))
+		return;
+
 	dir = debugfs_create_dir("in", debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
@@ -129,7 +136,7 @@ err_out:
 	}
 }
 
-__init int kho_out_debugfs_init(struct kho_debugfs *dbg)
+__init void kho_out_debugfs_init(struct kho_debugfs *dbg)
 {
 	struct dentry *dir, *f, *sub_fdt_dir;
 
@@ -137,7 +144,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	dir = debugfs_create_dir("out", debugfs_root);
 	if (IS_ERR(dir))
-		return -ENOMEM;
+		return;
 
 	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
 	if (IS_ERR(sub_fdt_dir))
@@ -155,17 +162,13 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	dbg->dir = dir;
 	dbg->sub_fdt_dir = sub_fdt_dir;
-	return 0;
+	return;
 
 err_rmdir:
 	debugfs_remove_recursive(dir);
-	return -ENOENT;
 }
 
-__init int kho_debugfs_init(void)
+__init void kho_debugfs_init(void)
 {
 	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
-		return -ENOENT;
-	return 0;
 }
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index e9685e1ef6d7..424467a98da2 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -23,17 +23,17 @@ extern struct kho_bootmem *kho_bootmem;
 extern unsigned int kho_bootmem_cnt;
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
-int kho_debugfs_init(void);
+void kho_debugfs_init(void);
 void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
-int kho_out_debugfs_init(struct kho_debugfs *dbg);
+void kho_out_debugfs_init(struct kho_debugfs *dbg);
 int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
 			 const void *blob, size_t size, bool root);
 void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob);
 #else
-static inline int kho_debugfs_init(void) { return 0; }
+static inline void kho_debugfs_init(void) { }
 static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
 				       const void *fdt) { }
-static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
+static inline void kho_out_debugfs_init(struct kho_debugfs *dbg) { }
 static inline int kho_debugfs_blob_add(struct kho_debugfs *dbg,
 				       const char *name, const void *blob,
 				       size_t size, bool root) { return 0; }
-- 
2.56.1


