Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808DFC28B20
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sGZeCa0sKqwzNT7+OssvY0XCe1f29aCSfnouhi7cVM=; b=CNgWbesc1SxIXhWBFR2GOqVDav
	59CqiE0wQnW8RIG2p6wtm2Cfxy7DGhPS27eMS0cBymnb1ZNKiQ6mX772RtC0m17PtNyte9Nl3X9wR
	FNQh20oMhAQu1biBYHEoRG0vgF8B63OQlSvQdBZll1Qve96SNqTpr8c//DbBNcaQ6JJZD7pTUURdU
	/pKljPhnNlOZA4ISP+7lDcUYVMvsR0mDtTxxSmZxTe/j+34HyIeUVjxuF/kPgGTsY+QZpCtEd/wfX
	rO3ZFSGQl/rL5flEYSkdnb8MPp+rWrcPGF9JQZK7YGgkGMMLgIEC+/LZMN0IyfIILIiWPNr5/E6Mr
	4LoEa3ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0302-00000006wXN-2LL2;
	Wed, 02 Apr 2025 18:39:42 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02yG-00000006wIv-2Mz2
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 18:37:54 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4775ccf3e56so12504121cf.0
        for <kexec@lists.infradead.org>; Wed, 02 Apr 2025 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1743619071; x=1744223871; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sGZeCa0sKqwzNT7+OssvY0XCe1f29aCSfnouhi7cVM=;
        b=rBGSg0j0PRC3IO5VbMYPEGijF0Jzr4NnrgIgo3ht/Xjlc012/o3TaxtmI5369q2Jbw
         aruZ4pP16FkQYvBIV9Jh8dj8KHQisz8xAI2fg3j8bIErNDL/awxfCk9DzNBnrrYXaxxT
         RGbtJsTBmXHlDoTFCLLsPgVzu6oYdITFOiX0L72qktddo82k4qG4cc23b40CkJhVfbW7
         iuB8GRhM0+P69RLGrWZRqlKgqSDAdenACj1wx3x2ZHoSySjA0YWZbCGkNtFIYuKcBVE1
         GyZBNIpOr6hDqBAti68Ss6G7hpcP/rY88o1oZmpBIIKN7evxRSQw8+1V/Hl3qcwX1hM1
         QDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619071; x=1744223871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sGZeCa0sKqwzNT7+OssvY0XCe1f29aCSfnouhi7cVM=;
        b=d8GqqhiE4g8tZuRN6stSe5UXvrTZVIth+0S0vuzTE2IEtriPWM8QETYIl9DPt2YqTA
         k8BaOaQrFeA/apDOE4ngxg4YCKKlvdRadOTx6lAxReLFiofDbo5kxbt4DbBjcZiRUGNb
         b8a60B3/fJDv7Qy72CYfLKYZYJfu4fBF8Yk8GLv0ZQwl1FFsfvQtzmJ6oLyTm+Hu7Q/F
         3q78A628R7nkxONPQ/kIIjVRBAnFj7kEjR7NC4yR0O/3oW5C5SH/Iu5ojN3SBV7eDeVM
         WBaz6N68J6RL7aqRrrycm1CZSV2hstT/8N+lXNFDv5caVvDzbJQ8pqbl7fiwszbb9U3o
         F43Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsZxsXn4jVF08UlFpoT6wRG0DUPkxiWsKU8QnTSHpZocpt1bRNXfwyf9pDgnDvrfU6VzbiRA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgP9B/vFGXnpjz4e6DM8/DwERPp6mbt00TSfuBR5xN+fLKXjUE
	VcIp0LY3zSk6lbRdSpRdvvrULf3xxLk0zpE8zRFwtbo/p1+ctI/uep7aJ1qtOCPWj5XjJYmqQ5o
	UAHTtFVhRcAFpUzb/l/dBgLeqk9Gw+YmxHYFNGg==
X-Gm-Gg: ASbGnct3dL29YitYOLO/EgaldSiO6BWBnSSUf0nA2KNZ8qt631+lw1quKgWq5Spo4E4
	ql8QJ1ogTCugP0s/r8qakU3bk7yfo6GBKeoWv6X/0gup18c7G56O8wa5dfx0AINymnhVUgAxwqu
	HexLlJMp6XWoUC/QKyG/ALYZY=
X-Google-Smtp-Source: AGHT+IGBm8eRAZTRRIQNHm7hrKsMWsRZO7yaRU5V8qu8Hz4XTnZI9DQTzhglhyasNi+RSLHZS4pwai1XiiNO0rfUKEY=
X-Received: by 2002:a05:622a:255:b0:472:145:3e02 with SMTP id
 d75a77b69052e-4791615e607mr11970971cf.8.1743619070935; Wed, 02 Apr 2025
 11:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <mafs0tt7eqt6f.fsf@amazon.de> <20250402164453.2470750-1-changyuanl@google.com>
 <mafs0ecyaqzmd.fsf_-_@amazon.de>
In-Reply-To: <mafs0ecyaqzmd.fsf_-_@amazon.de>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 2 Apr 2025 14:37:12 -0400
X-Gm-Features: AQ5f1Jr9Neh0jFNvgUt9co1Ay0Junb4b6fkF7RtFZQf-u5XIPaKITjI68-n5adU
Message-ID: <CA+CK2bBnbEtw7jL2fbukJ3aBCjn=-OVT70oEAsZ435vtFe18Vw@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgg@nvidia.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, pbonzini@redhat.com, 
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_113752_603050_5D561B89 
X-CRM114-Status: GOOD (  34.91  )
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

On Wed, Apr 2, 2025 at 12:47=E2=80=AFPM Pratyush Yadav <ptyadav@amazon.de> =
wrote:
>
> Hi,
>
> On Wed, Apr 02 2025, Changyuan Lyu wrote:
>
> > Hi Pratyush, Thanks for suggestions!
> >
> > On Thu, Mar 27, 2025 at 17:28:40 +0000, Pratyush Yadav <ptyadav@amazon.=
de> wrote:
> >> On Thu, Mar 27 2025, Jason Gunthorpe wrote:
> >>
> >> > On Thu, Mar 27, 2025 at 10:03:17AM +0000, Pratyush Yadav wrote:
> >> >
> >> >> Of course, with the current linked list structure, this cannot work=
. But
> >> >> I don't see why we need to have it. I think having a page-table lik=
e
> >> >> structure would be better -- only instead of having PTEs at the low=
est
> >> >> levels, you have the bitmap.
> >> >
> >> > Yes, but there is a trade off here of what I could write in 30 mins
> >> > and what is maximally possible :) The xarray is providing a page tab=
le
> >> > implementation in a library form.
> >> >
> >> > I think this whole thing can be optimized, especially the
> >> > memblock_reserve side, but the idea here is to get started and once =
we
> >> > have some data on what the actual preservation workload is then
> >> > someone can optimize this.
> >> >
> >> > Otherwise we are going to be spending months just polishing this one
> >> > patch without any actual data on where the performance issues and ho=
t
> >> > spots actually are.
> >>
> >> The memblock_reserve side we can optimize later, I agree. But the memo=
ry
> >> preservation format is ABI and I think that is worth spending a little
> >> more time on. And I don't think it should be that much more complex th=
an
> >> the current format.
> >>
> >> I want to hack around with it, so I'll give it a try over the next few
> >> days and see what I can come up with.
> >
> > I agree with Jason that "nothing is ABI at this
> > point" and it will take some time for KHO to stabilize.
> >
> > On the other hand if you have already came up with something working an=
d
> > simple, we can include it in the next version.
>
> I already have something that works with zero-order pages. I am
> currently implementing support for other orders. It is almost done, but
> I need to test it and do a performance comparison with the current
> patch. Will post something soon!

Hi Pratyush,

Just to clarify, how soon? We are about to post v6 for KHO, with all
other comments in this thread addressed.

Thanks,
Pasha

>
> --
> Regards,
> Pratyush Yadav

