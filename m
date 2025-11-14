Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED6CE8D4A
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzmFAH3xmZJhmT0Rkc3uU+e9AsoR0HG7wEejoVF1lJ4=; b=gjvkZfH0NjKefy/r1QJml+Wf1x
	P6QvSh9uKeOcIz4A/LmIpOwI5dCe0Nu/+0ZAlIw5wdEAhAtsc2d0k/TTttv/G1Z5D0ZVzN/K+B1/D
	o9vwqaT8CBnu/JdHgvDchxvkyPE4nRvY4eqXisDxpV3oEOvnM+TzBu0JJyXzOldEbZh2teFj/5rjf
	4OTLbpl88xuPcooDdz4hvLzIYFFV+Qv2S/bzroJPN9dz/wpTawLUoQNuf9DvpCc6oiAKiwqpdT9KK
	BcxtM3UqHHUhBK17K1BCL5kQqcQhv3WSR/Eb+MyR41SWWw1YBexDXk0dl7hiHc/A9rfwylLg6EU7S
	dUbJld6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7o-0000000CcmF-2HWn;
	Fri, 14 Nov 2025 15:54:12 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7m-0000000CcjQ-0Spr
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:11 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7881b67da53so20644917b3.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135649; x=1763740449; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzmFAH3xmZJhmT0Rkc3uU+e9AsoR0HG7wEejoVF1lJ4=;
        b=SVsPC5v5cgcM7kWPv0ntXYGXvKNsZN6QKzjPcP9pSJjYVPSyMpb4u6OO/8NW15iC+f
         ZXdMb9Eth6rHZl8ttUL2gDdBoyJrXnDGRybV75N6t1lTM8s1pRO8CMxe9k3fqILruV6C
         w68K30cZcuZ99gAoyuyFO2q0sJtuGbLDRiIFFf4ws/dvAMHfBZ3pQfDAkttWVNx3eaZ+
         oyZwccaMHUdGdVd0yJDkpD6/CA6FUOX9kXoxIKL4Rts2IaMHBSKQe3URBmEmFFDxcb/T
         F3fLXpz8ahmLG2tk8/dyp9j8M+6LO+BZR48RnG5nf379TBBob/0KxImMGgJTij4i71FF
         GHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135649; x=1763740449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzmFAH3xmZJhmT0Rkc3uU+e9AsoR0HG7wEejoVF1lJ4=;
        b=M0G6sNBW0z6iC62A3P1mBV4ms1eh2W0HFIeF7x52ReYWhPsFjKPExngTpt6xay4aGg
         stxs3XSUYjRTTiiACNBmeOVXcuK7SCC3ZIgjAiJhnkWLGsFn3jqjsnnEZ2NdroE0f6Dd
         qQILtbH64/E/ExeuUr4ECZ2oTtE388LMFlNfcOo+8cgpdYpL0qThCrMxn8VdcIAssQHI
         kbT8TtoAf1/HNIN/oV0uA9XhvDv2bHh2v9VU2UVdNSKQWbw7EwSDEibcju7UoX7sfHwm
         DYqLyeK5Lnp8sDlqxeZyLUbVi3bfeYDGZq/UFz29+6TDE5GwhPG6528l/iZavl1FF1st
         xBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+6VLhL0BJc5CEMHJ3DwnLCsEfxRp3bvZk2LrOpZ6Ii4X1HQwKzi3dfknQDDPZDWZbmoIa1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzxBdRNElPNgM2mNGrvvcZpiXAVKWvWlHinrCYYoe4UIjeWy/jg
	nEeIgn7tBA+HXcyvvK3167LDDHItQeHf+51JEGFDBTJaeqGQAS3FLLy344O9dMvDX4NctxnWYh2
	cNjAU
X-Gm-Gg: ASbGncupKHJFJAgr2k7mjV2uImtL9HOwPHe0dQ/P9ladM+GSadEcRVVD5ukimwHAan3
	GLFgCefApOqV38tQHkdJnH152xq/4QMkOBo/mtJoRM7I5qbKLI9AZce2H0i1+rPfdM3pJtgEAUq
	PwG3ZmfcLU9qOcmxYFgATqbLPa7MseNreA+2VOMAqSKjhQwb07Ua28D9M9lFPTagIsoqNY0l073
	T9iDaNX1xbBlNwIrZM+QJryT0Z7U8aEWNHqM91gOZRMAQIPb+kR371e3cfp8XWPHDw2gtRPZumo
	pIk8ELrzaNCyVHU1Tp3RT/TJT5riXodSwb3jwKZVFDn8l1iUnkw5NZ/H0lmk2rny4l0w1sePY+J
	7j4aYbTVpwgkkJYdpwfzLKlI8h24Ny/ljbq3O5jbINk+r7S+Xj1/RljB3zv2lhUYNg2KMTDiwgz
	3/+BeGgvPP5MnxFCeEFOzWTBPmFos1RVSYsw5aIkAbzo5KDn+qsSbWoP/YOxgsfpILjODM
X-Google-Smtp-Source: AGHT+IHTzr8yE3ggcwxtjOMXBuZ+AkCCbUZfzA+E1WP5d8Pf6HPSzrjQ6c3qDriXPIifvjJMeL/d/w==
X-Received: by 2002:a05:690c:5885:b0:787:f5c5:c630 with SMTP id 00721157ae682-78929ed6f0bmr24916857b3.41.1763135648927;
        Fri, 14 Nov 2025 07:54:08 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:08 -0800 (PST)
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
Subject: [PATCH v1 06/13] kho: Simplify serialization and remove __kho_abort
Date: Fri, 14 Nov 2025 10:53:51 -0500
Message-ID: <20251114155358.2884014-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075410_157142_28F0FBEB 
X-CRM114-Status: GOOD (  11.81  )
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

Currently, __kho_finalize() performs memory serialization in the middle
of FDT construction. If FDT construction fails later, the function must
manually clean up the serialized memory via __kho_abort().

Refactor __kho_finalize() to perform kho_mem_serialize() only after the
FDT has been successfully constructed and finished. This reordering has
two benefits:
1. It avoids expensive serialization work if FDT generation fails.
2. It removes the need for cleanup in the FDT error path.

As a result, the internal helper __kho_abort() is no longer needed for
internal error handling. Inline its remaining logic (cleanup of the
preserved memory map) directly into kho_abort() and remove the helper.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 41 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cd8641725343..aea58e5a6b49 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1127,14 +1127,6 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-static void __kho_abort(void)
-{
-	if (kho_out.preserved_mem_map) {
-		kho_mem_ser_free(kho_out.preserved_mem_map);
-		kho_out.preserved_mem_map = NULL;
-	}
-}
-
 int kho_abort(void)
 {
 	if (!kho_enable)
@@ -1144,7 +1136,8 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	__kho_abort();
+	kho_mem_ser_free(kho_out.preserved_mem_map);
+	kho_out.preserved_mem_map = NULL;
 	kho_out.finalized = false;
 
 	return 0;
@@ -1152,12 +1145,12 @@ int kho_abort(void)
 
 static int __kho_finalize(void)
 {
-	int err = 0;
-	u64 *preserved_mem_map;
 	void *root = kho_out.fdt;
 	struct kho_sub_fdt *fdt;
+	u64 *preserved_mem_map;
+	int err;
 
-	err |= fdt_create(root, PAGE_SIZE);
+	err = fdt_create(root, PAGE_SIZE);
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
@@ -1170,13 +1163,7 @@ static int __kho_finalize(void)
 					sizeof(*preserved_mem_map),
 					(void **)&preserved_mem_map);
 	if (err)
-		goto abort;
-
-	err = kho_mem_serialize(&kho_out);
-	if (err)
-		goto abort;
-
-	*preserved_mem_map = (u64)virt_to_phys(kho_out.preserved_mem_map);
+		goto err_exit;
 
 	mutex_lock(&kho_out.fdts_lock);
 	list_for_each_entry(fdt, &kho_out.sub_fdts, l) {
@@ -1190,13 +1177,19 @@ static int __kho_finalize(void)
 
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
+	if (err)
+		goto err_exit;
 
-abort:
-	if (err) {
-		pr_err("Failed to convert KHO state tree: %d\n", err);
-		__kho_abort();
-	}
+	err = kho_mem_serialize(&kho_out);
+	if (err)
+		goto err_exit;
+
+	*preserved_mem_map = (u64)virt_to_phys(kho_out.preserved_mem_map);
+
+	return 0;
 
+err_exit:
+	pr_err("Failed to convert KHO state tree: %d\n", err);
 	return err;
 }
 
-- 
2.52.0.rc1.455.g30608eb744-goog


