Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43618CAC5B8
	for <kexec@archiver.kernel.org>; Sat, 27 Sep 2025 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=; b=M72W5Hcj9cJjmUOtpUmgJW/9vq
	vnbM1lUa8ZubeXlZpY4E4OhtEgplKstPiIYcn68AC9fA58IfZkjsQr0l8SMFlyZdWCfIGzDpxtNBo
	6XMNCIQqeq/S7TmqFZRWLiKN2cLSRV5anOFYdnTER84xzmEz2fKA9dKFIFidvFjylH7O9AbG0rT5Q
	5HJGEGvNqzMIfOsh92FNVaJhoMnBgAgWjOMTA3r+/5yj95ViRRSEOzgTjd8+JA0xl7UWii1+hZ8IZ
	zbrYTgvQbHZwD0X68KQGeyVUiCld8xH+YSNTprmxjGI7kr9IaDyc86fTq6NZj+75rItAUkHSlHXNE
	qPJxJwyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bhn-0000000CPcF-3tts;
	Sat, 27 Sep 2025 20:39:43 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bhl-0000000CPbh-2Qcj
	for kexec@lists.infradead.org;
	Sat, 27 Sep 2025 20:39:42 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4ddabf2ada5so25328031cf.1
        for <kexec@lists.infradead.org>; Sat, 27 Sep 2025 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759005580; x=1759610380; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=;
        b=FrbN1Q7i7dM7G821LrE/v88Ut0ska8yKE/oy+x627hk9j/7SnSqsuOwZqcx+uCu6NX
         P14PyA0SdEj5Ub1KoMOLUtIlTFuKUf6dihFgTLpBWKUOM8G6i0OXOTsPdEg3puBMt9fd
         1wOHvvY/MbRJqOYdTvwdzGydSjcI46iPZxIQ6z0fwsf/tXNJl2ADF0pX/c5HY/xprgrL
         ipUcPZq8smponCNB6xzy4+y6LzAf5zqsSeW7w/OHXVUV0urq1J2mXarygVbqpMC5Io3p
         LsJVE/WyLeg8u2z+nTnjfyN8e538Anp2h3Sf2RRfEEBb6wWdWdxG8z9QhogVU4rNel2m
         7Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005580; x=1759610380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=;
        b=Md2iRK5RwHdOMWuKIWQ8Eq4Nv8uiVhDktAXt9f4RcsZbWpFi1+xbqealttq5en/eIB
         g34Ucl3lyB5Q9MKle4UfSbC+KgHxmR4fFd2H5LsWYAmKCK/7rw82bDxlt+tZqtUvBbDi
         2yiXkkSEHd/D7gBtA3LS2yymNIYMj9Qc2Cvv44y7jl45l0Aixw5xBFhWqd7GDy0Lty61
         KssBxA5eIy+qSNliZvWDs71rn9aAuLkN/s9qbNuMH3K8G8lEMgUFbybTJINiaPihsOr/
         VU01g3yYcZ2bANNBCq9Gq5RkNn2vLsaR27HFh1+O7fu4nzk7X1Jg1Vl/rhNJ/1b6ItDq
         WzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWgQZVpIQe/lwjkkhEAbWbpuZxTn9/HeNYV0piC3L9HdyMgcOC0sNQzKQG+HM3UlKP0t/STg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4mXh4RYeLlzxdiFyNCYRgdJBdRwplLEzxYa9USLf4vrRLbGK3
	Nv8h9ngTygWg31oAnoJERziwaR/kYkBTQMCCxkCiJO60kPJHjPI2llwC3v799/a3iDE3kGlH0RZ
	XJ8775Df2D3Pu062UZa4Q9Qvlo3nM2kDTWMEBb8r9Ww==
X-Gm-Gg: ASbGncuI0X8AKXWSmpZcjlkRmyXosvw3Is0ltsE4Cko8FnazBYijAPoENmTMQmLhWY6
	P26RRhshAHVNP0QB4bdxXU0mqIEEty1o865RzCejcFIENJ/NXu936OyBZ8tRD/SNw/f7FTt7X/q
	RV0tkE0dbPB8umGXBNH1oqJubDElgLSPiPPZPRLYJ9cIeS4OvndORyQY24Wht54F+1p7BVOV7zR
	qF48JRzBDgplILbx3A3mFpYyA==
X-Google-Smtp-Source: AGHT+IGBzy4xKVonjD75U3bFZeJHdh+aNj3HgTEf2iQJ6Ivdld2/QWu42FO96m5+KzxRvbcmbaVonTr0xtmksT79s30=
X-Received: by 2002:a05:622a:4cc9:b0:4cb:102c:56b2 with SMTP id
 d75a77b69052e-4da41e113ecmr158400271cf.0.1759005579868; Sat, 27 Sep 2025
 13:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <aNZWTB_AbK1qtacy@kernel.org> <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
In-Reply-To: <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 27 Sep 2025 16:39:02 -0400
X-Gm-Features: AS18NWAcl8Gu_k5gDYsA34u-oRSTQGnYnzR7vJJapQMSC9amp96YmIxuBqedkv8
Message-ID: <CA+CK2bCFBOVQnwvRePHRkDqdh5rA+QYrkhqvf=ZiHu=yicShAw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_133941_630054_919381DF 
X-CRM114-Status: GOOD (  31.39  )
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

On Sat, Sep 27, 2025 at 4:27=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Fri, Sep 26, 2025 at 2:01=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabli=
ng
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CP=
U
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> > > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > This list is like asking AI to list benefits, or like the whole cover
> > letter has that type of feel.
>
> Sorry for giving you that feeling. Please let me know how I can
> improve it for you.
>
> >
> > I'd probably work on benchmarks and other types of tests that can
> > deliver comparative figures, and show data that addresses workloads
> > with KVM, namespaces/cgroups and this, reflecting these qualities.
>
> Sure, I think performance comes after usability, not vice versa.
>
>
> >
> > E.g. consider "Enhanced security through kernel-level separation".
> > It's a pre-existing feature probably since dawn of time. Any new layer
> > makes obviously more complex version "kernel-level separation". You'd
> > had to prove that this even more complex version is more secure than
> > pre-existing science.
>
> Apologize for this. Do you mind explaining why this is more complex
> than the KVM/Qemu/vhost/virtio/VDPA stack?
>
> >
> > kexec and its various corner cases and how this patch set addresses
> > them is the part where I'm most lost.
>
> Sorry for that. I will post Youtube videos to explain kexec in detail,
> please follow our Youtube channel if you are interested. (I don't
> want to post a link here in case people think I am promoting my
> own interest, please email me privately.)
>
> >
> > If I look at one of multikernel distros (I don't know any other
> > tbh) that I know it's really VT-d and that type of hardware
> > enforcement that make Qubes shine:
> >
> > https://www.qubes-os.org/
> >
> > That said, I did not look how/if this is using CPU virtualization
> > features as part of the solution, so correct me if I'm wrong.
>
> Qubes OS is based on Xen:
> https://en.wikipedia.org/wiki/Qubes_OS
>
> >
> > I'm not entirely sure whether this is aimed to be alternative to
> > namespaces/cgroups or vms but more in the direction of Solaris Zones
> > would be imho better alternative at least for containers because
> > it saves the overhead of an extra kernel. There's also a patch set
> > for this:
> >
> > https://lwn.net/Articles/780364/?ref=3Dalian.info
>
> Solaris Zones also share a single kernel. Or maybe I guess
> you meant Kernel Zones? Isn't it a justification for our multikernel
> approach for Linux? :-)

Solaris kernel zones use sun4v hypervisor to protect isolation. There
is no such thing on x86 and arm.

Pasha

