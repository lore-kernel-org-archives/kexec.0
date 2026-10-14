Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835C6CC6B1D
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6FYbrevdgrlXICYbDisVp02TqxYzxOau98WxnsCDnI=; b=TCL1iVKsGFlOvG0KG96DSSX4KK
	sjduLPw6/h2q1qr6Wcl5XH+6hUKV1Er6zoGh8I8vqBe+klJ+/CMg+os/upzMyLJhwjFhfHAg6ML81
	SfFnXrilZDWCaahTS6MugPjc4O1LLOcfaXWthQIDtZEIy1qS1NvWVREImRTSgWl0Np44Jb0Dmfze6
	mfBoCRK4fX435bU9vL2COFoEG0aShAbFpBxt3xkosS3oh8tZ7bGi8cqZZ0YaPpKqssN60UCUQTPjZ
	Ytq/H+hDAGx7wBfDzmjm/hQ7Xvdbki71LrDXzk+CrnCH8ezCF1f85Jtv6w2eMxcuyc4nvYBkvwPot
	jWrSRcvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGz0z-0000000FarA-1r25;
	Wed, 14 Oct 2026 13:27:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGz0y-0000000Faqz-0Okc
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 13:27:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C168C4195E;
	Wed, 14 Oct 2026 13:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6584D1F000FF;
	Wed, 14 Oct 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984447;
	bh=S6FYbrevdgrlXICYbDisVp02TqxYzxOau98WxnsCDnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gVkrlyYfgDvpgrb7kze2duhicGcq3rSl8DlaBsTLrcLorOyEQvmWmjkhvZG+6Befu
	 qyk1+RMK6ed4hSQb3i0gAE+D63knm92zH7LCvpNDE6pVsnvyTVirj4/1yVS6zI7uAX
	 qjYkV+/of6+83KlH8ZYzkohfPvlNr7b3LhC7p/yz5AwwXn43j6c5z428J9+8wy0rXr
	 jyz1yOarQu0AlMDubM3cOFHyTaTQgIe6hEHNp88aZBeguaQC+ELOv5GX2IpX7pvfO7
	 jzpdOM+3WLWeywdQfwUzi1gL8zKWAKcUMYoIRnuc005OdnxXcnQsZSYj5PdEURKYqg
	 OWFzyOXokHcxA==
Message-ID: <sashiko-outbox-171352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kho: do not reserve empty per-node bootmem areas
To: "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>
Cc: kexec@lists.infradead.org, "Bing Jiao" <bingjiao@google.com>
In-Reply-To: <20261014131547.259138-1-pratyush@kernel.org>
References: <20261014131547.259138-1-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:27:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kho: incomplete fix for zero-size memblock allocations in bootmem
--

commit 67ab500bd948f5a3b52f1c8170626cb8f1dfc6c3
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: do not reserve empty per-node bootmem areas

Some nodes do not allocate any early boot memory, causing memblock to
return an address without reserving anything when requested with zero size.
This address is recorded in kho_bootmem with a size of 0, and can cause KHO
to fail to initialize. This patch skips bootmem reservation for memoryless
nodes entirely.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 7018e25e4eda1..6f1f55fe31819 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -882,6 +882,9 @@ static void __init kho_reserve_bootmem(void)
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		size =3D bootmem_size_node(nid);
> +		if (!size)
> +			continue;
> +
>  		addr =3D memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,

[Severity: High]
This adds a zero-size check for per-node bootmem allocations, but does the
same issue exist for bootmem_size_lowmem and bootmem_size_global?

Looking at kho_reserve_bootmem() just before this hunk, they are allocated
without a similar check:

kernel/liveupdate/kexec_handover.c:kho_reserve_bootmem() {
    ...
	size =3D bootmem_size_lowmem;
	addr =3D memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
					 ARCH_LOW_ADDRESS_LIMIT);
	if (!addr) {
    ...
	size =3D bootmem_size_global;
	addr =3D memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
	if (!addr) {
    ...
}

If bootmem_size_lowmem or bootmem_size_global evaluates to 0 (for example
via boot parameters or on systems lacking lowmem), will memblock return an
unreserved address and add it to kho_bootmem with size 0? Alternatively,
if the region has no free memory, could the 0-size allocation fail and halt
KHO initialization entirely?

Later, if KHO attempts to preserve a contiguous range of pages that spans
across this unreserved boundary, could kho_bootmem_overlap() incorrectly
evaluate the overlap and fail the preservation request?

>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
>  		if (!addr) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014131547.2591=
38-1-pratyush@kernel.org?part=3D1

