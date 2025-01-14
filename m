Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F45DE77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6zHY6jHIC86Gn2iZzBYv98W6XUmxFOKaeGRIE2XPsA=; b=kKLvxzTqna2h84T9FrtXaVWz/X
	XTtPkUuhimce5dakkUAmT7PcNv/JGg4DXuMFinKqC2A+G8NMP+o7mfmCsqvR2QGc6iQLbK0RzNr+F
	iY1hpudhyCzWLOgGEOq6EIaueTKxzL4UUlmhLNbeLmw8LI9n/QhWNaw+Gq1f1fSnGPtd6YKjePalt
	XK3swMjgkjeaLfL5JXqI/UZKrqeIvZ2epyfpCWi/kV3/syJ/RyA9B3FrU0HAakBGdr7gsDTYHiVw+
	jNke27tdHO6TlOAZBDjfopTciAA+UbmB8kWkbWTy1cC5MlSLyOciOIK2KRIGWZo9jXBU67oY8ntUb
	ccFd2sew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfSo-00000008JYl-0QdY;
	Tue, 14 Jan 2025 11:52:06 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfSj-00000008JY9-0x6D
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 11:52:02 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C26040E0264;
	Tue, 14 Jan 2025 11:51:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o1P0B351mw8w; Tue, 14 Jan 2025 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736855512; bh=W6zHY6jHIC86Gn2iZzBYv98W6XUmxFOKaeGRIE2XPsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jX2VfOVrnPK23VPY/gnUFDOgmdueufAGApo7nN7S/LZ36jh7LSzPzubrHQpLWYFS7
	 nV9gRBEA7kE0sFprbgo2OLGzeu2hWQEFAsfAy9s7fV84bSt2flIMKx/nU6ygvt0cAR
	 +qp6LfIkb0iMPFs6AIwh17V4fVKyuqWmDAJUVI/SUYGXKVPEfXZd13jOnbnzfwmM0E
	 NgeB0qgxdl1oJrKR66oFbl1BELHl2vSPfSCKMYY8R35wtmO7UyO1swliBPkCHGDbsR
	 +M6foNjprxTFA/Hu8EMnuzDDWtRQ2lD9b22W7r5IoCwONR2e0uxQx7hHkr/ho1vYHM
	 IuJftxQqAQ7EjpDdEjq1tWW9w4HENRyMpsjzEAagtcL+JPZu/Yig3BlBW3tdbHdKoZ
	 TZlRNSEmSe6zZh5BEqb/1VxwD9VUZgpGgyafe32alPC1jH2Psh36qlEJP+va5FYoAa
	 KqjKBoyFzn9UzN6zeo47mRk2UlcRq51ozGfs/FYcS7ymfynLMRAcXW4MbQUjpPyDnO
	 R+kLpHHEMN/iRbd0aj00gD2jrPA4EZ+ri+U/FMs2tyP6/vfzd1SHDz5S3rfoSygT+t
	 DzP47CsLMfuJaRN9AMWyOMgGpdtBuIfmY4PJ3ukR+NHYHxKe8e8ii/cMOHqoXCM8pA
	 Mv4lK0AgI7xUa+aPObrzEZ9k=
Received: from zn.tnic (p200300eA971f93a7329C23ffFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93a7:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 478B340E0269;
	Tue, 14 Jan 2025 11:51:21 +0000 (UTC)
Date: Tue, 14 Jan 2025 12:51:15 +0100
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
Message-ID: <20250114115115.GAZ4ZPs4R-Sw2NBZHL@fat_crate.local>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
 <a3ca6fb291674f92fd2f94acf45bf3813baa3a49.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3ca6fb291674f92fd2f94acf45bf3813baa3a49.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_035201_419571_19461380 
X-CRM114-Status: GOOD (  13.80  )
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

On Tue, Jan 14, 2025 at 12:34:29PM +0100, David Woodhouse wrote:
> On Thu, 2025-01-09 at 14:04 +0000, David Woodhouse wrote:
> > Fix a few bugs introduced by the recent rework of the relocate_kernel()
> > code, and one which has been there in the kjump code from the beginning.
> 
> Ping?

I'm going through them as we speak.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

