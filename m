Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0862EC83F2D
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=egRU1RP+uwvtF8r2JIbytYbVGfNTTuAHz1L/kX5LYfg=; b=2+UH7b/wFpo39m
	jEvUebPZDNLvRegTSuYBXQQzzrlOP7x5iUpHG53yB0HBSNO1y5Wn1OLEuq5+MsxqxA5v63LECyNIv
	8m6QM8iwJMtWgM/NYiJ78zbqBR2ET4c1AHk+uk1tR2UYR/VvSjLte+LsIt2HDOi7oPv0iw4g6+5zV
	XMlPlnn/eLkKWO9lvsmgU3Rfqdw6IxYq7M/LhKgLVxIU55JCl/r5si/nRSc7GhHdmgLeNjRktTYDb
	sQ6Ons/yfAsBDxr8fNiqOfi+XbUa8SQPWG2LruURGhoUdj+1ksjvBsSQQaLG4i9Fk8lOgXBKPL/WL
	aCI1BSRHRJc2U7slntoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgKO-00000002Rwm-0pDa;
	Thu, 29 Aug 2024 14:40:48 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgK2-00000002RqE-2sLR
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 14:40:28 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 00B1E40E0263;
	Thu, 29 Aug 2024 14:40:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3hXt4QUD73xh; Thu, 29 Aug 2024 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724942419; bh=O+zT3c7g+nfKFQAW3i4+B/E3z+UfHpqlnaQDYR4t32M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrQt/TTKNoCpQHk2xRfjBqK9rKn51MYIr8I1+xIowVrI2boDzmwCkumG7l/zyqJ0e
	 ESMb6z6FFJgR4A16DFBZlVAYVtuwdC4g53+7h34kQb5uB1D6w+XGX3JIPYJYfmVCl1
	 RXh11BQqK6PhVrwwI+ZH/T3lWtAC8DhL44q+AOleZLvj/iqHZQrnMBd8QpTa+/J0sK
	 LlvEW/wE9pz5msT+IHcKGL5saORL9vmYl1E3sTjlF+dVvwuRlChi98R4J0E5VO7d3x
	 A4iQBwjJKrAIpJGiszhdX3V6AZPVxeIQx/Qmkn/kENjUoW326hCQ8skxev2AjefTpi
	 n9qoJOH38XejXTV2J1LzFAsgHgxJTsHEtyCxa/cV+ZbehQs5wD/K0G1ve11LG1ukbo
	 D7uBGiLnWJmRx1Y/JA/LxjNqE4Z+G8Zc87SySDJnZvMSx6wH95ErfS38+24Kfo0eak
	 oe0GSKGZ92BhtEqKwaGxW6r/qmFfDECa8p8N+JXFHyqNs7KqckhG3jHQV5od6WxgTN
	 LoMv42wtInDDhPjPxDJ2Xr/xgT4wK/GlLWcxnXJmS6uT5w3e9ybtPX7UJykwUruYsG
	 vrN2tprPA86Xy5HrRi8bUizUCN3ERroYvdKnQM6emkfOXQT4FJ/h1+80j7cX295Pou
	 uyWEpmimBIadQhdJdYaQ2MIg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64D8B40E0275;
	Thu, 29 Aug 2024 14:40:04 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:40:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
Message-ID: <20240829144003.GFZtCIQzK6SCrZsgyE@fat_crate.local>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
 <87475131-856C-44DC-A27A-84648294F094@alien8.de>
 <3f887fb7-e30e-41f4-8ac1-bd245e707ccc@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f887fb7-e30e-41f4-8ac1-bd245e707ccc@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_074026_900095_2884A7A8 
X-CRM114-Status: GOOD (  11.33  )
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

On Thu, Aug 29, 2024 at 09:30:54AM -0500, Kalra, Ashish wrote:
> Hello Boris,
> 
> On 8/29/2024 3:34 AM, Borislav Petkov wrote:
> > On August 27, 2024 10:38:04 PM GMT+02:00, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> >> From: Ashish Kalra <ashish.kalra@amd.com>
> >>
> >> With active SNP VMs, SNP_SHUTDOWN_EX invoked during panic notifiers causes
> >> crashkernel boot failure with the following signature:
> > Why would SNP_SHUTDOWN be allowed *at all* if there are active SNP guests and there's potential to lose guest data in the process?!
> 
> If SNP_SHUTDOWN is not done,

Read my question again pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
