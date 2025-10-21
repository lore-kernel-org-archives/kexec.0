Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57898CCD1A5
	for <kexec@archiver.kernel.org>; Tue, 21 Oct 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2M4QI2/OOLg7uUeHMOQoT0d9A80Sw7H3NedIfzkAEY=; b=mLj0cybZeb8Tknea9cfGHkep9m
	00sXRa5iPOZkd3XDCwBLwPEml3bdVCokuBUHmITdNK9h2rP41MEFwTlTpvsuSu03yEFNEYlDV9mtz
	1JT3xFAVQSz1+lF29RcKvf47NPE452LLUmdl17IAO6oNLCdK2BRqplGmzo/mYeh8+GTeBrC6ZOEla
	F9isLOoeJ4Rkmyyxhywprcnvu1awCqxDb8xPaXMIwdDDGMQwpfMM00Pe10Hn7sQKN5+dbTtSL4EVX
	0EgP9GeC9wVGm0eviMv4mgW1hEZPrpYBAB8wGqxu4YrL2CmxftAaMc6N7ZTZh8yleMGs/FfoJzlAw
	k9ZV1RAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB8s8-0000000GUMm-3Con;
	Tue, 21 Oct 2025 09:41:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB8s4-0000000GUMJ-1kWq
	for kexec@lists.infradead.org;
	Tue, 21 Oct 2025 09:41:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC4F943C35;
	Tue, 21 Oct 2025 09:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8555C4CEF1;
	Tue, 21 Oct 2025 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761039695;
	bh=8dOBD4BckFGpaCNrWmvtyD6EjxMvEuwHFVyiglw2y0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9cK5QHDvCtecgEuD/dvsmDKlyKmi7hpjXEiam+xTwlCa6C1FcV8neQJbWc89DVN4
	 kgv9vXizxt86ZPck/cYUq0o5vH+Fd41GrHenD+tScKWNh2+XF/T2bJ8cjRJO7wVeT/
	 k07BQdItFqsZB3iPL5WdzzLvpbYmb3bSo0svZAKi2oKc4ir6oh3Dwv1MiODvAjja0R
	 /zAqdXGGO0hxtutYJTcixCqYTSKsfUpYACdEg7FyuISQrLeoU8jAFsaxdicOfZMgi1
	 35WHLAtSLRcbsNr9fMBCIHC51HaywPQUJF8ObS+95M0nZ6Xy5KKXminhlzrlLQ+3Fn
	 IlPMwbFq47T6g==
Date: Tue, 21 Oct 2025 10:41:31 +0100
From: Simon Horman <horms@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	rppt@kernel.org, changyuanl@google.com, akpm@linux-foundation.org,
	bhe@redhat.com
Subject: Re: [PATCH 1/1] kexec: Use %pe format specifier for error pointer
 printing
Message-ID: <aPdVSyLRKeRN3i6z@horms.kernel.org>
References: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_024136_475461_17A68A0F 
X-CRM114-Status: GOOD (  10.48  )
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

On Thu, Oct 16, 2025 at 08:03:20PM +0000, Zhu Yanjun wrote:
> Make pr_xxx() call to use the %pe format specifier instead of %d.
> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
> -EINVAL) when given an error pointer created with ERR_PTR(err).
> 
> This change enhances the clarity and diagnostic value of the error
> message by showing a descriptive error name rather than a numeric
> error code.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,

This looks good to me, even though I note that this file
has moved in linux-next.

Reviewed-by: Simon Horman <horms@kernel.org>

