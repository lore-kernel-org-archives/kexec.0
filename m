Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E698C35FF6
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXJ6+L6L3pDQEM5UY7CMnGVjtGIc37AUYwWjD/301wM=; b=2o8E4rQtGJ8QrQqGwh6nXn8omz
	q+A6CEqeZuwy0+RuGoWlXKbY358sedTlUTYbuwWx5iIv09aET/BpYtEX5icCBnOw+oVTM55kmv0Iv
	z9CpM1bPjo8EOkI/fOgJ2asJ8HNLOwIVbobUpMWhwsAtXWa5OjBKLCWthXBb7WpXGj7BVdFpim91+
	nH1+kign9Mul6PElHoiXA6p2PCdT2L1UbWXzz/eYnZNtRmAnWjPvfUNDtIMUYeTCRJJ80fXbWaU0V
	6uzTSz/Grd7JnYy+Xl3d4hnNfjKUizvcCGV6dDY/JE/+3a12xfsTOSl/la7xuqcVy02322HFosaoo
	6/dHLB0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm9k-0000000Bz3A-0lcF;
	Thu, 13 Mar 2025 17:15:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm1J-0000000BvUa-3jAd
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 17:06:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7EFD85C621E;
	Thu, 13 Mar 2025 17:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B38C4CEDD;
	Thu, 13 Mar 2025 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885617;
	bh=Nz9EEbxa96ubbGlmtt8GqUKsPrxRe7iBnOqLJfXPMJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htfqBc1o8KoQCwCwBsyUS+lFslHdDQBvQ/yEkPjM1sTnEJcMgDfXOvgdt59jsYUcN
	 Gmdept+WN/OWh+7QkJJMtNeolAhvIExamo2gd/8+l57Z01YE1OIUsAH3jOY3YBQabT
	 YcdgxGAeVJZSIA/uDNdrLZCkVBhzFiXZNMwEb5M39mv1qaRft43K6seXa0/MNDxBZo
	 F7LfgVtdZTprlAzjNezH55eTHVSSXadrSGMJ0VC9jx5ExJIfa9264HvannO42xloRg
	 Wqc7vZ0b0ggO/jjd4XuLbA/Afq3L7KocRL3GW5Exe91i2O0Q9knH+YBxTUe33yXlcA
	 NRNRjf3rMF+rw==
Date: Thu, 13 Mar 2025 18:06:49 +0100
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
Subject: Re: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path
 for testing
Message-ID: <Z9MQqYbGBAvTz4Ox@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-8-dwmw2@infradead.org>
 <Z9K3GXSaZUcVr8cb@gmail.com>
 <0CDE8ED7-D8D2-4053-AE4B-4CFF59DB56F7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CDE8ED7-D8D2-4053-AE4B-4CFF59DB56F7@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_100657_968059_BAD0925D 
X-CRM114-Status: GOOD (  14.27  )
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> The exception handler already returns if the exception was int3, but 
> not for anything else. Less so the "print something warm and fuzzy" 
> part; it just does the same register dump. But we could change that.
> 
> I'm less keen on making it unconditional though. Kexec is a 
> performance-critical path when every millisecond is perceived as 
> guest steal time, and the serial output should only happen in 
> production if something goes *wrong*.
> 
> And besides, most kexec users don't have early_printk enabled anyway 
> so if we break them, this idea doesn't help.

So this check would only cause any real overhead if serial debugging is 
enabled - in which case there's already substantial overhead due to the 
serial console overhead (virtual or otherwise).

As to not printing anything unless the early serial console is enabled 
- that's fine, we'd still *break* if something doesn't work in this 
code path, so at least the exception handling machinery is kept 
well-tested. :-)

Thanks,

	Ingo

