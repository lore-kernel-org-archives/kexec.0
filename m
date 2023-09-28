Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183EE732E9
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eJgh/4oiJxEqYiSYZBPxLIBnfrXreTxlCuYZsMU8HbY=; b=byROjRjk/bMRq/
	HvPjuiZ2l3jy3a5P8mxoAf6lT3KOPOOwBD56veUmogpl+e1kF6+tqPuli8GOFarYahOMo6pKEo736
	kcmWQh1mXAmRVPKfUPfCCqW6Mo7wRJ1ecIItUpw5a79Q+aIx5M/Q8rex3dXwG1k9h7GAgDqoSeWLV
	uhm2rQrMPJ6aJzMhPYSh7qy5NFnKQPvGFRGE2tTP9PWSLNnC+6LdjbMCg625IdDZUPLYlEDEe2EYJ
	ei8Br5xGokKtdoRQDTvZCQk+PC4ceR3bg/OuAY0itUQ6eGS5HXR+UbyYX9g5xF80KsfG1vbiW274t
	SDnK2M0HYBDocgmcuDFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxSu-006d9r-02;
	Thu, 28 Sep 2023 20:18:28 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxSr-006d8w-1o
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 20:18:27 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED35520B74C0;
	Thu, 28 Sep 2023 13:18:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED35520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695932302;
	bh=wz50AnR8DoJagH+bYRnpSE1N+GfL6PVir2jJWX0plLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf1WK8ac5b6oA9wt9M+cxek3Uv14+QHpzqZPPKlh0ydRwWo50iszJ+C65uL9tP/1m
	 M4+yqK2kP1LLb+B26OfKBFCGI30ySoQ1M3Un8qtuzP/0Yx7OUuC2gTmuOK7dvDmtoa
	 l7kmPbfBAqiKhCRMOfMF4cOrf4wP9+BjsU9Y/d7o=
Date: Wed, 27 Sep 2023 19:46:36 -0700
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
Message-ID: <20230928024636.GA20423@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_131825_644759_D782EDDB 
X-CRM114-Status: GOOD (  53.76  )
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

On Thu, Sep 28, 2023 at 12:16:31PM -0700, Dave Hansen wrote:
> On 9/27/23 17:38, Stanislav Kinsburskii wrote:
> > On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
> >> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> >>> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
> >> ...
> >>> Well, not exactly. That's something I'd like to have indeed, but from my
> >>> POV this goal is out of scope of discussion at the moment.
> >>> Let me try to express it the same way you did above:
> >>>
> >>> 1. Boot some kernel
> >>> 2. Grow the deposited memory a bunch
> >>> 5. Kexec
> >>> 4. Kernel panic due to GPF upon accessing the memory deposited to
> >>> hypervisor.
> >>
> >> I basically consider this a bug in the first kernel.  It *can't* kexec
> >> when it's left RAM in shambles.  It doesn't know what features the new
> >> kernel has and whether this is even safe.
> >>
> > 
> > Could you elaborate more on why this is a bug in the first kernel?
> > Say, kernel memory can be allocated in big physically consequitive
> > chunks by the first kernel for depositing. The information about these
> > chunks is then passed the the second kernel via FDT or even command
> > line, so the seconds kernel can reserve this region during booting.
> > What's wrong with this approach?
> 
> How do you know the second kernel can parse the FDT entry or the
> command-line you pass to it?
> 
> >> Can the new kernel even read the new device tree data?
> > 
> > I'm not sure I understand the question, to be honest.
> > Why can't it? This series contains code parts for both first and seconds
> > kernels.
> 
> How do you know the second kernel isn't the version *before* this series
> gets merged?
> 

The answer to both questions above is the following: the feature is deployed
fleed-wide first, and enabled only upon the next deployment.
It worth mentioning, that fleet-wide deployments usually don't need to support
updates to a version older that the previous one.
Also, since kexec is initialited by user space, it always can be
enlightened about kernel capabilities and simply don't kexec to an
incompatible kernel version.
One more bit to mention, that it real life this problme exists only
during initial transition, as once the upgrade to a kernel with a
feature has happened, there won't be a revert to a versoin without it.

> ...
> >> I still think the only way this will possibly work when kexec'ing both
> >> old and new kernels is to do it with the memory maps that *all* kernels
> >> can read.
> > 
> > Could you elaborate more on this?
> > The avaiable memory map actually stays the same for both kernels. The
> > difference here can be in a different list of memory regions to reserve,
> > when the first kernel allocated and deposited another chunk, and thus
> > the second kernel needs to reserve this memory as a new region upon
> > booting.
> 
> Please take a step back from your implementation for a moment.  There
> are two basic design points that need to be considered.
> 
> First, *must* "System RAM" (according to the memory map) be persisted
> across kexec?  If no, then there's no problem to solve and we can stop
> this thread.  If yes, then some mechanism must be used to tell the new
> kernel that the "System RAM" in the memory map is not normal RAM.
> 
> Second, *if* we agree that some data must communicate across kexec, then
> what mechanism should be used?  You're arguing for a new mechanism that
> only new kernels can use.  I'm arguing that you should likely reuse an
> existing mechanism (probably the UEFI/e820 maps) so that *ALL* kernels
> can consume the information, old and new.
> 

I'd answer yes, "System MAP" must be persisted across kexec.
Could you elaborate on why there should be a mechanism to tell the
kernel anything special about the existent "System map" in this context?
Say, one can reserve a CMA region (or a crash kernel region, etc), store
there some data, and then pass it across kexec. Reserved CMA region will
still be a part of the "System MAP", won't it?

Regarding the communication mechanism, device tree is not the only one
indeed.
However, could you elaborate on how e820 extension can help to
communicate thing here without introducing new ABI?
And if it can't then done without a new ABI, then why e820 extension is
better than a device tree extension? AFAIU e820 isn't really designed to
pass arbitrary data bits in it.
Are you suggesting to intoduce another e820_type like E820_TYPE_PMPOOL?

> I'm not convinced that this series is going in the right direction on
> either of those points.
> 

I understand the skepticism. I appreciate your efforts in helping to
find a solution.

> > Can all this considered, as, say, the first kernel uses device tree to
> > inform the second kernel about the memory regions to reserve?
> > In this case the first kernel behaves a bit like a firmware piece for
> > the second one.
> > 
> >> Can the hypervisor be improved to make this release operation faster?
> > 
> > I guess it can, but shutting down guests contributes to downtime the
> > most. And without shutting down the guests the deposited memory can't be
> > withdrawn.
> 
> Do you really need to fully shut down each guest?  Or do you just need
> to get them to a quiescent state where the hypervisor and devices aren't
> writing to the deposited memory?

Unfortunatelly, quiescing is not enough as the guest-related state in
root partition will still exist in the hypervisor.

The way it works right now, is that the hypervisor can return a
"ENOMEM"-like error upon guest altering hypercall in the root partition
(like partition creation or device addition) and then Linux deposits
more memory to hypervisor. IOW, while the guest is running, correposing
root partition pages are "used" by the hypervisor and can't be withdrawn.

Also, guest quiescing itself isn't something mandatory with type 1
hypervisors, as guest can be scheduled by hypervisor without VMM
support, and VM exits can be trapped on the hypervisor level using that
persistent guest-realted state in the root partition. VMM can then
reattach bacak to the persistent state after kexec.

Thanks,
Stanislav

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
