Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81320C282DE
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7zASUItQnpEtXCiku4VqH1IsXtYlinmRro9uTjTIYc=; b=RsMHqa5KPt2vsiWhVQHxil/go7
	IT4Q/rtlGOSFKu32GTJGfFuweIbVLDgtT1AVnyzJtwCYmOR244Uh2q6RXK0x3nRTeqKICBWN99U2T
	hi2ySl8ASNUiKRQVuJ/oqPbizuWMbOw4DQuGjB48Yr8TqnZfUmlwVMFDJAKF4Hhow+Y20CMoL17M/
	D8aGD8Kha13V16Z9Qrm4LUtyMwdIKcfhBkOn2fSZnWVznEmV7NG0mqTKMvNwQREC0s3vKzvBrU47B
	DnVJ7U6ZpwCE8UDCKMw92HQEeklzrziYj3Hbn1QZmJZ42w9hakoxT4sPYarQCo8L8+KdCaMcFPPxd
	o30qoO8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsfwI-0000000AtYk-2Bsd;
	Thu, 13 Mar 2025 10:37:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsfui-0000000AtN8-1MtR
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 10:35:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 85346A46BAB;
	Thu, 13 Mar 2025 10:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E345BC4CEEE;
	Thu, 13 Mar 2025 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862143;
	bh=HwddNMKoRxMnPfOo1Zy1wl6DJgyF9AKmbUbp/4mYZVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPJDy0LysT8DO/IFgRSu1ybIe0REzyyiM7ojFXE5bnQbKp/p/UVi+89gj4xHJ/5xb
	 kNhyCFdLobiFV9uQCVwHo9KnJyt3XVHbChLvmqpQFRFt/ZkMwXWCZ7WUwkPNSp5tZm
	 oyCo4XZ0lea4vWlZctbPFoOdsfZ12Zqxj0a1+fAgOYXpRJPbkjd/MWotqgu/qyiACn
	 Qs2kiUEkSekfypds2s1uzlFZ81ruIW9OzJ2HCYe1hKacasjBiXAGMl92LCfg1yTHqa
	 9cA7nttj7NKX20MGggXOpDvVt1SPiaCfhIXCNgwz5X3RnhSOzzCOG+EiQ+RqfJ16Zv
	 I5azTI4BnjYnQ==
Date: Thu, 13 Mar 2025 11:35:36 +0100
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
Subject: Re: [PATCH v7 4/8] x86/kexec: Add 8250 serial port output
Message-ID: <Z9K0-CFdaBkptAJR@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-5-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-5-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_033544_456836_713392E4 
X-CRM114-Status: GOOD (  11.13  )
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

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> If a serial port was configured for early_printk, use it for debug output
> from the relocate_kernel exception handler too.

Does the early console output something once it's initialized? If not 
then I'd go one step further here: if early_printk serial debugging was 
configured, let's output some sort of message as early as it's expected 
to work. That way if any of this debug codepath regresses for 
relocate_kernel, the discovery of that regression won't be delayed 
until something nasty triggers within relocate_kernel that would 
necessitate a working debug mechanism ...

Also, printing something to the early console using these new 
relocate_kernel printing functions would be an additional bonus as 
well, for similar reasons.

Thanks,

	Ingo

