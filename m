Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B0C10F16
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uG1/5tnXPUXS/ku2h0ZmSzIoFk9+UFnatytyaq3Km9U=; b=PW3KZMUMsNLDCA
	l0fnfqCbh9ki73ooFBWMx5ZcjksXVvSxV935ovruxbVvIOiwTmBHzJ2J+Q/V6WGkRRIoKzC9A3hKa
	oJRgVwwT8rVKb4Hw94Lmck5OO32OVsnpolgmjLA0TZCE82iDZOjIq/5BYvG5w5wHm1ovAMBSCpCm4
	0rZR9vZ6hN+23h9cTEwGfwsHZyfXpBWYA2MrDcyAm1MA2YYUmWCQlcEsRoYgFoiMn8IoUSzAaDJjU
	/x/z6Zh8+TgiX2JzOMqKF8ZCo4tOQ+QqVQ3KcoWpPUdmqmaGeFbZThi2CdXkFu847H6CetBrhC1UZ
	a1daucnE91W0cPsAbGTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1n4M-00000006Q6x-0Y2f;
	Tue, 30 Apr 2024 12:58:51 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1n4G-00000006Q1I-3hNk
	for kexec@lists.infradead.org;
	Tue, 30 Apr 2024 12:58:47 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD00D40E00B2;
	Tue, 30 Apr 2024 12:58:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZV3pt-UnzM2i; Tue, 30 Apr 2024 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714481890; bh=JIpGJ222f6DlJRq4eDp7EoEORpRjHOTnZ9jXZzNPKUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0hz+6YiJrTAJEVtCM44lX+k6fS0nhtBTM7sNoVHfqYqDltk9uRgnk05/peANK4Xw
	 DY34QJaWudiQm121U/c2t8W9sEFjrtGuAllZvb9yd6NnZOvydLsGezVRgEZ8WKtd0J
	 AlUwp1g0Vpq9x5deLTXx8qHmrAyEMVQQki1fARM4o3YIuhF4f5RTgZBmkk/h7utIgs
	 ERZvpCAJpzbElAae/y10YkkGASFA94BjvJO2TbYLWwKOtCtsWy3CnZe/uian3x3y63
	 /rLaLb4RnEs0KNL9O/1vJWSbEETl3egE9GeE6s1cncuMM8FAk+Q/8S1b+9fKt8gabi
	 iPQoSYgmOWupQU8E2vUFZTj6ztwyzt6qcC58Gp6nkowShdJRbvLwEGNt+qgufoxC2V
	 BSJ34iFpEpqUkQ5PJf/nCNAVbzs++JNLutcdMVAiA7Mw5wg9P9T4e62l/5sr/nQ7rJ
	 ucRyNe40IPf7uvX55ZYNdyn8DAYJeau5s/qCxKUsc+f0N25+8lPKxZ/vnRWTbd22yQ
	 VdzC5qJ2io5JiDh8EQUR2OORscxfnjDuiQzyRdm4abg8tl/ULDMf5o13YZnYRwBifr
	 22oeZvMnpDmhujKIXyfkN+AXuWCT77avEaGABW3EQqG1WbUIKnCZjlU+nAdu+UqTML
	 sFmaxBKupr32m8kBpVxTKI88=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CE0740E016B;
	Tue, 30 Apr 2024 12:57:50 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:57:44 +0200
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
Message-ID: <20240430125744.GQZjDqyM3k_peEw-bc@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
 <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
 <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_055845_396616_6C6128C0 
X-CRM114-Status: UNSURE (   8.07  )
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

On Mon, Apr 29, 2024 at 06:16:54PM +0300, Kirill A. Shutemov wrote:
> Yes, that's what happens in current upstream.

Let's rewrite that commit message then:

"TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or
kexec flows, a #VE exception will be raised which the guest kernel
cannot handle that early.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs."

without that bit about TDX guests might be allowed to clear CR4.MCE
which is only confusing and unnecessary.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
