Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8F7C0015E
	for <kexec@archiver.kernel.org>; Sun,  6 Aug 2023 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uml5I4VlwZKXTm8vbT1UR+3fer6qqbBAy+P0YtCpfH0=; b=vFVAhCPLpeaq9z
	GRvVmZEg10Dcxa/6mU18Dy40ALCrQy5bIj3XKV5BoHncmDaMC1BAYS413Ib1afPDdZegfQmGvmJAJ
	thpCQDagooky4+8RFaW5isg59+CIGR5a51p2DU8LI3PMvSdHR1l7zNgCz+ZpZqg/F/DSe45mzRR5N
	18sbtjCHZLhrJ9oad19QERaW8xWiSQUKqJX51HuEvRd56TAMbZQ0mQX2PQJ5zJYKTCLMLzA8sh0Xf
	fXfEUIv2v38bdvsWQyC23FndjhbQ0OZ6fWyYQ0/6+DHZSIG6iTqlnc9Y5yiYk7vGAsQcw3dQJAGOG
	4Kv7M9BkwO91xXS9KmZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSZck-00F7ev-34;
	Sun, 06 Aug 2023 09:00:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSZch-00F7eV-1d
	for kexec@lists.infradead.org;
	Sun, 06 Aug 2023 09:00:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC1D60FF5
	for <kexec@lists.infradead.org>; Sun,  6 Aug 2023 09:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C60C433CB
	for <kexec@lists.infradead.org>; Sun,  6 Aug 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691312425;
	bh=+TXmEJX4FKponOLIv3qrpvbnUYicMBXZZmOrD0W1BWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aEmjxEZ53tFzsU5Fsso656G5/XDgWWs3fQw+mWwEO/Cc7D6oluHf3jroD9t760Bi5
	 RuHYT70vFyvr4jDlZ02vzXJxDho/asCZZyqz4hKC0HAdqqRTuxsYSMVnAOh04RaP3h
	 YMY0GznnchRKydt+jALutU/eveNWtBliJ9zxZyPyU55u1Y6aweDMm8N43TahhjKCMp
	 UOUwer/Vm/g4a4WNSysQD93+alJP6RZ75DiLkSJMpGEPhpdIfeqW22ku/Xc2WpedcO
	 q2qkaMTOg2gJQqr2VOBFkMeoPdofoNQW6lRTgAKJIl9P5JKCAVvO4oZy5M/AbZpfzd
	 00NU9b+Uk5Qsg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so56789071fa.2
        for <kexec@lists.infradead.org>; Sun, 06 Aug 2023 02:00:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/4j9UuL2wVIglyBAYpMoXgzFtFTErasVsypk1NZQf7kcLWBl+
	dfzmwzYK7F+Phjz/tbZ39qGQVZ24rI8tOH302ik=
X-Google-Smtp-Source: AGHT+IF5eOhxK57JRUF6uaHX6gLolas9lqU/l2q+VhUtL98mtKu82atGlkOcgK3QEpJ5Kr84tLnvLrEIXS3YPhOOM8c=
X-Received: by 2002:a05:6512:1153:b0:4fb:780d:2a49 with SMTP id
 m19-20020a056512115300b004fb780d2a49mr4597409lfg.5.1691312423452; Sun, 06 Aug
 2023 02:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local> <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local> <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local> <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local> <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
 <20230805091738.GAZM4TslVWR3HHKeUC@fat_crate.local>
In-Reply-To: <20230805091738.GAZM4TslVWR3HHKeUC@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 6 Aug 2023 11:00:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFf1QuiYo+5gm_1X3OHStHqO=OtmumvQM=D75uNP=mpTQ@mail.gmail.com>
Message-ID: <CAMj1kXFf1QuiYo+5gm_1X3OHStHqO=OtmumvQM=D75uNP=mpTQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230806_020027_659941_224EA613 
X-CRM114-Status: GOOD (  21.38  )
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

On Sat, 5 Aug 2023 at 11:18, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Aug 03, 2023 at 01:11:54PM +0200, Ard Biesheuvel wrote:
> > Sadly, not only 'old' grubs - GRUB mainline only recently added
> > support for booting Linux/x86 via the EFI stub (because I wrote the
> > code for them),
>
> haha.
>
> > but it will still fall back to the previous mode for kernels that are
> > built without EFI stub support, or which are older than ~v5.8 (because
> > their EFI stub does not implement the generic EFI initrd loading
> > mechanism)
>
> The thing is, those SNP kernels pretty much use the EFI boot mechanism.
> I mean, don't take my word for it as I run SNP guests only from time to
> time but that's what everyone uses AFAIK.
>
> > Yeah. what seems to be saving our ass here is that startup_32 maps the
> > first 1G of physical address space 4 times, and x86_64 EFI usually
> > puts firmware tables below 4G. This means the cc blob check doesn't
> > fault, but it may dereference bogus memory traversing the config table
> > array looking for the cc blob GUID. However, the system table field
> > holding the size of the array may also appear as bogus so this may
> > still break in weird ways.
>
> Oh fun.
>

This is not actually true, I misread the code.

The initial mapping is 1:1 for the lower 4G of system memory, so
anything that lives there is accessible before the demand paging stuff
is up and running.

IOW, your change should be sufficient to fix this even when entering
via the 32-bit entry point.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
