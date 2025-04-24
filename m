Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9FBC369D8
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7VEVoe4uPheIEiVrtKTo6u/lqrEMNwyEPBA44TaHZQ=; b=2qsGtLbETe2WpK1Vawo+OTjK7z
	3DdIKeu0P1WTyg0piDGyuBXM6ELzlB0fMGCaRj+A5qfs60zSCrE41lMN6/wzagthOvBAEDH52rgfd
	x+9M2RYC2KDfEveEflP6Q21iU58bGyY7ZGsMAfbvWQyVHPv13wywu4oiKrVRP3xFIRhL/CyH1HlTY
	ZYaupH8hSE51QCkO9f/uKWYcR2j8nqFjVLimSVaZHoN+EPQUDjlszGRS7VQoSnJCyvx+fY/LZRZYi
	RSnIhuJ6vXIRr5gqRuyv7XuLC73LmJeDt5vZwYPMnoHebX6sd/HNGeDAfrlqlWei7xyyHC5tIF7Rc
	SsK84xVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s54-0000000DLS6-1SGG;
	Thu, 24 Apr 2025 08:37:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s1b-0000000DKoz-237E
	for kexec@bombadil.infradead.org;
	Thu, 24 Apr 2025 08:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7VEVoe4uPheIEiVrtKTo6u/lqrEMNwyEPBA44TaHZQ=; b=QiD5BlmqCNwbz60IRSMKYz+BYT
	H4Sw4Hi93TYQ1ClI2P9r05uxZl832VAmtMFILa4WA1hVzhRh73o4PhCTtay0D4QuPt8uBsTn7Pt88
	+KZpxxs/18W0VJbV45qoNvsx+7OjkyT/ftKrp4AxXdQ0cFvX6emJW7WJzfhbdZTv9A/y9m0Y27f5h
	txDR7daUtUhI8qELVq3BPRxBWJL8/ZYoQ7bO8keyILsqHyChbsV9bo3T+Smi8+P5z0MfqZ3zvzh2d
	WW9VpOOAMFZXcTF6YGCAfkgxmEaMkK2LpbD3aVYpSAQgxB0boDZdlFS9YNB/plfqdA3nX4oOyWPuC
	rLo8JnUg==;
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7s1X-0000000BcUy-0yn7
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 08:33:38 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso770916a91.1
        for <kexec@lists.infradead.org>; Thu, 24 Apr 2025 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745483611; x=1746088411; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7VEVoe4uPheIEiVrtKTo6u/lqrEMNwyEPBA44TaHZQ=;
        b=AeEpJmSi+Ari1yw8YSyaSquiQe+/FbckWOy9cEyPdylwDcwKfsiPLnVdobm3jXSB0g
         d65ECpKziSjs3VfIVuKxj5sm7g2sfUQG0/ds9KwHKocMgD/MfVs0jSUKxsKTcsZA4D5C
         C3B3IQIC6Zt8AN1CpeMKVh4+mhxj7E6ADxMlJ2R/9+OW9n4y4gk+JmO/Ol7d527PSzMx
         dCJWUVtABfFCH44ZHQFRqE4tnts97+3tGZHcJfV3nbA7oew/BRZhklKlxCWqGvtG7y+4
         44XQMoCoTJlcA42siOTtmPy6XAifqA1HzTfZTS0XS2sgxODZs1wufsQSC7AtbP6+emoS
         vYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483611; x=1746088411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7VEVoe4uPheIEiVrtKTo6u/lqrEMNwyEPBA44TaHZQ=;
        b=dfYBHy9ozgtfZB0AXqLDRAaWQvLLk7grHn1yKcIldMwt5lnARZEY+PKzJ+xFKsNffV
         +RugJL9IBwQF6JpkLj3n7bIK45vngn5KMu09Eii2LjBVp5AzGp5jGr2KzVTozjZi49r7
         uPyydDm0l7UjAWNxIFpbOujnx40aaO7fZykdxI78R39g0BjVBAP9dRnTCkcSYbYPz81v
         E5NUDYRNjobFtDjeq5nbCy+9JZh6ynISVJ0+NrSDnQMyP7zd7lGn1XoEdKDCHkg95QRh
         jcb0jG2Tp4xe7rexBwsTvhB8OSYl+zoClJeCKRnHa0sdQpLOUJNp1TNrCB+M6Vcmj+kp
         nUow==
X-Forwarded-Encrypted: i=1; AJvYcCU4l6ohdpyW2/KmMNuQ9afhkMxt6Vxbu3dDNsEJXmrUzzYLd13/4ZLl/Ns4vH50QSXA5Y+hRA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEe9KxUnlZYJz9BWi8lDSvTHJhYEekxhxEKP2kL4yaWzkfgsQe
	CW+NNL56646Mis2CNQPjQWINdSpdt5CYiDf/kjMgULVFl9oriFtg+sW3y8RZe2I9hLJoyLM0H9T
	yn2+KGtFuCJp6y/iuAg==
X-Google-Smtp-Source: AGHT+IGq6BVgM0IDW8HPijQuQX/f2OnqSI5HlIuEOLmb+TLuZj1I3Q9W3Aia7/3MIxDmrcexsVPCuLlX+IzwZqzj
X-Received: from pjuw16.prod.google.com ([2002:a17:90a:d610:b0:2ff:6e58:8a03])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:584c:b0:305:5f28:2d5c with SMTP id 98e67ed59e1d1-309ed27d7b1mr3055392a91.15.1745483611167;
 Thu, 24 Apr 2025 01:33:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:32:58 -0700
In-Reply-To: <aAeaJ2iqkrv_ffhT@kernel.org>
Mime-Version: 1.0
References: <aAeaJ2iqkrv_ffhT@kernel.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424083258.2228122-1-changyuanl@google.com>
Subject: Re: [PATCH v6 12/14] memblock: add KHO support for reserve_mem
From: Changyuan Lyu <changyuanl@google.com>
To: rppt@kernel.org, akpm@linux-foundation.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	changyuanl@google.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_093335_328726_F836501C 
X-CRM114-Status: GOOD (  35.63  )
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

On Tue, Apr 22, 2025 at 16:31:19 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Apr 10, 2025 at 10:37:43PM -0700, Changyuan Lyu wrote:
> > [...]
> > +static struct notifier_block reserve_mem_kho_nb = {
> > +	.notifier_call = reserve_mem_kho_notifier,
> > +};
> > +
> > +static void __init prepare_kho_fdt(void)
> > +{
> > +	int err = 0, i;
> > +	void *fdt;
> > +
> > +	if (!reserved_mem_count)
> > +		return;
>
> It's better to have this check in reserve_mem_init() before registering kho
> notifier.

Sounds good!

> > +
> > +	kho_fdt = alloc_page(GFP_KERNEL);
> > +	if (!kho_fdt) {
> > +		kho_fdt = ERR_PTR(-ENOMEM);
>
> Do we really care about having errno in kho_fdt? I think NULL would work
> just fine.

I was originally using ERR_PTR(-ENOMEM) and NULL to differentiate the following
2 cases:

1. prepare_kho_fdt() failed,
2. reserved_mem_count == 0, so no memblock FDT was created.

Based on the suggestion above, since now we only register the notifier when
reserved_mem_count == 0, case 2 shall never happen. So NULL is enough.

> > +		return;
>
> And actually, it makes sense to me to return -ENOMEM here and let
> reserve_mem_init() bail out before registering notifier if fdt preparation
> failed.
>
> That will save the checks in reserve_mem_kho_finalize() because it would be
> called only if we have reserve_mem areas and fdt is ready.
>

Sounds good!

> > +	}
> > +
> > +	fdt = page_to_virt(kho_fdt);
> > +
> > +	err |= fdt_create(fdt, PAGE_SIZE);
> > +	err |= fdt_finish_reservemap(fdt);
> > +
> > +	err |= fdt_begin_node(fdt, "");
> > +	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
> > +	for (i = 0; i < reserved_mem_count; i++) {
> > +		struct reserve_mem_table *map = &reserved_mem_table[i];
> > +
> > +		err |= fdt_begin_node(fdt, map->name);
> > +		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
> > +		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
> > +		err |= fdt_property(fdt, "size", &map->size, sizeof(map->size));
> > +		err |= fdt_end_node(fdt);
> > +	}
> > +	err |= fdt_end_node(fdt);
> > +
> > +	err |= fdt_finish(fdt);
> > +
> > +	if (err) {
> > +		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
> > +		put_page(kho_fdt);
> > +		kho_fdt = ERR_PTR(-EINVAL);
> > +	}
> > +}
> > +
> > +static int __init reserve_mem_init(void)
> > +{
> > +	if (!kho_is_enabled())
> > +		return 0;
> > +
> > +	prepare_kho_fdt();
> > +
> > +	return register_kho_notifier(&reserve_mem_kho_nb);
> > +}
> > +late_initcall(reserve_mem_init);
> > +
> > +static void *kho_fdt_in __initdata;
> > +
> > +static void *__init reserve_mem_kho_retrieve_fdt(void)
> > +{
> > +	phys_addr_t fdt_phys;
> > +	struct folio *fdt_folio;
> > +	void *fdt;
> > +	int err;
> > +
> > +	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
> > +	if (err) {
> > +		if (err != -ENOENT)
> > +			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
> > +				MEMBLOCK_KHO_FDT, err);
> > +		return ERR_PTR(err);
>
> Wouldn't just 'return NULL' work here?

If we have multiple `reserve_mem` in the kernel command line,
reserve_mem_kho_revive() will also be called multiple times. However
reserve_mem_kho_retrieve_fdt() should only be called once.

Here I am returning the ERR_PTR(err) such that if the first
reserve_mem_kho_retrieve_fdt() failed, subsequent reserve_mem_kho_revive()
can tell that reserve_mem_kho_retrieve_fdt() has failed so no need to try it
again. If we return NULL here, subsequent reserve_mem_kho_revive() would find
kho_fdt_in == NULL, and it could not tell whether it was due to previously
failed reserve_mem_kho_retrieve_fdt(), or it is the first
reserve_mem_kho_revive().

> > +	}
> > +
> > +	fdt_folio = kho_restore_folio(fdt_phys);
> > +	if (!fdt_folio) {
> > +		pr_warn("failed to restore memblock KHO FDT (0x%llx)\n", fdt_phys);
> > +		return ERR_PTR(-EFAULT);
> > +	}
> > +
> > +	fdt = page_to_virt(folio_page(fdt_folio, 0));
>
> 	fdt = folio_address(folio);

Fixed.

> > +
> > +	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
> > +	if (err) {
> > +		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
> > +			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return fdt;
> > +}
> > +
> > +static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
> > +					  phys_addr_t align)
> > +{
> > +	int err, len_start, len_size, offset;
> > +	const phys_addr_t *p_start, *p_size;
> > +	const void *fdt;
> > +
> > +	if (!kho_fdt_in)
> > +		kho_fdt_in = reserve_mem_kho_retrieve_fdt();
>
> I'd invert this and move to reserve_mem_kho_retrieve_fdt(), so there it
> would be
>
> 	if (kho_fdt_in)
> 		return kho_fdt_in;
>
> 	/* actually retrieve the fdt */
> 	kho_fdt_in = fdt;
>
> 	return fdt;
>
> and here
>
> 	fdt = reserve_mem_kho_retrieve_fdt();
> 	if (!fdt)
> 		return false;

Ah Ok, this is more elegant!

> > +
> > +	if (IS_ERR(kho_fdt_in))
> > +		return false;
> > +
> > +	fdt = kho_fdt_in;
> > +
> >[...]
> > --
> > 2.49.0.604.gff1f9ca942-goog
> >
>
> --
> Sincerely yours,
> Mike.

Best,
Changyuan

---- 8< ----
From 7ad4379062aa9709d3702bfc53d237d0c1a4e326 Mon Sep 17 00:00:00 2001
From: Changyuan Lyu <changyuanl@google.com>
Date: Thu, 24 Apr 2025 01:10:24 -0700
Subject: [PATCH] fixup! memblock: add KHO support for reserve_mem

This patch includes the suggested changes from
https://lore.kernel.org/lkml/aAeaJ2iqkrv_ffhT@kernel.org/ and can be
squashed with "memblock: add KHO support for reserve_mem".

Fixes: 2e257a656639 ("memblock: add KHO support for reserve_mem")
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 69 +++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3571a859f2fe1..d38a72f07ea0c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2490,15 +2490,6 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
 {
 	int err = 0, i;

-	if (!reserved_mem_count)
-		return NOTIFY_DONE;
-
-	if (IS_ERR(kho_fdt)) {
-		err = PTR_ERR(kho_fdt);
-		pr_err("memblock FDT was not prepared successfully: %d\n", err);
-		return notifier_from_errno(err);
-	}
-
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];

@@ -2528,19 +2519,14 @@ static struct notifier_block reserve_mem_kho_nb = {
 	.notifier_call = reserve_mem_kho_notifier,
 };

-static void __init prepare_kho_fdt(void)
+static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
 	void *fdt;

-	if (!reserved_mem_count)
-		return;
-
 	kho_fdt = alloc_page(GFP_KERNEL);
-	if (!kho_fdt) {
-		kho_fdt = ERR_PTR(-ENOMEM);
-		return;
-	}
+	if (!kho_fdt)
+		return -ENOMEM;

 	fdt = page_to_virt(kho_fdt);

@@ -2565,18 +2551,30 @@ static void __init prepare_kho_fdt(void)
 	if (err) {
 		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
 		put_page(kho_fdt);
-		kho_fdt = ERR_PTR(-EINVAL);
+		kho_fdt = NULL;
 	}
+
+	return err;
 }

 static int __init reserve_mem_init(void)
 {
-	if (!kho_is_enabled())
+	int err;
+
+	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;

-	prepare_kho_fdt();
+	err = prepare_kho_fdt();
+	if (err)
+		return err;
+
+	err = register_kho_notifier(&reserve_mem_kho_nb);
+	if (err) {
+		put_page(kho_fdt);
+		kho_fdt = NULL;
+	}

-	return register_kho_notifier(&reserve_mem_kho_nb);
+	return err;
 }
 late_initcall(reserve_mem_init);

@@ -2586,33 +2584,38 @@ static void *__init reserve_mem_kho_retrieve_fdt(void)
 {
 	phys_addr_t fdt_phys;
 	struct folio *fdt_folio;
-	void *fdt;
 	int err;

+	if (kho_fdt_in)
+		return kho_fdt_in;
+
 	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
 	if (err) {
 		if (err != -ENOENT)
 			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
 				MEMBLOCK_KHO_FDT, err);
-		return ERR_PTR(err);
+		goto out;
 	}

 	fdt_folio = kho_restore_folio(fdt_phys);
 	if (!fdt_folio) {
 		pr_warn("failed to restore memblock KHO FDT (0x%llx)\n", fdt_phys);
-		return ERR_PTR(-EFAULT);
+		err = -EFAULT;
+		goto out;
 	}

-	fdt = page_to_virt(folio_page(fdt_folio, 0));
+	kho_fdt_in = folio_address(fdt_folio);

-	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
+	err = fdt_node_check_compatible(kho_fdt_in, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
 	if (err) {
 		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
 			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
-		return ERR_PTR(-EINVAL);
+		err = -EFAULT;
 	}
-
-	return fdt;
+out:
+	if (err)
+		kho_fdt_in = ERR_PTR(err);
+	return kho_fdt_in;
 }

 static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
@@ -2622,14 +2625,10 @@ static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
 	const phys_addr_t *p_start, *p_size;
 	const void *fdt;

-	if (!kho_fdt_in)
-		kho_fdt_in = reserve_mem_kho_retrieve_fdt();
-
-	if (IS_ERR(kho_fdt_in))
+	fdt = reserve_mem_kho_retrieve_fdt();
+	if (IS_ERR(fdt))
 		return false;

-	fdt = kho_fdt_in;
-
 	offset = fdt_subnode_offset(fdt, 0, name);
 	if (offset < 0) {
 		pr_warn("FDT '%s' has no child '%s': %d\n",
--
2.49.0.805.g082f7c87e0-goog

