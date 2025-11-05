Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37947CCFA0D
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfwxojZOFFcOo9hnRHu2r7AMzIR991JVWKMGHEYB6Wc=; b=espYddICeWJiqNoW/Jueh2rRiW
	nyO4DVxV7v5U5zoI97KEVHFDaBJ0Jr5hHskHFo6vtul2WddvxpDy0Ku2KuH2P2Q6qBhNQ1/5NJKmD
	6NGF/t9V7ioq/fisBQ9XG70T1t1nENt0gzBQ7o4ydvlZ8RphoglGC07lDOKhp9zyoGMs2jqbnP8dl
	+mLpOsVIy/a/xD8jeuzp98uW+PotoGrST66QKkwPsEznyXsUIYvz/7Qfq6ykriYoNIx7ppS4HQZqO
	sLl3wvBIDmjeVyjkV9kUslpVI5h5oX/tgZUnwf4JsjHT3sByeuTy4+OLw/tE2K0Kn+MmAXzKQ0HhQ
	Hvez95pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaPD-0000000DRed-0jnp;
	Wed, 05 Nov 2025 10:06:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaPA-0000000DReC-3S0r
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 10:06:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33C3A44197;
	Wed,  5 Nov 2025 10:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F501C116D0;
	Wed,  5 Nov 2025 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337176;
	bh=7xelL80uD+mmTJR2hN24e9Ymu3C2gxHRvhahEaLbF7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XEEheCSjZlHYcaoorplt0rQp5cepQJdG9XPrkjpeRyZZNwsZTULh6DAKX/St3FlgR
	 05qjxYR5hoyxzpKI0tkyeXyoPLZOrMLelfjfvga4J+Wqzgw9+cKAso7+9avEAGSqEo
	 KwP5hf+BMCbGBeTb8892UAId7TL283+yLGI68VNqK/1GeUG4WGOWlqf9LDaY04j6sM
	 CvUJKAjPFgu0qIvUzjbO/q0itD0EEx29Z/BxgZED0mPeUpbmjzPQFhZYsEphXtB1if
	 qoWBeQ6ISiFlZQMOvlya8ylHlu4VKKSo1zn5sT4Q6NX2PB4OAbv9nx4dPoCIIqvRrU
	 Ie9jRbkH4fySg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Baoquan He <bhe@redhat.com>,
  Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
In-Reply-To: <20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
	(Andrew Morton's message of "Mon, 3 Nov 2025 17:23:21 -0800")
References: <20251103180235.71409-1-pratyush@kernel.org>
	<20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
	<20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
Date: Wed, 05 Nov 2025 11:06:13 +0100
Message-ID: <mafs0tsz8bxpm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_020616_882689_883D713C 
X-CRM114-Status: GOOD (  20.59  )
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

On Mon, Nov 03 2025, Andrew Morton wrote:

> On Mon, 3 Nov 2025 16:20:20 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:
>> 
>> > This series has a couple of misc fixes for KHO I discovered during code
>> > review and testing.
>> > 
>> > The series is based on top of [0] which has another fix for the function
>> > touched by patch 1. I spotted these two after sending the patch. If that
>> > one needs a reroll, I can combine the three into a series.
>> >
>> 
>> Things appear to be misordered here.
>> 
>> [1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
>> 	fixes a667300bd53f2, so it's wanted in 6.18-rcX
>> 
>> [2/2] "kho: warn and exit when unpreserved page wasn't preserved"
>> 	fixes fc33e4b44b271, so it's wanted in 6.16+
>> 
>> So can we please have [2/2] as a standalone fix against latest -linus,
>> with a cc:stable?
>> 
>> And then [1/2] as a standalone fix against latest -linus without a
>> cc:stable.
>> 
>
> OK, I think I figured it out.
>
> In mm-hotfixes-unstable I have
>
> kho-fix-out-of-bounds-access-of-vmalloc-chunk.patch
> kho-fix-unpreservation-of-higher-order-vmalloc-preservations.patch
> kho-warn-and-exit-when-unpreserved-page-wasnt-preserved.patch
>
> The first two are applicable to 6.18-rcX and the third is applicable to
> 6.18-rcX, with a cc:stable for backporting.

Right. Sorry for the confusion. I see that on mm-hotfixes-unstable you
already updated the third patch with Cc: stable. Thanks.

-- 
Regards,
Pratyush Yadav

