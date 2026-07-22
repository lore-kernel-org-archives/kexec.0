Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10517C4453C
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuu1Tu0mavyGTKCTNlz/UMSHBAzx4FGHXBKIVOkO5m8=; b=AA5fXGJRmsLefm52aYrIqKtQB6
	ArLEGAn+HLWKd/K9VFE0nKFBGjszBqir7gAbvvNziOW4Gk5e2itm4BDCkAQoN4FmareBWlNEz61zM
	STDdgkB+PxpMkpL8Bbby16q4oPNQ4Ph1RkY60Rr3GFQYYU+OYbs2qtIHiF9lh1CyMdtIGZ80XNWiI
	fUPvKVVqqYChB38utLo3F3ciy9lceUFmideBU2/QfeM3LXhWi5qwF4tpupesr4j50Ge4DNsjwHW7Q
	e3rjk3LpYK34X4TcC5YL/rYJcGRKPVG1PGZK+Pq9zACH2ZQOEr96UoEv56KavmlUVEwRJSuRttBB+
	HyK5vBzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZIu-0000000CH1A-0lJa;
	Wed, 22 Jul 2026 15:56:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZIs-0000000CH0u-2EBu
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 15:56:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 36AA443941;
	Wed, 22 Jul 2026 15:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D547F1F000E9;
	Wed, 22 Jul 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735774;
	bh=uuu1Tu0mavyGTKCTNlz/UMSHBAzx4FGHXBKIVOkO5m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=luqgxHZgCLrxH35q8K0hoG5fURY3wUyTXsoWg0QnmpHM71Q4GfoEZnLFZ7E43AtXW
	 R2csB6RpmM2d4Ky3zgHFJdkvuXaPl8zBu2PYmh5dA5DWe3lVLe8X13dG7V2JPIgUjI
	 dCvvi8VdDxSA+cR943rwpFJT6PLWwnU7WTs6TEl9/r0J7RI2hA6T4cZywp+Oz77ijd
	 6oX7iQyTXPEffMEIHWUpX/eNRbCJyRi757LlQJ0IgviZhqW6deQYHK61SS0xhOwwpp
	 yDaypsknrwAz6NFmfQgRJgy6QQ9c7/q5RdiZH4Ea/ir9U307CP3EvbEkHDX6xHJm6h
	 hZFLlsjKjNFYA==
Date: Wed, 22 Jul 2026 18:56:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE/CFP] LPC 2026 Live Update Microconference
Message-ID: <amDoFzbQVdxjgqzH@kernel.org>
References: <ahcc3Qyuy7Oy03Iq@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcc3Qyuy7Oy03Iq@plex>
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

Hi,

This is a reminder that the CFP for Live Update microconference at Linux
Plumbers Conference is still open and even extended until August 7th.

On Wed, May 27, 2026 at 05:05:23PM +0000, Pasha Tatashin wrote:
> Hi,
> 
> The Call for Proposals is now open for the Live Update Microconference 
> [1], taking place at the Linux Plumbers Conference this October 5-7 in 
> Prague [2].
> 
> As infrastructure scales, minimizing workload disruption during host 
> updates has become a critical operational requirement. This 
> microconference focuses on the evolving engineering challenges behind 
> seamless software handovers, state preservation, and warm reboots that 
> bypass traditional hardware reset cycles.
> 
> We are seeking technical presentations, and problem statements spanning 
> the entire stack—including kexec optimizations, hypervisor integration, 
> user-space checkpoint/restore, firmware coordination, and device state 
> handovers.
> 
> ---
> A few focus areas we hope to cover during this year's sessions include:
> ---
>  * Orphaned Virtual Machine for zer-downtime upgrades.
>  * Live Update Orchestrator (LUO) enhancements and architecture
>  * Kexec HandOver (KHO) framework advancements
>  * Kexec reboot latencies to minimize guest/workload downtime
>  * Preserving guest states across live updates (guest_memfd, hugetlb)
>  * In-flight DMA, IOMMU tracking, and preservation
>  * VFIO device state preservation and live update migration mechanics
>  * PCI/PCIe device handovers, reset avoidance, and state restoration
>  * Live Update in Confidential Computing (TDX/SEV-SNP)
>  * Building robust testing, fuzzing, and validation frameworks for 
>    upgrade paths
> 
> ---
> Submission Details & Deadlines:
> ---
>  * CFP Portal: https://lpc.events/event/20/abstracts/
>  * Track Selection: "Live Update MC"
>  * Deadline: July 24th, 2026
> 
> Session Format Reminder:
> LPC sessions are highly interactive working groups, not static lecture 
> slots. Proposals should be designed to introduce a concrete technical 
> challenge quickly and leave substantial time open for real-time debate, 
> consensus-building, and problem-solving with the room. Keep slides 
> focused on architecture and open issues rather than heavy text blocks.
> 
> We hope to see you in Prague to help push the live update ecosystem 
> forward.
> 
> (Note: LPC attendance caps fill up exceptionally fast. We strongly 
> advise booking your passes early, as track organizers cannot always 
> guarantee speaker registration overrides once the event sells out.)
> 
> [1] https://lpc.events/event/20/contributions/2321/
> [2] https://lpc.events/
> 
> Best regards,
> Pasha

-- 
Sincerely yours,
Mike.

