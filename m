Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0701C001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PZdS1KE0F4uiyHFs1fH22H4n5JThmiURjDftaClGpkI=; b=QUWkvdY/gJ57LU
	M4SrbJiF2bGSaM3zmqDRzmRK5xtUGBOyr1tp4fSeaKafSLV1S6HXTAM77A5z72XbHBczeU1nrHHUs
	i37bUzB6EgWvdARIUgmdpgoPdU1ywb+uSH0g9nAhzrPu62L85zwQ8iNLg+qkiI7rY7HE3aCpbKApC
	8mPYb/7xUPEv3KDYOA/Iu3Tit+wI6lPnpYCPTDVGzPDTB2N06YQHa++7T4qCPH6jHw27hRwZik7R5
	xNAegyz1fS7TPluT0rKRZbSoe/SvbUs2Qov/79FPFIFvTYQ3Xr8VG6MQ8JGNHDtOkK3SVM1eaDVM2
	mM8OlEXn2xeCGVvQJl2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRCO0-0052a4-2s;
	Wed, 02 Aug 2023 13:59:36 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRCNx-0052X1-0y
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 13:59:35 +0000
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D4711EC00F8;
	Wed,  2 Aug 2023 15:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1690984758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=QOfMj0yRD5e1Y7ZVsdyLC7SaQJiL2vnicxgkKfeEGcQ=;
	b=CZ4qmkgRU9PIcQ/ZHTBvKpUITHvq9JLZlUXNpJ77g0HP2KcNvFSAQogIGCmbfIa87ckwRl
	dbGLvvn5G4buwri1WDHhX1UoMeTNn626H+mR3exJU2Mnn1DmT/QY9R8YwIjnr8RfBXHc4E
	A0x6kBqAs5pVZZcIrnH5BpuBzNPDBX0=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VfcAOxr6NmCU; Wed,  2 Aug 2023 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1690984755; bh=QOfMj0yRD5e1Y7ZVsdyLC7SaQJiL2vnicxgkKfeEGcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkvRJ2vbdyXkzctAg2muud/4V82jYKu05V31/emaUcJHnutqPYhNBIBnBZW3dJU/D
	 bPH04+DeWXZ6PWwop0MwFMl+gUYDUOEfA7GlcmAWvpqqOi8yKykEDgVnBl+gOl3G28
	 B0Ko7Wg/H0L/54XMBXt+0UuDWGRR8OBRz+vwOOoPAlOG6gUrXX9/hRemT7fX5hXzpW
	 AhhGtQdTXToPEJc5LL9Br4YBLmN0oPsmU7EEgQBr+nQj1wzdR3tr27xtDUAtkU2NmU
	 ks5TzoifyTSrgzzU0Q6Sb53hIrn7i0kuBZPWWDRa6l65Bsinobp0YNfNvxvr41eMER
	 MHKStL8GhuJzpOMpnxsTy5QlDj9sqa1a/KbgSH8VSaQs72WPTAGyxHm2o+eJO/3mkJ
	 8H8ZXUYpiLxYz7Vgwp2UdCiTwvkROLZw1XrejBizpVjSc6KxSKQ6RuDBVZWVFVmevL
	 DNZcQj4Jps0u0cc4E9WP7fZe0pA8KQMx8MCY8F8k4R0E3PBpJ1K+WHIyBhcNn+h39U
	 VqsdRdu0XVbD0eRvGRG/WB7v3GLkAkYsgIKnmSX3pvPPBtMIlMp3Fr0Lv8RO/Csv+0
	 vjR9ftMwi5lHmlH5CbtV8gpmMgx3qnKGFQJ5fXUwKraef1yKsourdr5T7ZBHtySydJ
	 54sKXze/yrrfurrD0CORuS54=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D58640E01FF;
	Wed,  2 Aug 2023 13:59:01 +0000 (UTC)
Date: Wed, 2 Aug 2023 15:58:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_065933_510422_B21FFE89 
X-CRM114-Status: UNSURE (   7.44  )
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

On Wed, Aug 02, 2023 at 08:40:36AM -0500, Tom Lendacky wrote:
> Short of figuring out how to map page accesses earlier through the
> boot_page_fault IDT routine

And you want to do that because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
