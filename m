Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1056C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 06:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZwarcPKPTkjljrDo42N+w74VxiYFqGDfjaPe/w3i4JY=; b=P3ncsDv9TGfw6jKP/loepts1HV
	mckVp+OLkNNSK3KINOCOD5UqhaTfw+c/YBV3+Pxyztdkm8x5QMlH/0Le4AOA+COBMCO1+L805KuRw
	135p43wa89Nr8UVBi3h15KstnNtm5mZNfn+TphzkwTG4WTp8T4UlOfyy0G3If2rrQ4Yar+orQdwnV
	9tbIeADZalTB6PvyS2F+ZHyXCBCjBa7SB4N1QYBGLmN/LLBT0C3OB8PBLoze+ANi/TylXjF1B+kkQ
	Usqi8IOD7rYufAAgEsMfImUZynzWfW6VCfQid9fyW55eU4G+BZ3aincuoia/PoVHxH31jzLTjK2Ad
	qwYjtLjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXFB-000000068ym-3Fey;
	Fri, 03 Jul 2026 06:19:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXFA-000000068yf-2uQQ
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 06:19:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DDDF601FA;
	Fri,  3 Jul 2026 06:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826531F000E9;
	Fri,  3 Jul 2026 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059559;
	bh=ZwarcPKPTkjljrDo42N+w74VxiYFqGDfjaPe/w3i4JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hspcQVPKCeLKZ/8DIJFTQdXNhZ0f5Ljo988vqBA0ZEquyjFCZPh+yFajd0Sw8+zdd
	 2ipbSbntsGT5RI0QFuLKarJ0rrk5O+QNmTH6wMflatQVgJBL2wGrJVs2minZv62wIH
	 E2G8RITiEuKbatMFvyjX8hHeAfTrvEZmYAzaybsN8A1oi7hph56LyolY9pojr9qjoF
	 XiSme+LmTqYweoLbEH7IvgGGDYJuAULMrtw2Xax9z9jSdzmHdn4z/Nh+7IxBbwA4gH
	 FVQxMsULsbxRMaqJJjNIMDpcSAwqWRnHH/mlxUCeRBjIwEN8ERQxQs3wfRz4/qy1v6
	 qYC7bMC+oaMog==
Date: Fri, 3 Jul 2026 09:19:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pratyush Yadav <pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <akdUX4vUEEJWrlGO@kernel.org>
References: <20260701151536.3068791-1-pratyush@kernel.org>
 <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
 <aka8f1RNJH-zI7Kl@kernel.org>
 <20260703001128.GBakb-MO4o6AUffNAx@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703001128.GBakb-MO4o6AUffNAx@fat_crate.local>
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

On Thu, Jul 02, 2026 at 05:11:28PM -0700, Borislav Petkov wrote:
> On Thu, Jul 02, 2026 at 10:31:11PM +0300, Mike Rapoport wrote:
> > The examples there are really x86 specific.
> > KHO needs decompressor to recognise 'struct kho_scratch' that's defined in
> > include/linux/kexec_handover.h
> 
> That struct is huuuge :-P
> 
> struct kho_scratch {
>         phys_addr_t addr;
>         phys_addr_t size;
> };
 
The size does not matter ;-P

> > I see there's a duplicated 'struct efi_unaccepted_memory' for decompressor
> > needs, should KHO do the same for 'struct kho_scratch'?
> 
> You could. But it would go out of sync perhaps.
> 
> You could also try a 
> 
> include/asm-generic/kho.h
> 
> and put only really generic, basic gunk there and include it everywhere.

asm-generic would be my preference too if that's fine to include in
decompressor.

-- 
Sincerely yours,
Mike.

