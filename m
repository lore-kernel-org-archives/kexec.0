Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34349C25B75
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzcCksBK9QU3MJZftZ9fOaNorgzdmG+yAJHmVthsUFs=; b=d1NyjlWayMs4ar
	W9g6xOjMZ7htnaZddZd73m1RW7XgBOsBm9VuOhalEbg9967PpU9TjIdy+VWFwccKlgdtBCrOkc+nY
	u8YMur73b1G7kYsPOVcyOY4HE4O9KyFWPHUs3jv3VOBNWaYvJi5y1ENmlwIFcPEq4maH5jnn6s53H
	8V4VeoI3ERzOG8FzS43R3t9xOqEJDj06DD8UQ+0Re3c5qMkxz0I1t0pdhRA4p51s+EaifWK7Qy7H2
	/G0c4vBOkmx4PG03GRLn4PYlMU03UY/Mmeu8W2VWn+uzmBPj8mDR3klfmNelCHZBZPJCtvH1YVjQ6
	GkKGJftsvksYUfVK9wFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHUt-00000003xJO-3Iwt;
	Wed, 29 May 2024 11:29:35 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHUq-00000003xIP-0112
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 11:29:34 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A795340E0241;
	Wed, 29 May 2024 11:29:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HmlNtBqr6uY6; Wed, 29 May 2024 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716982166; bh=7UQS7j6CCagVlyJn9Hmk6NwjSsENYGcwi4W7WCTkCBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV5HUW531EDiz7oQ1FPuK0S/IzSZHeNkt/G9fyB4FwCoZzYhfNZGhG8APJHIv24qe
	 khz2nZDAkKxcjTfGkC9eVb5l4e070mmcM22lEeNo7kJxFVMeVktFnYLB/sTT7bEKZr
	 q2x4F4zVZ9l3wiNP0kaQzjBUHkhjdGxAl8BoERiiCG531K7Q3fspKbKSIR1OAZj4C7
	 VVc4Z7UATXIiJIZALj0I8+GIhy8DGf41W8PBJxQ295Tp618s3W5SdLtIxZPnirCkEY
	 X15kJQhqPzu+Oljl64c5vWHy+kSDPjCJ4f3tj2T8aQFtTBjaP1jzTuvtgaqcFlkImj
	 XqyO8dd9b1Tgg+XRWOvwmMiYTtsXg7QT4LQbXtk87ezRnBluiKD/0Y/lszFMz9lwBx
	 7NaGgzNgdtn1Tv+ksOwVGH6MzqT8+5H0T+wgZSOTU9CIvU78lIZClz9E3DGTIvty2A
	 GxRLH6houMcYoLFSa2lz6QKo8hRp7baOF+5IAt2cC/T9xlZoI+JTPC91J8aH/j0nLD
	 tCCvir3LafEQ0VmdfZzm1Fxz/GR2QyfkOvKjDxRgeu3ZahfpZaUVY4XFuohZTBjBNA
	 3MOy7IP2ggy/U48zEeNtCyRM+Xu9mV016oVlCwGq+tUc/+jIERc09SGV6E+/kfYwUu
	 Z26oM8yau0Hi7dXabPoG5JJo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18D4340E0177;
	Wed, 29 May 2024 11:28:58 +0000 (UTC)
Date: Wed, 29 May 2024 13:28:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_042932_760590_3D7287E8 
X-CRM114-Status: GOOD (  11.23  )
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

On Wed, May 29, 2024 at 02:17:29PM +0300, Kirill A. Shutemov wrote:
> > That jmp 1f becomes redundant now as it simply jumps 1 line below.
> > 
> 
> Nothing changed wrt this jump. It dates back to initial kexec
> implementation.
> 
> See 5234f5eb04ab ("[PATCH] kexec: x86_64 kexec implementation").
> 
> But I don't see functional need in it.
> 
> Anyway, it is outside of the scope of the patch.

Yap, Kirill did what Nikolay should've done - git archeology. Please
don't forget to do that next time.

And back in the day they didn't comment non-obvious things because
commenting is for losers. :-\

So that unconditional forward jump either flushes branch prediction on
some old uarch or something else weird, uarch-special.

I doubt we can remove it just like that.

Lemme add Andy - he should know.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
