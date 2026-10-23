Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5F606A320
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ME6dvKPN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fB5S3V/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q6quEbk1wjADIYDnbmI8RxySF7eMLqCwXbNeK/3QTbQ=; b=ME6dvKPNqZLOZsDvTw4cjr1IMi
	H29sM1e32JSxCvn5oLmZ4RPm83pnX63lSDhVxt+TZJiIYflENGhVKj0hSg8ut2+4Xs6gaSAfDlvzM
	yWcE5a3vnqiya3CxU/0vzK2HEPVbO1rGnPd/+zPBVNQs1K3UtUd35P0AAdCsDnfHyE/TBv7GX37+W
	8C9QaYewThN6B7fJEobW2sCthEgrZAxGj3+GdxPN8shh9LXvLAV74IR0quyRcgQ0le/GNsEz0aqVK
	6RGxxstKvq2q1vUqDgB5AHX+Kkd44aba2eQujpfywnzZtBprR3OUFKkHam7iZ87Oy4/3z2DKppUF0
	ahnsl3mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKIGw-0000000Gff8-2yFc;
	Fri, 23 Oct 2026 16:37:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKIGv-0000000Gff2-3XnO
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 16:37:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4674940F63;
	Fri, 23 Oct 2026 16:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458281F01825;
	Fri, 23 Oct 2026 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773457;
	bh=Q6quEbk1wjADIYDnbmI8RxySF7eMLqCwXbNeK/3QTbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fB5S3V/LaS0CaeNTSAaiAwX6QQaGxO+OqMWheFNTKPAvbenke7l17ptFB0A7vQjb2
	 JHvJGb6q3DIEyS/cw6/UVetwp0iUl8hd5HXKpVWv9ECNJNlcHsBYVnzI6Gd4ZtPYE8
	 oOlobM1tBmOifszaS3w7PmFzmoUXQeWZBv+GoYyzSU3L9tu8HGfXFF1u4zlQ/X1QFI
	 /pul3GxhWLCswfRS3qeRhzKZZaau5Vpf6R+DkpWAyaT2Q1yXLZsqVJ16O4jIO33YnM
	 N4xKOh5r1qKFveuMPJoE7khOS1YZ7HWmA4gBGV344J3/484dRvoqbOlF1M6el/vCzv
	 Cz6tzE5ePpetw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg Thelen <gthelen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Evangelos Petrongonas <epetron@amazon.de>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: check fdt_phys in is_kho_boot()
In-Reply-To: <20261023054518.3258350-1-gthelen@google.com> (Greg Thelen's
	message of "Thu, 22 Oct 2026 22:45:18 -0700")
References: <20261023054518.3258350-1-gthelen@google.com>
Date: Fri, 23 Oct 2026 18:37:33 +0200
Message-ID: <2vxzmrs4fk4y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22 2026, Greg Thelen wrote:

> During arm64 setup_arch(), efi_init() -> reserve_regions() calls
> is_kho_boot() before arm64_memblock_init() initializes memstart_addr.
> At this point memstart_addr still holds its initial sentinel value (-1).
>
> When booting via kexec with KHO enabled, kho_populate() sets
> kho_in.fdt_phys from the /chosen FDT node. Calling is_kho_boot() ->
> kho_get_fdt() invokes phys_to_virt(kho_in.fdt_phys), which evaluates
> PHYS_OFFSET and triggers VM_BUG_ON(memstart_addr & 1) on arm64 kernels
> built with CONFIG_DEBUG_VM=y:
>
>   kernel BUG at ./arch/arm64/include/asm/memory.h:377!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Call trace:
>    is_kho_boot+0x2c/0x38 (P)
>    efi_init+0x94/0xf8
>    setup_arch+0xf0/0x240
>    start_kernel+0x84/0x490
>    __primary_switched+0x88/0x98
>
> Check kho_in.fdt_phys directly in is_kho_boot() instead of calling
> kho_get_fdt() so that early boot callers do not invoke phys_to_virt()
> before the linear map offset is initialized.
>
> Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
> Assisted-by: Gemini:gemini-3.8-flash
> Signed-off-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

