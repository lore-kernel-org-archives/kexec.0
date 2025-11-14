Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3768CE8D7B
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7XVvQovi1B87PI8BOl3fRcDQNVRDW1j8jgntLzdzQ0=; b=hrnncjbHONkusLMEIHtg0W6SYd
	1DTLZDoF+TWOw1gNq5uw54+i8v4tyJomATCplzyt0kWMBES3/CTiQrwzGKBoPKeA1sQohpBW8squV
	2KsS2AtQ+QmtThnn0W9dAebwfL9v7hEHx6sq+a4wtQRgjM+bHORKVmimCHOJjwLVqU7281CeEs5mi
	PXhOnD+lzyBGghkMPkTVmVhWGWljFg8ONxSjIKbXjk4g68pzDJB3lPvFEX0ytyFvZy+pAY1xGyZ/I
	qs+qyOaZxKvRfUw400mQ7VTM9dFdrlAR3J7FbVKgUWx/2GWvZ5v7Bn2xOno9d242QU2tlWEiPj0y6
	sbpKI/NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1t-0000000CzNq-0Klr;
	Fri, 14 Nov 2025 19:00:17 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1p-0000000CzKu-1RcW
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:14 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-63f9beb2730so1907682d50.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146812; x=1763751612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7XVvQovi1B87PI8BOl3fRcDQNVRDW1j8jgntLzdzQ0=;
        b=idvWuPSbVr4VeFn/GWv81qQXDmdpeVL2s4+mihqkl47BDG8+yOoMkaAyeV4zn6L2Uq
         61+zb8SWjahBaeFppBx+COpFQyLzc7tEesQpQDWjY5rl7Nqd0ULqE/pTRH6bxnGLxEQC
         n8vHxMWyUorR4KVTRaWfGZueEbfumtcXB+pP/IecTxbM8HJXn5H/7UD3zkvMXpjddOuA
         PXNbofSW44vYjDT7xLAxRzO+XYd5VyoSIo9DrpOhya+aM9ivAu78WAgG4gnUDmF7JpOQ
         DAGWYgdMYm9vZN082zCaM0AE3VMEYV83EECE5qLAMXimv+AuRtl+Oa8kcyF7ZDWoz/Hu
         qUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146812; x=1763751612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u7XVvQovi1B87PI8BOl3fRcDQNVRDW1j8jgntLzdzQ0=;
        b=hfsm8woPq8v7WodVky/bKX75nKswmnCQqDR9VYmlRo4izo38vr6j6dga0BzCNhq96h
         w5B0zCrGoiLOT8AVyUY+5XRaQbjt8+1list3CnR4g+IIp7cshojXGoojZPvrCt7Yl1wt
         +05gkG//okmgNeFr1dNHsTvzD8tDOw9/4mY6pRWEvRFooyTqTRL/3UbiTHBZPs/WreP+
         uF5lBg9u9AgHVQ+eWiC+sa7ZUD78xedD2h2nt5tBf5xAJRlUlAyEN+yFGVBpsZFcyqTy
         SJYmBS98J4JZIbXSG5Wm6J2xC0LCk9WSfjj0FQIg0JjjK+MZ0qwjTvkwbYtcUoOKRWJ9
         JANQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj9QYdB6Hg13GKIQdkQiRGXtTkrNZhud80ho10mFiUV0rQwc9Gba89pDq4hI/Yhoout8bfCw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaJRc+lzp9886icYNW44u7vfYJvgCbDQy4xPeQkVi+EO7E7RQv
	Pk7dQsCdEQYo1lyw5ezmE39GerfdtHh2l48W+G0OwV4BtPkseoleVV8SktSwcyPMLR8=
X-Gm-Gg: ASbGncu4VwERmfLtVNOk32b5RnZp2kzEZz9p3TaRCT3I0hidXpqINI8nP8s/Jy0OXGJ
	P1CVW3++uhdM5pHzi89TaReShBfc+WDHG/0hK4jigiMS4hup7lSLxbWk4jtw0B1t0pAQg28iFYV
	ooPTqKidnuq4DyC4s60Vc4wWlccFGCK7dxOy+V8e4SDHQnZ7BOXN9Zb5sZUI5x7+kyndOe0vpA0
	R3mdXIBr1fT2e66wCVnQj3E8m2aMgYYQ8vC+p48ybYos2CA6B2apLEYPBP4pHArP5cV0Jp1DlsP
	8bslWUcUxBoONaNCAfJwvtxvnrO8q19mQkOfqhkFZQnX76FW0b9zCzhFoJrHS+EhDzgbv+hN5J4
	nKoc0vJvAPG9HNuvC2sS0SHeVE9FgSf3+2L8B5FA9hajE1UR8rK3jQTufGP87rjotMIXMIEPPjZ
	zJBGcP9Jd7B1TXQjRLlilnNvT4og00Bw/tf3ngCunXQM8WBwU6EUABKw7cXCrzxxYlSb7XMhRV/
	TyUSEMBl1vz7FDQdQ==
X-Google-Smtp-Source: AGHT+IF0iKCWHE07PgWFg/A1CwFMxmaP8Ueh0K2652mZRWA2JKfJppAhp60Gzd/8KnWhTuvrWjbQjA==
X-Received: by 2002:a53:d048:0:10b0:63f:7de1:7acf with SMTP id 956f58d0204a3-641e74e13cemr2926186d50.22.1763146811446;
        Fri, 14 Nov 2025 11:00:11 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:10 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 04/13] kho: Preserve FDT folio only once during initialization
Date: Fri, 14 Nov 2025 13:59:53 -0500
Message-ID: <20251114190002.3311679-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110013_411228_BA16730D 
X-CRM114-Status: GOOD (  15.13  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently, the FDT folio is preserved inside __kho_finalize(). If the
user performs multiple finalize/abort cycles, kho_preserve_folio() is
called repeatedly for the same FDT folio.

Since the FDT folio is allocated once during kho_init(), it should be
marked for preservation at the same time. Move the preservation call to
kho_init() to align the preservation state with the object's lifecycle
and simplify the finalize path.

Also, pre-zero the FDT tree so we do not expose random bits to the
user and to the next kernel by using the new kho_alloc_preserve() api.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5c5c9c46fe92..704e91418214 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1251,10 +1251,6 @@ static int __kho_finalize(void)
 	if (err)
 		goto abort;
 
-	err = kho_preserve_folio(virt_to_folio(kho_out.fdt));
-	if (err)
-		goto abort;
-
 	err = kho_mem_serialize(&kho_out);
 	if (err)
 		goto abort;
@@ -1384,19 +1380,17 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
 static __init int kho_init(void)
 {
-	int err = 0;
 	const void *fdt = kho_get_fdt();
-	struct page *fdt_page;
+	int err = 0;
 
 	if (!kho_enable)
 		return 0;
 
-	fdt_page = alloc_page(GFP_KERNEL);
-	if (!fdt_page) {
-		err = -ENOMEM;
+	kho_out.fdt = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(kho_out.fdt)) {
+		err = PTR_ERR(kho_out.fdt);
 		goto err_free_scratch;
 	}
-	kho_out.fdt = page_to_virt(fdt_page);
 
 	err = kho_debugfs_init();
 	if (err)
@@ -1424,9 +1418,9 @@ static __init int kho_init(void)
 	return 0;
 
 err_free_fdt:
-	put_page(fdt_page);
-	kho_out.fdt = NULL;
+	kho_unpreserve_free(kho_out.fdt);
 err_free_scratch:
+	kho_out.fdt = NULL;
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		void *start = __va(kho_scratch[i].addr);
 		void *end = start + kho_scratch[i].size;
-- 
2.52.0.rc1.455.g30608eb744-goog


