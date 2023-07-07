Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A60EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B1RvJElMfwom+qNyS7p5O4qdsMuLB7f5yPFXq5JSwBI=; b=ERDauGWROBiPRc
	mtM8ySFnQ6rCwPfYqjLXFqWwQYiAi+6xNTNoociRVTj+wKfqsh5Nf3C58TKzlNvTcAr9b+Y/qteh8
	ycZsgOlFCfMRoUneC3uyLCIu1ruT4eaqhLt/8ICWPDdKLddraKh9cSw4cfNW1YVNzs6rNtg6TpRzy
	EyxdGp4+GF/jqNcDVvxDvji5cSJ0Cqa9H/4Tro0TJO7ndglNEoyovWuPqb5g6FHane5BFIXkXik0A
	CXgGIbbTtVpAxZwXuspbLVu6Nd6A7exSeM+UujvQi5hTACoWySYHhKnkmInqxlO/b/r/VPWbm5SD6
	WVdEO9UvwCyB4ehEW4dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHp0g-005HaZ-1A;
	Fri, 07 Jul 2023 17:12:46 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHp0c-005HZk-2q
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 17:12:44 +0000
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2CAD1EC0398;
	Fri,  7 Jul 2023 19:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1688749959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=6OzTAM5FK7zuWehbwIgNlYhTn7gz7QucEzqfEJ1uQTI=;
	b=Ofn5vYHULl96suxbDMl8V3puQxjmh25Tno5YjGIbEsBkrPiFJOa5NlyzTLaPt/R+MIeZUF
	Uizt9oJ9o7OW5R7R0wiP5jGIcMGUQymN8GRm9OGilHmdIYUahjq81dg90dw0ypAi4zDjKX
	MzwRASzQ5bETaid2gx4d3LR0NYyAHck=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k6gAkJSP5-z2; Fri,  7 Jul 2023 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1688749957; bh=6OzTAM5FK7zuWehbwIgNlYhTn7gz7QucEzqfEJ1uQTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDJmOTTLG3llFmdDaKnj+N0q1BVcJThGqAiKNp1ZUHH+UiMBMRE9/QEtwiG/3cfZa
	 6rTjON9AFVVjHpGKcTOar3LrWQr0lV8K/BgOUzXLMHwOiR0/Yjk1jJq7dbJuekJCZZ
	 X1L1rEMgfxlKC1xabfQg0YhvZXBAy4/oGeDF5opiQWZitjBa/mM1tWJQx2zQtPs0mE
	 Slke0oVL8p5vYisoWC64IVbAy6pQR3qyMtzzqu705q4V4TaeXMJFcqZWEzLsLtSqKG
	 vaIcWmD9wbRSP69U8m6r+t9uVZYxZr+bLuK0UJg52fwTrY3DIdcLtZ5PGFbb+QM3QJ
	 ogtoWsUN71NuW3F1148tAjUqcyrk+mxw/qakHSeAu1/Qjg00Lo9qvzvGV8cZ3hlncG
	 WcCi5e4Zqqch83l9g15JQ47DLEcuzjVt2Re6m8TlSmf0jRO/tVJuxy28y1UkjmI8Gz
	 1cMm4q/vM3OOmdd/1RnoZcsln5QfAzBlHBYq8UKcev62KeIra9IrhsnYh3c7kTccoR
	 6g7bNed2WfC0zbQsMSBCUBzH5xpzsES6JeHUXfHFgK/v3JyuB7rt5mLVkBpm+bwgcz
	 e9yOY7qHCeETWZv6Yp/CuCVbtVWJVLhaAeysDmoY5OLOgEoPJPwT3cv6Kzl0shauJ7
	 rD30uRnap9KWpwAVvKoxo2ec=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CECA740E0140;
	Fri,  7 Jul 2023 17:12:21 +0000 (UTC)
Date: Fri, 7 Jul 2023 19:12:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Roth <michael.roth@amd.com>
Cc: Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
	Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
 <20230707152515.42gpfzjgvfwe6rf7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230707152515.42gpfzjgvfwe6rf7@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_101243_078992_06BB3899 
X-CRM114-Status: GOOD (  17.04  )
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

On Fri, Jul 07, 2023 at 10:25:15AM -0500, Michael Roth wrote:
> ...
> It would be unfortunate if we finally abandoned this path because of the
> issue being hit here though. I think the patch posted here is the proper
> resolution to the issue being hit, and I'm hoping at this point we've
> identified all the similar cases where EFI/setup_data-related structures
> were missing explicit mappings. But if we still think it's too much of a
> liability to access the EFI config table outside of SEV-enabled guests,
> then I can work on re-implementing things based on the above logic.

Replying here to Tom's note too...

So, I like the idea of rechecking CPUID. Yes, let's do the sev_status
check. As a result, we either fail the guest - no problem - or we boot
and we recheck. Thus, we don't run AMD code on !AMD machines, if the HV
is not a lying bastard.

Now, if we've gotten a valid setup_data SETUP_EFI entry with a valid
pointer to an EFI config table, then that should happen in the generic
path - initialize_identity_maps(), for example - like you've done in
b57feed2cc26 - not in the kexec code because kexec *happens* to need it.

We want to access the EFI config table? Sure, by all means, but make
that generic for all code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
