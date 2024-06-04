Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF03C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gp+nbcHthTnu2N1RwPAQCDfSm2aHDLfuh+HD3uMlIy8=; b=bj72Z3f7M6PTDQ
	ppcpN87UDTTUnexaLfOvqb4YWzUSNZgFiVHWhVgIOaEK2kHu/b4IhcvXlaEwQQVJm2+bmoxI1y4HB
	U8UhbKF5RbaVlBXxJAzkPJ1K+nJ5y0PXFH2Js+aNC3tlh+P/pJ8aMqdNLEgXXDAWA5wfUUZiMc9VK
	s+kucPe7735f1YCEA1xIbqtJ4kbQwELBgflwk6Epd3YXQpAam8wd2mIsBUO0B1AgXwBxpKZ1TxBlo
	W38IaJLMdLSSKx2hQn+vo2Ek9ZnslTjm2Hh9v+Br+N5rf4kDxhzg00AJRqGVYcpQmiPRl/lnQIfXH
	RbKXGSsqXdl9seykn/wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYYK-00000003Pmn-3S0a;
	Tue, 04 Jun 2024 18:06:32 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYYI-00000003Pm3-2ok8
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 18:06:32 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0479840E0081;
	Tue,  4 Jun 2024 18:06:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aODJicEVTnQO; Tue,  4 Jun 2024 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717524384; bh=meS63MnlFXX/qkUgab/1h3yFeTOB2Up4cbcyhv6eQF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qcd3QTnuRZDQQm/WVb/kDGKGIpKkoDMDIl29qUOVk6IaxfBNHQnzuQDtyt3xEbmAH
	 IOM9C4JdKAGGTQXzVzIzefFqProE8Rt4rDQVjOV9kNQF9DUtTllwV+9FLs08PyBlGY
	 q+bJelC25FNaCJkKW857MzL7VncyvOyYS6aCpZhFHUmQ1lW7V5RmvTWjXUZDfw3k81
	 TNSnu8YrHoI2PL8KtLePPs9P3iF3SPGJWtYUbpeeTnafko0PVz65UuMt9VtWA5pjcI
	 fdVZlnTjckoOiFrxcmVsoYv49oM6R+GqdtVlQtmhZfJvgFws8n0ofh42pG13ggDO+Y
	 D7twSe/5QDvNqlY9hRtyqNJn9uqtUc7WVSQjWvLIgNEYgiCAPvTIiFpbOkmMzrUrp6
	 MeG7p3zMGl6w7Z0FM6ibJvMdlW4l3wMlZTN57RvoXToXJnBELOqoYv7KLTY1s5InD+
	 bOdkt8HsRuCXWXLxgAz9NkFSJzI8IQK6jYt/lh6FhwqBo5Zbh2KO9ZMbvmUqqGtAY+
	 VMk0ek/yLx7IS7AHpI/CfdH6AXooAyDqNwTLcQjEpmipTiAwUA9BmVhOt2MPqCP5/e
	 DbnB9bTDYGSNTsIJk7mxnKbAB7Du7Rfm+s7W5czyESBY91PK4AlHZ9QnV2JDOKUDyi
	 95STKxzaeIVOQ4XnMKySMkIs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCCBA40E016A;
	Tue,  4 Jun 2024 18:05:55 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:05:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com,
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com,
	kai.huang@intel.com, kexec@lists.infradead.org, kys@microsoft.com,
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rafael@kernel.org, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_110630_985384_6FFCDEE7 
X-CRM114-Status: GOOD (  10.04  )
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

On Tue, Jun 04, 2024 at 07:14:00PM +0300, Kirill A. Shutemov wrote:
> 			/*
> 			 * If tdx_enc_status_changed() fails, it leaves memory
> 			 * in an unknown state. If the memory remains shared,
> 			 * it can result in an unrecoverable guest shutdown on
> 			 * the first accessed through a private mapping.

"access"

So this sentence above can go too, right?

Because that comment is in tdx_kexec_finish() and we're basically going
off to kexec. So can a guest even access it through a private mapping?
We're shutting down so nothing is running anymore...

> 			 * The kdump kernel boot is not impacted as it uses
> 			 * a pre-reserved memory range that is always private.
> 			 * However, gathering crash information could lead to
> 			 * a crash if it accesses unconverted memory through
> 			 * a private mapping.

When does the kexec kernel even get such a private mapping? It is not
even up yet...

> 			 * pr_err() may assist in understanding such crashes.

"Print error info in order to leave bread crumbs for debugging." is what
I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
