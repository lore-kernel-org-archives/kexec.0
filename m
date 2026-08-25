Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E052AC61DBE
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLscfcmLNRd3f1PhGpx41k5USRhZyaKtVT+AsVQwKXE=; b=eNrLl5W/5OYxCoGcOd051mmN/G
	cXy5NBc1MBFtfF6mLGjrXw0f0rExGPM5g9TaZbGr0ZREx9xod6nrdP9/NX9U9PHEYMgfzS9I9FZib
	hRIUKyHYEHNBATwBPjEoj6lkTBaQYiGMWKCQ+Rp3eYEEsLwuXQbrtswZBzD7fawLwwWNqZurXbdo2
	Q617X5IQEbigcpJbk8dIK5sMmcSh/o/l9/GrhN1BW9vYd1lzUvjko4HDA3nt/g3B5L0CIVLSee3ek
	QIpi0ZKyaWcaPEO3W2th2avG25c2AUZta1nmeHO54TSA57CvEAbBig+A78IPssmsoX8rKaeeX6mA1
	XNF55Smg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wysrl-000000011MG-1hFC;
	Tue, 25 Aug 2026 15:15:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wysrj-000000011M1-2zlY;
	Tue, 25 Aug 2026 15:15:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 162E3419B0;
	Tue, 25 Aug 2026 15:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DED1F000E9;
	Tue, 25 Aug 2026 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670907;
	bh=rLscfcmLNRd3f1PhGpx41k5USRhZyaKtVT+AsVQwKXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKt9XnhQJ0Jv+LiWz7EZIWcKUj5pr1jQioPbRmKBddxcRnglcwR5/jrHA5iIVfgMI
	 HzjOfACz98g59qd/tOWKog6WxXKhD/KXaPFhYLMhIv+XPz2PXkzM++hVZ+X7BI4EKZ
	 aNUY9GhhNCFYR0CsWpf3YU61x+NPvUH26AY/MR4ivFRWyMqmS8iskw33wGv8pU2sUD
	 KIcUtDB0UOjyqz8AR6cGUd8saiE6nhOt7YvUnUmcmwS5q4dUqZM8zRo0VF5J2ETElL
	 aIqyGX/67NJ2/2baRrQhN5xL4WqYIhVN+uYx9vefhAK4e7Uw1k3Eb/yWzfAlOx86Z3
	 8vHf8+1Nvz11A==
Date: Tue, 25 Aug 2026 16:14:59 +0100
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
Message-ID: <ao2xc027TNYTwBA1@willie-the-truck>
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
 <20260821-mpilaniy-v3-1-76b355399d2e@redhat.com>
 <aoxQFxuzZ1AHmM8d@willie-the-truck>
 <06a45c67-2642-4efa-994a-ee50cd40a697@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a45c67-2642-4efa-994a-ee50cd40a697@redhat.com>
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

On Tue, Aug 25, 2026 at 10:43:48AM +0530, Mukesh Pilaniya wrote:
> On 24/08/26 7:37 pm, Will Deacon wrote:
> > On Fri, Aug 21, 2026 at 07:19:57PM +0530, Mukesh Pilaniya wrote:
> >> Several kexec_file_load() image probe functions return -EINVAL when
> >> they do not recognize the image format.  A probe function that rejects
> >> an image should return -ENOEXEC to indicate that the image is not a
> >> recognized executable format.  -EINVAL implies a problem with the
> >> syscall parameters, not with image recognition.
> >>
> >> kexec_image_probe_default() iterates through registered loaders and
> >> returns the last probe's error code to the caller.  That error
> >> propagates as the kexec_file_load() return value to userspace.
> >> Returning -EINVAL from a probe when no loader matches is semantically
> >> incorrect and misleads userspace about the nature of the failure.
> >>
> >> Return -ENOEXEC from all probe functions and their helpers when the
> >> image format is not recognized.
> >>
> >> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> >> Reviewed-by: Philipp Rudo <prudo@redhat.com>
> >> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> >> Reviewed-by: Bradley Morgan <include@grrlz.net>
> >> ---
> >>  arch/arm64/kernel/kexec_image.c   | 4 ++--
> >>  arch/loongarch/kernel/kexec_efi.c | 4 ++--
> >>  arch/riscv/kernel/kexec_image.c   | 4 ++--
> >>  kernel/kexec_elf.c                | 4 ++--
> >>  4 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > Hmm, so after this patch, are there actually any implementations of .probe()
> > that return anything other than 0 or -ENOEXEC? I couldn't spot any after
> > a quick look.
> > 
> > Willkexec_elf_probe() can return -ENOMEM if memory allocation (kzalloc())
> fails inside elf_read_phdrs(). This behavior was previously discussed in
> the first patch of this series [1].

Fair enough, but I'd have thought it would be easier to special-case the
one -ENOMEM path instead of changing all the backends to return
-ENOEXEC all over the place (and hoping people don't start returning
-EINVAL again in future).

Will

