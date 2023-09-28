Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB034E732FD
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DWDdpUUMAdCNAJkYtuHZVTE8dXV5oh6H9FUhBOjAtrs=; b=N+APUovPmUERhq
	Q2H8nMKQegY+LJpycYrmnmImRNaSR+zkQg9j/SN+R7nn95tKqmVqQI+QAuMYUoGAWcMl0/lfWSN4Q
	Str8RsstyiMcX50rS+El3EGG1oIrgk/g/Lif5mbSCPhEGzc5xw/qfaRnxjMtZEdxxwnUu3pFsbh/z
	CqEgezENxhnRLLp4lBnQobk2wBuwY+oNefiAIGOkkTtbhXTgghzKxA5SD7APhiWoDmcVF0n80aKxm
	cfe8Ta4qnaB0G6dCWyGAY5B5jq0h2TJ3Xesi5vDqs+q9tLR2qNlFXa+o69KlwU2tJ/WvY5UvyRXNI
	KJ4Rumo+3vCOwqU5uGhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlv6N-006SRB-1F;
	Thu, 28 Sep 2023 17:47:03 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlv6J-006SOu-1j
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:47:02 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94B8220B74C0;
	Thu, 28 Sep 2023 10:46:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94B8220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695923214;
	bh=8azlj8h+nnoYckRZdoq3dRRObjjiSdIAPmN8H2cYaLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBT+2hpWVBtgR8Fn0JKt9Je5NDuy81aE6D/bgVPnc7CnR3tpXNSEmjdQRo61dR3+e
	 3ToiRnx5iOH7bDBL4h3AGcyDpMVqYw/MnNn85fWvBneMfGp9nhAH98OCguhdrJltKo
	 tDtmP0I5slUIbFAuntyrJcLdZcALdag4msVdmqWU=
Date: Wed, 27 Sep 2023 17:02:30 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230928000230.GA20259@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b684d339-991d-be85-692c-75f21679ca69@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_104659_618710_B66F91BE 
X-CRM114-Status: GOOD (  39.47  )
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

On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
> On 9/27/23 16:25, Stanislav Kinsburskii wrote:
> > On Thu, Sep 28, 2023 at 06:22:54AM -0700, Dave Hansen wrote:
> >> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
> >>> Once deposited, these pages can't be accessed by Linux anymore and thus
> >>> must be preserved in "used" state across kexec, as hypervisor state is
> >>> unware of kexec.
> >>
> >> If Linux can't access them, they're not RAM any more.  I'd much rather
> >> remove them from the memory map and move on with life rather than
> >> implement a bunch of new ABI that's got to be handed across kernels.
> > 
> > Could you elaborate more on the new ABIs? FDT is handled by x86 already,
> > and passing it over kexec looks like a natural extension.
> > Also, adding more state to it also doens't look like a new ABI.
> > Or does it?
> 
> FDT makes it easier to pass arbitrary data around, but you're still
> creating a new "default_pmpool" device tree node on one end and
> consuming it on the other.  That's a new ABI in my book.
> 

Well, then yes, it's a new ABI.
I guess it can still be named as "linux,cma", but then another
compatibility needs to be introduced, and that's again a new ABI, isn't
it?

> > Let me also comment on removing this regions from the memory map. The
> > major peculiarity here is that hypervisor distinguish between the pages,
> > deposited for guests to rnu and the pages deposited for the Linux root
> > partition to keep the guest-related portion of hypervisor state in the
> > root partition. And the latter is the matter in question.
> > 
> > We can indeed isolate and deposit a excessive amount of memory upfront
> > in hope that hypervisor will never get into the situation, when it needs
> > more memory.
> > However, it's not reliable, as the amount of memory will always be an
> > estimation, depending on the number of expected guests, guest-attached
> > devices, etc. And this becomes even a bigger problem when most of the
> > memory is already removed from the memory map to host guest partitions.
> > It's also not efficient as the amount of memory required by hypervisor
> > can grow or shrink depending on the use case or host configuration, and
> > deposting excessive amount of memory will be a waste.
> > 
> > But, actually, the idea of removing the pages from memory map was
> > reflected to some extent in the first version of this proposal,
> > so let me elaborate on it a bit.
> > 
> > Effectively, instead of reserving and depositing a lot of memory to
> > hypervisor upfront, the memory can be allocated from kernel memory when
> > needed and then returned back when unused.
> > This would still require pages removal from the memory map upon kexec,
> > but that's another problem.
> 
> Let's distill this down a bit.
> 
> I agree that it's a waste to reserve an obscene amount of memory up
> front for all guests for rare cases.  Having the amount of consumed
> memory grow is a nice feature.
> 
> You can also quite easily *shrink* the amount of memory on a given
> kernel without new code.  Right?
> 
> The problem comes when you've grown the footprint of hypervisor-donated
> memory, kexec, and *THEN* want to shrink it.  That's what needs new
> metadata to be communicated over to the new kernel.
> 
> 1. Boot some kernel
> 2. Grow the deposited memory a bunch
> 3. Kexec
> 4. Shrink the deposited memory
> 
> Right?
> 

Well, not exactly. That's something I'd like to have indeed, but from my
POV this goal is out of scope of discussion at the moment.
Let me try to express it the same way you did above:

1. Boot some kernel
2. Grow the deposited memory a bunch
5. Kexec
4. Kernel panic due to GPF upon accessing the memory deposited to
hypervisor.

> That's where you lose me.
> 
> Can't the deposited memory just be shrunk before kexec?  Surely there
> aren't a bunch of pathological things consuming that memory right before
> kexec, which is basically a reboot.

In general it can. But for this to happen hypervisor needs to release
this memory. And it can release the memory iff the guests are stopped.
And stopping the guests during kexec isn't something we want to have in the
long run.
Also, even if we stop the guests before kexec, we need to restart them
after boot meaning we have to deposit the pages once again.
All this: stopping the guests, withdrawing the pages upon kexec,
allocating after boot and depostiting them again significatnly affect
guests downtime.

Thanks,
Stanislav

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
