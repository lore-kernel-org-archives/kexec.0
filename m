Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BD9C47BC4
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1WqPrA7PMfp4dqiVUq/folMhiyG7j6ZuSATIJ+Fy70=; b=VMPCNyUH/LlO8D7sLKJYF4uZL5
	WFvgHX8PAtfj+sRDU2CGxnR/qwLf4NKSEEtNhuY+r7BYV1L+5BujbEe+xY3vKvCwNBHh2hn57+bL/
	ib8OcR71hbzXEZrn71Jj8a5NsSxgRnJGqrnxrUa2vRwOucMs0wDfnAHMfTlZdgq+jcIw/QlYvwhgD
	deSSlwZgjyNG5tvba8R2C7aQ9XCK9FFU8gGfBLOQZcMiC6g1qsNj2oZW/rqA08FMILUTO8I+Y0z4E
	memta/HUAri0d375I5VskcxzXGGGgXTzgO0H2X8sMY9oklMaZTryBLq1vOVKRheJD0r0StKKJdYUT
	BFyieeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd24i-0000000CacQ-0H1I;
	Tue, 06 Jan 2026 08:05:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd24f-0000000Cabp-21u0;
	Tue, 06 Jan 2026 08:05:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F0784066D;
	Tue,  6 Jan 2026 08:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90659C116C6;
	Tue,  6 Jan 2026 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767686752;
	bh=MhlFTdwsDfjttLwAEC+WP59n2v37830ZfqL8GiFjHlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzV+F+tSLv113051K/7/MB6HLDp2meAlNfZy5efM/FPt8Q48hkpMyz9Oi2d3VEUvh
	 RFkeiW6Yo2OODKd9Tf+6TIA6tx/0BDEr8HcEWklZnKig8r8oeMjK5XVeBCiKAyJc8J
	 gLyAk4IgdxTrmcAgGWew3eELKzzpHVAIfSZq1MCXLlbVy25QhQe+ETgW0i+SbGoLrj
	 ZqXE2WB9Cyhk7eS0I/4+TEAaT3IYtf0sLgISDeJZOPBfhKBlhGsxiEqPsctkzRvb5p
	 5QIuFG9g/81zDjF6ZYW/0tf05f+Ad5FDAdGpBLii27U8QxhsoN2FQGbdO+BS9XxW+m
	 OqREHwjkEAYTQ==
Date: Tue, 6 Jan 2026 09:05:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <20260106-mammoth-of-wondrous-blizzard-e30d62@quoll>
References: <20251226141116.1379601-1-coxu@redhat.com>
 <20260106062231.448170-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106062231.448170-1-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_000553_543865_A63C9DC6 
X-CRM114-Status: GOOD (  15.76  )
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

On Tue, Jan 06, 2026 at 02:22:30PM +0800, Coiby Xu wrote:
> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump.
> 
> To also enable this feature for ARM64, we only need to add device tree
> property dmcryptkeys [2] as similar to elfcorehdr to pass the memory
> address of the stored info of dm-crypt keys to the kdump kernel.
> 
> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
> [2] https://github.com/devicetree-org/dt-schema/pull/181
> 
> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v2
> - Krzysztof
>   - Use imperative mood for commit message
>   - Add dt-schema ABI Documentation
> - Don't print dm-crypt keys address via pr_debug

Your changelog should explicitly document that this has external
dependency on dtschema pull request, so that maintainers know that.

Also, in the future:
Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof


