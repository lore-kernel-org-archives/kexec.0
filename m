Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B39AECD6F7
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVkPJxeFqre8GXwMKfPL88jdlevbQ2wGI8hai57pULU=; b=VgCZHs8WYqFWy8u+C+tHO5ZK4E
	GGHKqob4IdELBBa+a1Euq+vmu81wLBbM62CL1qLrBtuxw6DvZrFCFN+w1qQfMhmOSPVyMG00oSYQ+
	7fTVpxleJeQaLsD51W8OS9byMqQqwvnp+ETDCvEw7UVZPhLUeIyJzLj0O197cd0HiTWwIGwZEW+eB
	809toXA1sBvOkeHteiadN3L+IjqgIwW7+hy4a26Vc3X8f9S1iKZwHPSe7BjRyVLOExBBnXOLe9eSX
	bcWfGGus6Wi9hsxdIuEBeniTF/EdIuiwnVx86JplaUwxb0Gw9AlUVHKo+jKW4lQXzyGfaXaE0KdTG
	BX5ZM9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqJfl-00000001BRN-33W1;
	Wed, 11 Feb 2026 23:31:05 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqJfg-00000001BQW-3kH5
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 23:31:02 +0000
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AF3320B7165;
	Wed, 11 Feb 2026 15:30:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AF3320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770852653;
	bh=vVkPJxeFqre8GXwMKfPL88jdlevbQ2wGI8hai57pULU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkoJY9VfrcOLuh7kU2526UYX5qYs3LgDqlnRjZ84vbbshTIGKI+tgzSdzYpzx70hU
	 9CojwoyBQ6CaCs+rAIiRjttwRiJV7NCvxtqu8t2h3APukDX54kAfxUjyLD63vQeSXk
	 /x/HtZuhWq8zqNS8GuosfWl+UoU7IWni0Qia7Trg=
Date: Wed, 11 Feb 2026 15:30:51 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kexec: Refuse kernel-unsafe Microsoft Hypervisor
 transitions
Message-ID: <aY0RK8cADz3MkUdY@skinsburskii.localdomain>
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_153101_172714_B5FBC5D7 
X-CRM114-Status: GOOD (  21.35  )
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

On Wed, Jan 28, 2026 at 05:41:56PM +0000, Stanislav Kinsburskii wrote:
> When Microsoft Hypervisor is active, the kernel may have memory “deposited”
> to the hypervisor. Those pages are no longer safe for the kernel to touch,
> and attempting to access them can trigger a GPF. The problem becomes acute
> with kexec: the “deposited pages” state does not survive the transition,
> and the next kernel has no reliable way to know which pages are still
> owned/managed by the hypervisor.
> 
> Until there is a proper handoff mechanism to preserve that state across
> kexec, the only safe behavior is to refuse kexec whenever there is shared
> hypervisor state that cannot survive the transition—most notably deposited
> pages, and also cases where VMs are still running.
> 
> This series adds the missing kexec integration point needed by MSHV: a
> callback at the kexec “freeze” stage so the driver can make the transition
> safe (or block it). With this hook, MSHV can refuse kexec while VMs are
> running, attempt to withdraw deposited pages when possible (e.g. L1VH
> host), and fail the transition if any pages remain deposited.
> 
> ---
> 
> Stanislav Kinsburskii (2):
>       kexec: Add permission notifier chain for kexec operations
>       mshv: Add kexec blocking support
> 

Hi,

I’m sending a gentle follow‑up on the patch series below, which I posted
about two weeks ago. I wanted to check whether anyone has had a chance
to look at it, or if there are concerns I should address.

Any feedback would be appreciated.

Thanks for your time.

Best regards,
Stanislav

> 
>  drivers/hv/Makefile            |    1 +
>  drivers/hv/hv_proc.c           |    4 ++
>  drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h         |   14 ++++++++
>  drivers/hv/mshv_root_hv_call.c |    2 +
>  drivers/hv/mshv_root_main.c    |    7 ++++
>  include/linux/kexec.h          |    6 ++++
>  kernel/kexec_core.c            |   24 +++++++++++++++
>  8 files changed, 124 insertions(+)
>  create mode 100644 drivers/hv/mshv_kexec.c
> 

