Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D95C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=log9Y1/FtX7D4hpSxqOjc6RYDMSqMNLwZMRoYqyuEwE=; b=ScI7PYLORLTgxUe9AkdMa2gzCW
	JZeYKqf/E9heLZ9hdoM/jLaR6h58U7X9c82dRpJQnP7O+YZsSdze14udzZuCiZ4pUEr1jxKplqrCF
	XoAwNtMXuRMJ7aucEp/TlTz0/hLgIZI+Xk+HasXgV0b1Z9xIEtzArqW34drdtNoVN0OuR4DG6Su/y
	qPUj7qFKROWRmW9wX/FZAAYJ6W7+bVDZ5N8G6hqlTAfTTbVlUttmLOZx9tdIvz0n+b2+S5+41IRH2
	AcwxJJRvwkHD/N6Dxzb8GLMXxRB/qXp1/0FVla/7EuBOHBbuIFmiLOFj7aDWOiivDjC5bsKBFk7m8
	hqQ1MNIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKIn-0000000CliG-2xWY;
	Fri, 21 Aug 2026 08:08:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKIl-0000000Clhu-3iKD;
	Fri, 21 Aug 2026 08:08:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 40907431E3;
	Fri, 21 Aug 2026 08:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35361F000E9;
	Fri, 21 Aug 2026 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787299715;
	bh=log9Y1/FtX7D4hpSxqOjc6RYDMSqMNLwZMRoYqyuEwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+gRjS8ypMPY4upPxQqn7EhNHpp/wLA9eFbeqPkRIFc4PcWLkxdTApSE9rNoRh1VN
	 ckqOFqmlIuGgzk805hQVKJkEni3qBXfkPEWpFZ4+vPb8opDeut3L9gkOU4q8vuPgX9
	 TZ9qhSgPJpT+M4Dk1C1MoKrA2W7hu9G9lqmc5AtrQkRBv/tMfHVYKR0NOgjFEJMwmB
	 S/eHEnKAXmXjmVz6rlGoOxIOm4lA3KMBwVYxAEF7X7nrEaar0OUfWVydllmT6OPFTK
	 sEN4uXUNQneR8CH056dQbqXL7xbvJD04vs1NEoKWHzKWJz+nh9v7aLW4kQQ1a4VEIA
	 pbgq8bjA0UF+A==
Date: Fri, 21 Aug 2026 11:08:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Philipp Rudo <prudo@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Tao Liu <ltao@redhat.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
Message-ID: <aogHeKQ8UnudNAMu@kernel.org>
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
 <20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
 <20260820142114.0a36ac78@rotkaeppchen>
 <2vxzik54zmpp.fsf@kernel.org>
 <713ab0a0-235d-47cf-a0c2-73249fbc8f74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713ab0a0-235d-47cf-a0c2-73249fbc8f74@redhat.com>
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

On Fri, Aug 21, 2026 at 12:48:15PM +0530, Mukesh Pilaniya wrote:
> Hi Philipp,
> 
> On 20/08/26 11:41 pm, Pratyush Yadav wrote:
> > On Thu, Aug 20 2026, Philipp Rudo wrote:
> > 
> >> Hi Mukesh,
> >> Hi Pratyush,
> >>
> >> having this patch makes sense. Personally I'd go with having a
> >> switch-case rather than individual if-blocks. E.g.
> >>
> >> 	switch (ret) {
> >> 		case 0:
> >> 			image->fops = *fops;
> >> 			return 0;
> >> 		case -ENOEXEC:
> >> 			continue;
> >> 		default:
> >> 			return ret;
> >> 	}
> >>
> >> IMHO that is better readable and easier to extend in case other error
> >> codes need special handling as well. But that is only my personal
> >> opinion.
> > 
> > Well, IMO both look roughly the same so I unless Mukesh prefers your
> > version more, we can keep it as-is.
> > 
> Thanks for the review. I agree the switch-case reads nicely, but since
> the current version is functionally equivalent and already
> reviewed, I'll keep it as-is to avoid re-spinning for a style change.
> Happy to switch if you or Pratyush feel strongly about it.

I'd like to request another style change :)

In newer code we often use 'err' rather than 'ret', so it's more obvious
what this variable about.

I don't feel strong about if or switch, but if you go with if, please don't
compare to 0, use !err.

-- 
Sincerely yours,
Mike.

