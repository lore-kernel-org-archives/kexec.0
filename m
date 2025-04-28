Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B68CC369D5
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HwBT/ovUEv8UzpWAZc2njxR0ZKeSaS/THTkBms/bELM=; b=IA4AdGwB7FSqiLEZBP2t5DCl9J
	DCrRj1T3G8CX+6B8VYdfXp3U0mZ5iQNRQkPXWMgTk8OL1KWND7Yarbel9bplrt8vk5cyAi2rg9Jji
	BLxURHtw57j2is15sUhWgroDOXaQ/Lpt5j/DfyU5gILLPs1uFnUyhuXrqPuGFbqSqP+eBVNu2gHNj
	gCsk8AkSDK/IPKs0yH1uVkuBkSkMXplDQhQCIPENzlcRoJeh7XB6j2QQKyHHy4ySkCIgL/5Fj9tXU
	AH68XFdut/wBAXZnEsYE1nNO2zmhkGTHWxUMaYFBcB+KZ+lra13tWFANwSbO3AFKECNgJ/45q+wo+
	7kfgfMAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9XU7-00000007m45-47DJ;
	Mon, 28 Apr 2025 23:01:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9XU5-00000007m32-3Fkm
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 23:01:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EC744A60F
	for <kexec@lists.infradead.org>; Mon, 28 Apr 2025 23:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18246C4CEF2
	for <kexec@lists.infradead.org>; Mon, 28 Apr 2025 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881317;
	bh=HwBT/ovUEv8UzpWAZc2njxR0ZKeSaS/THTkBms/bELM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qJHzpRfZ+tCuI02iRkM858HwNpAXUci3xSnPoO2kSqMlpLH3MrTzZTRU91ZzwV6fg
	 YJeHtF/oidckWUJvg6SPJX98M05AoKqEHWy7cvVPR6UJf7CPtg/SpfqJGHR3R2gPYt
	 /0nm1odKhCoCQI7K+n/d+d7SAsdHHoMETwGyruiAqjufqzGINX7Rt2XNRq0lsnBKJG
	 sx+4Z+QwV19xl39JylyUArWFVbkWmLKYRCXjGZkUuckn9JVzJL2oA7Th/wFb3eDVlH
	 WUlVS25qp02PTXy38HrD+mdv6oP/FT9vHvoqKQiPqF6KveNAu4SjOTD0Nt8OWVRkJ+
	 1Gn79zG0zHPqw==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe808908so4275e9.0
        for <kexec@lists.infradead.org>; Mon, 28 Apr 2025 16:01:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8udZEGYCF8Z1fYIbciGEVam/2OUGNubl0b12bvar9LzHFYg7f9YgoE6mwg+R3XzeoVzGjfA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFQQZSIIvsaM/EiVpdrQHLd9+c+a5VMbXIHZtQrbfOJJYTvAj8
	oJHyWPVObm91f3olDtHCSrbhUq4Iz6XFv8N1HKJZQP/V1iqKeFHJdBFDAX/6QsIPgfb9azk1UnI
	77woG89CYgZC5jtTRCiQ8R/0Ke/DSckt0eApA
X-Google-Smtp-Source: AGHT+IFltF0sFMEKKxvR5oEXrKzNbNJnpjWpEV2T1C13cir292/kbjIpYGja2HYoKWTK4fMkgc7VXYkgS3IGbLrZCG4=
X-Received: by 2002:a05:600c:35ca:b0:439:961d:fc7d with SMTP id
 5b1f17b1804b1-441acb99999mr528205e9.6.1745881315845; Mon, 28 Apr 2025
 16:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250310120318.2124-1-arbn@yandex-team.com> <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
 <CAPAsAGyOcyi1PLK_mjdf9STX4HOxNnBU8t3d20fSS3QO+znwNg@mail.gmail.com>
In-Reply-To: <CAPAsAGyOcyi1PLK_mjdf9STX4HOxNnBU8t3d20fSS3QO+znwNg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Apr 2025 16:01:44 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNVCezdk6SZSYKp6EOByYbc=tVgP2F-5G=obbjaa=pyTQ@mail.gmail.com>
X-Gm-Features: ATxdqUFGsN2yKGjnSWE8Z8P2YNgx5olP5cHe8TNU73XJyrvNYVVrVxIXXPjB6GI
Message-ID: <CAF8kJuNVCezdk6SZSYKp6EOByYbc=tVgP2F-5G=obbjaa=pyTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the
 kernel state across kexec
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Andrey Ryabinin <arbn@yandex-team.com>, 
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_160157_850451_B63CC81C 
X-CRM114-Status: GOOD (  24.31  )
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

On Tue, Mar 11, 2025 at 5:19=E2=80=AFAM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
> > Hmm, this still requires manual efforts to implement this, so potential=
ly
> > a lot of work given how many drivers we have in-tree.
> >
>
> We are not going to have every possible driver to be able to persist its =
state.
> I think the main target is VFIO driver which also implies PCI/IOMMU.
>
> Besides, we'll need to persist only some fields of the struct, not the
> entire thing.
> There is no way to automate such decisions, so there will be some
> manual effort anyway.
>
>
> > And those KSTATE_* stuffs look a lot similar to BTF:
> > https://docs.kernel.org/bpf/btf.html
> >
> > So, any possibility to reuse BTF here?
>
> Perhaps, but I don't see it right away. I'll think about it.

There is some possibility to use tools to lighten the repeat portion
of the load.
For example, the use sparse checker to example the struct field.

>
> > Note, BTF is automatically generated by pahole, no manual effort is req=
uired.
>
> Nothing will save us from manual efforts of what parts of data we want to=
 save,
> so there has to be some way to mark that data.
> Also same C types may represent different kind of data, e.g.
> we may have an address to some persistent data (in linear mapping)
> stored as an 'unsigned long address'.
> Because of KASLR we can't copy 'address' by value, we'll need to save
> it as an offset from PAGE_OFFSET
> and add PAGE_OFFSET of the new kernel on restore.

Agree, there will be cases requiring manual intervention. It is
unlikely to fully automate this process.

Chris


Chris

