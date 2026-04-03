Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D74AE8537A
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxfxN2zWBmikOMpbTxf4ZqLUBV1Y22o7mjg0HGhygTw=; b=yenY6+V6lAQOgoeztFdMZaACTt
	sOq+6ythkvQ4MRgv7+d9wsMYnX7JpfjQ0j9a/ok1i6Q5VeVq0/S55yNlDNuxrTYy/gOah6g6FmwSP
	Z45nudJXZNhRI50Qt1S5dU8RJtBFd4+pVeAjO7WNqTvm9t761yGsjO0o7nl4g60B5iuoNM5m7vPj8
	t53O8S08bLvcgqJrPzFKcdxzYSnnNX3HQGarOsK2lcWUGWlNIom2ej+Rs/nveI5do8dp2H14Q7ZNN
	zIAlnzgoUBV0MPpb39/KhR7kcm473oH4rdllkgq5Yyi4YhrhlXjmrWz5vdcQXZ9omUxDNX28Rp0qO
	810KKlGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8iGJ-00000002ONr-2Sym;
	Fri, 03 Apr 2026 17:24:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8iGH-00000002ONU-0Hht
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 17:24:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B0736445AA
	for <kexec@lists.infradead.org>; Fri,  3 Apr 2026 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE2C2BCF4
	for <kexec@lists.infradead.org>; Fri,  3 Apr 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775237087;
	bh=E1bzUypaVS7w28CbARApxGc+uxb6NjOyzaisp3si/6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ri162ENaaXiSRPqBTShI8ahm36fA0yxapnpusRTreYOdDDMZ+niMHjj7xqXvZwXxR
	 W4688wQ9cGxnGe+4MGiHfTAaMtuD2Con4gYFbAMxcYjgjIt93lCPasclWTi7ojO9Zc
	 cazVdgRwAtkk89yPiJTWnIHMEFFN8LHV8glDBn0X8QcC5UvdP0JZaLMOMJXUx/iVXU
	 J6GWfBEZdlJkOBVUvtov+m1djxfdByrpUr0rmKXjb+/NqCjkj+Qy2GYzHPm2Fr+5nb
	 8/vPh720vR6+uCmdKhX7HYao8p87jfXTXfxJbR1k47IxMwREqsFF2kj0iRdD6uwC5X
	 E/5FWDXI51lcQ==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ef161129bso1800170d50.1
        for <kexec@lists.infradead.org>; Fri, 03 Apr 2026 10:24:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYifpYwfxpqVvbW68Sqh5F7B5O7hGBWe99BKUeTo9l22Qj9MHQDqZcY5C4jz4Wwp9s9JJ4iw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwFH+ivzKjTGm21yPprhz91bLv9f1ee1LPSgJhbQQ1rOmK0fVu4
	3ihBu6ifsxqfEk/2ktr9wc0q6pmiss4VsCH88XALKYScS+XGBsZkliPRRLT8BHPkz4czfZxDXFJ
	fZ8uKdqYsAfi/zsj43dfF6gemIx0AljYIJORBW1KIyg==
X-Received: by 2002:a05:690e:d41:b0:64e:a765:ef82 with SMTP id
 956f58d0204a3-6504870ea48mr3180067d50.24.1775237086162; Fri, 03 Apr 2026
 10:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
In-Reply-To: <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Apr 2026 10:24:35 -0700
X-Gmail-Original-Message-ID: <CACePvbWrHCSzYmiKz0EuXE48MNk26+4j0njSP+1Vy83RMvvVrQ@mail.gmail.com>
X-Gm-Features: AQROBzDLi9Fnv8_mDDwmklVKEby5KKVysrnsYTweXxYMFegWZQjyvtyGp9AI6Cw
Message-ID: <CACePvbWrHCSzYmiKz0EuXE48MNk26+4j0njSP+1Vy83RMvvVrQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
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
X-CRM114-CacheID: sfid-20260403_102449_178427_B72776AF 
X-CRM114-Status: GOOD (  17.82  )
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

Building as a module has extra complexity to handle, e.g. the callback
can happen when the module hasn't been loaded. Then the user space can
take an arbitrarily long time to load the module.

It needs more infrastructure to support the liveupdate as a module.

Chris

