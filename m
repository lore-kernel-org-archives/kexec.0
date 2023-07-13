Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF2FC0015E
	for <kexec@archiver.kernel.org>; Thu, 13 Jul 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9A0KUMuX/ud/HZUNkX7NeqDelCklz+nHPxX9MyOZvcs=; b=eEjUlDRGYo5NHG
	QpOvaz8Km18/2JCVNfJM5oOQplGZ7yI4ovjyI216/ovjuCf9aR9HWHko/eu2PoIYdxaeTIsycrZr1
	o6MSzkOugMjg9QfKhoDNvPMQWqYM2kWPehf+xmExUk08WuewrYMXkhn578uTCbCvG8HXhMg9FTGSw
	8xIy7PaqVsqBIjEbO+8lSau/wQvlcL3Dk1/PBgGd6IK26Re/O7fEzRjqHFHVnAB6zvprk5zy8WL+u
	RTRYqxfSgXdSjxh1/6BsDUqNnwkEVPU1pBURZpW5aWuVJv68WGxtotQs9VdbEPmcKVf63M6lhb+iu
	yy8lasMC7oY9VHcUaq/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtOq-002nES-17;
	Thu, 13 Jul 2023 10:18:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtOn-002nCm-0l
	for kexec@lists.infradead.org;
	Thu, 13 Jul 2023 10:18:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6627560C0D
	for <kexec@lists.infradead.org>; Thu, 13 Jul 2023 10:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE75C433CA
	for <kexec@lists.infradead.org>; Thu, 13 Jul 2023 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689243491;
	bh=ET0PIk/EJwOtrnFetQCgnV0IGpMF5SKCWlqW+zEctgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YMlAn0FKUIcij8cMaBk1sFjGdlftqb544w6tk1470W3FP8qhFxn+egxqkXA5LavAS
	 esTIPGnjOKs03CHA1k5fK0BcLZG62Fd+YJjjeUX9Jx/+xTrTWAxHKlJCXj/+I0fcf6
	 tgt9Hl+9GgifspdfdEgIMhgHCX9v0289T95tYeQ7gFQeNRPmW8uUyl6JLAr/+vh+sU
	 EArTQBAxwB/G70oaog4LkVrUoXGF7PalknTC3Qf4N+/v/qvWOAIvAtxUG8G1VdKaZC
	 SiS90semh7lh/XT8ETTWgIFpxHQAzLQ8xhYpCzly4tEAIDqDQZ178VA/ugu6IOY3u9
	 uYQDvUzquX5OQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso961094e87.0
        for <kexec@lists.infradead.org>; Thu, 13 Jul 2023 03:18:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLa4hYPeZEwajo27M/fg7iQjHkDhslp6A1opGkFjJS4Ox2B8E71t
	BV8Fumaw0lYuJJY2GKXMxSRQvLs9NVLHY/MrxUk=
X-Google-Smtp-Source: APBJJlFBQWCejzkySepLV/mSpZDO69J/ce++jVUzK0IbQmheOsTIP22zHMFDXog7ITY4n68UbN14AQPbrEm/zMas0Pg=
X-Received: by 2002:a05:6512:3984:b0:4f8:7513:8cb0 with SMTP id
 j4-20020a056512398400b004f875138cb0mr1040508lfu.2.1689243489214; Thu, 13 Jul
 2023 03:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv> <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local> <20230707152515.42gpfzjgvfwe6rf7@amd.com>
 <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
In-Reply-To: <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Jul 2023 12:17:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
Message-ID: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: Michael Roth <michael.roth@amd.com>, Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, 
	Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_031813_399565_9AE0B495 
X-CRM114-Status: GOOD (  34.74  )
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

On Fri, 7 Jul 2023 at 19:12, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 07, 2023 at 10:25:15AM -0500, Michael Roth wrote:
> > ...
> > It would be unfortunate if we finally abandoned this path because of the
> > issue being hit here though. I think the patch posted here is the proper
> > resolution to the issue being hit, and I'm hoping at this point we've
> > identified all the similar cases where EFI/setup_data-related structures
> > were missing explicit mappings. But if we still think it's too much of a
> > liability to access the EFI config table outside of SEV-enabled guests,
> > then I can work on re-implementing things based on the above logic.
>
> Replying here to Tom's note too...
>
> So, I like the idea of rechecking CPUID. Yes, let's do the sev_status
> check. As a result, we either fail the guest - no problem - or we boot
> and we recheck. Thus, we don't run AMD code on !AMD machines, if the HV
> is not a lying bastard.
>
> Now, if we've gotten a valid setup_data SETUP_EFI entry with a valid
> pointer to an EFI config table, then that should happen in the generic
> path - initialize_identity_maps(), for example - like you've done in
> b57feed2cc26 - not in the kexec code because kexec *happens* to need it.
>
> We want to access the EFI config table? Sure, by all means, but make
> that generic for all code.
>

OK, so in summary, what seems to be happening here is that the SEV
init code in the decompressor looks for the cc blob table before the
on-demand mapping code is up, which normally ensures that any RAM
address is accessible even if it hasn't been mapped explicitly.

This is why the fix happens to work: the code only maps the array of
(guid, phys_addr) tuples that describes the list of configuration
tables that have been provided by the firmware. The actual
configuration tables themselves could be anywhere in physical memory,
and without prior knowledge of a particular GUID value, there is no
way to know the size of the table, and so they cannot be mapped
upfront like this. However, the cc blob table does not exist on this
machine, and so whether the EFI config tables themselves are mapped or
not is irrelevant.

But it does mean the fix is incomplete, and certainly does not belong
in generic kexec code. If anything, we should be fixing the
decompressor code to defer the cc blob table check until after the
demand mapping code is up.

If this is problematic, we might instead disable SEV for kexec, and
rely on the fact that SEV firmware enters with a complete 1:1 map (as
we seem to be doing currently). If kexec for SEV is needed at some
point, we can re-enable it by having it provide a mapping for the
config table array and the cc blob table explicitly.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
