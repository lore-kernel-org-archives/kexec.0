Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D006D0E6E8
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jINZJmyyWu5rCApo39y9CQSrIgPXtGCDMkygKLsTsQI=; b=vQa9qDkPwev+0upNBkfWuYb2CD
	jBIbu7vOB8JxC2rnfbApa72eOr9UthHIfHL2hEnjkh4hHgRzHBv9wRhcYvHZCO1zpT1mQKeDJu6w8
	CsQm/hwgCdFPB6jroS/b8sCVawiL83I29OT1LtDbihNviYSg/H60D4tHdE1F2u6TXoLhtEiQ2GKtV
	bz35m9bJKxc5RTJVO8WlVkY05r+HFHcpZjqq+c2ulYX95B/kJYqhnLAA14xpkDZLeVGmdXkAqB2D1
	jt0RB4WULrNOLzvlgNliC0TBzsF6pjtC8QrCr0kBSCRHb99AnpPXs/axYuSFczMds9GH+6T5/FyfC
	58CBo0Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtTx-0000000DNal-2Yh1;
	Tue, 25 Nov 2025 13:53:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtTu-0000000DNZt-41bh;
	Tue, 25 Nov 2025 13:53:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 162CA43D06;
	Tue, 25 Nov 2025 13:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4CAC4CEF1;
	Tue, 25 Nov 2025 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078801;
	bh=wm6FV3IVT1IV0DpBE30PulkbTqg/dBVhT8sK6JRjf2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPCDLMdKI43zuEecrbT9L31Ory6H5TCx9BWZdKDZON2SHCBPuwYMv0wBVhVS7cB0c
	 iIJQ1xIVYTxfl0Rpr3BS9XUzqXdlNwS/TPGeaTPVocHFJRKO8Gqc8qpCmxm7HROe5Q
	 5J3f0ZBm8mupwSBzJh9D3Q7rZJFPalAN5MpOOdFvro4YZWdLqgs4EH0J7U4SHB596+
	 WcRbnLveEiK3AkGThBNyo3eUk6ZvNRsZ8vEDjV/ONd0ORJY2a2c4GRoZi8rwW+bsk/
	 ppSENZ3oU8Reh+pE2+BZSB/zRrNw7O4CVBVKu8bHuocb3W76AuFFT5d3fkVQQz7vNb
	 WbIP1TP22cbbg==
Date: Tue, 25 Nov 2025 15:53:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
	Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com,
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org,
	bp@alien8.de, catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
	peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org,
	rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org,
	Breno Leitao <leitao@debian.org>, thevlad@meta.com
Subject: Re: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for
 memory below 1M
Message-ID: <aSW0wySe2kRl1P8e@kernel.org>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-13-changyuanl@google.com>
 <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
 <22BDBF5C-C831-4BBC-A854-20CA77234084@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22BDBF5C-C831-4BBC-A854-20CA77234084@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_055323_014311_871D5298 
X-CRM114-Status: GOOD (  11.05  )
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

On Mon, Nov 24, 2025 at 04:56:34PM -0800, H. Peter Anvin wrote:
> On November 24, 2025 11:24:58 AM PST, Usama Arif <usamaarif642@gmail.com> wrote:
>
> >diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> >index 88be32026768c..1cd80293a3e23 100644
> >--- a/arch/x86/realmode/init.c
> >+++ b/arch/x86/realmode/init.c
> >@@ -66,8 +66,9 @@ void __init reserve_real_mode(void)
> >         * setup_arch().
> >         */
> >        memblock_reserve(0, SZ_1M);
> >-
> >+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> >        memblock_clear_kho_scratch(0, SZ_1M);
> >+#endif
> > }
> > 
> > static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
> 
> What does "scratch" mean in this exact context? (Sorry, don't have the code in front of me.)

In this context it's the memory kexec handover used to bootstrap the
kexec'ed kernel. Everything beyond these scratch areas could contain
preserved data and kexec handover limits all early memory allocations to
these scratch areas.

-- 
Sincerely yours,
Mike.

