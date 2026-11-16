Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95388606A329
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ffIJ5Ws/;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=C+oWZpPI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BDGAdzVguqNy0JEZoxyPcMqb3hE97RGPZcChbfGjrxc=; b=ffIJ5Ws/StOqMZ
	iPlagBFtiGZizT3fqxJ9X0XrikouLOTERN4crAZXTCXBxLGm6Lzdz8axHFo47rkQSqPnCoPQLrgOt
	FR7nCKLj54QFafzBjF5tQd3OQshHVD0XvsAUX8TMXrHG6psPnIxMjaLL4RQEu0lThhDslDXj+aPIA
	sOU816b9iQCaIznZBlAYPlxJLnyNMliDhKPNuf5GwOTUdcQUJYYE8D4NYUxCv/OYHpMLSmIm1cgfK
	bxo9CsD/qo67gFGOdsccmmS4QPsFVC+f1wuI1VRM4NBOdE7SZ0jVVV4ydcKw18tupwhYTuj1B3H9N
	Ia17CsP1nNJ/QJs1VNEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT34z-00000003qi5-0dQC;
	Mon, 16 Nov 2026 20:13:29 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT34x-00000003qhf-0VK7
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 20:13:28 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-5eae12762c9so1365713e0c.1
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794860005; x=1795464805; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BDGAdzVguqNy0JEZoxyPcMqb3hE97RGPZcChbfGjrxc=;
        b=C+oWZpPIUk0uzMiH/pAIlB435ho9c+FRKJRaQzpUHMAyKpA/+c3S4lF/F38f7nY7rm
         uGDayCfr3ZIpVfo47A4tFVraIPuSKKwX+M9+yrpAq8yUoX8mBr9JLDjwf7yjF7Psn4ii
         QjdL0iJXHJEvznI9ZeVzk4+kgKdprJDNcGzd5oKQlM5HQpZMbaMtyI1uTI1teLqHAFAB
         JJKjgLNGFFCejgtpl1v+xxpynEDDTo68piRsAZNKC9H+Yse31f+dhegUBoLVNnr6h2N+
         /B0cvRdKlVWyN0/MnJj3NJ+V08q8bpPGlBe+KuEQq2lC31M5RAWCKGYULDBlKiMCskmf
         TLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860005; x=1795464805;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDGAdzVguqNy0JEZoxyPcMqb3hE97RGPZcChbfGjrxc=;
        b=bAojWRmyICCjaAU45Qtw/A6RF8BZQayxI3hmhVLvPcy51IBtsi4Atav/ZNvqEqPS25
         ryhrzKmepa3SUxd+SAEG+4iKB3glVNQ0uj4DFjRfFlQuVcDbQuuG9AcCGO519PUyoHFI
         n8OEyktf/dHiPk81EZBgszdsrHrBYs07fAkTSR70go2GLjuky/V42OFQIQKSzyTkZc3l
         GgMlbpOM7T6UWZ8DfIixIu6oW/PE9p1ysWy0iMMMjCR7e40y9vaA3VmbUIBYmJ0+np65
         9u9iE+LTc8BTeN/Z0R5xoSKR7Kd98cAXeNDPFcVCW+bHX+mDCBqtAHpd9gbifgAOTQHo
         F4MQ==
X-Gm-Message-State: APuU4Z/JphrygM9/9AcGPrv+EA1o3updznChPNjr/mMFQnHUUN+/OKYW
	tgTBqQUdcMpbL8VN8sSIuh1ZfgftdAwpdL0rcY3bSD5qbYbYWqFKJ0LDfF55I5Wcf2vnGm6/B7P
	49L4K
X-Gm-Gg: AYBFou2Ne6hiZNKLix9L/TVjZdD5BXKhTYJ576e/nVSbySnTjIpSqFegn+PAXeTDlJM
	dhWZhis2B+xvmLh9eaWw1Y3R6OfWflM0HBAaXOniprHuKKoPNWbTcmyeIiwwm2yEADteMVmO+h6
	V6nIyLWv496qSNG0jYFqPY+UEhlecJyLdaHBtF1aH4MkgMTeTa2tr3DzKjRg2wsbEb4CoSH1j/u
	hdAMu793iXJKeQ8Tn5OSBj101e21DULYO7UnpZeU79K2DzhWYNGrvBIjLO3xGasvBuPV+qR3iyR
	au1CEXILGEzvITtIGEcxCn2iZyecbinQk9oCaMhD9jOpPWM5Utx6DQxiV8XTl6aiNQ4J/oNhzjJ
	H6+AGEv2upxkuYwbYkMmjCf1lfpDylfc3P3Yk5wl5zEsfyvwheNii7nUUF0WYQXzRCZPhadyX2P
	WSH1JLuFr+xvdxEhnHU3sC/HJHiinFA52OSlRSTR0UwcrGQgkvcgjs8CUhEXm9s2BAnQ1kZyXZM
	Hgcw6VNpJKct4y3fOOYdC6h/3aiaehATyNLtzzjlgAhZSPIufddxxLnTAs9cqqtimMoRN6pI8tF
	Nm2b30KXx8wKkeI/h7C6/oCBj1OmkBfyZxkV+UK28HAQA4ygRG/1A0ZL9HG8Ve0Pj0Tfg2xZcHm
	sYwBt0hYiiq4+/ZmyYWmfTjf7589nIGqle7iRdzYf4qCM0BFoDNdW
X-Received: by 2002:a05:6122:3c4b:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ee34aa9574mr3361794e0c.17.1794860005139;
        Mon, 16 Nov 2026 12:13:25 -0800 (PST)
Received: from localhost (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee3e031bf0sm5639266e0c.5.2026.11.16.12.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 12:13:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 15:13:23 -0500
Message-Id: <DMWWRQTLNYH6.1LJ2K5HT60LK8@soleen.com>
Cc: <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] kho: build KHO objects into a single kho.o
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport"
 <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Alexander
 Graf" <graf@amazon.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Tarun Sahu"
 <tarunsahu@google.com>, "David Matlack" <dmatlack@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261116134013.1636689-1-pratyush@kernel.org>
 <20261116134013.1636689-3-pratyush@kernel.org>
In-Reply-To: <20261116134013.1636689-3-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_121327_172317_19879F98 
X-CRM114-Status: GOOD (  15.47  )
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

On Mon Nov 16, 2026 at 8:40 AM EST, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> kho_block.o is part of the KHO infrastructure, but is currently built as
> part of luo.o, which ties it to CONFIG_LIVEUPDATE.
>
> Group all KHO objects into a composite kho.o, built for
> CONFIG_KEXEC_HANDOVER, the same way the LUO objects are grouped into
> luo.o. This also gives a single place to add new KHO objects.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/Makefile | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index d9f4694625567..bc679905ce3f2 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -1,13 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +kho-y :=3D								\
> +		kexec_handover.o				\
> +		kho_block.o
> +
> +kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) +=3D kexec_handover_debugfs.o
> +
> +obj-$(CONFIG_KEXEC_HANDOVER)		+=3D kho.o
> +
>  luo-y :=3D								\
> -		kho_block.o						\
>  		luo_core.o						\
>  		luo_file.o						\
>  		luo_flb.o						\
>  		luo_session.o
> =20
> -obj-$(CONFIG_KEXEC_HANDOVER)		+=3D kexec_handover.o
> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+=3D kexec_handover_debugfs.o
> -
>  obj-$(CONFIG_LIVEUPDATE)		+=3D luo.o

Please send it as a separate patch. I have the same change included as=20
part of the kho-ro series, but let's fix it outside of both series=20
instead as a standalone fix. Also, maybe rename kexec_handover_debugfs.c=20
to kho_debugfs.c and kexec_handover.c to kho_core.c for consistency, now=20
that they are not shared with the rest of the kexec_* files in kernel/*?

--=20
Pasha


