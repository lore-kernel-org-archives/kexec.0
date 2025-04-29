Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6955EC3ABA5
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOAoClMcBjLU+CqkVXLT7D9MbeyBuOnbKGqbxUcqpgQ=; b=fsysFLRBRJH35viF+6MjSlFr1v
	+GOX32xqy2B5856a5svzdVkfJjzItI1V0uXiBr0ZQ3L96kuJ6AFZml9Vy3S5ElYG3SnzZK/vtxJfv
	b3zCEbXQk5Fb8T+GEpy+0oqNtlRQxwMmklNPPK1XbK6URwaR+bPbbQ7FPEOWI2nknEUmxpRO1JYns
	oPNIj4dju8qr6FzRTWVHzqYoDJ93CxZCC+rs4hC8QLNn65Leu3GFSZHmWzIe25GZYqyEmwRoB8je/
	xbla2Bk7U6fYkKhFl75RZJbyR7ZdZVBEbj3QAVv2GqMzc7gr7yK6nPMLvmfVoVKCtTuDjV32T9wuO
	D5OqTQqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9p28-0000000ARhU-2lhj;
	Tue, 29 Apr 2025 17:46:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nvH-0000000AGsx-3GVX;
	Tue, 29 Apr 2025 16:35:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B2A1A615CC;
	Tue, 29 Apr 2025 16:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C094CC4CEE3;
	Tue, 29 Apr 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745944506;
	bh=+UGyRtEyWANVYEtyHHifh4EloDW/BOB+dVBrXx8R5aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv4+V9oEHFFoqPKi4JJC4Rggve0BsZAvaDzvh4SEQuECW785vJ5yPZ4AatV4KqWu6
	 wuF2qFRqPfjjSeYHDw7enNzhmN+iUgUUbapSZvr+Dz1qVv8qFyUfXoil/gPujvw11w
	 qoFYOIY78wNSefF32YipQjxSwHAcW3XOmHqgg1S2VM0PWb8PBDGDdDJRkMRAooSKa4
	 dtKpsbh7N+d9YIvzbEGIi3+RyayqE2xFI+WA5HeWOtGFHWzSkmRs90NjfbDCTTecMx
	 dcRb1imHHNN+d2crW1PnDFXSnrtBlXapjqWlicbZjIMRypxWwu/J1ycGlUtEr3CMqd
	 0B2+9D5ZaXxeQ==
Date: Tue, 29 Apr 2025 19:34:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 11/14] x86: add KHO support
Message-ID: <aBD_rOvMPk5_iT9J@kernel.org>
References: <20250411053745.1817356-1-changyuanl@google.com>
 <20250411053745.1817356-12-changyuanl@google.com>
 <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
 <aBD165pVhOIl3_by@kernel.org>
 <e90b81a4-a912-4174-b6e9-46a6ddd92ee3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90b81a4-a912-4174-b6e9-46a6ddd92ee3@intel.com>
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

On Tue, Apr 29, 2025 at 09:05:02AM -0700, Dave Hansen wrote:
> On 4/29/25 08:53, Mike Rapoport wrote:
> > On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
> >> On 4/10/25 22:37, Changyuan Lyu wrote:
> >>> From: Alexander Graf <graf@amazon.com>
> >>>
> >>> +#ifdef CONFIG_KEXEC_HANDOVER
> >>> +static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
> >>> +{
> >>> +	struct kho_scratch *kho_scratch;
> >>> +	struct setup_data *ptr;
> >>> +	int i, nr_areas = 0;
> >>
> >> Do these really need actual #ifdefs or will a nice IS_ENABLED() check
> >> work instead?
> >>
> >>> +	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
> >>
> >> What's with the double cast?
> > 
> > The double cast is required for this to be compiled on 32 bits (just like
> > in mem_avoid_overlap). The setup_data is all u64 and to cast it to a
> > pointer on 32 bit it has to go via unsigned long.
> 
> Let's just make KHO depend on 64BIT, at least on x86.
 
Ok, so we are keeping #ifdef and dropping double cast here.

> >>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> >>> index 68530fad05f74..518635cc0876c 100644
> >>> --- a/arch/x86/kernel/kexec-bzimage64.c
> >>> +++ b/arch/x86/kernel/kexec-bzimage64.c
> >>> @@ -233,6 +233,31 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
> >>>  #endif /* CONFIG_IMA_KEXEC */
> >>>  }
> >>>  
> >>> +static void setup_kho(const struct kimage *image, struct boot_params *params,
> >>> +		      unsigned long params_load_addr,
> >>> +		      unsigned int setup_data_offset)
> >>> +{
> >>> +#ifdef CONFIG_KEXEC_HANDOVER
> >>
> >> Can this #ifdef be replaced with IS_ENABLED()?
> > 
> > The KHO structures in kexec image are under #ifdef, so it won't compile
> > with IS_ENABLED().
> 
> They shouldn't be. Define them unconditionally, please.
> 
> ...
> >> Please axe the #ifdef in the .c file if at all possible, just like the
> >> others.
> > 
> > This one follows IMA, but it's easy to make it IS_ENABLED(). It's really up
> > to x86 folks preference.
> 
> Last I checked, I'm listed under the big M: for "X86 ARCHITECTURE". ;)

I remember :)

-- 
Sincerely yours,
Mike.

