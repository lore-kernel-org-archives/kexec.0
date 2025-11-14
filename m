Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A5CE8D6F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKXqn4UCsx5taExigGhwZ/uQl6fonqpp/y9tU9NzApw=; b=KGv/SO0mgZmi/lch2dkS+3mouZ
	pBFoM0K9kXC7pX3dhEwZWVu18T8qoGabmlQfx/HoCenNYgsVZGmikENAvKw7QRbQGOPTdMt6RPM2j
	zlE8X7BWojx+jmhSH1pF5mSfLuX1XgDIbIDo+l197DdgpWjEGjz4Bh9Ota392KoBvMMD3dwprFeS0
	CEZo7eLPOSXyu9OAs2gXbG9wZFC215Ty0aQodjB8kx822E4q0s73B6BOL0espyaaSz5zZHo9BmKWi
	2Vv0FwD5jyAXovyUOol3AG3JLlYsghzKHzyuDyeVlZvuYA/7EhUa1uEArOD6Amrx9q46CZB2jXNei
	Hts8CMFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1u-0000000CzPY-0ZNl;
	Fri, 14 Nov 2025 19:00:18 +0000
Received: from mail-yx1-f44.google.com ([74.125.224.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1s-0000000CzMq-1ONg
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:17 +0000
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640c857ce02so2221000d50.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146815; x=1763751615; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKXqn4UCsx5taExigGhwZ/uQl6fonqpp/y9tU9NzApw=;
        b=KZhFPZbiCIISAtL5aIQvDPlrCCtTKCzBDzaRwOff7SgkS8ULoYhTJbhGKH83LrRt6A
         /iJNVap4gaZGSTLPyYlCk0KJgNr3KApXiE11xHXZkPKb6v2kYtgqxYJQQCS+VuYVQcML
         km9FlMArVcukCZ/Gj6iLzqF+XWKAkCRjvFLV7ob4NRIc4L4jRj27n59NO6mAb5YXKzrh
         h4FFTbFgFnBmANKm+wHIse2bB2ZJAdQfGakJJ5N+KtMWJbPMH2ogDTJhmKaUBJLi5EMe
         ztnumGVKjvPcwKF2dBQtIWjYNvBtIDAegSf1kr2db9jmq6Zdz0DQoVjnkEEVtSuNzQ8e
         SzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146815; x=1763751615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKXqn4UCsx5taExigGhwZ/uQl6fonqpp/y9tU9NzApw=;
        b=f9dR1e92Wm1V4Ovr1ZEPRlFgfjcjtEIGk1c/hV8FMs5MW7qLDsxIYJBv0IBS+OgIy0
         yGBNkfk5+kdsI0dibCHriFxgp6L3dNZbQjZDKvdYFwGi7HvABTCYR9ykJTNoDywtW4jg
         qlX0LBxiKq61P8XMxv4PjSGuuO1x+T3ZsRzvk9YOaoYqE5FEsTG7/i57Y0i7gIEoNBK+
         dVk1z7wPEh60VFm1dCYW/w+PIB9VvCubdl3HqQOGYjM42808CgXg+isRJjQgfqAykUKi
         ftaAFaYJ3XaW+APHUqbV+HJj648V5ZXUbJTAKOK9BCVrnw8kMJVHIdibNkMUX8DTo+pO
         oBlw==
X-Forwarded-Encrypted: i=1; AJvYcCWC6lEXwKsNSVjFBAPilREzwRf8ZIGnuphRo8dUU70dmewuTsSxhvyQBje+ZYIvE0bKBApQzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyADSOM6x1D6KcKOpx0gvD53T+2G9Jd/6kRdphVlQ354cliI7Ws
	FHlLWs58yZy5EM6zmSm0gUE8a/BR0msPyBFAAu++kjZnc0dw5qGnefKFXP3vO54YFIc=
X-Gm-Gg: ASbGncv6rmYfCTo8Vld6O+9SaXmmj1w5Jb0NkM4l6kB5A+AOsLiSpN9g7yxdbZK0Sm7
	kjyorn9funI01OV+CJRt437cVOeJRC+s1vO1P9iuOgqidsIzLJ4pmcwGJ0w9cGSz+q/2d6ShUDC
	ZsAnug4ZNHp0ZyD+sKE2VbH0/oOPwjy4dA7bLkPGFLGKFUnilM405BXqOTifT2YiuuoLEs3XLqb
	2fMiJBndDkCwnWsEVWf30c6/5Jpv+Mdtz2Tk7flyMqh9a4h4nWfEbtrq6FJkQN9Jr18pn8u2mGK
	/vIj5rpQYWoxo6B9abfPhaL8F5X0FQgyUq/2cJGgHVyXFZE9XH4f5FhAla1tPR2B8s8kBP1gtsO
	GiBEFMqIKoKnodpSvTx925Vxfs9EbGiQUsTVZhvjmCenWVhBcTY9JthKqO2VB5qExWOSilXFK95
	p08F9rcsutJxs6b3t8eziD/G6xHEr0j20Evl5invCQ6CXIDor4Pk1LgCq+n5N64M2KOGE5
X-Google-Smtp-Source: AGHT+IGombylFpcjG2djxoO/obQ9YcdXjb9GnKr8tqI/Af7HjHJJG+neoAQar3y1uITvPYzUr69PHg==
X-Received: by 2002:a05:690e:15d7:b0:641:718:8a08 with SMTP id 956f58d0204a3-641e76834camr2719966d50.52.1763146814781;
        Fri, 14 Nov 2025 11:00:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:14 -0800 (PST)
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
Subject: [PATCH v2 07/13] kho: Simplify serialization and remove __kho_abort
Date: Fri, 14 Nov 2025 13:59:56 -0500
Message-ID: <20251114190002.3311679-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110016_380563_1CC287CD 
X-CRM114-Status: GOOD (  12.08  )
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 41 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3e32c61a64b1..297136054f75 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1214,14 +1214,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
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
@@ -1231,7 +1223,8 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	__kho_abort();
+	kho_mem_ser_free(kho_out.preserved_mem_map);
+	kho_out.preserved_mem_map = NULL;
 	kho_out.finalized = false;
 
 	return 0;
@@ -1239,12 +1232,12 @@ int kho_abort(void)
 
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
@@ -1257,13 +1250,7 @@ static int __kho_finalize(void)
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
@@ -1277,13 +1264,19 @@ static int __kho_finalize(void)
 
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


