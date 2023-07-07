Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A7EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QnT2Phvjen92oKmidokhH3LP7cToFYn/KLNtd6cFxM=; b=HkmXUFMPlwnDBI
	lmqpkOyux8ik/EMhMxw4GDtwmCz8sChz7UxwqGs28et1UzcvilW8qFjl0iGaZqViXmiDY2gqGcH1E
	FWykZza9ifvkeFxz8+EExQ2zsizasz47BU7+kCyqDR35TenaE0Ks8o0/d56YkR1SdQnoftCSzTb7i
	ZiBSxUonTCH05iNqGH3hFFQWIkzSNzStD//M3bduyAi3ZIxWL+s+1WV+6NB7XPWON2hO+hWhkhVIj
	mnDzHuNNmTWIU3M8u19Os/xYw31igCgyYTV9ix4e/wXNVuIbGS6jQS2T9Z33JjTnEAt19l4GB74V9
	RvfZU1oz4/doAV02JXHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHhHc-0044An-2V;
	Fri, 07 Jul 2023 08:57:44 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHhHY-00448W-2k
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 08:57:42 +0000
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0DE81EC0398;
	Fri,  7 Jul 2023 10:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1688720254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=GbkfdLxp9rbQ7AZmN6x307z1tOVXWnNsYY4HWTwrins=;
	b=bTkZdCbdw2GZhc2GvXaNOtj9+aqKb+BrFtxh5mguwFfQVyldtHs3xPkfXBXEyPWnPMsBBz
	krJh3j19J4FhWVWTC/78jcP6RZEFmFxZDzbAUe2EPooxvvPighLbwwc/ZwfNpG6c/SzV34
	k0S3pzuXoHUiaU9n50wJcNBr3Faijfw=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aOrEHwDTfLF3; Fri,  7 Jul 2023 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1688720252; bh=GbkfdLxp9rbQ7AZmN6x307z1tOVXWnNsYY4HWTwrins=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Btv9s/ge/XigqKznJFeyxJDvvCxC4amkdlU18+hJG8mAULOQBZOSRqivw1XrmKyrb
	 ZIK5fB1JTWJa6Wq/T2GAMA/yPNoitAo2hmTRqYBfJ9iuQlGxWSBgtmDbsWVGVI7jEh
	 NlSHetQxvPGZIhv6TWQ2LsyTkrASV9rgvAel4SukBGn+MVu0jBYxzl5o4cfPz58EfE
	 /coHNKiPukC3mVE1VpLL1hKBBg4sblcXPOel7s1eu6NMpfvFcuC9V0JB/YweRQmLLw
	 mgQgkbFV0qk62n2JCbxDLNnRndFm+D3eGh/QCJmml57u1mH7WVqR+1qbYBXEtlAFVW
	 CV3kodEru/Pp0091eSlbo2oM4x5zmB2tvBjc6IihDnN+kuopSgQtaGVIfhdBG1RKle
	 IKUL2cVH9Qjxbxhr+BoRKpfuad5wnKbckpQWIEvaPNf/BO7hyjVg6iE0BKKNQhH9i8
	 FN1sVkoxdHHBAVXiJ/rP9QSYho7PXaV4HIry4epe3aPtnm75WRTf7dIPVd49TfM5oN
	 Ga/dbgdFNlsmbveHNVbV2HLKsbuqvicDbjPZR6GRcOKNwn7VcYl6AWyRwLwKqKcZsx
	 YptrBQUkg4V15kl89VPwKWSgbz589YddKW4e618ehFKgHNWUTKyc2rQbFKZbvmeTPo
	 2BJwfVNXl0MPqeec3SK4laeY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 109AC40E0187;
	Fri,  7 Jul 2023 08:57:17 +0000 (UTC)
Date: Fri, 7 Jul 2023 10:57:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <jroedel@suse.de>, michael.roth@amd.com
Cc: Baoquan He <bhe@redhat.com>, Tao Liu <ltao@redhat.com>,
	thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ardb@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKfLYG_4DANc_i5r@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_015741_068441_D3E92298 
X-CRM114-Status: GOOD (  14.76  )
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

On Fri, Jul 07, 2023 at 10:22:56AM +0200, Joerg Roedel wrote:
> On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> > I am wondering why we don't detect the cpu type and return early inside
> > sev_enable() if it's Intel cpu.
> > 
> > We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> > executed or not because we usually enable them all in distros.
> 
> Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> bit should already be set in sev_status. Maybe use that to detect
> whether SEV is enabled and bail out early?

There was something about getting the CPUID page on SNP *before*
actually calling CPUID but this is not the first time we had trouble in
this area. This needs to be done differently.

Michael?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
