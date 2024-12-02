Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B067D78318
	for <kexec@archiver.kernel.org>; Mon,  2 Dec 2024 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWZZTnQRqsoLLmvYM5ojk/Vh49Bxuuzq0Sz7VdX51bo=; b=GatKjxsIjvFJQJXLGuA4KxjUDQ
	NQGOwmRWAdX5wnpkPQ2sL3CL4B1C0Z0UjWI0nRHIf1gNhX/F/FR2xU9sDfv0cHIQ9KjpCha/YRUg5
	TtlwKql+wpvXLlCsm1vhmKR1hAQS3LL3yFsbeoyYyH3TKsY7BhkT7jn/GH+S/l9sFafZ+m9hFpDUf
	IU+B2gW+BdynSItLU1KU+T4WUUDDM6PiOLZbVtkARmiA/JcAD467cjDeoag/R40OkZ1B+EM7ZOYuA
	49twfigecvkROrao8R9OE7cSFvOJ57BptVr/IGn6GEq3QaYg2tF0LIVoS/Cz9VpVGR8q3+HjRZn5C
	UlRljgqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI68D-00000006B1G-2wGE;
	Mon, 02 Dec 2024 13:06:29 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI68B-00000006B0u-24PV
	for kexec@lists.infradead.org;
	Mon, 02 Dec 2024 13:06:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4B010A40C3F;
	Mon,  2 Dec 2024 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D4DC4CED1;
	Mon,  2 Dec 2024 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144786;
	bh=ixotu7efWDw76OZEkFEs+oPPWmFFEgqGOUXoch4fqmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjLDQeW2q+uRqCGhpclBHZ7ECbj4UUHta/lxvJrhENY/JRFjEvkMC2u6dlsSgTQGo
	 mYHaY4HufRgty84crb65SlK51MkLkEgdy9zDuBlzRaTux+23EYiBSuuEPxFNRKT8q+
	 p0Q4uh7GJ3HwOf/y4WhWCbOWm273csfXNpM2Cb7IoOAgbhZ+aiAbimPvyiABxkTufF
	 j9/iIEK3ZTNzLsgUktgZoZ/DD2x0nhDqUBL/QpwB64PIANwT32MOyszV/edjAW1TdC
	 5FTezGCJoKKkS5VOiuBNmdWqoz5ppurA9Vi0jwdUtFZdm3A13BV5fX+sdSMumBI3FT
	 AoYbzl+6T1isg==
Date: Mon, 2 Dec 2024 13:06:23 +0000
From: Simon Horman <horms@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 0/3] Enable UKI image load on x86_64
Message-ID: <20241202130623.GB3737@kernel.org>
References: <20241105035710.11384-1-piliu@redhat.com>
 <CALu+AoSRyHHwR6twY5upJdXnZCPui02Bz3k6niPQ4ZzLU5XQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoSRyHHwR6twY5upJdXnZCPui02Bz3k6niPQ4ZzLU5XQ2g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_050627_593231_4F51C9D6 
X-CRM114-Status: GOOD (  19.18  )
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

On Fri, Nov 22, 2024 at 10:12:35AM +0800, Dave Young wrote:
> Hi Pingfan,
> 
> On Tue, 5 Nov 2024 at 11:57, Pingfan Liu <piliu@redhat.com> wrote:
> >
> > The correct kernel fd instead of UKI image fd should be
> > passed to the syscall. On arm64, it is not a problem, but on x86_64, it
> > is.(see commit log in 2/3)
> >
> > This series aims to address the above problem.
> >
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> >
> > Pingfan Liu (3):
> >   UKI: Split out the routine to create temporary fd
> >   kexec: Create a temporary file to hold .linux section in uki_probe()
> >   x86_64: Support UKI image format
> 
> After Doing a test based on this series,   I noticed the uki load will
> not use the uki internal .cmdline for kernel command line parameters,
> it requires people to specify cmdline with kexec.  I think this is
> helpful for kdump to use.  But for general use it would be better to
> do something like:
> 
> by default use the UKI internal cmdline
> If one specify --command-line or --reuse-cmdline then just use the
> user provided cmdline and ignore the UKI internal cmdline.
> 
> Anyway this can be improved in the future as an appending patch,  the
> functionality works for me.
> 
> Acked-by: Dave Young <dyoung@redhat.com>

Thanks,

I will plan to apply this after v2.0.30 has been released.

