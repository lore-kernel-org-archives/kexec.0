Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4557C83F2E
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFAJN4yHgQ86Lo6lS08+fvn7T4tcRU0cyxQZeUqMIeY=; b=H4x5Zyl+kKYDo/
	OZzKjqigdhtFkwtxQ/WyeKEhwwz/T3cGNqip+95+subKMNeSKvggYul8HX1rzh/bKKpSR92mihOzD
	JAhkuWdUzV3EwXHuHzDajHRgToa8IloFlsI6qJ/eISMJ1QyaHCPsmCuVqvzC7KnSByon7UZcaPm1N
	+P+KNLtyiOHF/F0MkJryp6EqqBVqpp/r+EEpCVicxOrAE0HhjRnIQIyJ9gSRI0Jn8Lm7TN2WNbRP8
	6KlNSDC22mzF+IIhka33tL5eO4xiB2LOqV3s5JDxD/rVLL7YCGdYOThrY3PB7DT8DZ3d/KrCDMO/j
	HWfhJpHxSbqTJ+5CpybA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjghL-00000002XBe-08h3;
	Thu, 29 Aug 2024 15:04:31 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjghH-00000002XAB-3LRD
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 15:04:29 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D879040E0277;
	Thu, 29 Aug 2024 15:04:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eGyWPI7l-Okp; Thu, 29 Aug 2024 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724943862; bh=YfvEj90/YGTqFstXw+WygwIyDmoZvVGd7EjPYBPVmmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXO7HL9vBgsg3vVGUgx+5tUa1K02Cy5YiW87naLs7rQWruNBSeAPNX84S5dPpx16Q
	 Phc0unvnj/pAXRoTrl8gKXNmjc28NiQa7Gx7IuKoEwyxMsXo7PCayGQ11aa5YiS41q
	 LH4lBzFE8o/V46xa8cGFGKVfepmKo6lAW1qiI7QW08SFGBPDqWtsmgmC7/qcS8vVB2
	 9jnAbgFEnu/gu2+aAsJgU/noo9i0vUolxyTqDWbJ63DBSJ8wxGpD9r/lSDe/+o7dmk
	 fWipX/QOAaR6LFBXcrGJhzluk01T2RK+pFO8Mle3AgYYbD3g/b9FcW34EUgt8pzwIw
	 VZQgQtSceacb0xUyCqqsrbOEABhkSLE42a6pr40MSN9PhUSQEc0OjzIFAgyX62if/9
	 BdnlIykYUe3hxsiWLWDvRYG157aTgZfWpom0KXvuJk5W2T5Fp595xq7hbkwkcuVyeh
	 QYEOmfNQXpjszVN5KE+N9v2D08w6K8xi7+YfX+hu6vbxjroa1gG90yD6FeS0K0v9uQ
	 4ey8hLyMvDTt2KComHRs7C3FoW1XOH1gCNLx5LB3wUnGKfP7BPJTsnWNiWXYHG01bG
	 WHnpNP+RGVdn/9KHkVmplmyFVp5E1H8+8B5SkDKpVvIah6dWJjHrs02ssUIu+EHhgo
	 bo49QgY29hvKGw7zGc5MgNO0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD3DC40E0275;
	Thu, 29 Aug 2024 15:04:06 +0000 (UTC)
Date: Thu, 29 Aug 2024 17:04:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, pbonzini@redhat.com,
	dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
Message-ID: <20240829150401.GGZtCN4ZtVyqjYHbpD@fat_crate.local>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
 <87475131-856C-44DC-A27A-84648294F094@alien8.de>
 <ZtCKqD_gc6wnqu-P@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtCKqD_gc6wnqu-P@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_080428_014864_39D2BE96 
X-CRM114-Status: UNSURE (   7.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 29, 2024 at 07:50:16AM -0700, Sean Christopherson wrote:
> Because if the host is panicking, guests are hosed regardless.

Are they?

I read "active SNP VMs"...

I guess if it reaches svm_emergency_disable() we're hosed anyway and that's
what you mean but I'm not sure...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
