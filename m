Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ED4C36000
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1f7vYLVQ4kLido9b67URFtXyj2TSNX9XgKK9/HjKEY=; b=aXqt+0P/oQoOdIwT/+kOG0PDZM
	asrzkAzUkCLdCGh+/WkuuFYYS4P+eU4/WA9orKvfKj6kGkfxlA+isTUOvkfFCdwg4RhhQ1rG3X/SE
	Pxxw+xh+xYdUxnVEhRFwI9toYo/O+nitwbscifHVQ3teSo5l6R0nwAuoN0M6FnNdeXIjUHp1l75iX
	KNyXLqZToUiQi4Eri5p5yHmXGe5PfyW/KYxLwIvHqv2gf64oPeFU2sP8vtkrMTJQsbKTdgK37eMDq
	KofinJk2tJhTTRMJqeKJTGIpYS3g2XpYNFEeG8uMAfn20i0XcnekL6VZrnYNKX4YfLMW/JV7obzJy
	0nDzHsIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBO2-0000000BY9u-0K31;
	Thu, 20 Mar 2025 08:36:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBIh-0000000BXHi-1u9T;
	Thu, 20 Mar 2025 08:30:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E4C9461579;
	Thu, 20 Mar 2025 08:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF6C4CEDD;
	Thu, 20 Mar 2025 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742459450;
	bh=v+FOAUR/wqoAqHaoplhVPRBHIikWSf8V1laXOuxnNfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEkJKg+eJogLP7TusVxf7b7P/d9nFvPAwJ5TKX+AvnXMsyoNB9Uf9tgOI6jR88QCM
	 JkYvO2jo5I7eAB1u9/xJZpDu+Oopr3mT2NVSZ/EvU3R7jh6dZlhAZ16GVDmlTvpffq
	 iiSDgZBbF1JkdErKodK9X7EiWFC3Yg13LAnitCwjXwRjzEy8zMTLp1Wq3sscrIIWeM
	 FgmpDRVRnJ37VPZfmcEgw3YliLJJdIJCmGuvzrskhLpVCAdq6HYTXmRZnTX/wOuHDY
	 YyGVPP0jB0PQbEJ3m2aeUQfqftuMQ8nfawOMqXiDaJiTxOpnJPFcSB1Wf3yRH0h/Eg
	 AMVe5byYQWq0Q==
Date: Thu, 20 Mar 2025 09:30:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, 
	bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com, 
	dwmw2@infradead.org, ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, 
	corbet@lwn.net, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, 
	robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 12/16] arm64: add KHO support
Message-ID: <20250320-muscular-cougar-of-apotheosis-e4c80b@krzk-bin>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-13-changyuanl@google.com>
 <55a5e3f3-1b3f-469b-bde0-69abfff826e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a5e3f3-1b3f-469b-bde0-69abfff826e4@kernel.org>
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

On Thu, Mar 20, 2025 at 08:13:24AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2025 02:55, Changyuan Lyu wrote:
> >  
> > +/**
> > + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> > + */
> > +static void __init early_init_dt_check_kho(void)
> > +{
> > +	unsigned long node = chosen_node_offset;
> > +	u64 kho_start, scratch_start, scratch_size;
> > +	const __be32 *p;
> > +	int l;
> > +
> > +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
> > +		return;
> > +
> > +	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
> 
> 
> You are adding undocumented ABI for OF properties. That's not what was
> explained last time.
> 
> NAK.

Also there are checkpatch warnings :/

Best regards,
Krzysztof


