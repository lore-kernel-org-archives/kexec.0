Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED416C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Djs5/cNfeokHacl9lhYShfIG8fxSHbDbegcp+pIFTAo=; b=HVdB9H+Zo2Tc3I
	BuIBE+f7gnWYqvdV/TEkaA7k7WOn2c7B80AopQviBRdvoDQlfhGMoY9Jdt0/+l0xKtRP5M0rkYpBt
	6BskuMjG/NqCyHgyiGkfsv5MYBN8AzIMYMwdOTebh6eEcze8xNA+8ot1iiHA+gZgKQhgOHdrxLJsN
	//e0kiTe1zDavJ9blsnhhnP25iQfyTD8oS+c0H0nTJenu8IXTOUG7cIphuNo5NSoFnH5mRI8ghAPf
	sIlPdW2LlgFOFtv+tnmwYEzLPdTA3llx1RwMYOCfy4BYFGP7qRQnvR9rXp6Sgj/KcOUPB76u874rs
	9ZSzXmw1Zr3EgLnRAs1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NbQ-0000000D4w9-1nb5;
	Fri, 26 Apr 2024 15:35:08 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NbN-0000000D4uo-0kmy
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 15:35:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EA7340E0187;
	Fri, 26 Apr 2024 15:35:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y0I0XX85N4vT; Fri, 26 Apr 2024 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714145697; bh=075frEUodZiVoP0luxda7AkjREYnqrV4QquOdVqaK9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaOCu6wW5+hAYb3VNxSHy0uXO0ug44b8nFbNgfqBeVqUijxNlL60tiulCQhQ656EH
	 +umGjHofXzVh9uqFUZhD8PV5KIZLQEZdSIfk0ABlNgJV/I8aigPSmigofDXETJF7lR
	 gYJOAGfZvcVigL0+apZahn53U3qcsU4j3Q0dIlTmw6SWu5+qq7Dc2QO8XMK9GEwPkQ
	 6BuRFvp0ky49u3y8S+/hVZKpwt60VjVO4ItNVpigpgp6GXaB3yWIazHmBazSIiYojy
	 FEKirILHy8PfHuIMrPLaAFP4gCnkDWTg6qpoTp8JUFCHWPpHa0BdAizh38aCSDW4rF
	 RjOSv1IjkuTYwJPqRlfnRJZxAMwYIGyf3CIYQW2DoH+maegwnGFg0v8doQXMKNu2lp
	 Q/CqXV0jN4JhWy40bAbgTb57rBj2sX1Gr6PAGdWcXZZeqGdcXk59vMC3Ef1RpIOho0
	 bEgJMA51lZQ3ln3OZBPVDAfV2+uby+yZmg6BHa2Au918k47eN2Yab2M9tNAslboo4C
	 kyfv0NfZf3zAGIS3/FSRmx1RJDQnmHnu+xoifiFsEB1zmXZuRZX2U+C0Xve+j9Y82d
	 NxF171TyeoAevmpen5YUYcVil+u1PCg9LFR32ozcOZ6LmsOygjeYnkWjxgG28W7n1+
	 hGMVkDXmNpz3ysHRMTFacLj4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B01540E0177;
	Fri, 26 Apr 2024 15:34:31 +0000 (UTC)
Date: Fri, 26 Apr 2024 17:34:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426153425.GGZivJgbBxzo30ja8V@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
 <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
 <debd333e-6897-476a-97fc-02246e97a24c@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <debd333e-6897-476a-97fc-02246e97a24c@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_083505_490800_84FB5E49 
X-CRM114-Status: UNSURE (   8.40  )
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

On Fri, Apr 26, 2024 at 10:28:41AM -0500, Kalra, Ashish wrote:
> "Chained guest kexec" is when we are in a guest and kexec-ing into a new
> kernel and then this kernel kexecs into another and so on ...

Make sure to explain your terminology:

$ git grep -rE "chained.*kexec"
$

and there's nothing "chained" about it - you're simply kexec-ing in
a loop.

Please don't make it sound more complicated than it is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
