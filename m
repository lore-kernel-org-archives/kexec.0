Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535CFC282DE
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thchq9IdL4oD6YxrvgblhR5JIjm/MnSBvT50T36oz2E=; b=NEYticrelXdeEjNihKGO6csrGK
	v1NCEUa25NpeJC18KfS8jsovkWL9YKNPZ1n4o9oJq22d9QxlJXkQME7jH4BfvfWlVOIF5qa20kgvD
	VEnimdWDBOwH5YXA1rD2GiV+Hj0RtNdZp1E4A3r3MA6Y8lg+tB9rL8WvjLdjoY+2GOxNgi1OHUEW7
	c4OwS9Qt1rRB0ZzTQOEPrczj2CLDHmmzfQZoeckFaIWzETFTh/SFWN5GqdTYSaopPHRv+JSbi0xWb
	orkE71BOgfksAjZRgaLTKkuqMswv2DoRM3lEXdAcuBvj3RXbP5Y8wYcc1UnKN/ogqfJDAaLeaR981
	jl6CVCDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsgG5-0000000Axje-4AuD;
	Thu, 13 Mar 2025 10:57:49 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsgCa-0000000AwyN-1Pmz
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 10:54:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AE432A46AB5;
	Thu, 13 Mar 2025 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F3C4CEDD;
	Thu, 13 Mar 2025 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863251;
	bh=PhG3T14xmNLJ2igVUO8SEMpUDPPBIMEnhLKBsTJGWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nc6M6+cGMmfjfPl6mygKyLqcLK7ngvetUYGX4u8WNzZdEBMPSoyJ/UDkORp4TSrJS
	 oDTxoCHVhy1GmkJDOWw1iGFdlFW0Y3JpkxXQdkoO5DUXoBdZ2qiZh33RTwFRAKEfuM
	 aLBqBfdVhNJYmup2tUhyo2oLEFduJNwmANjZ/2TIKHS2b61pJqY/i2MPlI984yjnSE
	 ZkfmWMk/nIqJQZzb88L+jQJmRom8MJgeVJL9KiM9WoFdJ2I8RwYQx34MO56o0f4z8O
	 5CWMZCUPzXQgReTO6BahpIuQmIvWMhLp8fZzqGeNQ/+czi2r2HSKgOk4ADz6L5LnAX
	 iKOMi8fbSYDUQ==
Date: Thu, 13 Mar 2025 11:54:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9K5TGMvmS1ApBCW@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <Z9K3dcMAgu3cot85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9K3dcMAgu3cot85@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_035412_445627_572A493A 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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


* Ingo Molnar <mingo@kernel.org> wrote:

> I applied the first 3 patches to tip:x86/boot for 
> phased-risk-reduction reasons, and because I had some questions and 
> suggestions starting at patch #4.

So there's a new objtool build warning from the new exc_handler code:

 vmlinux.o: warning: objtool: exc_handler+0xe: early indirect call

That's with a x86-64 defconfig + KVM enablement.

Thanks,

	Ingo

