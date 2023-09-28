Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC5CE7B06
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qkUGjnfffUG6m3kOyz6brsCK6bxSy4OUdouimvoTePg=; b=U30mL5Ympx5eoc
	eaN0FVU0AChbfrRAEZLpF+6lKo/ujFDom4Wyn5Bv6rdTvwR08VBuc0CsP9FsXtIYvRyuJCncFYiEs
	WiGqI6YFL4hNNkc/gBI227P5AdrqTFqN1qAGp3k9K2PKqS+pW5bkDk8gmKXVxzwNVS0voRmtYHsLM
	y4w018qCSOW9tGsXhwk53F8Z/z/J/xZamMSUGCe300m2jxRMaYBvfgXa4TIOvd9ukirLazM0qWA3i
	ZDID9GEWDPOPzoyCekWtzcgT8bgw0wWPhnhs7rS8vuH1HLvrJgweqBUalgSBUMPlgbjJpFMlU1xDJ
	L2Lvejr0D89rhgyXEsuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlvcT-006VhB-1k;
	Thu, 28 Sep 2023 18:20:13 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlvcQ-006VgP-0C
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 18:20:11 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7EE4120B74C0;
	Thu, 28 Sep 2023 11:20:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EE4120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695925208;
	bh=qzXRtVqab1KuX8hacfAHwg+J+YhXJMcTAAAg0YJWefc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InogNLf7WzZJzUcwSzdHla+lWmGcKkolbTfAENutwo01jBMn6+6+J+8PQsSZ8clS4
	 ychBtzZqvdYXuBAR0DrEqwu84wPSo4tRfl2XmoP+WmPQr2F5mh8zah0HLooz0taaGi
	 1VaQW11p4wHVEwqdduASRTnkYvoVGlXbuRBHGeDg=
Date: Wed, 27 Sep 2023 17:38:31 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230928003831.GA20366@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_112010_125283_B57BA053 
X-CRM114-Status: GOOD (  38.15  )
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

On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> > On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
> ...
> > Well, not exactly. That's something I'd like to have indeed, but from my
> > POV this goal is out of scope of discussion at the moment.
> > Let me try to express it the same way you did above:
> > 
> > 1. Boot some kernel
> > 2. Grow the deposited memory a bunch
> > 5. Kexec
> > 4. Kernel panic due to GPF upon accessing the memory deposited to
> > hypervisor.
> 
> I basically consider this a bug in the first kernel.  It *can't* kexec
> when it's left RAM in shambles.  It doesn't know what features the new
> kernel has and whether this is even safe.
> 

Could you elaborate more on why this is a bug in the first kernel?
Say, kernel memory can be allocated in big physically consequitive
chunks by the first kernel for depositing. The information about these
chunks is then passed the the second kernel via FDT or even command
line, so the seconds kernel can reserve this region during booting.
What's wrong with this approach?

> Can the new kernel even read the new device tree data?
> 

I'm not sure I understand the question, to be honest.
Why can't it? This series contains code parts for both first and seconds
kernels.

> >> Can't the deposited memory just be shrunk before kexec?  Surely there
> >> aren't a bunch of pathological things consuming that memory right before
> >> kexec, which is basically a reboot.
> > 
> > In general it can. But for this to happen hypervisor needs to release
> > this memory. And it can release the memory iff the guests are stopped.
> > And stopping the guests during kexec isn't something we want to have in the
> > long run.
> > Also, even if we stop the guests before kexec, we need to restart them
> > after boot meaning we have to deposit the pages once again.
> > All this: stopping the guests, withdrawing the pages upon kexec,
> > allocating after boot and depostiting them again significatnly affect
> > guests downtime.
> 
> Ahh, and you're presumably kexec'ing in the first place because you've
> got a bug in the first kernel and you want a second kernel with fewer bugs.
> 

Right. All this is for "kernel servicing" purposes, when kexec is used
to update the kernel in a fleet with in attempt to reduce users downtime
as mush as possible.
I'm sorry for keeping this bit of context to myself instead of
explicitly stating it the series description: it wasn't intentional.

> I still think the only way this will possibly work when kexec'ing both
> old and new kernels is to do it with the memory maps that *all* kernels
> can read.
> 

Could you elaborate more on this?
The avaiable memory map actually stays the same for both kernels. The
difference here can be in a different list of memory regions to reserve,
when the first kernel allocated and deposited another chunk, and thus
the second kernel needs to reserve this memory as a new region upon
booting.

Can all this considered, as, say, the first kernel uses device tree to
inform the second kernel about the memory regions to reserve?
In this case the first kernel behaves a bit like a firmware piece for
the second one.

> Can the hypervisor be improved to make this release operation faster?

I guess it can, but shutting down guests contributes to downtime the
most. And without shutting down the guests the deposited memory can't be
withdrawn.

Thanks,
Stanislav

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
