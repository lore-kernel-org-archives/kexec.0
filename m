Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D93BC001E0
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4mqumnWa4YggiuXfGvaKbUEivgvbxUa91G7sPI/Zomg=; b=QzycrhwMJwwBD9
	qUEMzo/qFA28hmpd1KLR59YOqkLCFpeSlergtBRQYAP+edUarMztzx6jD15uRb0FP7Jc5OX7O5qqf
	qLXt09xxz9ErWEAdMO7xqGaFsJUXpCZ1NqzqFcc2lPcRy3MOfUPumfTn8ogND/7k0vEvjxL7xI6Q5
	RTLCTKOV+kGwljg5FYuWB8IFZDHRRrhsT2AGxX7XV5ZENaKeAhHLdJ+MAN6ataEAy8K8AChRmdkSV
	b+492B4A2dGstk3xGvi2zziOzMtn3y2wGDkQ+DaEYTgDOidlIqjV6fBeZJEVtQIKoGp2Ij4GHC5w9
	PJf8p6TUhB/SicuMHhxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRDGL-0058fc-0x;
	Wed, 02 Aug 2023 14:55:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRDGI-0058en-0z
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 14:55:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C90D619D3
	for <kexec@lists.infradead.org>; Wed,  2 Aug 2023 14:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A392C433CA
	for <kexec@lists.infradead.org>; Wed,  2 Aug 2023 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988141;
	bh=FZMPhXQrHyK9eeuZN1J/jrG/TyLK6PIVTmkTcWu2x8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nf9+x2Nau3IaPligYAwj77m2G8cVmC3xLAgRSYIxggCfuHTvqe9UxQcRObhU3LB6F
	 1v4ZMmPclGeYuyAmt37pw09cOJ8INnHVNQfK19PHJC0Ul0uukSTwF4UnpaqZiOVNOH
	 otSck7fW999Mqi6onftfzhTWKYAU4IVnj9oPXtDy9o0gz20LYgk6br0mHtbNwopoJK
	 y8VZixxHCG2a0A4bc/BOxEL9l1dgrJsb2Ikp2PV85GGk80a0TMpBq62qIR2mbO2L/z
	 cAE16MeEIN5qpa83iieROd2qpUkpfbppPSb39FZxtGg/fo1bEYpfhmu21hyTZBky4l
	 /EpiUINyLQZwA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo8230285e87.2
        for <kexec@lists.infradead.org>; Wed, 02 Aug 2023 07:55:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLYz+3ESllE9i6OvrYCu0VuxCNn3SfePjeLAxuSrYURY+yXmb62m
	NOd/5SL/bZIqvzU3vx7Lpn21tjUBm+nL393WsLo=
X-Google-Smtp-Source: APBJJlFkgTdGC/+fMRk0576THqIS5DHxPQs47yVN+ZI5ALLSkyek+7GbY4Kn3l6ILVEhda600DZTBdXCm8GHDpwxGSg=
X-Received: by 2002:ac2:4e81:0:b0:4f9:5396:ed1b with SMTP id
 o1-20020ac24e81000000b004f95396ed1bmr4371719lfr.28.1690988139082; Wed, 02 Aug
 2023 07:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local> <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local> <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
In-Reply-To: <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Aug 2023 16:55:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
Message-ID: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_075542_388950_E008B608 
X-CRM114-Status: GOOD (  13.40  )
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

On Wed, 2 Aug 2023 at 15:59, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 02, 2023 at 08:40:36AM -0500, Tom Lendacky wrote:
> > Short of figuring out how to map page accesses earlier through the
> > boot_page_fault IDT routine
>
> And you want to do that because?
>

... because now, entering via startup_32 is broken, given that it only
maps the kernel image itself and relies on the #PF handling for
everything else it accesses, including firmware tables.

AFAICT this also means that entering via startup_32 is broken entirely
for any configuration that enables the cc blob config table check,
regardless of the platform.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
