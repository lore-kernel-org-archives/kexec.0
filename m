Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B6C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PsfxTkGnDrUalYoqPsjagWTKprwMoObykyFymmVhNZw=; b=0NWBy7trABJtHY
	yXG0N0ouPG6UdxrwQ9vGO+5Tm4VAtFGT8dT4x1Qnn9Y1k7FK08OPundVSilwk1KE7K4U9+Jm9vshw
	O/EkGMTRzKM47YZK+AnBlY+M9vtuP/eYSzl2yX4jadg0W8BRHgPPELqwM+rK/xevrPUgBsfG1LBws
	Jqn99SPB0zw7pw+GZfO3URClvlTHKU2HbG25u1yg3TeE1VkNaKzh46ll0Xc0PFZTF3jRvcdT2fEf3
	QfGLGkWnYWDYqNsWtX53Pf1nSsgcWUVdBF5o/+gTV7tsZ/GbtzbtDzNqgXxNx7uEdclQjFSjxjjC9
	FitIs9WG9eJyMY2XI3Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdvW-00000004YpY-2gLV;
	Wed, 24 Apr 2024 14:48:50 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdvS-00000004Ymp-3uRv
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 14:48:49 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 772CD40E01C5;
	Wed, 24 Apr 2024 14:48:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XLd7nMXK0Fye; Wed, 24 Apr 2024 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713970119; bh=tjC6kbIr72reDuf9fcXqQKN7h4mHTtbXsy/eWk74eZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+2PY5Ta+lHyRxxNJSlJwQ5urkqTd4H+Hr14nUq7gG+spBXAIVklTASyiwNcNHHAk
	 hdvzGpzTi6fY607KTQkumCruYGuepitchzLYsJVP0iG2e5BIzSLjImAQsptoM9P7qD
	 ZZH1FwH3sNCWtRUHK9XngiJHLXJU8pzfzxn6CEmB2mAilIXVz/rmLtygdgpUhrLLn9
	 WAwH1nLzdr83Ekqoe8dh7Bdgj3OPLJG/auiRjmkHUi8krWxJQknvcJNgoxoJLGRl0w
	 KBGGmVg4Qo11IojdDN8IouZBxnwxJ0K8n3xJRDm1A6y91MFR4BAsEa0PR4ANHmccB4
	 qz6Q52ZCQanT3MrUhBby47H+bGLO2wXPgpgXzx944Zol/REKGHjSW9DChi4vmVelOk
	 zFY/x7Gdubv3jwge6uVxvIqJVP3b5GKE0wvhl+yYKanqVfAgER77XJ2fP2mmVH8dXC
	 DGjcKcinJFeMp8yJisGBWki9dt7nrVAuB46xtomsxGRdOOmMebZsjjPqc9e2EYj5Rf
	 +uc6GCylVDXWN4ndTKv/m0/aPBnibzcWRDFIMz3Zi70j4fGqv7Vo4FbAwZrUQ72DuL
	 D82uM0aOTgfsxyLZzN20teZOzI2tWnbtfuja3yp8Fm99pswovFg9T6NoQvm9+eHvbn
	 p9qAzvoW8BesW0V7EghQrTww=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD91D40E016B;
	Wed, 24 Apr 2024 14:48:12 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:48:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_074847_153691_2F29E521 
X-CRM114-Status: GOOD (  27.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Apr 15, 2024 at 11:22:58PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.

Please use this or similar scheme when formulating your commit messages.
This above is too laconic.

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec.

That sentence needs sanitization.

> kexec_enter_virtual_mode() during late init will remap the efi_memmap
> physical pages allocated in efi_arch_mem_reserve() via memblock & then

s/&/and/

This is not code. Please take a greater care when writing commit
messages - they're not write-only.

> subsequently cause random EFI memmap corruption once memblock is
> freed/teared-down.

"torn down"

> Suggested-by: Dave Young <dyoung@redhat.com>
> [Dave Young: checking the md attribute instead of checking the efi_setup]
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..982f5e50a4b3 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,12 +258,28 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> -	if (efi_mem_desc_lookup(addr, &md) ||
> -	    md.type != EFI_BOOT_SERVICES_DATA) {
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first

Make all your text impersonal - no "we", "I", etc.

> +	 * kernel via setup data, so we need to skip this.

What exactly do we need to skip?

If the EFI memory descriptor lookup fails?

> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
> +	 */

Why is that comment here and what is its relevance to the line it is
above of?

> +	if (efi_mem_desc_lookup(addr, &md)) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>  		return;
>  	}
>  
> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
> +		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);

What is this pr_err() useful for?

> +		return;
> +	}
> +
> +	/* Kexec copied the efi memmap from the first kernel, thus skip the case */

kexec? This is a generic function - what does it have to do with kexec?

The subject of this patch is:

Subject: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec

and yet, nothing skips this function - it adds a bunch of checks,
printks and early returns with the intent that those early returns
happen on kexec and thus the actual memremap doesn't happen there.

So it is some sort of: let's check things which will be true in
a kexec-ed kernel and thus avoid the function by returning early.

But I have no clue.

It sounds to me like you need to go back up, to the 10000ft view and
explain how exactly this efi_mem_reserve() causes trouble for the
kexec-ed kernel so that we can think of a proper solution, not some
random hackery.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
