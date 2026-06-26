Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1987CC43458
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tG9B+nb6q7AJXdqBeEZmjPB+auopz/lufEKOo/Tem/E=; b=X03Pjt+KNGDOfkqj29iHFTP8pJ
	f+hilgzVV1t69YNpHlyRmmE/SYHw6wStiRDJ3xLqrOgxh88qsDa7fZKP41TQ23Ww0Ldvwce/pgc1n
	WnKp5i6xWHEZQKzuMkwfoYQ/l6wxMhpsGlbb4bSSILD9eQQiM7aXxod4B/pC8/yBnTDxUs8LE/6au
	HLzvNLyHe1PbErV42HFeSf3D5DLWfpDzPIgu7oMZRkdvFIWyabdjnMsKNQWQNzGKU3Thamgygvibh
	67QyVbyD1UF+yPqdnt8TQbGSciD6M8qtKdjmmCkyNlExNm8HbdDA/xHlXKZ26EJyqSfurfE6N7rHU
	cesz3wJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdA5b-0000000BgYT-2N6Y;
	Fri, 26 Jun 2026 17:11:39 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdA5Y-0000000BgXy-1MKC;
	Fri, 26 Jun 2026 17:11:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEAA1F60;
	Fri, 26 Jun 2026 10:11:30 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA563F632;
	Fri, 26 Jun 2026 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782493894; bh=2Utd0N86MYNjJo+OrS+WeKcY0n7FZPkf9EAQgABOrpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWabBNRIZ+FuDwevXn80U/01DGm1UIj9+lSegSodD3K4KHVC5SqDQuvu1fCVjKaNq
	 tYVHSozu47HG5f0KDSGbuppXwpLz97F0fMxy9j6Tc/eZzmaw0vCN3TUPdT3W0MowWD
	 wxjnNqas9sm94L4ui9R6FbMysK3ZODCWqtouZ+Ho=
Date: Fri, 26 Jun 2026 18:11:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v4 3/4] drivers/firmware: add SDEI cross-CPU NMI service
 for arm64
Message-ID: <aj6ywfhRtYn4kaWc@arm.com>
References: <cover.1781709543.git.kas@kernel.org>
 <cover.1781709543.git.kas@kernel.org>
 <ab745689c0bfd01438d98ed1c79328bf2121be3b.1781709543.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab745689c0bfd01438d98ed1c79328bf2121be3b.1781709543.git.kas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_101136_423223_7B5A8AEC 
X-CRM114-Status: GOOD (  10.66  )
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

On Wed, Jun 17, 2026 at 08:20:04PM +0100, Kiryl Shutsemau wrote:
> +/*
> + * Raise callback for nmi_trigger_cpumask_backtrace(): signal event 0
> + * at every CPU still pending in @mask. The framework excludes the local
> + * CPU from @mask before calling us.
> + */
> +static void sdei_nmi_raise_backtrace(cpumask_t *mask)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, mask)
> +		sdei_nmi_fire(cpu);
> +}

Does this need a barrier as in patch 4? Sashiko spotted that
backtrace_mask won't be visible without a dsb(ishst). Again, as per my
comment in patch 4, we get away with this because of the TF-A
implementation but that's not guaranteed (we could ask for the SDEI spec
to be updated assuming all firmware implementations do this).

-- 
Catalin

