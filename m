Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2E0C5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=my9GYhoB5pagzF6M6ZagB0B0WZqIwM9tl/SdPaf+pZk=; b=X5b8HhjpjsP6ZQsGPOozvYR8Lf
	sPqnt4LPMDpuh9knnne05Op4FGdlMFCl365lHTGa8zbx84lctbtSuFVr9QqrgEQC0b9D6J3BOXyr4
	ABuFbjnrvBBHRkpaCPMtALykR0jmVSZckjeKhvhY5zZ8veJLBXrIFBnjPyu+ij13ViLhKFqUSkGlm
	NqrjXaGF+YYkayMGZo7PcO2MCVw+mDbA27yMADjcpLWEqpYMWst6OTNZjtjj99qcLr220cmHup7ds
	OMBQ4MjY02jsORofSrbWjriKa9pZewORshIK3e848zXQ5OgvuzmtTDTE0uYKWwdJZ2o6xcYiahy/Z
	m3ytB88w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVKi-0000000GkMT-3ZfF;
	Mon, 24 Aug 2026 14:07:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVKh-0000000GkM8-3xrB;
	Mon, 24 Aug 2026 14:07:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA871600CB;
	Mon, 24 Aug 2026 14:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EE71F000E9;
	Mon, 24 Aug 2026 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580446;
	bh=my9GYhoB5pagzF6M6ZagB0B0WZqIwM9tl/SdPaf+pZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TOv+PwCGfXFC332KGFB9T7dQXJCrhXdMJFRpEQ9/TE3Vx6NIAY2MKQP0Iznx7qRcz
	 L2MrLS5j4meQvz+/oOSbDMYImL0w/a+KlTtqGfu3JwN/vioyhG8u2vZ1p45PJIb/Ga
	 2njsOlOPXwa4SCTgrRl3GWIu3eDt+mXQ/BLl+ocbChhTFt363vDUHPRQpA9rHDkdG/
	 8j3imGMbxGZ2S/VjpPB98mGjco2CXiZHRzysGH5l3+mQoZqDUN5dAfXyj51k8QHx8J
	 IqGM0pZEDWjWBuH2ICNqxRnUPl1xf8qU0LuX04/D7Zj0qES6hFUgP2PlHWXXY84ZeU
	 o+MyUMGi/9STA==
Date: Mon, 24 Aug 2026 15:07:19 +0100
From: Will Deacon <will@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, Bradley Morgan <include@grrlz.net>
Subject: Re: [PATCH v3 1/2] kexec: return -ENOEXEC from image probe functions
 on mismatch
Message-ID: <aoxQFxuzZ1AHmM8d@willie-the-truck>
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
 <20260821-mpilaniy-v3-1-76b355399d2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-mpilaniy-v3-1-76b355399d2e@redhat.com>
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

On Fri, Aug 21, 2026 at 07:19:57PM +0530, Mukesh Pilaniya wrote:
> Several kexec_file_load() image probe functions return -EINVAL when
> they do not recognize the image format.  A probe function that rejects
> an image should return -ENOEXEC to indicate that the image is not a
> recognized executable format.  -EINVAL implies a problem with the
> syscall parameters, not with image recognition.
> 
> kexec_image_probe_default() iterates through registered loaders and
> returns the last probe's error code to the caller.  That error
> propagates as the kexec_file_load() return value to userspace.
> Returning -EINVAL from a probe when no loader matches is semantically
> incorrect and misleads userspace about the nature of the failure.
> 
> Return -ENOEXEC from all probe functions and their helpers when the
> image format is not recognized.
> 
> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> Reviewed-by: Philipp Rudo <prudo@redhat.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>  arch/arm64/kernel/kexec_image.c   | 4 ++--
>  arch/loongarch/kernel/kexec_efi.c | 4 ++--
>  arch/riscv/kernel/kexec_image.c   | 4 ++--
>  kernel/kexec_elf.c                | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Hmm, so after this patch, are there actually any implementations of .probe()
that return anything other than 0 or -ENOEXEC? I couldn't spot any after
a quick look.

Will

