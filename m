Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356F606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VJINS7fY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Hf6ROo1D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWAuZEoa06/FId6EaCbOOGJEvcdb/dADU57niR/UVVQ=; b=VJINS7fYT6LPHn+edzogKMgUDM
	/wN2QJMUa0V0Gmj311uslYP3TCru13DArmjcjYzMTs7ra8WD+jDOojEZdLstrmSf7oeV1+LceUHUD
	NFu1QHOCc3VneW2hTjHYBOR4/hEa5oHtfClI+TsT4gPPZxBc3JClM5RIOJGMw6Bm1coH8wSQnmmB2
	n2Cb1MuT8sqDs+jFNUPruyn2d2aGCVhX5itBSI5ZUEWpTObVx1kSZGKSAIsVSL3GuUUTJSmVhYF0P
	xzeDtBYe7Z4M2KAyWYeGLg9YXWKgcCrO1Os7kyAiHPCpvwJ5Holl5tpmVHWRzCbO33HEY4IHS+3ta
	o04LiMIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ525-000000098Ie-1fPt;
	Tue, 20 Oct 2026 08:17:17 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ523-000000098I5-0QwY
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 08:17:16 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2484780f8f.0
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792484232; x=1793089032; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mWAuZEoa06/FId6EaCbOOGJEvcdb/dADU57niR/UVVQ=;
        b=Hf6ROo1Dwtgwbi30VQ7Bh7oODpJFA5reN2oq3Md+PxUkh2hvD2LLiDONxSNPgVFidi
         36p/NiJyFG9GJsV4XTCMTfCpWiykszNrdpUxsGmxp9jzG18NaqClORbNO9HZpSFXF3tQ
         yqjkSZ5A/V1tXkhzlrCy/Cs43rUphXrrU2siquu4rKsoZaiShnZ592LRwSH8SSiKEv7B
         EJsAjJZpl9iY40shrwCkNxu/cqZUS3nqutr/mxF2jCm/ETlTZX41qOs5EgoIkViET5tJ
         uhMgkBGtWsGGI4rCSGbDeTEstiBwD52De77r0WDrv1TO2KkZCjHh2f2BFppIoFd65sg1
         i3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484232; x=1793089032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWAuZEoa06/FId6EaCbOOGJEvcdb/dADU57niR/UVVQ=;
        b=GOL0vD4G2QjmuSwSXoi5olka7q6E3oxaEBNNusLNAfB8J2NOL1kEOT2i4Q65LnH/k0
         bzhiZrD13snXBuFfRONGsCD7lv+ez2itR7ObhqUNKoXVajHcf2tn3GMS7epSLdjf144W
         UcxiCdB+WoZBI3Tpj3MuJeVY/z7CjhtnXEQSxgDrgyD+IBW9CVX2h1T1h6IuMBbvaY0x
         8DyDCROmMVuhIYb86A/NCaHSzcy4NkWeqt2+DHQurNg9NnpLUkihUu04+gAL4E/sG/1x
         7J7OUA//Tyi5ck/ij/AfhpHjC+VLPeSmrBeT3YJn9udVwsh13+XCNkWceUCqIc+IUsdy
         Jiew==
X-Forwarded-Encrypted: i=1; AKwUvByP3T2sNFQCO/sYWRRxmrTt9dgHxvu1vxcmQbnZKGmnmTa+w8efsBFX/vBC5x0HTtf47qmTgQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKGbZrhNI4Ke8GMSx1wvawdbAkjG+Y24st1e7H5M79A8gRPtEum
	FD5Jrs8NIBA/mVlEpv3taSu+VLj4NMUXbt/qcuvwrp31Uui7n5kX/LZVbJwL8bpf8nU=
X-Gm-Gg: AYBFou0Q+3i4RCr3oE7NTJO7WqJPvC1WZofgO2MnFXMH8xN+C06kUap2sRruJZYYGlM
	Sd63iL7+04O/ro+wSrWdPxOEf9NAz+KDQ12kYXiELjut7oVjCtPBfYTiO+cl0O8yIuL3PsHgtLs
	nATevSYC35kzrMUAWtyNPs9Qg/xJFKY6d39Lx72QQUC0NMyjfa/0nvfJf4b3UL1NxWLsILjyXpD
	BwpUQEbn5WteUwx5NWvf/0fVc+Lopukv9XnHKxPp6djV7qI91haHpadLo4B9g+ESLuS/zoZdzDC
	d901V6iqHYBrOjEyUrhz0KDXsoWH8MrLJFsNk6FZOV3XjNQLUfwnaOfsdpmpat++ThUnQf7cGGH
	8d78LJ4ocTCyTDuJZTjCdC5E+Kqw9IuT4i2vHNtgrpN6BzdusdvUXDCVVfK/R/6MBMv2mLE0Tiz
	4YmNAtzS04JqCYPaFWSo2t7I5KLsKFaIzC0CPK7KgMDByi0x7SuinTbhtUvD/W5NjcYCUos0SG
X-Received: by 2002:adf:f806:0:b0:48d:f99d:a0cf with SMTP id ffacd0b85a97d-48e07bbe7b8mr14525572f8f.16.1792484232267;
        Tue, 20 Oct 2026 01:17:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbd43sm3653817f8f.4.2026.10.20.01.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:17:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:17:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Message-ID: <atcjhe4329sYHWvZ@pathway.suse.cz>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
 <87v77p9t4h.fsf@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v77p9t4h.fsf@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_011715_186968_A57513F2 
X-CRM114-Status: GOOD (  50.77  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Bo Gan <bo.gan@broadcom.com>, "H . Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-09-28 10:35:10, Stephen Brennan wrote:
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> > This Message Is From an External Sender 
> > This message came from outside your organization. 
> > Report Suspicious 
> >  
> > Hi Petr, Zack - thanks for CCing me!
> > Some comments below:
> >
> >
> > On 18/09/2026 00:23, Zack Rusin wrote:
> >>> [...]
> >>> Maybe, we should start with something simple, and introduce
> >>> one more panic notifier as a start. It might be called either:
> >>>
> >>>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
> >>>     seems to be primary set on hypervisors.
> >>>
> >>> But I would rather make it more generic and call it
> >>>
> >>>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
> >>>     more notifiers which are either 100% safe and useful or are worth
> >>>     the risk before calling crash dump.
> >>>
> >>> We could put there x86/vmware notifiers as a start. And we could later
> >>> move there other important notifiers.
> >>>
> >>> How does that sound, please?
> >> 
> >
> > It's a good idea, IMO. We could start with this, Zach commented some
> > implementation details below...and after it gets merged, we could move
> > other hypervisors that currently set "crash_kexec_post_notifiers" to
> > this list and eventually, unexport this symbol. We should avoid having
> > code forcing this parameter, as Petr said, many notifiers are executed
> > if that is set.
> >
> > (I'm CCing Stephen Brennan here, I recall he had problems with this
> > being auto-set, we talked about that in the panic notifiers big
> > discussions in the past heh)
> 
> Hi Guilherme, thanks for CCing me! You're right, I'm interested too :D
> Your email arrived on the first day of my vacation, so I'm sorry for the
> delayed response.
> 
> I like the above idea, starting simple with a second list for the
> notifiers which are straightforward and have an urgent need to run.
> 
> My previous complaints were with code overriding
> crash_kexec_post_notifiers, because that really interferes with your
> mental model when debugging panic/kdump issues. Having two notifier
> lists is a reasonable mental model, or at least more understandable than
> silently and unconditionally modifying crash_kexec_post_notifiers.
> 
> I like the name "panic_pre_kdump" for my own tastes, though n==1 on
> that.
> 
> I do think we're going to have trouble articulating exactly what are the
> criteria for a "pre_kdump" notifier vs a "panic" notifier? Anyone
> submitting a patch believes their notifier is important, so of course
> they believe it belongs on the pre_kdump list! How will we draw the line
> in the future?
> 
> - Is it safety? As in "the notifier doesn't take any locks"? I feel
>   this should be part of the criteria. (Though I have never been
>   successful in predicting what code would cause a kdump/panic failure)
> - Is it urgency? As in "without this, the expected behavior of the
>   system during a panic will not occur".
> - Is it the fact that the notifier is communicating with the hypervisor?
> 
> >From my perspective: informing the hypervisor of a panic is both safe
> and urgent. If the hypervisor is configured to immediately halt and do
> its own panic handling, great.
> 
> Providing the last 4KB of logs seems less safe and less urgent (though
> obviously still immensely helpful). The kernel provides a huge variety
> of consoles through which the hypervisor could have already received
> these logs. If the system is configured not to use them... it seems the
> tradeoff to not be debuggable has already been made :P
> To me, that logic belongs in a standard panic notifier.
> 
> Plenty of people will likely disagree with me on that, but that's why it
> would be helpful to have clarity on what separates pre_kdump from
> standard panic notifiers.

The rule of thumb might be. If you think about setting

      "crash_kexec_post_notifiers = true"

because the notifier is required for a successful boot of the
crash kernel or successful reboot after the crash dump. Then
put it into "panic_pre_kdump" notifier list and keep
crash_kexec_post_notifiers disabled by default. Otherwise,
put the notifier into the normal "panic_notifier_list".

I agree that people might still want to cheat and put their pet
into the pre_kdump list even when it is not strictly needed.
This is why my original proposal suggested 4 lists. But
maybe 3 list might be enough:

  + panic_pre_kdump_notifier_list: for the "must-to-have" stuff.
	 It ideally should be 100% safe.

  + panic_notifier_list_safe: for dumping extra information where
	the code is 100% safe (modulo bugs). It means no locks,
	no waiting, no blocking HW access, ...

  + panic_notifier_list_unsafe: for dumping extra information
	which is not 100% safe, aka using trylock, potentially
	dangerous HW manipulation, ...

By default, the first two "safe" lists would run before the kdump,
and the unsafe one would run after the kdump.

Does it make sense?

> > The only thing I'd like to suggest: I think we should have a parameter
> > that disables running this list, which would be the opposite of
> > "crash_kexec_post_notifiers".
> >
> > I would implement it as something like: "postpone_pre_kexec_notifiers"
> > or something like that. The parameter would basically "move" this list
> > execution to the same time as the current notifiers, gating them to
> > "crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
> > failures maybe related to the "early" notifiers. WDYT?
> 
> Agreed for precisely the reason I said above: it's difficult to predict
> which notifier is going to cause a problem. Having an escape hatch to
> change this behavior without rebuilding a production kernel is critical,
> IMO.

I agree. People might want to "postpone" the "safe" notifiers
because they still might be risky.

But I think that they might rather want to "disable" the
"must-to-have" notifiers when they cause problems.

The naming "postpone_*_notifiers" or "disable_*_notifiers"
sounds reasonable to me.

BTW: I am always confused by the "crash_kexec_post_notifiers" name.
     It seems that my brain focuses on the word "post" and assumes
     that this delays the notifiers. Aka it makes them
     "post-notifiers" aka call them later. But it is the other way.
     I wonder if it is just me ;-)

Best Regards,
Petr

PS: I am sorry for the late reply. There are too many things going
on...

