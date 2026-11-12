Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D5606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mDPfAwap;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LjLRHOH4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mWI7ugCczmlr7WYE/mOm+2XZ65nCDibs51EgikULhns=; b=mDPfAwapfitq39
	EB0NTjf75anchuW01ZfRrps1fdQhr8o+iBgGPlIspu1sF1dv2t/DtnVJwG9+RVJV0M6M45ycarbdV
	RUWMim1jUi94pOcz5L/OzThkPYGd/tZOh9IS+CCkyARFeCHHg6SX6A2Vp+2zpUFie0q/PRWo+xLmH
	n3GvtEeV+BnprEUoD7MbQG/sK/12b+wZCd24w5sAcV+rVbQ/z6OwLgdgZNAbPRHCO0yTChsr2DARu
	pLrCKmKJ1idyHi4tl9S1ss78YSFq8oYNA0wI/klRPAxqdETdnpv63Km+sqdIBKvwf4g/c7VPYcr59
	0tmK5LJrsyGZumLtKw/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWHI-0000000AMcN-1Eyo;
	Thu, 12 Nov 2026 14:59:52 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWHF-0000000AMbL-2mvb
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:59:50 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-7d2ca055399so1301964137.3
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794495588; x=1795100388; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mWI7ugCczmlr7WYE/mOm+2XZ65nCDibs51EgikULhns=;
        b=LjLRHOH4PyJw/EhBq9a8ekhXbEykYEFFERBU5kRIQ818jSvNSAarD+W1BC2L+4Fto0
         UpcxXrEYy5h14pFGdYFh4/CUDot20cG2Dm1T8daf5EQT51Ow9faMtlV9OdIYzWZzkp4U
         CTOQberfSl3f5eR3sj1xk3Ti+ng73u0/hFQOSYAg1zPUQebYhFSgeY/X5vqnEUnBc8z+
         njv1dKqsebH2CAi9VzHvb1nMN5gfO9GMUqFPubNPKy5PBTVHe7FhXeMf31DwdUoy+tUw
         +GYG3BXh824trSjR7D4lDrTWfEfo8OXWSOqUWexCUhX1p4q8EIXoc6bd387rmF7abQt+
         dv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495588; x=1795100388;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWI7ugCczmlr7WYE/mOm+2XZ65nCDibs51EgikULhns=;
        b=kfMjBe8/EytY1AoboEg3XATiM7ID8QMDnyVnfelwR1Tzr7eS7rJWViAxDo/QoTKjpP
         spUK5/PD11W1a+o7m8CLFGdAktO2dk9+82f6WFxVvzKkZKzh6fIhvLM3UOqrQU6CeqU9
         w3nibei3lGpKwZKKkwyEqPOVPfTnlRkVubxCRJtaDVPfspLXa1iehitnqsbTGtCYam1L
         nvpC6gIhFBi7327A1iCMai+xwVIOM/uCcQBxHuyI26pbfD0cFlEukMS3hJUT76T45yYr
         wvM5fnw/bFx++1JDUcNkMOkBe+VNT8g8b0zvUHsxCf7twQFhauVttMEz639THKVKSjFC
         lQ2Q==
X-Forwarded-Encrypted: i=1; AL+hErFdaK/4Fke96ZxMkge8IyEUL1aghrW352OasMEaNkEJcn4k6fPZjlJ0nbXeWuIZyoWn/FCkAQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8DBSH+lvhwuQZ/sW82tl6mlIr/72JMay2TppURui8HbrXjVp2q
	FHvtxX7yyOS8PBU5u40owZ6WPfyUFEHRHpA2Z9KyDo4l6EFe228cPHjepJBWJOvAzGrmwbtJ0Hy
	0oqNs
X-Gm-Gg: AYBFou2hDG/PXc+XIH+bYz0XE+xCmVDb8Xm0SR7uIQmKFOrz1QIp7ujxttmARtnL8S3
	rATTVuroZ6GWuQYDrde8585X7nBaPFGevcUZX9Y+5fOfpj/Qc3lS6ybQJlKyve4sU9rI9YU+i8n
	q/FasZOTR8rABeDONM6L+qiWyd15VtaODw5VP6aqGvvdoWRNq3oYfYv3wRws+daJKlnoFV3CeyT
	qkKt3Hk5cnEGlShP4mXT+FbGuw5V1qy8UprnxOpkwEoI0CpKIzep41/EwEZLKBeoOGmyidfKYxa
	sHl/SLCXCso9HYJoGEo+0xWi5xkdpBKCZiBtMdP/Yz1++goA3roA6D2PhagLfudmgue2bqleZPv
	hL7wn/Tq4McggN339r5ecPtAs82prrh3yi9ZogEHbxI7htek/zdIndRqtl8JsSwmmCLYOuCzfp1
	wGRUHJMelV4HQhNC4WbxSEiRXLZjxU3aQlbU/n1kGoHR1EZzVfdXUK7sd3oqFYZPXlrnPO9NROr
	YAazKH2xowyly28XXpxvi82LCBZDhEDhsbLDgb0/ca443XS5js+jkccGakDvMy5B9s5GOzb+/Hw
	4C2H/tqvYCnllla7UqjIMKSk2L0eZ5ygxW2dSML/meMqebUxVlJjZ7rsSEpIp1iYhvAwKetYXxM
	TEabwV0fd22I41+joL0+DVXP92iJ9N54=
X-Received: by 2002:a05:6102:f11:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d4fb24dcfdmr2020028137.9.1794495588205;
        Thu, 12 Nov 2026 06:59:48 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302239188sm5739554137.2.2026.11.12.06.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:59:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 09:59:46 -0500
Message-Id: <DMTBLFVSOEYG.K5WAQC5KN7IQ@soleen.com>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chen Pei" <cp0613@linux.alibaba.com>, "George
 Guo" <guodongtai@kylinos.cn>, "Kexin Liu" <liukexin@kylinos.cn>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/5] kho: reject zero bootmem scale
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_065949_722990_37D2DC04 
X-CRM114-Status: GOOD (  16.34  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 5:38 AM EST, Mike Rapoport (Microsoft) wrote:
> kho_bootmem=3D0% sets bootmem_scale to 0, and then the bootmem areas are
> sized using the explicit sizes that default to 0. KHO remains enabled,
> but there is no usable bootmem to load the next kernel.
>
> Reject zero scale the same way zero explicit sizes are rejected.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers"=
)
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 6f1f55fe31819..b30ba686cb301 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -703,16 +703,22 @@ static int __init kho_parse_bootmem_size(char *p)
>  	if (p[len - 1] =3D=3D '%') {
>  		/* unsigned int max is 4,294,967,295, 10 chars */
>  		char s_scale[11] =3D {};
> +		unsigned int scale;
>  		int ret =3D 0;
> =20
>  		if (len > ARRAY_SIZE(s_scale))
>  			return -EINVAL;
> =20
>  		memcpy(s_scale, p, len - 1);
> -		ret =3D kstrtouint(s_scale, 10, &bootmem_scale);
> -		if (!ret)
> -			pr_notice("bootmem scale is %d%%\n", bootmem_scale);
> -		return ret;
> +		ret =3D kstrtouint(s_scale, 10, &scale);
> +		if (ret)
> +			return ret;
> +		if (!scale)
> +			return -EINVAL;
> +
> +		bootmem_scale =3D scale;
> +		pr_notice("bootmem scale is %d%%\n", bootmem_scale);
> +		return 0;

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>=20

>  	}
> =20
>  	/* parse ll[KMG],mm[KMG],nn[KMG] */





--=20
Pasha


