Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AE6CD3439
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OSINYmJ3vJWPFl8vzHtHzlEblnGus+VWg6G+vnhXyiw=; b=K5KR6dgU6wt1kESqOpBwYrvVfN
	/HT5ky9P/CjFyl2TCrw9g6Ry5K6MSJqdNc4wGmHoP1EflHnCFn2hslkMoAFG1t8hxOIxOLOsYV5s+
	iJ9jWmM3MmRN2vwn80VGrrzAfvl2UCxWSpNsIXaI/KFbzddS8dLYnsdeUVfXvXjq3t4oXa7sYYKHE
	DFF+PMwkXQtmdo6WL8QB/6z7TAQOLYqyKwd2xoEmfy/YfVgVFWL4r8+AL9lWANbO2shX/uAZFw5BS
	Z83EnDEWrc234KsJEVJ+DoVAJrDl2gjrGMPyIQ+sDzzpeuAt8V884Ahw25Tky0hvlAa9F1Moq+V+9
	6qirI0BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKfCR-00000001WZW-3QDX;
	Wed, 06 May 2026 16:34:15 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKfCP-00000001WYe-403D
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 16:34:14 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7991db3dc98so70206057b3.0
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778085253; x=1778690053; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSINYmJ3vJWPFl8vzHtHzlEblnGus+VWg6G+vnhXyiw=;
        b=FHRP+7g0zWfRPjkTbXxP7htE7mAJ+hqmE/NGra7Fgk/0yNiGZpRbQ4PpFBjGpFq6TL
         +76kLfqABt9jbmdYzluSAnWl1xy2hWlhE6IzZqf9qqn04M5f/hyWOHDLKkdxE8M6fL/X
         Wl8h0eeAPBAA8a/AbMQqedtCl/4HkVlixAcH2BBXlqHOKV4dSS/ddthqaYqoGAP1zdaL
         FmeqDPHtG8dmXshghzjNn4A8PxZlLsJPxaaajbgGiqSFhPQDNzoNVnvtvgP1vF3hPLIz
         JL/VRnVyYwgnpz5UVpKyIfP2rCQ9XX4t6wb3QIVjA976yb+YUoSX1X/VezGk1RAQ+Jsr
         /mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778085253; x=1778690053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSINYmJ3vJWPFl8vzHtHzlEblnGus+VWg6G+vnhXyiw=;
        b=lYNAkQQWf3S2dYYpNPGA0IoI2ptiZnlZi39+kdE0+SHa8+PGYd174QOCUklzbbE/Df
         jDvLl131JdYMlR5RTQ2bdWgJcbx9YGOUvXhsIbjX7MSZKlFQXqmnTqBDl+Ky9Bfy6YX5
         eOmF3bhm6xYZ4vprbUuoumgvLuFRJeDrVuxgRNr/cnZVrAo7LKl4jxoho4zKgfviW9yq
         zobmR69QGhX0kSCxynTo4qUKwiuy/W7EkveytFWuV1stkIPS5CDKuRUwbM2Dy/1ul/dQ
         Sjv3V3h55TD2AySVk3EvJt2S22OHNEAzmWNrtq4BVcDOL5cKKRKXrYXaopRJfgZK6Nx6
         yOqg==
X-Forwarded-Encrypted: i=1; AFNElJ9a7AZEVDyrl2tilYDTpYFcW/7Z/G9HzZ9leRL5S9h5bUoj6tDDF27e5ARhBa4nShOL0RYhyA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzNIDNl1AI752DYrB68dugVSlXfg+iGnmei9O7zKezJX4QMScFi
	qXhhb++9h6i0NV1NFTJJBR6xkL/VnnLQy08UgPAqnFiQfwt0XtaoH0m8aVvA3Kf6XzI=
X-Gm-Gg: AeBDiesP/W0bhLXU8mbMemVjtyPDdbN5mbLiMIkFUtGD76RIIRo9xZtF9amCkrBX6A3
	KEJ3MYv8DQxW7vuQOOnoixpGunbk0l03jTZlufCeTrzKWZoSOEDW7CrfDjr9WX/AtRrYlpy+bHh
	aECM1qsEGYVBn5ZCdEuHHjRQ6aoPFcbUgnEGZJ1a6zUJFZ5zFtnrPHyutZ0jcgFQ5JkunE0OLxO
	FNxpfW8HKp6xtUy5lsQaV0/TnojFv09G+9t9gqXJYid9y7E4w4/1LMkTtseVP32NW5oNzMChXDE
	5P4FPv+188gjYbZxWHwswS4cT/BzWvB6Z5E5MkL1aPp4T6e9JAq/0uRx0XkSUT4hQFngf7lrcdn
	d+mYs4dbFs/WpRs8cOfORMKCG2/MQrhH0nKWUcYZ8c/AdRXtfvaerBX5q7gVIx3yL1MT3nvkGaj
	SYN/umW3CUOp0YidvxZdRM+5N86PsT8+XLab1HDbAijYTatVavGCxal/m3O23AJsGJ8f2WZEM7X
	dg8sMf4NBCz8LlYAPmYVXD4DtrSf6ppNZUsO5bJ
X-Received: by 2002:a05:690c:8e07:b0:7bd:d145:3af9 with SMTP id 00721157ae682-7bdf5f265b3mr41479677b3.47.1778085252743;
        Wed, 06 May 2026 09:34:12 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6654cc7csm83105227b3.13.2026.05.06.09.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:34:12 -0700 (PDT)
Date: Wed, 6 May 2026 12:34:10 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Cris Jacob Maamor <crisjacobmaamor@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
Message-ID: <aftsRFhwjE0mq7pb@google.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
 <afT_xHDuFwAUSR0X@plex>
 <2vxzse84zzag.fsf@kernel.org>
 <aftVd5RnpnAi2jdc@google.com>
 <2vxzfr44zf94.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzfr44zf94.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_093414_015635_CA829826 
X-CRM114-Status: GOOD (  53.94  )
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

On 05-06 18:15, Pratyush Yadav wrote:
> On Wed, May 06 2026, Pasha Tatashin wrote:
> 
> > On 05-06 11:02, Pratyush Yadav wrote:
> >> Hi Pasha,
> >> 
> >> On Fri, May 01 2026, Pasha Tatashin wrote:
> >> 
> >> > On 05-02 01:30, Cris Jacob Maamor wrote:
> >> >> LUO restores metadata from KHO/FDT during liveupdate. The restored
> >> >> metadata contains physical addresses and count fields used to access and
> >> >> walk preserved session, file set, and FLB arrays.
> >> >> 
> >> >> This series adds a non-consuming KHO preserved-range check and uses it
> >> >> before phys_to_virt() on restored metadata addresses. It also rejects
> >> >> restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
> >> >> before traversal.
> >> >> 
> >> >> As far as I can tell, this is root/admin-only; I do not have evidence
> >> >> that a normal unprivileged user can trigger it directly.
> >> >> 
> >> >> Changes since v1:
> >> >> - Dropped RFC marking.
> >> >> - Added changelog text to each patch.
> >> >> - No code changes.
> >> >> 
> >> >> Cris Jacob Maamor (5):
> >> >>   kexec: handover: add helper to check preserved page ranges
> >> >>   liveupdate: validate LUO FDT physical address before mapping
> >> >>   liveupdate: validate restored LUO session metadata
> >> >>   liveupdate: validate restored LUO file set metadata
> >> >>   liveupdate: validate restored LUO FLB metadata
> >> >
> >> > I have replied separately in the security report to clarify that this is 
> >> > not a bug. The behavior follows the ABI specification exactly: we use 
> >> > the PA addresses and ranges provided by the KHO FDT tree.
> >> >
> >> > NAK
> >> 
> >> I really do think we should do a restore-only variant for the
> >> kho_alloc_preserve() family of allocators and use it everywhere. It
> >
> > That is unrelated to the provided patch series. The author of this 
> > series reported this as a security issue to the Linux security ML, and 
> > submitted this series at their request.
> 
> Oh yes, sure. I am not arguing for taking this series. I just figured
> this would be a good point to have this discussion.
> 
> >
> > This is not a security issue, and in fact, it is not an issue at all. A 
> > restore-only variant can be added, but I do not see a reason for LUO to 
> > use it.
> >
> >> would prevent problems in the future. Not because the previous kernel is
> >> malicious, but because we might have bugs and the KHO page magic sanity
> >> check acts as a defense in depth.
> >> 
> >> For example, I am currently looking at a LUO bug where LUO does not
> >> track if a session is outgoing or incoming. So you can do a retrieve()
> >> or finish() on an outgoing session. A lot of nastiness is saved because
> >> of the page magic check. Things like kho_restore_vmalloc() or
> >> kho_restore_folio() fail early and loudly.
> >
> > I am not sure what bug you are looking at (please share the details!), 
> 
> I was looking at LUO code and realized that we do not separate outgoing
> and incoming sessions when dealing with preserve/retrieve/finish ioctls.
> So you can create a session, preserve a FD, and then immediately call
> finish or retrieve without doing a kexec. Of course, LUO file handlers
> aren't able to cope with it.

Oh, this makes sense, please add a self-test for that as well :-)

> 
> So for example, you can preserve a memfd and then immediately call
> finish. This will call memfd_luo_finish(), where it will try to
> kho_restore_vmalloc(). That fails with a bit WARN splat. And then later
> it calls kho_restore_free() which also fails in a similar fashion.
> 
> You can do the same thing with retrieve(), but that also fails early and
> loudly and does not cause any problems.
> 
> I am working on a fix for it. Should have something out shortly.
> 
> > but the fix absolutely should be to use outgoing/incoming sessions 
> > properly, and if we mixed them up somewhere, THAT should be fixed. Using 
> > KHO restore is not going to help much; however, I agree it can add 
> > some extra scrutiny (i.e., similar to an ASSERT), but it is not really 
> > something that would help improve correctness in any meaningful way. The 
> > correctness should lie in the LUO logic using incoming as incoming, and 
> > outgoing as outgoing.
> 
> I am not arguing that we shouldn't fix the logic bugs. Of course we
> should.
> 
> My point is that this sanity check acts as another layer of defence.
> Bugs happen, but the earlier we catch them the better and this sanity
> check helps us do exactly that.
> 
> For example, if we did not have these sanity checks, the loud errors I
> described above would be replaced by silent use-after-free, double-free,
> struct page corruption, or other problems.
> 
> So I would like to understand why you _don't_ want to have this line of
> defence. What's the problem? If you are worried about performance, we
> can go and measure it. If the overhead is too high this can be behind a
> debug config.

Most likely, there is no performance cost, because when we free 
preserved memory, we still need to do a KHO restore. The only difference 
is that it may occur after a blackout not during blackout. Anyway, if 
you would like to add this sanity check, please send it out, and we can 
review and discuss how it looks.

> 
> >
> >> 
> >> If we want to squeeze out more performance later down the line we can
> >> move it behind a debug config, but having this usage pattern of always
> >> restoring before using is going to be a lot more sane than just using
> >> physical addresses willy nilly.
> >> 
> >> The approach this series takes with kho_is_preserved() is the wrong
> >> design. But a kho_restore() or something similar (maybe we can find a
> >> better name?) is really where we should be going.
> >> 
> >> -- 
> >> Regards,
> >> Pratyush Yadav
> 
> -- 
> Regards,
> Pratyush Yadav

