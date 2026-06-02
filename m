Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1AECD6E55
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPvRvQYgRD7/HoySAet9PZFVFYRckPsfq4Aycc89cmg=; b=EGLQaE3XGEEioo25A1gZMJ7AO7
	7HZfvMEPpFW+xapvDueGrk2IvQaY/IxblkrfFC9xS5zIvsXbQ3QGg/Pfwwkf2eDeZAa5Xr4NXO9qV
	cD/oSE9lVgc24QKOAemf09xCq7svcKFHpcwgFBAaM+nwa+ZnZ36pFW4+f3eKhK4X8jx6CAZsbKAZs
	NQJi82h2wGjMTByI6W9IuTmhqK8lteGZT9RrSGWCKl5FqFtnMr8LJuj2kRWzvbtk0EQ7XSrHURmhj
	kL3mwAbTERfFih8VSsxiTGhJdxOLFyu0fzGpQXXtCo2OzPdkQLC5QCSjCtOF1RlWeg/nptwHiiLT4
	bdun8c8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFR3-0000000CClE-0jZs;
	Tue, 02 Jun 2026 03:04:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFR0-0000000CCkq-3H9e
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780369492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPvRvQYgRD7/HoySAet9PZFVFYRckPsfq4Aycc89cmg=;
	b=jITMIRGWn48nx/YnabQtGA6rPbgPez3SnLz9cP8pEB9FhIOfiBM90ChX3nW7aTMltKyOAG
	LddcL9beMrK/PkpwB6bmZrYyGr6PBYoCFVGLhUz+gOxqHZe1MnvyrFFx8ap8Cs5zkMa+M9
	z7IoQcWg+lPb6c5K0nhUunQWA7iIQPY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Q1O6-PcXO_qspKuBxMUW1g-1; Mon, 01 Jun 2026 23:04:51 -0400
X-MC-Unique: Q1O6-PcXO_qspKuBxMUW1g-1
X-Mimecast-MFC-AGG-ID: Q1O6-PcXO_qspKuBxMUW1g_1780369491
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d6cf547bso41619161cf.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369490; x=1780974290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPvRvQYgRD7/HoySAet9PZFVFYRckPsfq4Aycc89cmg=;
        b=epblP6YZUlslMvLip3rEMulHP1XetVv0BmEY0fV5gFY+Yu3vQ+oF/XdQZ8KMyIOV8u
         IIvwuAqwr4hA9MXIiEMyynR5jJlDdInJgKwNJGQz+IK8sjzj3Z6yZaP8ePBBKryKl+cs
         Liv2yPOpTpqwtqxGcW+fFNaZBWDVSUp/uCxJsaggFqCSNpyIF/1yDJjOmD/euY/elz0h
         NbPjtQk6smxAPNRZKG+8ZhjpRi/Cp1Cx+PhRktrWwucf5oHxmltLFH/72Xc0rmvXRD4L
         InZ/jwhRno5DKnJcMoh99bHshqBT+gdUSyU9RPBT8ccXuO6AYFc43XBBg7TPbzHzMiL4
         kqeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/R9++Ok9xvqmrC3g9pKqf2oBkVSNuNIlb2x94qwl13NjIa7Zh09rCoWBpmyj7dHGyw/KGrpg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywc5P/W5tGOiowNpACbJnayMsIbsFdl6MzlmrNtikr3UPiwYF4g
	S6ifBH9pOM2qSQUQH4cqKb7DuteCUUEuPJqg3S2r13Ztsqn8NUtxP+5SZJid5PDIWDygnvJS1U3
	18PdIiIzUpSzAFTEOh4v9m0YpFvqTLhpEDkT+RB/PYtNxWteenqTGF3oS9anpxRpLf0a0Gd2M8k
	+QJ5ND9MK2Q11X6Uph+zsuL0tHzb6eGLVQV8gYNfaItuUm4i8=
X-Gm-Gg: Acq92OG0/frLOB8PufnCwn4fLiEbszug28tMjmkcrSAVy28jtdW1CXQwPO28H0CMlsB
	Kg6ubLjMxtsPEo5ycG6rgjST5IuM/f/41sJeUlhL5ThFziiCzRzf+Llx8KLiIHDzAtgwPAz4OeM
	h/AC6DAHqr6DhH3W4ZqU/imSg7VJxWhfMn/0H2Afciuj+rbqscxBaCJCsENtUycSR9qtk7DuUyp
	wURDFGNk1F81U/x
X-Received: by 2002:a05:622a:a917:b0:516:d943:175f with SMTP id d75a77b69052e-5173a8381c2mr168296361cf.52.1780369490507;
        Mon, 01 Jun 2026 20:04:50 -0700 (PDT)
X-Received: by 2002:a05:622a:a917:b0:516:d943:175f with SMTP id
 d75a77b69052e-5173a8381c2mr168296181cf.52.1780369489954; Mon, 01 Jun 2026
 20:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com> <ah4oINLOlhxpQuFR@templeofstupid.com>
In-Reply-To: <ah4oINLOlhxpQuFR@templeofstupid.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 2 Jun 2026 15:04:12 +1200
X-Gm-Features: AVHnY4L9oWQL6_FL1VrC9amtwv2Gp1ROEK1jzTzivJCg7vMW059TL7gXqfnU6Jk
Message-ID: <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N7UW6PpsdG1FWM6QJ3wgXtbDfnK_X0kzL30UXdk89TQ_1780369491
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_200454_894758_189E8BF3 
X-CRM114-Status: GOOD (  67.39  )
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

Hi Krister,

On Tue, Jun 2, 2026 at 12:47=E2=80=AFPM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> Hi Tao,
> Thanks for the response! I've put the followups below.

Thanks for your in-depth explanation, it's very helpful to me for
designing the data erasing function.

>
> On Tue, Jun 02, 2026 at 11:12:05AM +1200, Tao Liu wrote:
> > On Sat, May 30, 2026 at 9:11=E2=80=AFAM Krister Johansen
> > <kjlx@templeofstupid.com> wrote:
> > >
> > > I love this idea.  Do you have time to take it further, and if not ar=
e
> > > you open to making the extension framework more modular so that we co=
uld
> > > add others in the future?
> >
> > The purpose of extension is to make the framework modular. My original
> > thought is, we can implement several makedumpfile extensions, each
> > restricted to one specific function. Like one extension deals with AMD
> > gpu mm filtering only, one deals with Intel gpu only etc. For distros
> > we can ship all extensions along with makedumpfile once, but the
> > respective extensions will only take effect if the machine has AMD /
> > Intel gpu. This is the same case if you'd like to add other customized
> > functions while the makedumpfile core remains unchanged.
>
> Makes sense.
>
> > > Could the btf lookups be extended to cover the symbol lookups used by
> > > eppic and the erase filters so that the -x option is unnecessary for
> > > kernels that have BTF support?
> >
> > Yes, from my view it is doable and not difficult to implement.
>
> In some environments, the size of the vmlinux + modules can be fairly
> substantial to leave on disk.  It's attractive to have the option to
> omit it and still filter dumps.

Yes, I totally agree.

>
> > > The current extension implementation is focused just on skipping page=
s,
> > > but it would be great to be able to use this to erase data in structu=
res
> > > like the config filters and eppic, but without having to provide a
> > > vmlinux at dump time.  What do you think about adding the ability to
> > > use the extensions to also erase parts of data structures, in additio=
n
> > > to filtering whole pages?
> >
> > That's the step 2 for the BTF/kallsyms work of makedumpfile, and I
> > have planed to work on this once the patchset(step 1) is accepted. The
> > reason for the task dividing is, the GPU mm page filtering is more
> > urgent than data erasing from my view. For data erasing, at least we
> > can do the erasing in 1st kernel with the help of dwarf, cumbersome
> > but working; For GPU mm filtering, as far as I know, there are no
> > handy tools in 2nd kernel.
>
> Excited to hear that you have something already planned for erasing.  My
> apologies if I missed a more comprehensive write-up about the longer
> term goals for the work.

No worries, I didn't post the goals upstream; I only had internal
discussions within my team regarding the next steps for BTF/kallsyms
in makedumpfile.

>
> > I think erasing the data is doable upon the current page filtering code=
.
>
> I wondered about this, but for data-structures that are smaller than a
> page, wouldn't that mean that we're erasing other content?  The "erase"
> plugins memset the output data to a chosen value (or 0), whereas the
> filtering just drops the page.  Couldn't this also lead to a situation
> where the debugger can't find the page at all, versus giving us one
> that's sanitized?  (I do understand why you want to drop the pages for
> the GPU cases)

Frankly I didn't consider the data erasing as in-depth as you did. I
think you are right, makedumpfile needs to know which extensions
handle data erasing and which handle mm page filtering. I guess the mm
page filtering extensions will need to perform a "dry-run" filter
first, in case the "data erasing" extensions break any useful data
structure. In this step, "dry-run" will only record pfn numbers of the
pages that will be filtered. Then "data erasing" extensions are
called, so all the sensitive data is memset to 0. Finally, all desired
pages are filtered out based on the previous recording.

With this, "data erase" and "page filtering" will not interfere with
each other. What do you think?

>
> > > Would you be willing to modify the extension registration options to
> > > allow an extension to specify what kind it is? That way, in the futur=
e
> >
> > I'm not sure what you mean by "what kind". Do you mean an extension
> > needs to tell makedumpfile what purpose it is for when loading?
>
> Yes, sorry I wasn't clear in writing the question.  Stating this
> differently, if we want to allow the ability for different extensions to
> do different things, how do the extensions declare to makedumpfile what
> they can do, so that it knows where to invoke their callbacks, and what
> callbacks of theirs to invoke.
>
> Looking at patch 6/9, right now run_extension_callback() is involved
> from __exclude_unncessary_pages and always calls the
> "extension_callback" symbol in the module.  This makes sense for a
> single extension type that's focused on filtering pages.  However, if we
> wanted to have multiple different extensions, this might be more
> difficult.
>
> If we could determine what type of functionality the module implements
> in load_extensions, then we could tell if this is a page filtering
> extension, an erase extension, or some other kind of extension.
>
> For example, for an erase filter, perhaps we would want two callbacks:
> one to set up the ranges to filter "extension_gather_callback" and
> another to actuallyf check the address range to see if it is filtered,
> "extension_filter_data_callback"
>
> I'm not sure about the names.  "extension_callback" seems generic, but
> this has a specific purpose.  It's a "extension_filter_page_callback"
>
> I may be overengineering this a bit, but having makedumpfile pass an ops
> vector to the extension in a load function could help here.  Then the
> module's load function fills out the vector with the functions it
> supports.  Depending on what's implemented, these can be placed into
> different callback lists to get invoked at different points in the
> program (e.g. one at pfn filter time, another in filter_data_buffer,
> etc).
>
> It sounds like you had a plan here, though.  Were you thinking of adding
> new extension types a different way?

I see your idea: makedumpfile predefines a few hook points at
different stages, and extensions can register their callbacks to these
hook points. For now I think 2 hook points are enough, one for page
filtering and other one for resiger the data erasing, which definitely
shouldn't be within __exclude_unnecessary_pages().

I'm willing to modify the code. Such as implementing a hooking point
registration/management. But since I haven't work on the data erasing
functions so far, the design might be superficial, personally I'd
prefer to do this along with the data erasing functions in the next
independent patchset, considering current patchset we already includes
plenty of code/function implementations. @maintainers, What's your
opinion?

>
> > > we could register multiple different kinds without breaking existing
> > > ones.  One for filtering pages, one for erasing / modifying dump
> > > content, and others based upon whatever additional use cases develop.
> >
> > That's the goal of extensions, each extension deals with its own
> > business. Could you point out the code that doesn't match the goal?
> > I'm happy to correct it in v6.
>
> Yes, I attempted to elaborate on this in the preceding paragraphs.
> Basically wondering how we can add new extension functionality without
> breaking existing extensions, and then get the code to invoke the right
> if there are multiple types that need to be used at different times.

Agreed.

Thanks,
Tao Liu

>
> Thanks,
>
> -K
>


