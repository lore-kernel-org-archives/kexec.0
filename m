Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F007DC3DA63
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePhIFSgHfGi5w68FSP0O9NHjjybobKV9Qjio2KmldnU=; b=1grzLGYkz6Kyix
	1vFyMYVH/d/Li4SDEAb4dnao8SNWCrZK38wnBNEN1buRFWaOLB188PvrOC4HA4BdowSFyGpcGIvfz
	9gHxDGvfTz5X2v3CfWkzw14g1jLOpD/9G7uULVyi6NLSlDWKdKiJyKMdr5JNVpdJaH3aVZXWx0g2o
	d7cx0JKYe9O0l9bH6tCY2+Y+YmjGvB+ACJQwrVapUX8lBYWIVdLR/c5LLkPAFLaPMiWfLWrOxC72M
	lVqLNLRSbSFYAmEJLW2SQ+QxuyGYVh5h0ZiqBf5FdpjKa86sbVCulORzT21uMVeqNanUweJtP0pHq
	5Z6fgIf61alYzRR5QzTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUUnQ-000000005F2-306v;
	Thu, 18 Jul 2024 17:20:00 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUUnN-000000005EA-0Vp9;
	Thu, 18 Jul 2024 17:19:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7BD2ACE19D4;
	Thu, 18 Jul 2024 17:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31218C4AF0A;
	Thu, 18 Jul 2024 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721323193;
	bh=keIX2+eAoAsKL+d0fzFb7BJ3sbvEkE/QR7C10Odk9Qo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sglcyTWg6b2IrV2cQTwxnMPN+5e3yJX6eIthBvycT/RpGBou/LTM0chIL9VjkL3Yy
	 NWd9VQPjwoodC3WCHs+KkT9HQlBhWtq2tpVblk+OgGobvY09EhD5CpImOFljkNPHRD
	 lKCIUw3Q7gxA9/WshpjJxttGrnBNokewQET6O/l4hdDqlVsWxNOYdkNYU+DVONzPdh
	 qqv6YRs2vFFNwwTa/rI8dbgE/gKg3IzjxCbYfEdrUo7MSla8VpvoU8cr4uH+2rRobL
	 f8ReqWXXGLGd6qgNuBpkXjKdUpYG83sKPoOrunLzJHCEfvgxRwA+0tjJCfs0pFlIYb
	 q1MLvA/z2Y70A==
Message-ID: <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
Subject: Re: [RFC 1/7] efi/libstub: Ask efi_random_alloc() to skip unusable
 memory
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
 Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>,
 Baoquan He <bhe@redhat.com>,  Dave Young <dyoung@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>
Date: Thu, 18 Jul 2024 20:19:49 +0300
In-Reply-To: <20240718085759.13247-2-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
	 <20240718085759.13247-2-piliu@redhat.com>
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_101957_518569_379496CF 
X-CRM114-Status: GOOD (  11.64  )
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

On Thu, 2024-07-18 at 16:57 +0800, Pingfan Liu wrote:
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
> 
> Fix the issue by checking md->type.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> To: linux-arm-kernel@lists.infradead.org
> To: kexec@lists.infradead.org
> To: linux-efi@vger.kernel.org

I'm on holiday up until end of next week so not going to go this trough
right now but I have minor complain ;-)

Please use:

       --[no-]cc-cover
           If this is set, emails found in Cc: headers in the first patch of the series (typically
           the cover letter) are added to the cc list for each email set. Default is the value of
           sendemail.ccCover configuration value; if that is unspecified, default to --no-cc-cover.
       [from "man git-send-email"]

This will make the commits less bloated and makes sure that everyone you
might want to CC will get always the same set of patches.

I'd also recommend to pick only one list for to-field because there can
be only one maintainer that in the end would take these patches. Change
rest to cc's. Now the process of managing these patches is ambiguous by
definition.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
