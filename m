Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D2606A331
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w/EfZjmY;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Zc7XKakN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=; b=w/EfZjmY1n9Fye71HryfW7jfRj
	oDw+pd7qzNIFJ+95nrLULVq17eP86xASSClA9mo7Ixuad4nKGChpnFR86v59tH83BO1bi6R3hWlh1
	+Kq290cv9UxnWdv2mvb/VCg9HSMGXEXQCPRR40l/wMKyyImbEjmkSPigrt4Di9Kqfa+idIlCPSxsA
	btkFe9XyX2bCzh/JUKW5q48QYIdNdOU7Rpx6MNYCWD0UOqG2pM+NJAPdzrfd6JCDtXWhs3ir+Lsi4
	3LYmc+1HQM6yB9KdghMpiPlXZocIuYB2/P5LvnWIMo9dKLSYPi35d//Ozzv0GNrhjY20nbSONuXFZ
	RTccM/JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKEt-00000003X16-1KbH;
	Tue, 03 Nov 2026 19:32:11 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKEr-00000003X0K-1Df8
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 19:32:10 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso1307359137.1
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793734328; x=1794339128; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=;
        b=Zc7XKakNqvNRF3pVpyZH5UobNNpnOZCE0iIQc6klt+Eb4lXikLXTAbfbdZOgm/DjwT
         IT1GAzJ7Lfme6Eme9NR16QcJgIS+TGxUYFdO+ZjESX6VqoyM2WPfGIqYz9zmLQpi5xMG
         OftuWnP8zE8VO4Q0cFqZCpXVK6Ic43CQYBweryb1Y2S+bWwRLRae+WveerM6E0Db/dnF
         nR3isDuPuxfVucsLLPgcT7+x8IHizWQLiPXEqVQeRLC3ovoOvKj87ZrEGe9cdcY0Rfkc
         grCNoOeOEsetrNIpVJVeDzYv3ZbxREvZdF+MwFlirhQICc1LD1mxV4rhmp1uJHHh8ZgY
         s/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734328; x=1794339128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=;
        b=2mWbueEidoU+ev3fufDF7Orjj283D4luLFzWVggX7bxLc/gs/xrnwzc9AxK04Rhloz
         pAO4GXfQULax0c8UHq6bvg7XgSmSN8gRfQQrd/snY5SczulX5vXtM9efLZxI/A06OAIh
         7Ez5VNXimdgC7LQA/T63132AK279RaJzIgI2IOOyW7J1Zo9lAQJ5blPFVuh5pnOngaN3
         /2g8o0nUD6VnlPeIZrbmKvz46EFl2SP0qEFXLnQ5hUUCkt0q2lHkE+2NooKyH+WbIoEm
         dacrwgKKdfPbGQYmn5iQoo9fvZ6Hd98K4ediwZyzsxXogOaYBpf7odD4w7kw+XQX5kdW
         CKVQ==
X-Forwarded-Encrypted: i=1; AKwUvByb3Ng16zCopiPP0pqZUxuYslUZktSKhDNP2F/0ARsgQJuRMo6vdiQFx7GsMBRRvxkdU6ERAQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9cxtqeXvokoHcRLve/wZYw74idFNoBMkYGu3GPtRk0nHXXcyk1
	tR4jS2tnTrzBmu2xp/ZDYVNDQSP5uR+fBseLmNfmd55SEfkB9m4YrTIZwWh3Aznwu8E=
X-Gm-Gg: AYBFou3P6sIj/SVlESI5c8FScrWCTEjB1Z/yvRgk0jeNzxbeQFB0s3MojZ8zCAiZ/Xf
	bCesnX155lLmJtEwMc6/jhHAAPSs78oX7wKK5B/8LSvXx6lkVKEGqbRPBrG1NIB1SnJJpT8s5Uu
	MYdb7E6NDSfjyIHCpg5Ewmwy/Jjrpa3+42Dxlu9BOBWwW+pSgGCMSL6mQna+Lmtqw+x9HdEf7BM
	0Bi9E0Nu4nMtBgtDcrItgCA71/NQ0C9v8vjvaTOCHXo9jlH2X1JST3DwsdZdFVMqAFHPxDjxn2m
	Lwypg7IDj0+scy5qNb/PIbA2NY2I43ivcx02BmimpCa2XmH/DFMVG3IgPG0UVoX5sYj1+LsI2qf
	jo+RtTS1aP/SKHqKfbQjpZqFhV2zXFqAkBZ5tGPJ2K3F04HEdV17As8GV+4FXu/YciFaCm1vq3t
	9SdIi4jjTlVSZSgfHEp2lKhIdDVTxlwKJ3Z+TQNesA2ehGCze9/G8tWJF12QUFR+VSVd2Gfoq+I
	RWvU0eTU5AB6dGL9MhBn47b07SKt/K+8b3U1cMsFiLBJN440V3eo/qDXi7NneeVtBEc+IIfUJ0Z
	VSxnM4bJqqsLJJ0N0HZ94aVFLP6kcoDuklQLDgCQSfp/T8QIXhdkR2VL8l0kIyLhX/5/fHZtDgX
	AUSFqcEK7tCNgAlnd/JXVzf2DykduVsE=
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr5503016137.34.1793734327741;
        Tue, 03 Nov 2026 11:32:07 -0800 (PST)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fdaf4efsm33576137.5.2026.11.03.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:32:07 -0800 (PST)
Date: Tue, 3 Nov 2026 14:32:06 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing
 block set
Message-ID: <auo2qqZIbElECcw0@google.com>
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_113209_364047_19309360 
X-CRM114-Status: GOOD (  22.98  )
X-Spam-Score: -2.1 (--)
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

On 11-03 12:39, Christian Aurich Zanettini Martins wrote:
> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
> 
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
> 
>   luo: Block contains invalid entry count: 0
>   Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update
> 
> Check for the duplicate before growing the block set, as
> luo_preserve_file() does with the token.
> 
> Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
> ---
> 
> Notes:
>     Tested in QEMU: create N sessions, retry "sess-0" to get -EEXIST, then
>     kexec and retrieve them. Unpatched, the second kernel panics for N=51
>     and N=102; patched, N=1, 51, 52, 102 and 153 all come back.
> 
>     Based on v7.4-rc1.
> 
>  kernel/liveupdate/luo_session.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index f48e9a4185f9..74bc66929f4b 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -176,16 +176,6 @@ static int luo_session_insert(struct luo_session_header *sh,
>  
>  	guard(rwsem_write)(&sh->rwsem);
>  
> -	/*
> -	 * For outgoing we should make sure there is room in serialization array
> -	 * for new session.
> -	 */
> -	if (sh == &luo_session_global.outgoing) {
> -		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
> -		if (err)
> -			return err;
> -	}
> -
>  	/*
>  	 * For small number of sessions this loop won't hurt performance
>  	 * but if we ever start using a lot of sessions, this might
> @@ -196,6 +186,17 @@ static int luo_session_insert(struct luo_session_header *sh,
>  		if (!strncmp(it->name, session->name, sizeof(it->name)))
>  			return -EEXIST;
>  	}
> +
> +	/*
> +	 * For outgoing we should make sure there is room in serialization array
> +	 * for new session.
> +	 */
> +	if (sh == &luo_session_global.outgoing) {
> +		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
> +		if (err)
> +			return err;
> +	}
> +

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

