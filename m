Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52332E88D63
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=; b=apG8ehs5dOSAc0YjbmRNlFDQ4i
	47Yz3vtv2jr9VfekwKiBdLrm40Y9Jyvw2cwBysxjAgWWMqxad9d5yQvIy/oBumhzPg+cwnPnyOgKN
	yCc8kqdy+QI9Knz5mtNl4SkcwRJlkutQ1e+N87DJKqgfAzvxBOmkWTU3aieIw9mYr3rgDpeacacik
	5FFmdJjpv2NmfiNd4Gby0c5DBn42pQ24RyOcH7yImERCCuaQNYo3gkE+igRTXUPbiW3xNXjymQxhU
	tcM84jvSNhT+zre7WwpfCDQBu6q1HMxQEJqViohY8aBT09R/9DmdXFVO+FB81GOSY9kSP3Zm67xQh
	9meIxhiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8mXP-00000002g1f-2pxU;
	Fri, 03 Apr 2026 21:58:47 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8mXN-00000002g18-228D
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 21:58:46 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so2928253e87.3
        for <kexec@lists.infradead.org>; Fri, 03 Apr 2026 14:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253522; cv=none;
        d=google.com; s=arc-20240605;
        b=WLB3oGOR8iZP+B2BR897UQIRDqI9R+Ta+gXlg0XOIoltAaIipLA+APq3tESPFGVsMm
         A9VewLp2idL5z07tbUcjlmZyrkkpXGWW94WW+x/Tn3As9iRYOnwdjOUIKT0hoYIPmDbK
         hE3zKgCVgkwsHBlLfbMLLhh3DDEmJtYX7xmmApTncbtEvcZChf7RR5Z8K+sl1tNhddnB
         PvtxWvZuKFMCSUP3Wip5YU7BalkMxqw4Q64n9RFr+D9HFEI+kXLs7Ze9bqKeNUDJnq2q
         rSXnE+iUsGrBBB8WY1sSo9v+InfPngjikz7NgNff258bHxY++CmkqBDh1LWltWRnktc0
         TxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        fh=BQgJEMRD33xKKHavmA1gHTuVhQXET7Vm53kDwF84ms0=;
        b=U6q6uLRGlBzgAUai8/u7UzFGxfyynvFnZBak5BhJN72s4rWltfixZiWMTrWes5rjng
         xONkGrGshz5YBoQdSakQmavJsdU8Oxjn8NqI5B6BcrnapBzGpVSr0kUXfrZIPPhDEsPA
         K6udym2fI4H6ah+cmkCbO2YFxnPgamABYak1YC5JYFaQ6f9QGCYGyHSnceVCM53/WvsS
         3KgMKP2E2WITyathquc9HgXSLzxbCdOkmy8rHcW4yhz1bYmYgXjMkGERc8FAZL6Szc3f
         DFIaRgDNGzUqojf9BgrQcdroD33tDeynXbda7Msuhj/aB4gLLv1U0I5MhsZg2hpcqZ0P
         gBTw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253522; x=1775858322; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=TCUdcgnA+q3nze8cX0xgCVUI7jPquRWTLEiHBqmoIkjenYF1W0IdM6/u0zlCjtms2k
         mGwAW6V7M7eXdN8+6FOnYuloNYTe5uEneFtjK2mFgpKg22oNWhSy4DbaH6Gpq60psIAh
         VbCOmwuV+CyhzckT/CkKVA+JUrxFlpogZ8yfilqKVuz75cNFMR2H6V0uvi0h3G2jUxYC
         f7ggh+tP4q6+PeFJq9GFxmIu5Fd8l6KDmPoVxH8oj6ZJ1Gj+RU/dUZTA2hd1Wu/He2A0
         Jw6q3e9DysHS8TUUTVY40B77chzEzYd8rNLX3SxG6gArt6Jn3BSjC8C5yqneEO1kBOcB
         L8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253522; x=1775858322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=LYWM2V5p+j/tzXl3RCqxdcWIt6thoxCMfeuLFbhnF1MZ8qAG30Tg7al3tBTV/Glnny
         1+jJ2QNsXZjh/eJwD72LNVquu7Zukll0YOLkgjtZK1iZ5o+rJIc6wnv93eeVAN6kX9UT
         jxKVr47dSs8MqgXdZF7yvI/7MK+EATaZdDAwF0ekhUs1561fJMXSl6pr4er2iXrLaVS0
         WyR6m1JVyI9r9walILthn3jg2Owu2DdyGZNA8dsCznQhVjc52nrFXo76saGtgqp8hman
         Cakz41UOoueGdRKpE6QTvFLKdTGSCJpgkQyG98kSnWX/k2hsI0ntbrKyNMV8cCiZoc7k
         5peg==
X-Forwarded-Encrypted: i=1; AJvYcCUDTMnrJtyAP3ob/tI5qZ8nM2Dw+BpY6O1ncCk5YZ7sN8oUi53/feJLR2xCS2ZGz9UgLqT9aA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCwSburpNPI1TkNkca7mTvojdzzxFeatF3MaQS8M3H5dW52PE5
	bWoESbhr4juoSJSusEkyGEllH3xyTb1x+Nbo802oDZRI1i8WjKaLp9PU+5uLTFhvJmy/C+f3xX5
	HP3TcRpe4vtd0YpB9PG7wtnX5axsIuzDVDoyKVmFH
X-Gm-Gg: AeBDieuA4M+qCLfp9U+WRcHYzWw7qTkAj1xkYI5vZqjdhtSNOPJovt4bNNvexhYhyUw
	s7WFyMsTBCwxdntjbKThY1kTR9Za2eKQmi55jvQ3MG1fTH/jaCluxTafJpeinCMeHWmEsrks1LX
	9WH46YdmzmPLePuLL71knEI4AQCX4fItaLvyW654EJeOPU9SesACGkZ8PHl7kD//SirsfCFZXoO
	DmOSG+vH9xitsVu6EY/WdJvgclFQ7zRhrIC5eCBA9x7ELGVeYKcpVwDj7UvGIv48N3Hrvddu/1G
	2LTyEFZs
X-Received: by 2002:a05:6512:1310:b0:5a2:a5dc:6111 with SMTP id
 2adb3069b0e04-5a337563322mr1534908e87.18.1775253521414; Fri, 03 Apr 2026
 14:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
In-Reply-To: <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Apr 2026 14:58:11 -0700
X-Gm-Features: AQROBzCufsJjSomX3fu7F7ptwK4HJAYNpi3kPBVsC_mFldZEseUJNvIFRhG6pcY
Message-ID: <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_145845_561329_1F9A738F 
X-CRM114-Status: GOOD (  18.49  )
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

On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
> On 3/23/26 4:57 PM, David Matlack wrote:

> > +config PCI_LIVEUPDATE
> > +     bool "PCI Live Update Support (EXPERIMENTAL)"
> > +     depends on PCI && LIVEUPDATE
> > +     help
> > +       Support for preserving PCI devices across a Live Update. This o=
ption
> > +       should only be enabled by developers working on implementing th=
is
> > +       support. Once enough support as landed in the kernel, this opti=
on
> > +       will no longer be marked EXPERIMENTAL.
> > +
> > +       If unsure, say N.
>
> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> (modular support)?
>
> This would allow the feature to be built as a kernel module. For
> development
>
> purposes, modularization means we only need to recompile a single module
>
> for testing, rather than rebuilding the entire kernel. Compiling a
> module should
>
> be significantly faster than a full kernel build.

I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
pci_setup_device() (which is under CONFIG_PCI) needs to call
pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
module. This call is necessary so the PCI core knows whether a device
being enumerated was preserved across a previous Live Update.

