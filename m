Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864CCD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztkkIPmg9U+YA/yLFAokmrecB+uGWFUWKvG1CC+VtcQ=; b=OrGvg2CHCEKqPTGag7ye1fspsL
	LLZ9YcWpMb9ZKQPkFhS80G3BTFTAAl6nr7IiJfZMoPqVxdle4FFE9yOZdSmb4/iGt9Xlt2y3jwnZ0
	ZXialNwn98Nn+zhhSwXThI5Lm5Zu68EaCwmRQ7IHUQwrAFAoViDBLKl+0hE0xSLAVsv1YV4s9M6q+
	ywq5yebZYpygYmoW3lYPRboIZ/TIOPaafb0c3c0bPDIMkIj0NQF0K4idSRyUI9+yAh68EYL6ynOTV
	W4jcCpHumFgd59LxT+LCNr9kpZ1IxWtMjS9Wrd2uZ6umYwBxIjhrkHCpiQbd6wz9WEwZD7LGIxs5f
	atZWzWPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvVJ-00000000EIV-0i7X;
	Wed, 17 Jun 2026 19:00:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvVH-00000000EIE-38aN
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 19:00:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF3A16001D;
	Wed, 17 Jun 2026 19:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A901F000E9;
	Wed, 17 Jun 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722846;
	bh=ztkkIPmg9U+YA/yLFAokmrecB+uGWFUWKvG1CC+VtcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NlGZSzs/gjXRpoS8cRAEp1qvHOvKXm57Xwd+WjSh1mksdHHhasQJmBYSpkHquvZxI
	 iBczxb6BlR85sfINTRuz3WqEo4Xrfx+zTFBO+lsV2+aHxvDsb9X1NDWVZ/O6Ha2QX4
	 YF7JdeVoO4fOK9uGEO+rtzsGc3kIg78Tqk2xZmTvFJu9xySYA6BHC8D42OdHeYQbYC
	 wBoZM4NECr8iTylm62lwf/QUY793pls70cfJPaVLdci14RLQy4alTmOhWkxSCkU2Ck
	 AvLFWWnwkkwz3uJTET1QKF0Mo/wlkZAyOMeMqub+oNkn98sPzhYO75M3dv8ZJkNfMo
	 q1nIqyLI2sYDw==
Date: Wed, 17 Jun 2026 22:00:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, tarunsahu@google.com,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/1] liveupdate: Add internal APIs for file preservation
Message-ID: <ajLu1-CnJfgD5Ch2@kernel.org>
References: <20260613012521.835490-1-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613012521.835490-1-skhawaja@google.com>
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

Hi Sami,

On Sat, Jun 13, 2026 at 01:25:19AM +0000, Samiullah Khawaja wrote:
> Live update orchestrator file handlers depend on the preservation of
> other files. To make sure that the dependency is preserved, the file
> handlers needs to fetch the preservation token of the preserved
> dependency. Similarly during restore, a file handler wants to fetch the
> restored file of the dependency.

This will have to wait until -rc1 is out.
I'm thinking about taking it to a branch in the liveupdate tree and keeping
there until a patchset that uses it, be it iommu or kvm matures.
 
> There are two known usecases of this,
> 
> - VFIO-Cdev preservation requires the preservation of iommufd. This is
>   required by the IOMMU preservation series:
>   https://lore.kernel.org/all/20260427175633.1978233-1-skhawaja@google.com/
> - guest_memfd preservation requires the preservation of kvmfd. This is
>   required by the guest_memfd preservation series:
>   https://lore.kernel.org/all/20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com/

-- 
Sincerely yours,
Mike.

