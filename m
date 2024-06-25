Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4A5C2BBCA
	for <kexec@archiver.kernel.org>; Tue, 25 Jun 2024 03:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HYlUF8CLNGTs7Q2gWVnX55oGkDTpk9LJIaGHm1mbVXo=; b=1PvJLDgy5B7avw
	UY7Q+kMDblknWlFslnbQgjJsczH/pPE7vQVWiOC17nbfapAh2NRwk/FTrxQiCAlvQ/vYalHLhJe52
	Pq0c41fJo5fwfAlZKD5STG/hQG8rVx8SnLxetSvGnhFdMAxXo+VF29SRiZ9XRlAeZQyggygjucHPT
	AnQ/invowSuen4y7ruIfy/2lYzFuodXKknwJflWXaWhmbo7Ve96SU/kulMe0TDoNe6fQIzfDPv9e3
	rpNpknvAknPdDm4jNWVEBoJn3cDVCjO7qfp/91ZD9tpDI16NxC/FRfYn52Ji5MprP+SE1bzRBfozM
	IPfDbBvPSfCoRecQdbfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLxLX-00000001W9T-0Qf3;
	Tue, 25 Jun 2024 03:59:55 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLxLU-00000001W8i-0E7k
	for kexec@lists.infradead.org;
	Tue, 25 Jun 2024 03:59:53 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0483B40E01D6;
	Tue, 25 Jun 2024 03:59:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p0aPhogJeEvc; Tue, 25 Jun 2024 03:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719287984; bh=NGE6k15yt/YA8tmLnFsWy2oVKXGugkiZpFZ4hOjBhFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWAYvYSJCvfHC46BI2hkwsEjZq3z789TA2evpZDUfGXa65tv7iupqtNf4VUf3BqQc
	 uBE5agD/82Ur/2oxWJ8yZj8c0V0bFy75jiCi2PSgR5OXxUccZA95vNL95wWTnXk+iE
	 e8gWScrjP3rXWYxjeVEloxNY3h/5P52eV2P0sAy8XO5ZrQ+A8TVVBa+w9EmsExt3oC
	 rI0JQ71Yn+UrN/7BZaUPx4mD6eEU9R7UhlO3xUrXrqupxz8iHDiD/wpojeGkHbQwiu
	 PBVRCz0z5Yo49w3rfAVLbqrVQcWa6bG+qq6G86D/jLoIgYlz3JAE5IDgsdlpYt/wrq
	 LVm2nxeb8TQeDEWjZJxfeObm8GYD1E3GrTpIbHvGURhPC0nf4q8mnRi56nc/Dlx4+Z
	 iHKnu2jSPHk0V3+GORAwR9uDDV0FINuMTTb4weEhulLPAv68ai9bDhFa5B0h0Legnd
	 SxQxPVQMG9asYIFzrG3/RFDDdn58RJ3iFBFLie+3OJB+v0BVYldz9o8jkirAnnvcNc
	 DMZv/dQ/kf3vNP52VOMA6mtU1jw3EW1FcfgdvIa2R5UJQSPYxnur1WGXJuvOagCaJS
	 OfWZs5R100mk/He9WnH8JE09B4Z5zqyxNxlNmrVvGMQfO3PnM08tknTKo+LsfInlRJ
	 2EKIhUfLKCO3JwKvMtS/YUNQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC3E40E0177;
	Tue, 25 Jun 2024 03:59:16 +0000 (UTC)
Date: Tue, 25 Jun 2024 05:59:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <20240625035909.GAZnpAjaV72A50kcWs@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
 <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_205952_377784_6235D83B 
X-CRM114-Status: UNSURE (   8.31  )
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

On Mon, Jun 24, 2024 at 03:57:34PM -0500, Kalra, Ashish wrote:
> ...  Hence, added simple static functions make_pte_private() and
> set_pte_enc() to make use of the more optimized snp_set_memory_private() to
> use the GHCB instead of the MSR protocol. Additionally, make_pte_private()
> adds check for GHCB addresses during unshare_all_memory() loop.

IOW, what you're saying is: "Boris, what you're asking can't be done."

Well, what *you're* asking - for me to maintain crap - can't be done either.
So this will stay where it is.

Unless you make a genuine effort and refactor the code...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
