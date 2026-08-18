Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A0EC5DF7D
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=; b=MnIwOIhaX1+P4hvr+5V5x4LXYM
	jthfHA2x+8G4CV0MoW8aJbtStiZxTX254QW0+ENZG65NzyeWYFf345CJDVokJzMNHK+6zfpCb81dm
	x2oLReUk5TRcsVVwwu6ynb49VhU4xrXMRTULIy/6qYxRBC3WORgcNE9wU35A+vAIvjVwLkqC/tuYy
	+ZmtqcMF+Xbm1k/cLSHXLwotZT0l2ie8hBVEbwmbuS3EU4zSrcD0k2ZFytlvpAc5bV4X0tN2qkKhH
	n9sv2sbEwEK+nf2u3gDZ6swHWpzUmm+B5XwJgGer5u9fyyna+hD+Oh4Yi02F/tDUT/E0SoogbqjXu
	Z7SpYayg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwNCu-00000008Obg-1blZ;
	Tue, 18 Aug 2026 17:02:36 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwNCr-00000008ObG-3pEA
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 17:02:35 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5b3119957f0so108527e87.1
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072550; cv=none;
        d=google.com; s=arc-20260327;
        b=o452YjcvkuCWMcQzf/HMa1NE1tb1dFw0wzNFKamf4D/ePM+jDbaVhO+xncS7d4H+F3
         BcOedba4VbG6z2wu1Rp3wBhSPupQd7SW26CJVrhWNifscbXF4evuiKgzfBdey6wib/3w
         D5Dfr4V+Gaoe/Kwex4c2Kce3DOJB1nkGRZHYUv6XXoBpT2CzzZVJiSO1DWUX929XblEc
         iteBmjkBaucK3kkS5ZTYtJoln//qvfQI/GtwIDkSqWHAOOzovqFao3kq/5h/6y0ya/Hb
         XlELR6uK/LcxIDetJDMn/J+KiOp9VLX1gr7j2mYb2269cUOV/R6HlkDN0S9kaD9FwhcA
         5tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        fh=toEWdZl4NcSIn90ATNtcKrIm5OPALzE0wzdsx62kkVc=;
        b=SWazBXBl8BuG8OY7D/NSpVGikoV9l0RgYfXM1aMk57D9M8n3xE1WaG67ba51+6d2xd
         KQtP1B2Xa38TYX0j3RDO7Qfhol3ebGmVuaqq85h4DKltvdZG5mFh7MO2H7LKMM79JWQp
         1+/qGqhsSw5sk+4IbPWZw17iv6cqiVmq5H4YrqOu6Mk8ot1BfsBI/btLwBjQmll5pxx6
         hk6LELrimpFXJ+V4JzrFCkPN/4RZ1RxRN9mQrVUlrnlFqyq365Wc+xcWm/brZo9AL6FA
         c3E3nAvw5lDwO52IvWPqCILQAgwALsQ8b6HsSETEI88OkebxwGelHl0EnNgZpZImjTcf
         PacQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787072550; x=1787677350; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        b=AYpbO4Xm6Li3q2SOQNEbAK3rNpnUzhaxEHwINY5HFjtnY7k2RFi74NZ0kB0uodEFaZ
         Ugj6+coJxOic3czXKTw4VvYU4r9HJMxh4WoXC99LTIGF9nVvvsUtqCI0xqU/vThS6b2v
         BXmixO4uDL8FjAZNGPb1k8GFw4ctmJEwxP8JLSNdpu+j/qdkYTCxlkfNsLs7Gyj+VmgY
         WqJxhojYWRm24wZxO0eQCqoHyaiWi++Qam3TDdi9a+nZD7N7wC6idXkXd18HTDaru97d
         soUYIiThzEFcjamC+NTDHGRNksEIb+UBGpLniOPCzEc5sorNKTOztuq0mwLWtYZptEeG
         7IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787072550; x=1787677350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        b=LWhO99JlYqIQ40pZ+ROBZN0/0KaWNZln7YLBcv/relcat/sxf7lmbyzmPRk3rn3TXz
         o7pbwgb3zUulX02Q7fGa07QlIi7DpxaExny2HXDN7x7juHuU+4vMI6nneuZ8Zw3pQc2l
         iDO7g1PjcHKH2Y1iw0sTQGdRU82gmHYbwCO1v7I39PUVLvLAVAFbngmm056urqcmKjLj
         xhhWIQJYUB4H73bIBNrvG+FeJuG5Usw1p9xJPtfm2qiNMX2S7qtL4TVEvyngBvISCGEw
         8oAa5LWm89gbUU8TMyboDIJS6qadyA509NAcVvithJaoO8cjqPp4QI6p66zFGQh0UIcI
         8rhw==
X-Gm-Message-State: AOJu0YxH3TScAr+FMC+1k1UT8umO/x2jAD2bxBVA1xLJdK8lPyRApKsk
	MWavFF44FgRbiWIhQuJgal4XEDPQpQQwmywgIUuzwMb7DiWAPyyxUfh82/tKXR60U3lDfTatMY+
	RccbVrz2ceu5iaMJo/ysyyfcbbWB9X6/0IrqDLvwQKfLLDqBBMYtYgss0
X-Gm-Gg: AR+sD13Xik15WjnRzDvA7nDEusAlapxDX2XG+IxpoZcsGy+5Yq3S95SS+OxuY2x9zPP
	BQ/u0wXvsbwyKrO7kx9moojp8EKkHJMhwtdI+luLIOc1GCord+dcVvCDhKSlnPr2xVKyoCODLjv
	anjgksFb3dlYlguRhM/iifsTg7VuvYO2zRvEgA/V0qv9DQQmrKsxfBvThD7/RK58mUMSVv2jzw5
	Aqj96IFIEQaAQGIaNOCxwqPHoYYCeJpnb5/oZBZNGgCYyBQWjGO5Em1e6IlwKJQjGbaf5VtAQU2
	JLXXNB0grYjNe4p5fwKqEid1Bpqy8B5u3RAWFbbhjbqX
X-Received: by 2002:a05:6512:6686:20b0:5b4:3ddd:8996 with SMTP id
 2adb3069b0e04-5b470676e75mr1757831e87.15.1787072549336; Tue, 18 Aug 2026
 10:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 18 Aug 2026 10:01:58 -0700
X-Gm-Features: AcwNN1V4a25Yv0iJ76SrkHBknW5LsS7U4x19BfrVjGgcR0yRKfOyORXyqOEjm-s
Message-ID: <CALzav=ezKW25+1h=xQCRx0TQDtpADKpXQcKfz-3vbapz5-zwvQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] PCI: liveupdate: PCI core support for Live Update
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_100233_979925_4657648C 
X-CRM114-Status: GOOD (  17.56  )
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

On Tue, Jul 28, 2026 at 3:10=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
...
> Merge Plan
> ----------
>
> I propose we merge this series through liveupdate.git for 2 reasons:
>
>  1. There are some LUO core changes around how FLBs are refcounted in
>     the next branch of liveupdate.git that this series depends on.
>
>  2. We had previously agreed that the files covered by the PCI LIVE
>     UPDATE maintainer entry would be merged through the liveupdate.git
>     tree (which is the majority of this series), so this would be
>     following that process.
>
> This plan still needs to be Acked by Bjorn Helgaas as there are some PCI
> core changes in this series.
...
> David Matlack (12):
>   PCI: liveupdate: Set up FLB handler for the PCI core
>   PCI: liveupdate: Track outgoing preserved PCI devices
>   PCI: liveupdate: Track incoming preserved PCI devices
>   PCI: liveupdate: Document driver binding responsibilities
>   PCI: liveupdate: Preserve bus numbers during Live Update
>   PCI: liveupdate: Auto-preserve upstream bridges across Live Update
>   PCI: Refactor matching logic for pci_dev_acs_ops
>   PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>   PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>   PCI: liveupdate: Freeze preservation status during shutdown
>   PCI: liveupdate: Do not disable bus mastering on preserved devices
>     during kexec
>   Documentation: PCI: Add documentation for Live Update

Hi Bjorn,

Pasha and I discussed this series and are hoping to merge it into the
liveupdate tree by the first week of September so that it has enough
time to soak in linux-next before 7.4. I was wondering if you think
that is a reasonable plan and if you have any lingering concerns.

Thanks,
--David

