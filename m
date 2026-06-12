Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF69CD98CF
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s08faKqvDPkMJtxJMkDBvBUzs4ZbUBDPlDmo4vFtWCY=; b=X/fAm78MoVIzzrSv9Tby9XGI8e
	cz+2XXnw4Ohbc8jlNjHrScAlxfb+nU6lQybcVH8ClkD7N9E5/4qJpju4H90CFQ0stejRycm7ZlVJC
	IGfvGGgY9ADtak4gfp6/lZm5a/LSOItJ0QWdm7z//j64PZmn+KhcBoH4u0KNzdjH2mpkIhn/915Ez
	rftjevUPqAn/WltkP5H5YimGua2kjG/pmIgkxQp2Hoy8OE5drEOfvADEWfQZA0+P61y+WjKG3x46Y
	V7zcDqez1jF/J97QB+3PxXEXir1H2bz82YeBHV/eG8QYcYp7tHpBMgH8oRnXWVZUpaBTEw9Q1wz12
	wjASBLeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY7Ey-0000000BR7l-2InH;
	Fri, 12 Jun 2026 19:08:28 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY7Ew-0000000BR7B-3dyl
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 19:08:28 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-91563382bcfso147700885a.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781291306; x=1781896106; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s08faKqvDPkMJtxJMkDBvBUzs4ZbUBDPlDmo4vFtWCY=;
        b=iX7xCtlFQJ6Fvue+8FyKMegozSKNqGWMMyR+d+RTLpyEHrPYw40nmq0ReAwiX47LPa
         D2ALBmV6lU0LpBOUMYWaXBrKNyAGfZAh/R04VipIFHtyzVwkiFDMbOF7X3XZaGpRkKeP
         dq31tqvNcomYK1WpBl3AkNIwwjlvjhUh5I0QY+SyWRVpPYicInPy0bjCwacsKApJpjKc
         QIjDKlIPqEIKpuXs3tAS/XfbrEiVQDeUHqeNpGESJFaJake8Ok5aJOUmLb8MI7UmrNph
         X+kCmM+0JB2dUuMa6smFWED17theRzPZ/fsm9WcAQ5Pl7FZ1jrAlqfYt7D2bQQ5Mfs2I
         JUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291306; x=1781896106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s08faKqvDPkMJtxJMkDBvBUzs4ZbUBDPlDmo4vFtWCY=;
        b=ksUY1tgfrl7IeEeRyqUDD3W/PlgRZTK6cOJE2fWu52v0u7SgTsruzJXf/cpeOPAqDN
         Un3SkgXWkbpZFq/HzDIFPvWNjP8WsZ0b4TshWdRKM7d1JbK8TYolHWup4Z6zCnDQdO7s
         WppDcxcmMqYjvkCJRN6FxqiioxmGmBW/ov7vekg0WQXgbq+k6egEAeCvYcPSTZtk7qO2
         SgHkj9piLPumSj5cVDijzjujjoDErejACvIW+l4S5RNM2UPm8YJ8caBL4JMT5kBnNY2x
         X5FywZI1fwh+jXMfozEqnNA7zxR6+cWP8PeKFlQ0VFSzsK3dUsI6UG0wc17bf7ZDnJo7
         p5pA==
X-Forwarded-Encrypted: i=1; AFNElJ/jzaCZwNfs0ujJLtGny63z8uUTc/M0uRFpmQrVT3MoR37acVhLO9ZaWconZyF22ih6u4R3aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJnL6Zq3W1HVy7g7wmLJmkbfdG5FFjk5+wRjK6QTq0nz07OKyM
	LqVC2TeHuYv+0XCUe4TTA7tuXT+mZdOZUliNKTqnsVMnbVIaWE/HM0hVBfFVehM2fk0=
X-Gm-Gg: Acq92OG4B+7u9VsaGXhJ++GgtHP7Q5k1x6fcuOczktKGaEwXG609VGjD3qCKrM8w5ou
	fFemHyAWkkcibmqTAw4MjX/ZBlI63wfrNe1djl9zKY58i61U0t+GI4dZKX8wjMQUrdbGjWUFjuU
	wox2QVNlcs3esSsvqvi+okf/lyDJL2jb7zoXZd/I1bnZRKUCaQt5QD2R1CV4ANZIX6T53/Umh/x
	FiFjnXKAfDeN+QAzhCVaFC1veXxAHmiMZu7y6x1hDLgYH8veYPXn8KzY71f/E7GFdxBXmBtDctZ
	BNMAYgJOPT0CDLOb6aVo4LoqBw2NEXJmOtza50Pw/zhERqGF8vgklgsCpXx7P4WZVQQANGs1D5D
	jj7/XpfCMQmm+EqDuOA+eEwekb0RnVjHwjh49n2dZupk+u5yil5YLEfZrW9KffFsf3ynixIk1SN
	qY1ie6KD9xJL1/y4VJFkfvB2vGoqkHzsdB72WA/3SEE1Hb+lpI7Zs=
X-Received: by 2002:a05:620a:c45:b0:915:c858:7d42 with SMTP id af79cd13be357-9161bae70eamr627465485a.18.1781291305692;
        Fri, 12 Jun 2026 12:08:25 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f2d6a5sm291127785a.20.2026.06.12.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:08:25 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:08:23 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, jasonmiu@google.com, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, ran.xiaokai@zte.com.cn, kexec@lists.infradead.org, 
	graf@amazon.com, Logan Odell <loganodell@google.com>
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
Message-ID: <aixXuoCOCZZcBDci@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <178083348872.1648214.17778188633648887952.b4-review@b4>
 <aiVp5RlbWRz5VnPB@plex>
 <178091437240.1648214.10761111570005003901.b4-reply@b4>
 <aibYJvzQQnpoN6YW@plex>
 <2vxzo6hjss8z.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzo6hjss8z.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_120826_935603_305A57FE 
X-CRM114-Status: GOOD (  58.96  )
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

On 06-09 16:28, Pratyush Yadav wrote:
> On Mon, Jun 08 2026, Pasha Tatashin wrote:
> 
> > On 06-08 13:26, Mike Rapoport wrote:
> >> On 2026-06-07 13:43:09+00:00, Pasha Tatashin wrote:
> >> > On 06-07 14:58, Mike Rapoport wrote:
> >> > 
> >> > > On Fri, 05 Jun 2026 03:32:26 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> [...]
> >> > External users only need to include the headers they actually use. For
> >> > example, LUO shouldn't have to pull vmalloc or radix tree KHO
> >> > declarations, and memfd does not need block.
> >> > 
> >> > From a maintenance point of view, it is much easier to catch ABI
> >> > changes when the file with the appropriate version has been changed,
> >> > and most likely the version of that file should be updated. If a single
> >> > header contains compatibility versions for several different data
> >> > structures, it is easier to miss the correct version update.
> >> 
> >> No matter in what files the definition lives, someone can forget to
> >> update version and we may miss it during review.
> 
> Perhaps we should have some tests (maybe with kunit?) that can catch
> this? If you change the format, the test fails. So you'd have to go and
> update the test, and at that point it should be more obvious that ABI
> version needs bumping.
> 
> [...]
> >> 
> >> Sorry I wasn't clear. I agree that kho_vmalloc, block and radix tree
> >> should have their own versioning rather than rely on global KHO version.
> >> 
> >> What I don't like in your proposal is mixing versioning of a component
> >> with its dependencies.
> >> 
> >> I think that versioning should be completely local to each component.
> >> LUO should not care about kho_block "on wire" layout. This should be
> >> encapsulated in kho_block.
> >
> > That is a fair point.
> >
> > As I mentioned in my previous reply, we can definitely look into making 
> > the version checking more modular. For example, each component could 
> > implement a standard compatibility-checking interface.
> >
> > These checks could run early in boot to determine whether each component 
> > is capable of accepting the incoming preserved data format.
> >
> > Whenever the component is later used by LUO, memfd, etc., we can query 
> > that cached status. This achieves four key benefits:
> >
> > 1. It avoids delaying the compatibility check to the actual time of data 
> > retrieval, which is too late to safely abort.
> >
> > 2. It prevents a local incompatibility from triggering a global kernel 
> > panic, allowing us to handle failures gracefully for just that specific 
> > component or session.
> 
> I think the right time to do the compatibility check is _before_ kexec.

Absolutely agree; however, that is a bigger effort than what I am 
attempting to do here. So, let's remove composite version strings and 
integer strings from this series altogether, and simply make it more 
granular. The versioning will be solved later once we are ready to 
address the pre-kexec compatibility checking.

> That is the only point where you can safely abort. Once you boot into
> the new kernel and discover you can't understand the passed data, you
> are in a bad spot already and should reboot. I don't think think you
> really can gracefully handle these failures.
> 
> For example, say you fail to understand the incoming PCI data. So you
> have no idea which devices are participating in live update and cannot
> correctly probe any of them. Which effectively means you cannot resume
> any of your guests since you have no idea how to restore their device
> state. The only path you are left with is to reboot. I haven't read the
> IOMMU series, but I imagine the same story applies there.
> 
> For a more benign example, let's assume one of your memfds that back VM
> memory fail to restore.
> 
> In this case, you can safely leak that memory and run the other guests,
> but at that point the host is in impaired state. You don't want to keep
> running it in this state. You likely either do a reboot, or if you feel
> more adventurous, you do another live update.
> 
> In either case, there is no "safely abort" after the kexec happens.
> 
> So I think our energy is better spent solving the versioning story
> _before_ kexec. After kexec I think it is perfectly fine to error out
> and panic or expect a reboot. You can't salvage much at that point
> anyway.
> 
> And I think how the versioning format looks also should be based on the
> design of this pre-kexec check, not the other way round.
> 
> >
> > 3. It keeps the local version local, as you suggested, so it is checked 
> > only by the consumers of that specific component.
> >
> > 4. It provides a clean path for backward compatibility, as components 
> > can individually decide whether they understand the incoming data 
> > format.
> >
> [...]
> >> 
> >> Actually FDT "compatible" handles versioning nicer than composite strings
> >> You can have
> >> 
> >> 	compatible="kho-v4", "vmalloc-v1", "radix-v1", "block-v2";
> >> 
> >> and check fdt_node_check_compatible("vmalloc-v1") for vmalloc and
> >> fdt_node_check_compatible("block-v2") for block.
> 
> I agree. Even if we don't use FDT, something more structured than
> composite strings would be nice to have.
> 
> >
> > That is actually very similar to what I am proposing—individual version 
> > tokens (which in my current series are concatenated into a composite 
> > compatibility string separated by ';').
> >
> > But let's not get too fixated on the composite string formatting. I 
> > actually really like what you are proposing: using integers for versions 
> > and having each registered component carry its own "NAME" and version 
> > number in the KHO FDT.
> 
> There is another nice thing about numbers that Logan (+cc) recently
> pointed out. You can tell which one is bigger.
> 
> At some point I think we will support multiple versions of a data
> structure to allow for upgrades. At that point, it will help to know
> which one is "newer". So if both kernel versions support version 3 and
> 4, you can use 4 to serialize.
> 
> This of course is harder to do with strings.
> 
> >
> >> And we wouldn't need to reimplement string parsing ;-)
> >> 
> >> But yeah, I do see value of making components versioning and KHO global
> >> versioning independent. I just don't like composite strings and I don't
> >> like mixing versioning with dependencies.
> >> 
> >> Since we are moving from FDT for the most things, version should become
> >> a number rather than a string and version compatibility should be
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

