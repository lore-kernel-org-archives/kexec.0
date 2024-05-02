Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB32C4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=drptfYVEq5gIiYLmocLyz0D2YIz3CJW9f+4dqlLyDkg=; b=zvdodZDYgTGnJf
	GF1ylKWvBwQw3+47EKPugZ5xrV/o7OVcGWGBmvtLMIPyfRWkYTL+EdaNLYgOuZnok0t5+54SVJ1PU
	hywaTbhFxrNF5S6bbKdROexkby5xsH7XnTiPUxahzvIWLTSRI0Wd/qOLCcHYxF43jl4nq0DDIbz0r
	JfO2FVPfsuUUAMRSlxn9UWFSo+BsGq+IILb2BBM9SHPGkBvo3HIrlHHECUQfK9HCedAbjW3tgWSob
	SuolnHarJUJgwZYXHIg7EJRWwwpx7VtL9pYefPDSjz+oElyUT5jPCF2q4vLoGCJOLS99UbDtTTDTE
	nv878IJoC5xP2mk9mHdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2WOx-0000000CmYK-3T4m;
	Thu, 02 May 2024 13:23:07 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2WOu-0000000CmWm-1NnE
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 13:23:06 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF3E240E0192;
	Thu,  2 May 2024 13:22:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6xQRXxDKMM7M; Thu,  2 May 2024 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714656175; bh=KpaMMMmxEshpLndJz6FzKD16Wt8ZjX0UI6aaHqp2B5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZbK894erBEkJD8ZKxEIlsqHFH9FFvtGZRcWE19a7cEruu0X9261Drw6In+XJsarE
	 A3SzXTVOCB6QzhFWkVe6kzeHq96bBkdsamzjbVFgJ29hgdcV4G3++w6Qxk7z+D+0ij
	 TXbNpb4C1dL8MRpFNplXKbx57oFu5KooO/U9g4HpBexPKiMXjQP/JujGnKsaYhuj9U
	 MUJ+wVZEcP8l8PgChCLmYEgaMtT2tF9sDJhMtr8B+yEEtLzvb8B6fLAPPN1+h3SeTR
	 BaB6bhc6i3LUN07MZzMKpC6+yyC6+j8gdi5TD6o1l1KxYvG8IElEWZlHctUtESxylL
	 J23wSr0NgVGzFeRuP95bHiogRwtdnq0X7BTqzmSSXHndQU/cO14I2AzpFpkY9v9Ucr
	 KS2kGNcXh0Dyff+q+E2NIh2bLpSl0PjHH5UXJ+uMPpgu/McOzPfz626462iApzwywv
	 9ARS2wzI5p34+Hg9cSm0ISw86hsUqWEdTM4W+aD0INECKBcx958SPFME0WotOn0iNd
	 ZM2VWB84VY/T+qP7ZIPY3WGAf9KMlWl/aEEXVgLI4TTKsOIgaD0SbOT7k3310BfP/f
	 OQKJiz1wL03vT9Vf9AxUIJrjlfmr5K88iHuZB3kcyn6bx2vRF9CASEb5PfdMF3SgYV
	 k3aRslk87b2AWgdKlBJl25Qk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1346740E01A3;
	Thu,  2 May 2024 13:22:35 +0000 (UTC)
Date: Thu, 2 May 2024 15:22:29 +0200
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240502132229.GBZjOTlWg-CzSkrKA0@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
 <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_062304_573912_08A9C5AE 
X-CRM114-Status: UNSURE (   6.99  )
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

On Tue, Apr 30, 2024 at 05:49:08PM +0300, Kirill A. Shutemov wrote:
> I assume all of these new labels have to be prefixed with ".L", right?

Oh yes, please.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
