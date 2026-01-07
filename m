Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37026CD5829
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36wuYSpDK2R7J0yvGtlN9+rupa1ABZXtzEKw/I7D2mc=; b=mpiJuPnYrbOpDxVH3hHbFJG8o9
	x+wXD5Lsu0F4rok/tcDY2U1UdDuTmL0Fny9b8VwpJz474+ZIn83DALysv9HuFSd3IsfZXmtq2/b05
	LrNXUmHHG0gg0z+7FdUBjcXEJQJIdHjUlPjA+SSNFGW9haw2GQPYSXAO03aRHw+GKzbKaDyzvqKFZ
	wOPFmgSafjaO+tRw+NjlQT2rTtQA3LaSlsXK20SylFDdXQrB49nBXWSHEeKFKEmNkY7XLhoLMpvVX
	zArDAjfJrMsDwx26KDDau5TtqhJUeJvT2gDGImFVTVEFYJGi8pdZa8RRTJueUfDZx8EvpFHAjLRmG
	aHMIb5/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQRS-0000000EeGn-1jR7;
	Wed, 07 Jan 2026 10:07:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQRO-0000000EeFf-3Cbq
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 10:07:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6889F40135;
	Wed,  7 Jan 2026 10:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CEEC4CEF7;
	Wed,  7 Jan 2026 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767780418;
	bh=nEghX8BiAqAAWqHNMWEJ22do60eHFb1GQ4oeVhHrdpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iodDBfPBhdLwX8pOjdmGnJnUxVl7xS08q5+D8BsMOb6lm3GcJCWmkuDCE65gWHFqd
	 32pHmYlEab+je+ZkjWMrwlN2GEIzZwffcH0HZh0b64+ieCEGFnRIm/NclkKM+Oipf3
	 3aLbPB6lk7ZxAG1MbpSTwvtNyWwbtQz79LOLGwZJPyT3tJX/3Beu26Uwh6w0WOmFi7
	 Y2NHFcsIc/cS0XKLxn2VHzWwL7CjFJZa1OW4329qfOvkC2z2X6soTjKMdZmsodfugG
	 ZdL5NiaV5Z0lycBNtBNIr/HTqLeuOiq38c9NH7bvoL1yUe3lKYwRPOt/dU6G2UNfQr
	 yAUr2Vn731tLg==
Date: Wed, 7 Jan 2026 12:06:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: l00580197 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	hewenliang4@huawei.com
Subject: Re: [PATCH] kho: test: clean up residual memory upon test_kho module
 unload
Message-ID: <aV4wO1ORACvVpgAN@kernel.org>
References: <20260107022427.4114424-1-longwei27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107022427.4114424-1-longwei27@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_020659_033433_2453E4AD 
X-CRM114-Status: GOOD (  17.34  )
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

On Wed, Jan 07, 2026 at 10:24:27AM +0800, l00580197 wrote:
> From: Long Wei <longwei27@huawei.com>
> 
> During the initialization phase, the test_kho module invokes the
> kho_preserve_folio function, which internally configures bitmaps
> within kho_mem_track and establishes chunk linked lists in KHO.
> Upon unloading the test_kho module, it is necessary to clean up
> these states.
> 
> Signed-off-by: Long Wei <longwei27@huawei.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  lib/test_kho.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 47de56280795..69230da5a056 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -339,11 +339,15 @@ module_init(kho_test_init);
>  
>  static void kho_test_cleanup(void)
>  {
> +	/* unpreserve and free the data stored in folios */
> +	kho_test_unpreserve_data(&kho_test_state);
>  	for (int i = 0; i < kho_test_state.nr_folios; i++)
>  		folio_put(kho_test_state.folios[i]);
>  
>  	kvfree(kho_test_state.folios);
> -	vfree(kho_test_state.folios_info);
> +
> +	/* Unpreserve and release the FDT folio */
> +	kho_unpreserve_folio(kho_test_state.fdt);
>  	folio_put(kho_test_state.fdt);
>  }
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

