Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AF606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=adaWQQ1W;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD8HHl2V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aVD57Vyoa++azfiqBAhfzngOl8QvU9DsGw/NobLJvHM=; b=adaWQQ1WDPRd4g
	wnOq05fL4PU9hEWBqA8oRefHtfZH03t5fCyrJ5a3AGNKOL+Ii2qJmGloDU87JhnZKqAgVpcjAfUP5
	1T8f5c7bpFlEkt8p7Z8hRLpN8DD2klredt/TZ5FNAVKQnW84qTkCp4t+WEiHRScAJ4w99hhSp/giq
	i117pj6W25pKok5yVj0ZGPfvddraY8/T0dhEm/hN6q6L0qUj3XAGh8zbz/PwQ/DjaRKQT4zsHIbcL
	L34WtSZLSq03lYuaXe+V6c8Y3pQ9tOESUYnwPiWrV7MYtMiM3C55wvb42Xmh9Z1QYyfGn/5/RJnV6
	WAZfg/+Lneq4kV/YdIdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOS9r-00000004Hpe-15jo;
	Wed, 04 Nov 2026 03:59:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOS9q-00000004HpR-48Xo
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 03:59:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 62FDA4400F
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 03:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4052A1F00A15
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793764770;
	bh=aVD57Vyoa++azfiqBAhfzngOl8QvU9DsGw/NobLJvHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MD8HHl2V9nd3qEjuMbvRrBTZH2bsLxioMX7oFVjfHv6Tesnt0q7hLLNSr/m+49jT8
	 lSaMljX+4CfG6xelFsRF1fxldkH8GVcb5JOkwpvBTB6C904Npj4yaJEsjO6nsYj8ky
	 PiTyHb3iLt9aZhE4hj5wbXMfIg2RSBp5ev3N2fC5Zj1mxwDiJy86cQwRZb4AVliw3Q
	 RwP5uHM1C6vmwTxZCfbm+Pbg1xxqSdX9YQI/nAp+Zkv4z5kDyaFy/li/WcsfKzh4sk
	 2fq9e0+Qa+LlcBpy/2sOS5dBim+3SbmMjvx243pGgrt4PUVTbroGo+xDHS+eYE2LqK
	 T53xBvgdG3ILQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so292699a12.3
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 19:59:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBziEGPwO/CAPiS7sWu5fTlqlvqDNyU8LCpAJsB6rKKM4PIwnhVsIzlGqnxA6NfSTVq8dd75/A==@lists.infradead.org
X-Gm-Message-State: APuU4Z8+7UEtj4k10/TEbei8OGGlTgGrvOym40HHPDdW0Tr+T0PMz92C
	guhDWCJXw0AxjqDAR1lxhdKtPtjdmKFDxy64e6JzjdR0Pz33wV+Cn74LFpMIIBr5vqUfsXU1cyg
	D9b6dPfTGfgnPdaySGwTEDPUIQ0rxENY=
X-Received: by 2002:a05:6402:270f:b0:6ac:934e:a9ca with SMTP id
 4fb4d7f45d1cf-6b4d3289b13mr10634683a12.0.1793764768813; Tue, 03 Nov 2026
 19:59:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <2382a0ee-cb6d-4572-be6e-ce3cf4d006e5@app.fastmail.com> <20261103102941.11087-1-dongtai.guo@linux.dev>
In-Reply-To: <20261103102941.11087-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 11:59:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
X-Gm-Features: AclHuK_D5CUCusV0Gl1o9MYw2oMRSISAj8jwmHzHqtDwF9y7DdV5NfyDMepEVEM
Message-ID: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a
 configuration table
To: George Guo <dongtai.guo@linux.dev>
Cc: ardb@kernel.org, pratyush@kernel.org, rppt@kernel.org, 
	pasha.tatashin@soleen.com, shuah@kernel.org, ilias.apalodimas@linaro.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, 
	guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, 
	liukexin@kylinos.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 6:29=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> Hi Ard, Pratyush,
>
> On Thu, Oct 29 2026, Ard Biesheuvel wrote:
> > Can we handle this as an arch table then, and handle everything in
> > the LoongArch arch code?
>
> Ard, LoongArch is currently the only user, so I understand the suggestion
> to keep the handling in the architecture code.
>
> My preference is to keep the table definition and handling common, given
> the potential for x86 to use it as Pratyush described in his reply, to
> replace setup_data once x86 gains EFI support. The table contains no
> LoongArch-specific fields, and only the LoongArch stub installs it. On
> systems without the table, the common code does nothing.
>
> Would that be acceptable, or would you prefer to keep the handling in
> LoongArch until a second architecture adopts it?
I prefer to keep it in LoongArch until a second architecture, and I
think Ard is the same. But this is not a strong objection to Pratyush.

Huacai

>
> Thanks,
> George

