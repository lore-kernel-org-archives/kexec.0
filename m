Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A0CD98CF
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDX0q8phcP9mhqW5SB+yIq6adpUV680tO/gbdFTi4bg=; b=uIbUygtooPfHcAC6sbVxqd8xM7
	/GFxH6a+OGDTNlFT/cjUifRVgVAn8t4/f7njoNFmj3I57gOVhNI6HoY9HpKCjx/K7u52cY0CVeDx4
	COFypLyYYhSGM6Poma33SzqvFIqPEfFMGqrug4FcAwnJfzXcypkYEaVls4ABYduLMBt4AuJZEmwT6
	KQAMLxIWDvDZz3BZiO1CSJuFph7652k4vwB2yk7N8KHsrEYJn1ULePpY/dgkzDIyWPpIXm57pbC4y
	CCBHFlHyJRL8gTN6Y4gtf38IBOtdr/7oA18JhbY6tpsZuCviJUFyEiIi0XhikhVsquMiiAfAUwAat
	LwCqTm+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5D4-0000000BJwS-34dm;
	Fri, 12 Jun 2026 16:58:22 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5D1-0000000BJvw-2BYa
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 16:58:20 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68f9ee927fcso970128a12.3
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781283497; x=1781888297; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDX0q8phcP9mhqW5SB+yIq6adpUV680tO/gbdFTi4bg=;
        b=lHgP4Mh35sshGCCX1PGe47nAzoukBf30mcMkHVZQhqca5qw071mlfp2eAhmKRua4uF
         SOtKxZbqOGMcY2Y1g0gHxA5C0c8F6EMGyadNgRu0Xw2mbaLYEAP2LG/CdRL0enCAWCv9
         gmCn6A9uzt8XAbDtmpvyq5jWsYpDBcKSssQvTSPVQjyonG+s44WnxRbFfM2++KxWmUjp
         sjIcpfSarduMikzRXsg2EoNub0iTEng8aaSyTjRody0FX20QS8p7ETmmlKqbCHbGDJBU
         t+nmrDGvFZRPsLYi9H4Zml8GMNvxmxpjGP60PVexdyt5JYj6Y1KlZ6Q10EGMT6qQGaAJ
         lFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283497; x=1781888297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDX0q8phcP9mhqW5SB+yIq6adpUV680tO/gbdFTi4bg=;
        b=W+oxM+7xgyeyh+ik+sgE2S17M8lzmAHtrj5HmqR6yFdnJ9pDIZXXj7/JnSlMf9qCgI
         +XSjrfFKwSSsRPYJlJlz4yAvznrGZCvAKAWCYM0resxVDqnvwSjHeys8CVxFeinsakwT
         J4OztMp1txHg3Tb8xrM3DAXW/RPHLncoZ2uC4jnfApszuyTagApnABxrM5NM4y7b7SaE
         Rkjq54lixhM2ZjUzj+bnyG/Spk1Ul8qcLq+hP81MFXuBjd9ahQKf4cpm1FB76PpNrDLA
         ZPpMk5lH4bba3OureYPDYwB+irk/IUU8fq3t/YYl7moWYenuJ4YJYLU+tjk10qbpshiI
         W5kA==
X-Forwarded-Encrypted: i=1; AFNElJ+cXX0XNUO6jCzx9HeMhHfXH1vSFTlPilAGMOuFvfB1x5314dY15s6IuR7Cadi+eesEipXmUg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzoBMyIbZQyAHoH3rmA7Fx48jI6TlXMpH5BrcbFQB9H44eeaYru
	vgCqT9vqPXD25t0whcxzENH6A/GB89IRxDclBOX0Oc1vVpcXy4yUAmGf88EOwJRHBZBnRYsWzdA
	dRJY9684ilYQsuYtmoQ==
X-Received: from edi8-n1.prod.google.com ([2002:a05:6402:3048:10b0:691:a21a:fec0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5405:b0:68b:f026:f381 with SMTP id 4fb4d7f45d1cf-693787ed75bmr1752058a12.8.1781283496255;
 Fri, 12 Jun 2026 09:58:16 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:58:15 +0000
In-Reply-To: <aiuu1QzAk_pkQKNV@kernel.org>
Mime-Version: 1.0
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
 <aiqso7rkpX6oMer7@kernel.org> <2vxzmrx1qjuf.fsf@kernel.org>
 <airGIioUmTtU9326@kernel.org> <air5ho0LOIEKVzRG@plex> <aiuu1QzAk_pkQKNV@kernel.org>
Message-ID: <9huzqzmbelw8.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_095819_579094_EF0E1591 
X-CRM114-Status: GOOD (  25.12  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Thu, Jun 11, 2026 at 06:11:13PM +0000, Pasha Tatashin wrote:
>> On 06-11 17:28, Mike Rapoport wrote:
>> > On Thu, Jun 11, 2026 at 03:37:12PM +0200, Pratyush Yadav wrote:
>> > > On Thu, Jun 11 2026, Mike Rapoport wrote:
>> > > 
>> > > > On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
>> > > >> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
>> > > >> on args->serialized_data before checking if the physical address is valid.
>> > > >> Since physical address 0 does not map to virtual NULL (due to direct
>> > > >> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
>> > > >> catching a missing serialized_data, leading to unsafe dereferences later.
>> > > >> 
>> > > >> Validate that args->serialized_data is non-zero before calling
>> > > >> phys_to_virt().
>> > > >> 
>> > > >> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
>> > > >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> > > >> ---
>> > > >>  mm/memfd_luo.c | 10 ++++++----
>> > > >>  1 file changed, 6 insertions(+), 4 deletions(-)
>> > > >> 
>> > > >> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> > > >> index 59de210bee5f..10f3983b0060 100644
>> > > >> --- a/mm/memfd_luo.c
>> > > >> +++ b/mm/memfd_luo.c
>> > > >> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>> > > >>  	if (args->retrieve_status)
>> > > >>  		return;
>> > > >>  
>> > > >> -	ser = phys_to_virt(args->serialized_data);
>> > > >> -	if (!ser)
>> > > >> +	if (!args->serialized_data)
>> > > >
>> > > > We really should make args->serialized_data a KHOSER_PTR
>> > > 
>> > > Hmm, that would also be a good idea. I suppose then it would be a better
>> > > to directly convert to using KHOSER_PTR() instead of this patch?
>> > 
>> > Makes sense.
>> 
>> I think we should systematically cover all  phys_to_virt  conversions 
>> and add  KOSHER_PTR() , instead of an ad-hoc approach of adding it as we 
>> go. So, let's take this patch and do a series where we properly convert 
>> everything and provide guidance for others to use going forward.
>
> It's too late for this patch for -rc1. So let's systematically convert all
> 4 or 5 direct phys_to_virt() conversions in the next cycle and be done with
> it.
>
> We have enough time to make it by -rc2.

I am already working on converitng them to use KHOSER_PTR. I have patch
ready, Will send soon after some testing.

~Tarun

>  
>> Pasha
>
> -- 
> Sincerely yours,
> Mike.

