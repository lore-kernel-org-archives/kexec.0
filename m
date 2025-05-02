Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA95C3ABAC
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUaue560YkltyOlDG0wH62GcwgC5OBuxzVya6sKvsug=; b=hEOAMH9omLoRDeX+Ls8NOc2Yu5
	Bm3dKyQF7bHVF5ciKcS+KLukVd9RUBgjwccRaOy1EmdFq8KgCqvyG8gBsFYbYfc7nNofanDKCd+TV
	gbzSznh445KsitPbYcuR83WE+GhRTegV32cWclFr0Kv5QnbqemwQEPfC2ACScaUBymDgLlVd6HuTM
	/BxufXhK3+6uaKi4m1TzKkmPT/Ak3V1DUe0751Z/IxBMYWDCUXbJ5rXJqSBiPUE+0/VA/ymTst+Ei
	KeCyfGK+m1fJ8jjjXyVMhmpJ7HbUGwa24n9bhLdQCupB2c0PL9PyDoTRFx6hA64xB6Tty1mm3915X
	eQMvu4yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAqUA-000000023oi-1ErQ;
	Fri, 02 May 2025 13:31:26 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAqU5-000000023kX-3mGS
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 13:31:24 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 779D940E01CF;
	Fri,  2 May 2025 13:31:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bSZneCzSyNAU; Fri,  2 May 2025 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746192658; bh=yUaue560YkltyOlDG0wH62GcwgC5OBuxzVya6sKvsug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oqamq4qlI7br9n5Wd3igLSUN52Oqi154+I/XEpufXyQzY89hKLUPg0BVnjkQXft7l
	 UZo4Pya0eF+nHC5QI3AEidSN4ivSJbilDTAjd5H9zPx9sXR5KqGM+/9A1AlHCMia1w
	 8wsiqbkIgZxoZDE5PHOm0YkgotZ+YBQVCw+bqNEzuYuBjW90jWBjZsxzLuO1+7s70n
	 qQZ0Xc7Kbsu1FD+MMzGBmBpQAwP6iweMZu0nLZ1RM9uV5FOfkPOqseONVHej5WM+db
	 rw3jIh1HGCJ8UCGbpFjdeIswVFefh6KHfczz3fgWs4iAH/TIadtANJDwlDnPYVKjH0
	 UlZ/ibOIq+/khKozqesbiuZ6Rj8E54KvYOWfDQoLimYvm3+fg7Tx24F6G/cyJVOG0g
	 Fjxn53yGtx/yA7X6atX57UuXLrrQbyse39OuUoOtWSCJY1OwFgvbmTzC6l8B3CcKwa
	 r6RZL5/bLtc5a8M484Hqm88kEoXTtSd/Q3czfvtzM3byaTrfjuCahH/LRxB8nwjcs9
	 GS+jZAs0TkGRjMa+WtyW1CYLmM+f+L/56wJojZCu/ePjN+lRXy3dYQoeFjyj7WsLWP
	 NRIfuuh0RQb111hd3SFtfcBMhj82LCQeKKyNBdyvcSyax/pmEJYKYo9+toO8V7ZXOK
	 pdmGk/nNVdi4Ir5g7G+OLe14=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4775940E0206;
	Fri,  2 May 2025 13:30:43 +0000 (UTC)
Date: Fri, 2 May 2025 15:30:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v3] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250502133032.GAaBTI-AsaIVn4hOS8@fat_crate.local>
References: <20250430231738.370328-1-Ashish.Kalra@amd.com>
 <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_063122_314610_B6E98DC1 
X-CRM114-Status: GOOD (  23.66  )
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

On Thu, May 01, 2025 at 08:56:00AM -0500, Tom Lendacky wrote:
> On 4/30/25 18:17, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > When the shared pages are being made private during kdump preparation
> > there are additional checks to handle shared GHCB pages.
> > 
> > These additional checks include handling the case of GHCB page being
> > contained within a huge page.
> > 
> > While handling the case of GHCB page contained within a huge page
> > any shared page just below the GHCB page gets skipped from being
> > transitioned back to private during kdump preparation.
> 
> Why this was occurring is because the original check was incorrect. The
> check for
> 
>  ghcb <= addr + size
> 
> can result in skipping a range that should not have been skipped because
> the "addr + size" is actually the start of a page/range after the end of
> the range being checked. If the ghcb address was equal to addr + size,
> then it was mistakenly considered part of the range when it really wasn't.
> 
> I think the check could have just been changed to:
> 
>   if (addr <= ghcb && ghcb < addr + size) {
> 
> The new checks are a bit clearer in showing normal pages vs huge pages,
> though, but you can clearly see the "ghcb < addr + size" change to do the
> right thing in the huge page case.
> 
> While it is likely that a GHCB page hasn't been part of a huge page during
> all the testing, the change in snp_kexec_finish() to mask the address is
> the proper thing to do. It probably doesn't even need the if check as the
> mask can just be applied no matter what.

Sounds like I'll be getting a v3.1 with Tom's suggestions?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

