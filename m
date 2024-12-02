Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C149D78320
	for <kexec@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2u1DptE7aqPrajfMmuzVb0DhAEbAYSjQ3lW7F0V1lk=; b=irRu2yodr/a1oyzkWcg2zbouBv
	rsFl6tbVYZ9iiYzIC77nVl85BHO6qt/yK0UepHk9zt8UGL/8SJlrQIpz+AGlnxgQdnVnNcT0KgE0y
	+8ZdGaGuMjkcXtG5SQlJQSPOHPEmHKsZ69KWg7NYcmBG5ibfKGn0DRuXY4dCaQTS5NcjIJ8R7042e
	w/MvN+vQ18rIlEh/PqriEMHH0nZ7BS4la7+Z94echGI/s8FZ0LSZCGa0lJGywnJZPWKwTvOhSoPFp
	XW4vYoBQZhOGMNsUtSgm1yYnDyEABUw2hQLF25PCgnU6ZsAsd/YkOwTXwkENn3esKa1F4sGi/rIX3
	9RLkhHbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6Yw-00000006FvC-0pX6;
	Mon, 02 Dec 2024 13:34:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6Yu-00000006Fuj-0cMD
	for kexec@lists.infradead.org;
	Mon, 02 Dec 2024 13:34:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A8EE65C686C;
	Mon,  2 Dec 2024 13:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB83C4CED1;
	Mon,  2 Dec 2024 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146443;
	bh=zDv2A3xdqtScOvaXcvzZXL1YZ4qrOJm86gBmKdQV0X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNpgBOoj2ah34/AT9TOTINO9eo8O5dqNoLa8r5wxJlXGQ4vvL/BfWUAkljBw7Q4AQ
	 B1kBEuvkNOZx1anvBw9wAhkRDRQxuPLPjKAInoYxz5pMbrZfMpnQDfIcK1hOXl3AAx
	 MG7jxpB4XWrpwxQhZ9pnUoS2TDgWHElSbDO8Nf+iuEzfVZDgH40ZIzcPXuP3R7TPjz
	 +Ppk3NWc1TJU+AV2ozQGGv49ZHpZGOoVqXdoi2m/5HrMWLbdg/dHZN82ANXmi8hd3E
	 RqYqNS3Wh0BEErsck0VJzV63FpTUQJd3IL7nGJTP+yGw/JCKLZkDc0h0lUK/CPyAc9
	 Ubo8dUFsudsXQ==
Date: Mon, 2 Dec 2024 13:34:00 +0000
From: Simon Horman <horms@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 0/3] Enable UKI image load on x86_64
Message-ID: <20241202133400.GD3737@kernel.org>
References: <20241105035710.11384-1-piliu@redhat.com>
 <CALu+AoSRyHHwR6twY5upJdXnZCPui02Bz3k6niPQ4ZzLU5XQ2g@mail.gmail.com>
 <20241202130623.GB3737@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202130623.GB3737@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_053404_223197_032C864A 
X-CRM114-Status: GOOD (  23.30  )
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

On Mon, Dec 02, 2024 at 01:06:23PM +0000, Simon Horman wrote:
> On Fri, Nov 22, 2024 at 10:12:35AM +0800, Dave Young wrote:
> > Hi Pingfan,
> > 
> > On Tue, 5 Nov 2024 at 11:57, Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > The correct kernel fd instead of UKI image fd should be
> > > passed to the syscall. On arm64, it is not a problem, but on x86_64, it
> > > is.(see commit log in 2/3)
> > >
> > > This series aims to address the above problem.
> > >
> > > Cc: Simon Horman <horms@kernel.org>
> > > Cc: Philipp Rudo <prudo@redhat.com>
> > > To: kexec@lists.infradead.org
> > >
> > > Pingfan Liu (3):
> > >   UKI: Split out the routine to create temporary fd
> > >   kexec: Create a temporary file to hold .linux section in uki_probe()
> > >   x86_64: Support UKI image format
> > 
> > After Doing a test based on this series,   I noticed the uki load will
> > not use the uki internal .cmdline for kernel command line parameters,
> > it requires people to specify cmdline with kexec.  I think this is
> > helpful for kdump to use.  But for general use it would be better to
> > do something like:
> > 
> > by default use the UKI internal cmdline
> > If one specify --command-line or --reuse-cmdline then just use the
> > user provided cmdline and ignore the UKI internal cmdline.
> > 
> > Anyway this can be improved in the future as an appending patch,  the
> > functionality works for me.
> > 
> > Acked-by: Dave Young <dyoung@redhat.com>
> 
> Thanks,
> 
> I will plan to apply this after v2.0.30 has been released.

Thanks everyone, applied.

