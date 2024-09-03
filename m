Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CDCD3448
	for <kexec@archiver.kernel.org>; Tue,  3 Sep 2024 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0JSFwhpDN+E/caI3xa33JuY8nlZ2Y52smUhPrVm8lg=; b=l1goPsVeI4xstl
	1/eznqasgqZxfJN8KNWvGvDkzjvIwKdG2X7Vl/UVk1lizpsd6SeNGqnS7/j0xmAOnv4xvjopBQD9B
	9mw+nKo0cYtSZZjgBGVD+rQX3iPS8kaViQ0Q4A0qlav7nKeZYpJuxHtlSH4mNFDGA9bWGg35V2cqS
	jKTQwcpMpv7Yc8CTgDE19n6p3d90zUC39vVCTJyv1ioXE4GHYH/o3r5wfxZFRFCP08B0oT57gL6nW
	hRrbTEqDvEQtF4vHleXDTUtrENJJ0hMUPsVdQ5FTwaGlEaKh7RcXeQaTb1aCpbUUOd1eqcVGQKVZF
	AE3NXTsOsfTZ5RSi4siw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWnt-00000001D2N-2p8l;
	Tue, 03 Sep 2024 16:54:53 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWno-00000001CwW-1kGy
	for kexec@lists.infradead.org;
	Tue, 03 Sep 2024 16:54:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61C9D40E0275;
	Tue,  3 Sep 2024 16:54:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6uHhZfpwbo0n; Tue,  3 Sep 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725382467; bh=pYKhtjki6SeFDno2F6TDAHe/MTQ7DiBiBkBNTh+qMDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEh+QdheQQujp8eWR6xyHMIMIqI26xwx4REdP0K1dOLVoq5ZVZjIZDM8LPgqXKjIt
	 +51UjdOFu8cQRG9q/E8AW8HYjUS+lvHqif8zZS33UrCBdVIp1Taf4pHEeCjt4DyvZC
	 G8XXZ4GQ8unC5uTn1+t+f023dbcmwwrXAqrLEKG5LOrMbfW6b8aLjNbPAenMVmOHmb
	 UYULQ+wES+tNYhB1CrwueQdUIVxy6JM0JiHxlHuuCtJJZcb3tOsnCKmMh8K1B0Ub+u
	 p02zVIineHl5B8eTW8i+5V1xRgiQou7neqZ4J7uSs10GAW4WsCabtOpif7iP7MMclt
	 o8iWEwyjjTFUrSag7eNwY8nneI9zgxh/tQm8Bfps3ITdWOOVj97o3yyeTsrJTD6WO6
	 rmM3cMPwZ8iVdZn8vm+PeU97RLksk4gPOXit8EAX18Jp6AnzHPkDAEEuaMfHvcjsyI
	 6IFvRZHF/z3rtCYPKhcS8DHAvv+Y/3RkiRXHIsq200Ijo9wA1Og0GZooZWFYa7yR0l
	 FPWQK1pBRcFySzJx/pefP9T18dSzt4cBmS3vZNRqpPKaFsRy73JheqcA/yUGxDb0/G
	 YEFBMaL+Jbq3P5oZvKZ6Cb5UMwWfqvVGQLzK0bjhjOr5wwQ8ZbCkHK/BBpB3pay1DK
	 LFMw4yDYRpeK/Cy2PQklEtfI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14E8540E0198;
	Tue,  3 Sep 2024 16:54:12 +0000 (UTC)
Date: Tue, 3 Sep 2024 18:54:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
	dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
Message-ID: <20240903165406.GBZtc_LmcBbsGql9Dj@fat_crate.local>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
 <87475131-856C-44DC-A27A-84648294F094@alien8.de>
 <ZtCKqD_gc6wnqu-P@google.com>
 <155cb321-a169-4a56-b0ac-940676c1e9ee@amd.com>
 <26da9c1f-3cb6-45a5-b4df-1e4838057ea4@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26da9c1f-3cb6-45a5-b4df-1e4838057ea4@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_095448_841054_44B7A352 
X-CRM114-Status: UNSURE (   7.29  )
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

On Fri, Aug 30, 2024 at 04:08:35PM -0500, Kalra, Ashish wrote:
> Are you convinced with Sean's feedback here that this is a required feature to fix ?

Yes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
