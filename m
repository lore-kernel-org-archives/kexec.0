Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A5C04FFE
	for <kexec@archiver.kernel.org>; Mon, 29 Apr 2024 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S5QG/dwqR4RyoVB3iv48KwU3FVdy4j4trswT6BeNnac=; b=hkfP8kQIxNU/Mm
	HRgPewp/StFsCOVgH7AD2YKCa3UMBhfFPzMlCUCuCxZ1npDUDLs6YEKHW5284crsFLJOW1xotWiES
	1HKqsxTymAB4lJQGkXBfuWFrnsROjorVLwKO1Oj89IF+1ciAylAR+AGNfSg4VP608aKeMAegQDHLO
	cH34ijYzZe1sjzWhmidVaqeZlJrZyIXW7NTPvuMRjE6ZTTYWR+ylHYKmK+PzlWYayWKamNR5lXP19
	QqnPznV28EEv8w1uMO7B3HyYRNAIBj9Z99gDPZ+MKq2S1V63f/p8euI6YYBmT4cK8ldNiCkU1Espd
	vlXi+pBMJRnXO905xnnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1SGK-00000003Atj-0vKo;
	Mon, 29 Apr 2024 14:45:48 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1SGG-00000003ApX-48Lu
	for kexec@lists.infradead.org;
	Mon, 29 Apr 2024 14:45:47 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 988B940E0187;
	Mon, 29 Apr 2024 14:45:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jEjCQhPIYrru; Mon, 29 Apr 2024 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714401934; bh=zZZ5uIl7gam0sGKCdhwGGAI2qvhYN93EKC+r3/GxU7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUNn8bg9UGoZX4EhU2jeGeFFFlf7QDHM+ueU/sCj+9gGAJJZ+ukCF7gmLndn3W/T7
	 4wo6lFaRBzYuoMZxNEOxZDHlaQQVIGpI+JuoAoHdE+y5mL8n+yRz3WhUr6h1PGygj7
	 ZxwFiqR+ReP4lmSemEYnF2ywcqgTZuZifGr2+Tl51SVgiD8cLnZUhst/8Aet9ARSx8
	 SyeE44n7EzN9aIHV6RM/VYemsLUZ/mpZiwpawD38w+G9iWJNd48S6WZfxq3S2BbR/e
	 mHQD1jEOyrd8V3zgfNjviPj3x7Imq5QQ13rDDBvYHsPf8nxZmO4gn53/MPB4/6P/qc
	 eJ948igKRf4i05fxNhN7XUc6DBmaWnkqk4jb8EqF8ckEJT+Qz/VwpjOAIr8+6FWVc6
	 a8aegJ1S3eXyZMQspheuU4KSquSlQHkg97gZKZ6fVYfnoIepRMzQzYUg0Thg0eAtP1
	 3TRwkRehYHz9+Av2qXTC4HhtVzgLw9CMdGeHPulRGTNh+ahz2ptH0WY0tinNdfZHdg
	 1j0VXg8ljcNktUTniiXGKiW36ISjlip+f/FJbpP19sDGVkpqolIEpHW3lwzqH64T06
	 YYRwBGaB2Agmht8+OaiU5fRNib5gJAM+FyFqoeVMlkixNUDjda8OwVkFAaFkZ1eqfZ
	 jXwe/f5Ydu72Ky5gacB+n9Cc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A689B40E00C7;
	Mon, 29 Apr 2024 14:45:14 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:45:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
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
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_074545_274968_02AFB4D5 
X-CRM114-Status: UNSURE (   9.42  )
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

On Mon, Apr 29, 2024 at 04:17:38PM +0300, Kirill A. Shutemov wrote:
> As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
> platform.

You mean when identity_mapped() runs as part of a kexec-ed kernel, it
might clear CR4.MCE and that would trigger the #VE?

So, if that is correct, you basically want to *preserve* the CR4.MCE
setting across kexec?

But then __mcheck_cpu_init_generic() will go and set it
unconditionally.

So what exactly is the correct flow here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
