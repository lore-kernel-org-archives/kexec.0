Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70718C369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gj+lzkgRPCCF6n+yScpRzmM61Ws09xV++STXBmF59Ko=; b=GDOBU2G59+GF5wxqmaqjCmZqmr
	NTTUsK5zAxqeKj6sk/KUYIXkJ9KbR4cIuapqrR6sL5Kka9a6tCrwXYtFIL/2TLUfPVy5d+bjOaiBU
	xSxY8Ovk0Iv09rkt7o3nWIIkpPFKWhTiXBr5YfOC5KpJPqq9U1XosxsrFeo/vyvoUGsfgAsqwpeSc
	vj9yY1UOe9MoT91lkNs6n8MO1CLZHmZBCbG0VytHFfYNqIf9vBXMTznd8uUUaag7lG8oj6zPIaD6y
	UBg774fWcoeoJut1h7himcGK2w/8UtSMMiuWMDXCselriZUOcr5TNZTOYcsme24tXmTOfxM13eiW+
	FZljTmBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nvA-0000000AGpZ-44no;
	Tue, 29 Apr 2025 16:35:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nt3-0000000AGR7-2M9q;
	Tue, 29 Apr 2025 16:32:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 86F795C1046;
	Tue, 29 Apr 2025 16:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54235C4CEE3;
	Tue, 29 Apr 2025 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745944368;
	bh=feUIYWjgsatR0wsDBnR320zo35FzttrKF/ike0EndGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGIHmtRoeMc5skK+Uret9+sNF7RFNy3BEWPrbyWSDJ+5SRrf7mtw1bAaMaUc6Xpj8
	 cYPvdk+7/ciq2q8+VgFYyN7TT6ImhpLntVfyBRLNgAZjSDnD9Id6MvYJbX/7QMkwCm
	 OActXunbzjeRJyiT8rrBVDY9bRcxWjIjlkS79dq1HDDVQSGzoyxM2WU1eGEaBF3nEo
	 Ov0OcO8fHJCJgb5p86Z9lkWvoV9LqaeYYsDCuW1pKfMqxL2G7G7BdHP0mkU+FKXbR4
	 cOVOWOMT+9kujdP/3J71kDyjtlIDIzSdgSPSHd7D6d+NXNL58zUquXaMgCAakyuoel
	 J6QVYo/6Endyw==
Date: Tue, 29 Apr 2025 19:32:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 11/14] x86: add KHO support
Message-ID: <aBD_IUE6xmbphB5R@kernel.org>
References: <20250411053745.1817356-1-changyuanl@google.com>
 <20250411053745.1817356-12-changyuanl@google.com>
 <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
 <aBCIhQjKKyaAuvC9@kernel.org>
 <d64a4593-c9bd-42c7-81f6-137a22ff5caa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64a4593-c9bd-42c7-81f6-137a22ff5caa@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_093249_701164_ACAD5E63 
X-CRM114-Status: GOOD (  22.30  )
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

On Tue, Apr 29, 2025 at 09:06:19AM -0700, Dave Hansen wrote:
> On 4/29/25 01:06, Mike Rapoport wrote:
> > On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
> >> On 4/10/25 22:37, Changyuan Lyu wrote:
> >>> From: Alexander Graf <graf@amazon.com>
> >>>
> >>> @@ -1300,6 +1300,24 @@ void __init e820__memblock_setup(void)
> >>>  		memblock_add(entry->addr, entry->size);
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * At this point with KHO we only allocate from scratch memory.
> >>> +	 * At the same time, we configure memblock to only allow
> >>> +	 * allocations from memory below ISA_END_ADDRESS which is not
> >>> +	 * a natural scratch region, because Linux ignores memory below
> >>> +	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
> >>> +	 * allocations, we must allocate real-mode trapoline below
> >>
> >> 						trampoline ^
> >>
> >>> +	 * ISA_END_ADDRESS.
> >>> +	 *
> >>> +	 * To make sure that we can actually perform allocations during
> >>> +	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
> >>> +	 * so we can allocate from there in a scratch-only world.
> >>> +	 *
> >>> +	 * After real mode trampoline is allocated, we clear scratch
> >>> +	 * marking from the memory below ISA_END_ADDRESS
> >>> +	 */
> >>> +	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
> >>
> >> This isn't making a whole ton of sense to me.
> >>
> >> Is this *only* to facilitate possible users that need <ISA_END_ADDRESS
> >> allocations? If so, please say that.
> >>
> >> I _think_ this is trying to say that KHO kernels are special and are
> >> trying to only allocate from scratch areas. But <ISA_END_ADDRESS
> >> allocations are both necessary and not marked by KHO _as_ a scratch area
> >> which causes a problem.
> > 
> > Yes :)
> 
> So, on both of these, could the submitters please add or revise the
> comments to make it more clear?

Is this one clearer?

	/*
	 * At this point memblock is only allowed to allocate from memory
	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
	 * up in init_mem_mapping().
	 *
	 * KHO kernels are special and use only scratch memory for memblock
	 * allocations, but memory below 1M is ignored by kernel after early
	 * boot and cannot be naturally marked as scratch.
	 *
	 * To allow allocation of the real-mode trampoline and a few (if any)
	 * other very early allocations from below 1M forcibly mark the memory
	 * below 1M as scratch.
	 *
	 * After real mode trampoline is allocated, we clear that scratch
	 * marking.
	 */
	memblock_mark_kho_scratch(0, SZ_1M);

-- 
Sincerely yours,
Mike.

