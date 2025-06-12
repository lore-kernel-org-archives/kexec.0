Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27008C71136
	for <kexec@archiver.kernel.org>; Thu, 12 Jun 2025 23:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xk3dVLP87+nqYviJZ2ctEM/qLzksImDb/80f5aGQTOk=; b=Uvwg/SfnzpiuB2Pc29DJ7RGiDG
	/eDooDoTfFpxP1mT/QafUyPyxAs7lehiK8yDoTEd6GAEfSijCKHtUhhK+ybJBNGGOXIwGBOdnlylQ
	vYqMQubP6Eurs5PmesEYCIcHEJcOBXT1172cstVa3/AGVq5rVBZKVBa9JIJlP4ObQ9OuzFCT8aKKP
	BSAdfQFAEeIFQ6k1U3i7Czw2HcDVFAeFphmIxEwX8yEAh2AGi0FG6x1tUgdBpEwEIokAkw18WZS9b
	azWTTI0flN6TJxszaVeIZxEjiBaM2r2QRigPpBKZXrxv0VpZOO2516dzcfYYMI7HXK/EseVoivW55
	+wg56leQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPreL-0000000Eu24-35dt;
	Thu, 12 Jun 2025 23:48:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPrdx-0000000Eu1o-2QLd
	for kexec@lists.infradead.org;
	Thu, 12 Jun 2025 23:47:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 50D4B629D7;
	Thu, 12 Jun 2025 23:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D951C4CEEA;
	Thu, 12 Jun 2025 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749772056;
	bh=YUChF49bAYlJOpP0WqVyLSRATHcO/9CPEgcMbqtKARw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XR4I488AZIuD5wUchz+ZxH9y0yZjE8wvKVuscwaBAauVpw9jrrXNa73Dyj71GKWvV
	 r9ouV0lLueOOIN9f4uYhzrbLLIwkhRBFWpUPSFE0vP2uldYj4e0JWrbEr7HPOoVW2C
	 4n9FTeAs6nvAA0MghkEuEce3eKDI/r1nKw6kYmxs=
Date: Thu, 12 Jun 2025 16:47:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org, Philipp Rudo
 <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, Pingfan Liu
 <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>,
 Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 4/5] kdump: wait for DMA to finish when using CMA
Message-Id: <20250612164735.76a1ea9a156cd254331ffdc4@linux-foundation.org>
In-Reply-To: <aEqpgDIBndZ5LXSo@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
	<aEqpgDIBndZ5LXSo@dwarf.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 12 Jun 2025 12:18:40 +0200 Jiri Bohac <jbohac@suse.cz> wrote:

> When re-using the CMA area for kdump there is a risk of pending DMA
> into pinned user pages in the CMA area.
> 
> Pages residing in CMA areas can usually not get long-term pinned and
> are instead migrated away from the CMA area, so long-term pinning is
> typically not a concern. (BUGs in the kernel might still lead to
> long-term pinning of such pages if everything goes wrong.)
> 
> Pages pinned without FOLL_LONGTERM remain in the CMA and may possibly
> be the source or destination of a pending DMA transfer.
> 
> Although there is no clear specification how long a page may be pinned
> without FOLL_LONGTERM, pinning without the flag shows an intent of the
> caller to only use the memory for short-lived DMA transfers, not a transfer
> initiated by a device asynchronously at a random time in the future.
> 
> Add a delay of CMA_DMA_TIMEOUT_SEC seconds before starting the kdump
> kernel, giving such short-lived DMA transfers time to finish before
> the CMA memory is re-used by the kdump kernel.
> 
> Set CMA_DMA_TIMEOUT_SEC to 10 seconds - chosen arbitrarily as both
> a huge margin for a DMA transfer, yet not increasing the kdump time
> too significantly.

Oh.  10s sounds a lot.  How long does this process typically take?

It's sad to add a 10s delay for something which some systems will never
do.  I wonder if there's some simple hack we can add.  Like having a
global flag which gets set the first time someone pins a CMA page for
DMA and, if that flag is later found to be unset, skip the delay?  Or
something else along these lines?


