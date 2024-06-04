Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441C1C25B75
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=72Lk31L25CgZoOdHPGshFuAIgwAoBq3YEUJ7EErlmFw=; b=NUaQLT2tmN4z4b
	dWhGk9AIq80G2LOmNCuZDBliGc/pY1ahGf5vgRMmYca0r421rUXwfgVZKxWKy8BufEJSzzL0YfQYs
	3riz3Chfxbrl31zimnr+0jecVxbTNBYWO1TJP8WtHK/lFXRGMYtCI81GnyruNxejBmqYpeUPSL7IA
	4sOvf0xaFrQ6MATfTLe8rEh9TySnj5ol97nGgIpqi+bV7TfPrlUaG61jxdjbIdf77CePK1qVb7Z98
	Q2ZvAny6VRZjEBc3Jb/feOS2Swe8T5vmOt0sX5FFsatvv6u7HuOJvkgHJkzBtbYzcrE4doG+Ih0Ni
	Hz8hWH5afqOadzOhfnrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEIty-00000000oG9-0Rbe;
	Tue, 04 Jun 2024 01:23:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEItu-00000000oEo-34Oi
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 01:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2uM4DFyGxLz048gnN/tqwhjQvWlr4twzxXFxXx0Uho=;
	b=WuS9/Q6IYgg30Ef/CFxjRfn6Df8OSNZisEuOP/YXJbTJLNKPgK6A2ILub2N0ZJ7VYVDk5a
	ULbemf27QBEvjmCh4pccxGDm+XChUlmg2tLh0Om7yTjAP4JcX6o9rvTvwNfzyV2iOuWcnB
	EhWG4hdb8aha9vvL/b/JwSMb+6eejAk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Qe7XhFllNkWnybm3Rb5t6Q-1; Mon, 03 Jun 2024 21:23:40 -0400
X-MC-Unique: Qe7XhFllNkWnybm3Rb5t6Q-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374907a1f84so5814735ab.0
        for <kexec@lists.infradead.org>; Mon, 03 Jun 2024 18:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717464220; x=1718069020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2uM4DFyGxLz048gnN/tqwhjQvWlr4twzxXFxXx0Uho=;
        b=nZnq0OPbl5y3GL70t5+mp55Lo4AHbFMQcIz+E0RlYABUs9Ex6wlPwXhoZlJOYF3bMh
         6c/Df08Ov4RzvTz/QTShzU0Xt4L04WrByZFk0X58R8Z5buYsFoQX0DeHaQdg/M57OdGF
         KAoruIqXR/+fYCbNfIBGa1L04YzLq3FTAFnE2rq+CNs+MFJaXPGAIXXkwBzkslolCzEr
         pPymQ04ZftDg68+2o+o6y5SaTlPrL41vRX01AQwek6DpbLhKuuYhtEbAq2YhYTuYEgAl
         UiHKvF6dLe18WO92pQMfmRSZN3nszBy9FMdTi/RGYqO7yAPhmDzssPGOX5IA8T+m0H6r
         HOTA==
X-Forwarded-Encrypted: i=1; AJvYcCW3fF+vd7XJ6u+dReGGu0phcB6epUzzNBheEpXYYT18/KzBXsWBseqY/qUSJDXBn3RSb2wKKcEhwPGYQ2oBy6tc0Zs3zHXEvcjN
X-Gm-Message-State: AOJu0YzpNtY1w6OoPTSD4sbpmhLKgxwQw8ORK0EIHWWH28P686RGun+Y
	+K08TLKvVbcIrqxQvB5TDOArRvjagsgvRJ1CZvBZOsKGk0SATN5hyrCiqa5JGLFkZkQEqxEZLx2
	66szDzGGIqhM1kDw+CQEJ7RdS4LAlUfU52yGUkyOWXQtSKMTCbk1ne+G1Mk9pSiV+QlevuWDMVC
	IaNx9mqStVonMJ0wvgw3QzrSdLjFk1YwJl
X-Received: by 2002:a05:6e02:12cf:b0:36d:cb9d:cc9e with SMTP id e9e14a558f8ab-3748b9cfee7mr107650525ab.2.1717464220134;
        Mon, 03 Jun 2024 18:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg3MFJebi0AMEiF/DB64qHywmC9po1Ki163doJb0ZzhuVzWAmCpVqYYvMl/8ZsNk38RNQy2ClsQBbegQbN6zk=
X-Received: by 2002:a05:6e02:12cf:b0:36d:cb9d:cc9e with SMTP id
 e9e14a558f8ab-3748b9cfee7mr107650315ab.2.1717464219826; Mon, 03 Jun 2024
 18:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com> <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
In-Reply-To: <Zl3hwYL2GDiyUfGo@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 4 Jun 2024 09:23:58 +0800
Message-ID: <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_182346_872535_BAF9A28F 
X-CRM114-Status: GOOD (  19.70  )
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

On Mon, 3 Jun 2024 at 23:33, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
> > On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> > > If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> > > for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> > > virtual address as the first kernel and not the allocated memblock address.
> >
> > Are you saying that we should simply do
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index fdf07dd6f459..410cb0743289 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
> >       if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
> >               return;
> >
> > +     if (kexec_in_progress)
> > +             return;
> > +

kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
But eif_mem_reserve is only called during the boot time so checking
kexec_in_progress is meaningless here.
current_kernel_is_booted_via_kexec != is_rebooting_with_kexec

The code change below in the patch looks good to me, but I'm not sure
what caused the memory corruption, it indeed worth some more digging,
maybe SEV/SNP related.
+       if (md.attribute & EFI_MEMORY_RUNTIME)
+               return;

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
