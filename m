Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EEAD2F339
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7bd+UtBJangmLuzKR9t6l9CpBCCUbDMFM6346WeMfk=; b=kKvyTmpa+K/Dl6GPp+Z47Cqvcj
	ZlvbdZqq6SHMmCosMlgBKDksN3D5kuWAaypUJezKaRHr5WTtsLW08CPwu/3cCqJFoAD6cWJ6+7DyB
	G7Fo1VUrJkoZEJZJcAS3CTG/489FAG+wn/+GJWR72KNLu3a70CGIen2H5ZJMJKYQVNE6njpc2amuy
	anjujxMeH8uUiLpsePkyjhYlYeLPGGdstxPd3evjcEu/ISlJfABv55L9b3K1oexX7zZwTxYL7djNu
	MoePiZrY3E/Soggcq6HseVY367hCvPKTWb/MSzLcCFVHRlQgPt5QiZ1v9oxjDcQ4QhRN4D+tJZO/j
	9wxh7o5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfh4w-00000007SJ2-0fgj;
	Tue, 13 Jan 2026 16:17:10 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfh4t-00000007SIa-3BmY
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 16:17:09 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so11333362a12.0
        for <kexec@lists.infradead.org>; Tue, 13 Jan 2026 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1768321025; x=1768925825; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7bd+UtBJangmLuzKR9t6l9CpBCCUbDMFM6346WeMfk=;
        b=IbN7QF3Jm3MiIxHDQOv9Ewo6dyPhnmEVKYlm1S9sLWj951EyTHAWE+Kb3+4eWSGALf
         SBTmqWwNEJG/scix/aswXtN91iwiUK5R55cWRbL5ZyO+ik8aPaVdYWwuu4hIGSCen2Ih
         B7e3IQgsoz8LYp1mWcOW2FRCr50TCm6EAcDmOSdpmpfXYQzi6PYHuMKAEdlAn5QZf0cT
         PF7oD3FzUhAi0MR0gML526ZWCtwkvkJTpb3pu1/aNnGoQOPz600rgOhj9vxe+RxrP9Qt
         vF09mqYOD/nntTEmc4mcN8eVa2zlzWpIIrDXpl4KT1afWnjlXEAqUo/2l9ZWJxQ8lrDU
         9GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321025; x=1768925825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7bd+UtBJangmLuzKR9t6l9CpBCCUbDMFM6346WeMfk=;
        b=wQfk5rPrNGl/UpWi8Vyzhait8+XhfrM/BrMe41xFLLB/0EVROv4pj58uPymiBj8rDc
         ipYng+gWTM95rmV5RTNp/OPckHWV8NGvxnlZf6FhT8b7DPQ0/IDwKTsbDA2tQq5RmJWJ
         UW4z05vfU0kb3CrYvFnNTZlH2NhxcGRvik027C0i4gjIw4WN7wnSe+jfuIxY8xGyTw3m
         y+NiK2B4HxsVPs56OY9LzTtgvRuTyV1aku7I3aJaRYQOo6rYjpqeQffsZlyPNnDT/1Vo
         kAEX+tEL5UONcqE2OUfkwMJ5O3BImZBdnHvlydj+u2X/e5ppJyBHwpaSDvSO5VA4zf0h
         pzcw==
X-Forwarded-Encrypted: i=1; AJvYcCVBdEDDyyHIzNQLoXrCOR0DFH8cnZmW323gDMNeZ7uCCbOPfQc1mf5SHB69p8fzwYk0OPDRvA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxLh+JE8ewNW4LUb0YOCav7Dfgm/rOTEMxaTVmpoOySTmtmpkIb
	1ogWDQEspygeRNcFVSc3MZd6J/Va/YDYxOBRHBEfs2Fi0I6qA4CMucXqyqh94NfJJS2eAlremRm
	QHzYuovdc28spwP8K8JWtHuGaEpPiia7V8qKEjiIwow==
X-Gm-Gg: AY/fxX5vGwNKu2e4IUyruxatAnqYZ7IyvdxJ4ewclVaVuRfEdI3/lcHFWcmG5gtUat0
	cZYDh6lA4WFWetXwK0vQKpDTH03EokXiLY6IllEP3FTbNzZjQuGc9kgaqoqI7ACGnAVz8dGK6UJ
	od5soV4nlSAAWRbHHfWJ2H1/zHNpfK7nvweYAh1aY4AxzpdaR3NG4jYf8oT4tWiWoxiL3Sv6+UW
	AoK8Bmt4J/QvFgoPChXixSkGn4t3yFN5aNim0iPP9XxAgNiK8xvK0xM2or231FFqL8zDOklmqlS
	knJxwf1HtNtlt7Rs7z8DPweHXw==
X-Google-Smtp-Source: AGHT+IGaOrb4zzhWvIUS63W6GXcdLWTjekK8oVCYKzqKxlL53BXhoc0Q/MVLf36WUVWDul8F8ozYwETiXuQjQyiwqgY=
X-Received: by 2002:a05:6402:278f:b0:64d:3b22:a595 with SMTP id
 4fb4d7f45d1cf-65097dea481mr19954950a12.12.1768321024711; Tue, 13 Jan 2026
 08:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20260109001127.2596222-1-jasonmiu@google.com> <20260109001127.2596222-2-jasonmiu@google.com>
 <aWTJ2v9J-Aa6ykBf@kernel.org> <20260112143904.GA812923@nvidia.com>
 <aWYt0gBHxDCKqj9Q@kernel.org> <20260113130526.GE812923@nvidia.com>
 <aWZaqcStRAK6VWLy@kernel.org> <20260113145802.GA900112@nvidia.com>
In-Reply-To: <20260113145802.GA900112@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 13 Jan 2026 11:16:27 -0500
X-Gm-Features: AZwV_QhiFAqf5sxAvex6xIJLGyJLdLw2dMrpAVVtkd_ClURKVqujFiU__7SUlmA
Message-ID: <CA+CK2bA2L546L5qSoicA=R2S+a0R+D_kp_uo050uBD3B8f4MGw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory tracking
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, Jason Miu <jasonmiu@google.com>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_081707_937065_D32E958E 
X-CRM114-Status: GOOD (  25.29  )
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

On Tue, Jan 13, 2026 at 9:58=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jan 13, 2026 at 04:46:01PM +0200, Mike Rapoport wrote:
> > On Tue, Jan 13, 2026 at 09:05:26AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 13, 2026 at 01:34:42PM +0200, Mike Rapoport wrote:
> > >
> > > > For example mshv intends to use kho_radix_tree to track the hypervi=
sor
> > > > memory and there unpreserving will be a part of the normal flow.
> > >
> > > I do not think this is a good idea.
> >
> > Sorry I wasn't clear, mshv is not going to use KHO memory tracker but
> > another instance of kho_radix_tree data structure.
> > I don't see a problem with that.
>
> Oh.. That's.. Interesting but sure if it is made into a library then
> it makes some sense that it would need freeing support somehow.
>
> I'm surprised there isn't a better data structure for what mshv needs
> though?

It seems both MSHV and kho_radix_tree have an ABI requirement for data
to be parsable by the next kernel. Even if other libraries might work
better, they likely won't need to meet the stability and versioning
requirements for cross-kernel interfaces.

>
> > > Nothing should be touching KHO until a kexec sequence is started. KHO
> > > calls should WARN_ON prior to this point. If a kexec sequence aborts
> > > then the entire radix tree should be discarded and it should go back
> > > to WARN_ON'ing KHO calls.
> >
> > The whole point of making KHO stateless was to decouple it from kexec
> > sequence and let userspace control when preservation happens and to all=
ow
> > preserving as much as possible ahead of time to save cycles at
> > kexec-reboot.
>
> Sure, but also the data structures should not have a life of their
> own, it needs to start from an empty slate every time luo starts the
> sequence. There cannot be cruft left over from previous failed
> attempts or something

Even if a kexec fails, as long as someone still holds LUO session
references, we might successfully kexec the next time. KHO
unpreserving will only occur once the LUO session FDs are closed.

Pasha

