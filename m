Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2B2C64EC4
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1koDD8X99Bg63LGk4dA/9RBiQOk9ISzUh0avYFs4Lpk=; b=0EtFwOU1seY3Mv
	VIlptNyu75+eSjwMIg6bdvZQBmGWBTt7HoG30c5jy7kSFJLaDsh05KvtF58tBIlcMhe4YRzgK6tR5
	b9z2Xc2cMVF5hJ8FdNN5b1vvbeqp3Zk4p2RrNRSNAKZNEActZP35zrkNX2qsfiReV9uSK7tKSSdTx
	tWA4EBPBcKzplH5DpLg0tkUWo1Qc42Xo/SjVyaVfrecevtTi8FpquLbzhnwAnpec3QLar3xtEFAqO
	2kT4vmyrfOXRO7zsmpnYXYjD66rgE+tn12fVlK4hcJa7oOSKY2qrXuUZKOiTPKMqZExzAVHCHFm+9
	4cKP8BJUc+LQWbOdAXug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrYh-004Uwq-3W; Wed, 08 Mar 2023 11:02:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrYe-004UvO-H7; Wed, 08 Mar 2023 11:02:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A102661760;
	Wed,  8 Mar 2023 11:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34824C433D2;
	Wed,  8 Mar 2023 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678273327;
	bh=tNV9mMm1s/MjSaospZytlO4O6OsHOlv2qlO7ZKYN3RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lla01DBTq3zBtebe7SpLPs9XCRg496tXLV/4d2rw/2R2bvj2j1sZvniAfD25S+yIw
	 upDXja2CFlZF0emaMv1CXeA3ohuzDP1IZVEZ3orG037daIYW9x7w+DYaqpEomlhmpD
	 OVn5ZzEjaUjuim44aZ6vQ+BbMoAy8/8rDNrthchX5D6UAVt4rjdUMuAK4wrPtO0RMv
	 8HHLUt48Jzff2AScGeIvPA2zUcecAlxULxLY3XetBxYzF13xuo2EMO+q74uKn6cSTb
	 r/R60nBJhCv774mmSBrOLR7ul9YXEJNeVBM43+GTOZnARb/5IGu7ZkMoDGAB5XzAXC
	 qg7wh6hQZFVyQ==
Date: Wed, 8 Mar 2023 12:02:02 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZAhrKkld4oo2EhVz@kernel.org>
References: <20230306084124.300584-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230306084124.300584-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_030208_662806_A486BD98 
X-CRM114-Status: GOOD (  20.52  )
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

On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
> >From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> system, or 4G if other normal systems.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
