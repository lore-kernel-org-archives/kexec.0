Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC9ECA0EFA
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zIhJS+qV0HEjPxscJj4E1pYztwxEESljU9V7YVyocZY=; b=iia8qB9aGu6IKzF1ObFXzkNK3E
	Wbeb+UMAAvOGk+8OfCxAOwuHIgKJVLt9DAPPQkSls+lGRbPKYM6OytFqbbAFCLu5tAkHy5m30lmWH
	bMBZugnKJL6eIIzKTC4kDkBWrW+QSmi+l7UrKBIVl8zOJ/KXabteKt5dTb2Vvgkw1fGWCbS58H1/l
	v6+HMmX9gDab4MZESifhqptbyFCqIRl8ZMZIcB/Unyx6t9qeXDEPW7rnhYGsEHuxnVvGDFdFfmnHQ
	uO+PU4T83K6z3YNq19SiEe+4fOTAwv9RqYprcDuoeaqgEieTISrQdOpDrCBIS8j3MjdSEzowQw9T5
	9wNhFwKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoepu-0000000Cr9k-0ozO;
	Wed, 20 Aug 2025 09:10:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe3w-0000000CiVB-20cM
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 08:20:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DFBD161428;
	Wed, 20 Aug 2025 08:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B1C4CEEB;
	Wed, 20 Aug 2025 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755678050;
	bh=F2is9zfwLMGTq7xfkgAalDyZte6T3DvSchJ62PdSzbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oD4rECWnKxGis9qi02Vw4EZJJf6aHsdLFojZnMJh7ZquqKdZ0wuyZgD6pAwCRLWGK
	 VhvMM83b+X4a15JnGeQLjSFRIBakJbjp0WPVbTfhnCIexW76mS4jbaRroP7CgIKzCz
	 Ycuo36/5Plzwz0if77Dd3AG6UGjI86yEE+D7ctWWpIiplNP16CZqCedYPYwnHLOZ8T
	 qOV9TOkmxnXpDJQf+HQyg9npiG7OMbMeSNY8q25t4qgZWiuscep7LvoVnNM/BJvWFy
	 KHdPN4SYvY3V56XaGzPRd+pa/2h9bGQxp2sQng3TXHvuew4n4Dii7cmHpXr8IjFYmJ
	 HyGfv75T5Ixcg==
Date: Wed, 20 Aug 2025 11:20:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 0/2] efi: Fix EFI boot with kexec handover (KHO)
Message-ID: <aKWFWsk0mPPQFDyk@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755643201.git.epetron@amazon.de>
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

On Tue, Aug 19, 2025 at 11:22:44PM +0000, Evangelos Petrongonas wrote:
> This patch series fixes a kernel panic that occurs when booting with
> both EFI and KHO (Kexec HandOver) enabled.
> 
> The issue arises because EFI's `reserve_regions()` clears all memory
> regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
> from EFI data. This destroys KHO scratch regions that were set up early
> during device tree scanning, causing a panic as the kernel has no valid
> memory regions for early allocations.
> 
> The first patch introduces `is_kho_boot()` to allow early boot
> components to reliably detect if the kernel was booted via KHO-enabled
> kexec. The existing `kho_is_enabled()` only checks the command line and
> doesn't verify if an actual KHO FDT was passed.
> 
> The second patch modifies EFI's `reserve_regions()` to selectively
> remove only non-KHO memory regions when KHO is active, preserving the
> critical scratch regions while still allowing EFI to rebuild its memory
> map.
> 
> The patchset was developed/tested on arm64.
> 
> On a side note, I have noticed that `kho_populate()` calls
> `memblock_set_kho_scratch_only()`, but the `kho` cmdline option is
> not checked until much later. Therefore, memblock will use only the
> scratch regions that were passed from the outgoing kernel, even if the
> incoming kernel doesn't explicitly want that. I am not sure if this is
> done on purpose, but in any case we can discuss this in another patch,
> as it is orthogonal to this one.

kho_populate runs earlier than we parse the command line, so there is an
implicit assumption that we are going through KHO-enabled kexec if FDT was
passed to the new kernel.

I believe the best way is to document that and make it more explicit that
kho command line parameter only affects the "out" part.
 
> Main Changes in v2 (smaller changes can be found in individual patches):
>     - Introduce is_kho_boot()
>     - Replaced manual loop with for_each_mem_region macro
> 
> Evangelos Petrongonas (2):
>   kexec: introduce is_kho_boot()
>   efi: Support booting with kexec handover (KHO)
> 
>  drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
>  include/linux/kexec_handover.h  |  6 ++++++
>  kernel/kexec_handover.c         | 20 ++++++++++++++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.

