Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB62FCAC5AE
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1v/KwM/huxtHbwJvg0b1BdepVHxNprsmpQM5BGSeRcE=; b=poVaj7XomM3Bo9jB4Zo6iqmefD
	UN/KoOL99qBoM0cy4LDSW7YhcEmB5Xdo2MVFPY9vKu63e8z66mWVUHKJnb5z4Med/Nebu+k/MAYbM
	KPGYk4yDsZy7DUNLBpU3MEVzIOqB3D2gjVbvXPCnta3yAtmu7m8FpGwCuJ81rdzfF6k77zhVy0sWm
	7W6W8bix7sawhcF+1u6jhMv7yPsMPDjXBOgiXfc2Y8XUBMX81+EPpQm2WgsNFxFfTF1BpjyjzkHWR
	jUZ7Af0Ha0OKMNtAUHqIpHg6FhgiLaPz5Xyr3+j1uB2woWF5inlwcgDlTlIGmQTubUylYQRP64NtN
	VCiW011Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1TeO-00000002IiY-0NlP;
	Wed, 24 Sep 2025 17:51:32 +0000
Received: from gentwo.org ([62.72.0.81])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1TeM-00000002Igg-09AY
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 17:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758736288;
	bh=1v/KwM/huxtHbwJvg0b1BdepVHxNprsmpQM5BGSeRcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DqbVTkcaY2mxqjDwK32gR+OKB5UHJGJ6fYvY5/hFtLnO0BYvabDseryR6j9qIhGV/
	 +1Epf9QOiWySiyNWVUOqqJRMqddF0uNRtewcmXp4wzVAZTbX3dAn7xFUai3uyXUXVl
	 XszpToJbf2Y9Bl4p1xU8GtFtlG9b1+YsGNq5UgVU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 8B0C540293; Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 88C414028E;
	Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
    Cong Wang <cwang@multikernel.io>, 
    Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
    Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, 
    linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Message-ID: <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_105130_113895_889D39F9 
X-CRM114-Status: GOOD (  11.93  )
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

You dont really need any kernel support to run multiple kernels on an SMP
system. Multiple kernels can operate without a hypervisor or anything
complicated like that.

The firmware can prep the kernel boot so that the kernels operate
on distinct address spaces, processors and I/O resources. Whereupon you
have the challenge to communicate betweeen the kernels which led to
various forms of "ethernet" drives communicating via shard memory.

This has been done for decades. I have stuff run stuff like this on
SGI hardware and Sparc/Neon back in 2003. ARM should also do this without
too much fuss.

There is even a device driver to share memory between those kernels called
XPMEM (which was developed on SGI machines decades ago for exactly this
purpose). Its ancient.

There is nothing new under the sun as already expressed over 2000 years
ago in Ecclesiastes 1:9. ;-)

The improvement here is that the burden of implementation away from
firmware and we can then have a memory based "ethernet" shared memory
implementation indepedent of the architecture.

The reason this was done by SGI is to avoid scaling issues. Machines with
high numbers of cores can slow down because of serialization overhead in
the kernel.

The segmentation of the cores into various kernel images reduces the
scaling problem (but then lead to a communication bottleneck).


The rationale for Sparc/Neon were hardware limitations that resulted
in broken cache coherency between cores from multiple sockets. A kernel
expected coherent memory and thus one kernel for each coherency domain was
a solution. ;-)

AFAICT various contemporary Android deployments do the multiple kernel
approach in one way or another already for security purposes and for
specialized controllers. However, the multi kernel approaches are often
depending on specialized and dedicated hardware. It may be difficult to
support with a generic approach developed here.

