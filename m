Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABFE606A33D
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P3eqLXWd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hN2KP4pN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=71To1F+Ha52gfiOXVzuzWJ0D7FrFND/yLtAE+8lZwmk=; b=P3eqLXWd0wFOhil+GaMJlrzbae
	iO8PH8VFVs/tP5hFSE1orGWR+66s0TwmoJFavAahaBByGrUbZnxkzj3RLw7H0brnOm7Ljs9Ve1coj
	MOP9VvBd2Ql0LDvfS/iLXXEYwJCgfOhSNaeQWuSUHSKJNs3PFtlbeOBEG1lwZjghp0dTBPebcysC6
	KkMtJtaT4N++xFxD2baHOAM1pzJMiHhqEyQr1osUEND1R97TfPZwZdy6H5g8IcIdXjRH39J1ofk8z
	6DNeLtL0Y4VZ5AV7x6t12qNvlXBBifoEssmaEWF0X+zXYvtEYIIl+9iEVzRwPIOOp7CWQGMqSIl/I
	FNqpQmOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNnWd-0000000Fsoy-2Hcl;
	Mon, 02 Nov 2026 08:36:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNnWb-0000000FsoS-3K28
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 08:36:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C989560EF5;
	Mon,  2 Nov 2026 08:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698601F00919;
	Mon,  2 Nov 2026 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608576;
	bh=71To1F+Ha52gfiOXVzuzWJ0D7FrFND/yLtAE+8lZwmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hN2KP4pNFL2p90V8j3d/hLfQeX2QZzb9dkQfAat0qfzSTf5GYlqtJ1PzjKS3P2zkJ
	 RrjjMqw+iYfqFbInhZ3OrlHp5yEbrrPc+3VPUCVPVwd4Y77RXJWajAGWelPr76iq/X
	 j1acplbF3c8IQ5DGD30RFStFv7VTdoX+KHqeGgwbXJYgXaEen+icaidGQPc/upEpxg
	 QzHtvAqKv5xIeq01p4QdTNiIBlicUcI9sypwrt2z3DX8n04rS9oYy77b8b1NTVwBW+
	 H3n7kH9vKsu9goozvQPdw88H+cmY5p22CzQdSDTZ+7JEX2eFYcQr2pCjOPcyuiyy/J
	 iaAlGW95UJnlA==
Date: Mon, 2 Nov 2026 10:36:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Greg Thelen <gthelen@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: check fdt_phys in is_kho_boot()
Message-ID: <auhLedAuD32WNcXW@kernel.org>
References: <20261023054518.3258350-1-gthelen@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023054518.3258350-1-gthelen@google.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, Oct 22, 2026 at 10:45:18PM -0700, Greg Thelen wrote:
> During arm64 setup_arch(), efi_init() -> reserve_regions() calls
> is_kho_boot() before arm64_memblock_init() initializes memstart_addr.
> At this point memstart_addr still holds its initial sentinel value (-1).
> 
> When booting via kexec with KHO enabled, kho_populate() sets
> kho_in.fdt_phys from the /chosen FDT node. Calling is_kho_boot() ->
> kho_get_fdt() invokes phys_to_virt(kho_in.fdt_phys), which evaluates
> PHYS_OFFSET and triggers VM_BUG_ON(memstart_addr & 1) on arm64 kernels
> built with CONFIG_DEBUG_VM=y:

Can't see the forest for the trees ;-)

Can you please translate the gist of the issue from LLMish to English?
 
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
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..d81baa38497f 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1630,7 +1630,7 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
>   */
>  bool is_kho_boot(void)
>  {
> -	return !!kho_get_fdt();
> +	return !!kho_in.fdt_phys;
>  }
>  EXPORT_SYMBOL_GPL(is_kho_boot);
>  
> -- 
> 2.56.0.257.gf7497c7d27-goog
> 

-- 
Sincerely yours,
Mike.

