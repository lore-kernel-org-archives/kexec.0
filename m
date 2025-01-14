Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C1EC02184
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0cZ5eOPrcn5CfJRAquYo6SG1W7RrnVKQnK/aXoihrs=; b=HFp7UWCW9KR+wd5SN/7/y9JECG
	UtiHrBzzP1k9wqR5TKDp/8YK1X4gFwd8TUKCogRhoQ0ZknSgI0vRbJd3Y3WaV3559KoOftpfYcHjY
	3ObLOp9HvH3qrRiNBRhTghuGK7uPJeq02AGQ48NXzvRpOWwrRsYQsGJX7KnunZrDCPde0QgkGrcqm
	JdTcQvS1m7AyZ4lrQa4+l8iDy+q/6m0U7BbVlFePgdg09QL0OfMAyOvOJharkZq13r/gcX88Gu90a
	vzCfG1xqqYJbfMsbRrgpTw+2k68t+K20NnK2t+kYG/5C1khEE3FV6vDMIHsn9pP2guu2eNdntj8xp
	0+2r6zTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfmw-00000008M9J-2Pki;
	Tue, 14 Jan 2025 12:12:54 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfmt-00000008M5o-0Bsu
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:12:52 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 456E740E0277;
	Tue, 14 Jan 2025 12:12:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hfPSlQjBFZgl; Tue, 14 Jan 2025 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736856756; bh=h0cZ5eOPrcn5CfJRAquYo6SG1W7RrnVKQnK/aXoihrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRK84YZPeSd40UgFDHJJY3/YgkYiG0eX2nSUdh4TT6/s94h6zwLQu3oWilFsT0HYb
	 dlqZf4mguLarxnqQ+hO/Ub61wy6AlF1D9eQOa9wHfAEuQymKVX6pIg8ErFHMsQzyVx
	 oeenNt19kV3tpVpSgxL7SKZJG1DPr48RuiZw0u06OHzsCzRk5LGOPP+4o8X2B1ytvv
	 nEpRf4PEqXvbQzEqORiJ0xvVi+VzlwF7FEGkQRtyeKm+JM55dTWdwSBJCpniLVImGq
	 xE/R5Kaz8k5qFy06Plg4sL7x1+wmyKCn0gnvRlzxxHVn/pMis3m7HppE4hsJykMAX0
	 i+C5NLvmiCXxGlB66My3DdPEbUnFP12Wmah+ur+NLqPuVXCY2l++mPswzEv8j5di3Z
	 XkBpSEM5csy2tIQkVpP4B/qE95Cq6rhN8QzabNkLvlkvpxoYKEddQz5Cm25Dgb1eJL
	 PCXHCiNlIOXyaCLPPcGTBZTWECxNcwYRvrIDZGRFRvj2wS/nEZlX527QFHbbgG9pZb
	 kao/wdLv2cNuWF8RobLbUKa7obhQNVG0+TlKkbJvRaGn0xUaMwueqSCGTNxZainkaz
	 uZZcf0oszdEb9BrEDlGVNZ4gV8amaUGJZH+/NSh0sEG3wVlWmND9Fpd/Ql+3uiOuNa
	 YzmGKuP0sl4tXEBEfMTZ+d4s=
Received: from zn.tnic (p200300eA971f93a7329C23ffFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93a7:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B369540E0269;
	Tue, 14 Jan 2025 12:12:04 +0000 (UTC)
Date: Tue, 14 Jan 2025 13:11:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>, Tao Liu <ltao@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de,
	nathan@kernel.org
Subject: Re: [PATCH v2 0/9] x86/kexec: Fixes for tip/x86/boot
Message-ID: <20250114121159.GBZ4ZUjze3oZ3WT3ey@fat_crate.local>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
 <a3ca6fb291674f92fd2f94acf45bf3813baa3a49.camel@infradead.org>
 <20250114115115.GAZ4ZPs4R-Sw2NBZHL@fat_crate.local>
 <5E5117F9-2A7A-4100-BC72-7CDE8DD8361A@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5E5117F9-2A7A-4100-BC72-7CDE8DD8361A@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_041251_231264_A4502296 
X-CRM114-Status: GOOD (  11.29  )
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

On Tue, Jan 14, 2025 at 12:53:45PM +0100, David Woodhouse wrote:
> Thank you. Once the dust settles on these I can resend the debugging stuff
> which is actually what I came here to do.

Sure, let's carry over the merge window successfully first. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

