Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09112CC6B34
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3cnb+CSUe1D6LlSmFXne5YIHwXccTXJokwdIUD0wOs=; b=TI1UPjR9eCyhCBQwaWR7RmEdGJ
	XOv6DPKHBxgbq03hRuMSovU4pQ+9wuebesqPbwUkO4FV8Vw6lYgd8asX5ZmdlXKsyLnHA43Sxu6h5
	oY/g5bsNC60BEgkyD+HKcdlICXMNs0lA1MArFK6KEMgVlsZ6mFZuHPWkwdWyYN16Rule7Mp/5CVGY
	BECWEWviUXJRzN0pdMWKsXipz2RmrRkNIau04iMxrPXqPbdkOvD08nkyof8MHVczTOfX/fIzU41VK
	nHqVEVjzvFBt3y3EBGnRqZa0zW5MUNanCRcHo+1i+Hm6wKxnBiJQuSqjEWBhViFDAkfYFV8eP4R1O
	TtbbEqTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMvY-00000000SoR-3mor;
	Thu, 15 Oct 2026 14:59:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMvW-00000000So5-2ORY
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 14:59:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 552E143934;
	Thu, 15 Oct 2026 14:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00921F000C4;
	Thu, 15 Oct 2026 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076366;
	bh=c3cnb+CSUe1D6LlSmFXne5YIHwXccTXJokwdIUD0wOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XrnaYAohNUtvoeDttvfYlbaOAZGBShDNzVtp+IekE3Usk9Gkbz+2uK258I6v+lpPW
	 BbWMxvVIgD2GoY/iRozVonZEJ4F8xPnpkiEj2/SSU8Ij1lmAY6g52d4377fBt6tDRG
	 sADIDV2PlgtoDvN7GbrGe/X/6BABfRRxpI4DvldNno7lK5NZXpwxK+5MpTrlBsTeZ1
	 eqXQF7SySEiTu9rZ8pT7ZZC9G5assgBJW5bUA5CUw/9BplkLqON/9Pkf/4hiuKBq4A
	 t4YTzhCUQRjH9kZGg6NTWM6JROirJsYrogDlkCyEmskn/7+yr1qqC6PHN4YGuyVWUU
	 m5qkeXwzTvcSQ==
Message-ID: <sashiko-outbox-173017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using
 free_page() in __kho_abort()
To: "Federico Parola" <fparola@amazon.de>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org, nh-open-source@amazon.com
In-Reply-To: <20261015144529.76911-3-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
 <20261015144529.76911-3-fparola@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:59:25 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: use-after-free of physxa in __kho_preserve_order() racing with=
 abort
- [Medium] mm: memory leak of kho_vmalloc_chunk pages on KHO abort
--

commit a7bcf7c6e605c88c110bdd87cec6fe96445bb703
Author: Federico Parola <fparola@amazon.de>

kho: free phys_bits bitmaps using free_page() in __kho_abort()

This commit fixes a memory leak in KHO abort by replacing kfree() with
free_page() for releasing bitmap pages allocated via the buddy allocator.
Using kfree() on non-kmalloc buddy pages previously hit a WARN_ON_ONCE() and
leaked the pages during teardown.

> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 9fe5d14f1ec54..9691f6bc2fba7 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1054,7 +1054,7 @@ static int __kho_abort(void)
>  		unsigned long phys;
> =20
>  		xa_for_each(&physxa->phys_bits, phys, bits)
> -			kfree(bits);
> +			free_page((unsigned long)bits);
> =20
>  		xa_destroy(&physxa->phys_bits);
>  		kfree(physxa);

[Severity: High]
Does this code introduce a use-after-free? The physxa structure is freed
without being removed from the XArray first, leaving a dangling pointer
visible to lockless readers until xa_destroy(&kho_out.ser.track.orders)
eventually clears the array.

If a driver calls kho_preserve_folio() concurrently with another thread
calling kho_abort(), could __kho_preserve_order() load the physxa pointer
locklessly and dereference it just after it is freed here?

kernel/kexec_handover.c:__kho_preserve_order() {
    ...
    physxa =3D xa_load(&track->orders, order);
    if (!physxa) {
        ...
    }

    bits =3D xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
    ...
}

[Severity: Medium]
Does this code leak kho_vmalloc_chunk pages? When __kho_abort() drops the K=
HO
state by destroying the XArrays, it leaves the driver's metadata chunk
pages untracked.

In kho_preserve_vmalloc(), these pages are allocated and linked only to the
driver's struct kho_vmalloc object:

kernel/kexec_handover.c:kho_preserve_vmalloc() {
    ...
    chunk =3D new_vmalloc_chunk(NULL);
    if (!chunk)
        return -ENOMEM;
    KHOSER_STORE_PTR(preservation->first, chunk);
    ...
}

Since kho_vmalloc_free_chunks() is static, and there is no exported
kho_vmalloc_unpreserve() API, drivers cannot free these chunks inside their
KEXEC_KHO_ABORT notifiers. Doesn't this mean these pages are permanently
leaked whenever KHO finalization is aborted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015144529.7691=
1-1-fparola@amazon.de?part=3D2

