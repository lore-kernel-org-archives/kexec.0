Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFC2C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vy/hdy5lm8CcPKgWj+2AYKoZNmn9M9XQEuBn5w5mMgQ=; b=llXmla0v55Od2f
	KiGPAuYldpJxZ9lptvWl791zaxNCblIOEESP86hTYEWzVHOh7atzxB9C6FWXtQRPB/JSFZQOWkbzU
	YpVH0YzzIDGt7qdBAXSOBV1bJ9wfCAYDdDzuyAp4XUYgM/pj3ATppDbSczidqlGHUkuVjIiTOosWZ
	xX/hCMlX95HSV2l7wfw6LS2jTuWxXzQ/J17SnM5Sy+73UemXoqd/PwioQVxbWDScr1/80BDThIBPt
	iZKn2215PEXGtbJqfTRtF5e7rN+e8IsT6uzDgW4TNoJ7Z68miftrtJ1AEwi1DjdAmEeiXIAztj+Jd
	z05AvZqh13melw4E8wZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzIcN-00000000dmB-42Dd;
	Tue, 23 Apr 2024 16:03:39 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzIcH-00000000dl3-2kKB
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 16:03:37 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 86CB540E0192;
	Tue, 23 Apr 2024 16:03:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SL5JtAOWtOYR; Tue, 23 Apr 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713888205; bh=IiD+6XFkDSEK2/f7fOiQcCjp0YlleOKij4PQKeQ0D5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXxdSqMZsY+FRKwNdjz4vBICMsm9Enxv0XLC8q9Vup4Qk5tqDG705c2FJ0CMbJj72
	 igAyWgN4VL9Gxat3hdmABoIFuqaIXwpx2SbRKp258zyIo7xCrs23rKXYAYNgHomacS
	 Bja2CSfG70JvAre9Ih2CatH4OMJ7QtZeZQYxere7tyjWB+pJmaHDTkf6kEzhKHJCIO
	 BJFAgQJTgacsbJVFoCBhrBKdWb9UUReauR+Y+iDzP7rmKWIup6yWb4etUVkXbJhlCN
	 NcmAwWwJwIUNKOC5Sc5BRYyIZcNtTjlqOMjHYaGU4BlJ+MCVMF8BrMr2Dz9OOgKoI9
	 GVRkRtFFg1brO/ZEriSEsG0arG3Y9sjO8UBNXyt6lAGna3y1m3WonYhhhf+naxNDbd
	 egDk73cNtbhEPL6+bsS16kkdE35xAk/d+zKp7h61TitpU9SA6wzZQF+KzS9jYVWJ+H
	 UQTtWDXtZ5gUrvakcZl7NeY6f6UXPPSY7eEnfBiF8oDrBHbWgekiHvAJODMnWrNx8x
	 o8mEE/Fbobqs2VYNGVtWiSDJC4ZO6XkXdLSANmYt/n6nVGuSR5SoHB/LmET9301nKb
	 GOv+/sPBfBOEzVxbKb90U7GCNcrCLmH9DBvuA0DhEth7ppx0BhxvR76TZiasaITCTX
	 tZTDSfBAtksHFfubS2p9o2Iw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6555840E00B2;
	Tue, 23 Apr 2024 16:03:04 +0000 (UTC)
Date: Tue, 23 Apr 2024 18:02:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_090333_880625_1F1B8C44 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, Apr 09, 2024 at 02:29:56PM +0300, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up.

In all your text: s/woke/woken/g

> 
> Currently CPU hotplug is prevented based on the confidential computing
> attribute which is set for Intel TDX. But TDX is not the only possible
> user of the wake up method.
> 
> Disable CPU offlining on ACPI MADT wakeup enumeration.

Something's missing in that "justification". It should explain why
CC_ATTR_HOTPLUG_DISABLED is not needed anymore.

And looking at patch 3, I'm still unclear as to why this change is done.
Is it that the "ACPI MADT mailbox wakeup method" is going to be used by
TDX guests now too so that you don't need CC_ATTR_HOTPLUG_DISABLED
anymore?

It seems that if acpi_parse_mp_wake() finds an ok wakeup entry, then
offlining is disabled...

Or is it something else?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
