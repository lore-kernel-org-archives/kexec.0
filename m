Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731A2C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qxnqtsbnb67GmVI3pnWsHJ8/pqMUDRPwhFDvRvJ+Knk=; b=pqoOYJB1QyohL7
	oqmr5TUxGOyoYFbvvvWSh3Uqj/KRi2ZAbodvfQgQ2extrPQClb/KhFp8Ln1lL2y+68NFah01cNy++
	iPHoHuvRLwFaEccgHbHlKWcV4V8BpabDCcyYComC76UASM5/dtP9t2Z65aw/OdELuYRjM7iqVHww6
	DewQxpp3z3wLwPmf5d00t6WZoLHcKx3wdzQ5t8ZfxbQ9BPoHxFwbID27VQtlD63N5SnMPUBKFX+/s
	3iH6/cIaRdnO3M2/8gWywGW2SY8ZBQiSXAlbVr61Xk0p1/3a7MGlihZv6KQifsTgpTrLC6tNV2JQx
	jJZkm+4YMjF2rmNZoilw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQib-00000001uYI-3Va4;
	Tue, 04 Jun 2024 09:44:37 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQiY-00000001uWv-1vnE
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 09:44:36 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F31340E0176;
	Tue,  4 Jun 2024 09:44:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ddGCUwBu8TqP; Tue,  4 Jun 2024 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717494268; bh=pIg8xe1Ns+NA9fRhRn6k+zXFxaT3zBumGkXlIKY3LLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCoQSeVmBvXsN7Oj0IZ5XqLQmBMN11lhRhATE9jviznkzRP14Kd1hs2txtmf/4AyA
	 NCoDRxW0dgZwzakME8kA22PFD11iKTHm1yH4qH9E3hDGtrHRhJqlM1PmcaZcprC4KW
	 e5OTw9UJKJkmDY5F0H+PE/CzHSDNp8m8RYHSi9LPyrjTjD6IgtSp5tMQyobcusGgqc
	 qUyqYePgUtnHjDvNJagEur+WkeCVwX/b89H0Xpd9KZRx8lijyEtJQkgyQ0IYgktEYS
	 j3+lHQWXPR/gTsk3RJoXDsBnvtvvvaIMhrIIJtcQXc8gf6DrKtxY/Pr4TDeeq2QHLI
	 1DRED/m7UZUl8Nn4fPVzUOSNXBJsEhYlgp283ONUaF/DqdgwWwltjQ3YruAc0VBT3J
	 wcYgBbCmGHIMtzuBjgc/HdstEAS2je3fzhpv7TOym7iCDK93/OhdH7HrjBJrJ8EOb/
	 GxuRi2I37L2ARt3sD6T3k6rTayOZbw2oiWO04QcFaM+qKTPdwnMu8RtwTbVgxviMld
	 9HqDFPCq1OgIdfv5c/BRJkmvRH4j/lHQK1XOX4Nnz5lO78PcNDr39UtwyCAvlukc0P
	 0bbLlpzaBsgyS3EiwLUvyyEoX1TripsM1hYTynMQyw2RbG5oFFT2tj90oSN5x8K70V
	 MCD8Cow+w/9EbV9SbZ8oFHkU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7573640E016A;
	Tue,  4 Jun 2024 09:43:59 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:43:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_024434_677748_F629A7F0 
X-CRM114-Status: UNSURE (   8.71  )
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

On Tue, Jun 04, 2024 at 09:23:58AM +0800, Dave Young wrote:
> kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
> But eif_mem_reserve is only called during the boot time so checking
> kexec_in_progress is meaningless here.
> current_kernel_is_booted_via_kexec != is_rebooting_with_kexec

That's exactly what I wanna check: whether this is a kexec-ed kernel. Or
is there a better helper for that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
