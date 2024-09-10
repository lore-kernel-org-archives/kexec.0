Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A25BEDE99A
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t8ST6UKRVn70jKXdIHKZapWJvxpbZhmNqldK8PN9VuA=; b=x+1Us8M7eni+gl
	AVEdmnvTPzvslVjHvx2m7xU65b1619HVJd2Gmx2jNcVvXiDSc5ylXFzFY8i8IbLA3FYb+i1dCcj4S
	X621z7qEooKHzMoCYkisbzWes5SFaN7Ma4Cxkj+t//ahEUj02ShUzeHk1cIK2esqECQI3cBsp62ZC
	uX1o87JyngcLzkmLlNiMkLOynANBD5AmPYVq+Wx++uAGLOsW2fwKolUmdnvupT0Cv30nxxzQS1+Ls
	HvB7vf3kZLgoClOVOUCIEQuAMWRa20fYOUJsx1ENGGdOH55jTbvUiUSrrLc0D12roXQ9ypRlBsojr
	kOcSTDEVzAzj4+o1QVCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2Z0-000000061tU-2YZV;
	Tue, 10 Sep 2024 15:13:54 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2Yx-000000061sZ-1k4E
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 15:13:53 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8ce5db8668so652790366b.1
        for <kexec@lists.infradead.org>; Tue, 10 Sep 2024 08:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981228; x=1726586028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT/8R/5BLp+GREKZ2zNCykpf17IboodqIA5H60ak+44=;
        b=BxlsPtKQsimnPd+TBoNUKRrVqJXTlNVH7xhJKY/l/ltwcI5c0jSwBBr3Hg+2S4b8iV
         jeg/e0R/ltkWp0EqDNCWeZphMIsTC5y5BDA/79Vos5xxsjkuPFqW5auxesAWTr/1eJLa
         8WCbE9ixsw3H20LxBaPk4UWQbSobuLyKZNi53fw4cO6q+Bvp+69RK/YKKpQbgdI417Xm
         QzckvB1tdYHx2tHyJot49eiDHuUT8lOGWoT2eRxSWDVQbTh463BFuBzilzpfntZVkteU
         WwAjMiMKfRbdaUP7P+y56KIrKstnJ2W1aJ1wmFbopcJVvWsPCwjaGxRUOMJ8xP9l3UHU
         iT5A==
X-Forwarded-Encrypted: i=1; AJvYcCU5MZ+olyGSSKuIm2CC8A/6XmFNUUz8G3wlQrwZhtp24uZ97msbMMqGcP9/9QDTY0zf3uW8/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWXJ8KEtMgYh9DuMJ6lm0ICE1f2L/Mi0ezCdGVnL9VVvDPYx4B
	NHQxNnUXXBqk9hGDUA03nC9XKEpJ7l5qHZCvOgslRQU7UeiWkwTx
X-Google-Smtp-Source: AGHT+IGa324Mp4PeWqG8pH6t0Eo2JNJfFvVRTDFBDbp+jS0qdKR+yK3pu1oX1FOFMuTRkhs3lJJw7g==
X-Received: by 2002:a17:907:6088:b0:a8d:1142:1d68 with SMTP id a640c23a62f3a-a8ffaaa54c5mr136500066b.2.1725981227436;
        Tue, 10 Sep 2024 08:13:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceb1ffsm500604766b.146.2024.09.10.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:13:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:13:44 -0700
From: Breno Leitao <leitao@debian.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net,
	rmikey@meta.com
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <20240910-uppish-gopher-of-spirit-f14f0e@devvm32600>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_081351_476943_CC783CA7 
X-CRM114-Status: GOOD (  23.02  )
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

Hello Eric,

On Tue, Sep 10, 2024 at 09:26:00AM -0500, Eric W. Biederman wrote:
> > I am wondering if that memory region/range should be part of e820 table that is
> > passed by EFI firmware to kernel, and if it is not passed (as it is not being
> > passed today), then the kernel doesn't need to respect it, and it is free to
> > overwrite (as it does today). In other words, this is a firmware bug and not a
> > kernel bug.
> >
> > Am I missing something?
> 
> I agree that this appears to be a firmware bug.  This memory is reserved
> in one location and not in another location.

That was is our current understanding also, but, having the same issue
in EDK2 and on a real machine firmware was surprising.

Anyway, I've CCed the EDK2 mailing list in this thread as well, let's
see if someone has any comment.

> As I recall the memblock allocator is the bootstrap memory allocator
> used when bringing up the kernel.  So I don't see reserving something
> in the memblock allocator as being authoritative as to how the firmware
> has setup memory.
> 
> I would suggest writing a patch to update whatever is calling
> memblock_reserve to also, or perhaps in preference to update the e820
> map.  If the code is not x86 specific I would suggest using ACPI's
> arch_reserve_mem_area call.

Should all memblock_reserve() memory ranges be mapped to e820 table, or,
just specific cases where we see problems?

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
