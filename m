Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6AD6CFA2
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhM6KusIxk5pLuv1MBKQ22c+nR479iQtC12L+zVHy4k=; b=QokSTCaFxpUPSE+KrBuy988+1s
	VajdbVQ1UYIbapXjDJ7n6ZQK1uvk5B3bFBr7EbPkrFlXtQnHSb1z0XqaEWwf5a15eq+HitmDGbrV+
	Bb1My9mVlrGcKKYexbsk3X8WdU9i0DoaMjfCkQaLSX6juvEIwFl3P6bUxXr+6wuZpfb3HIDHIpcPe
	oTjg76Y+zRtXOSZOdiCFhVE0nnwElbtV42G9VMGAdyasghIbzi2dGT7T0Fr7/iF0Hm0DnP5aduoBf
	pfu+eF7wiBebEfcdlQzRAVa93q8yOBBcIz6GpotJIp1R6iZHIgptvxYOGlY+cB8k2GiNb/9QLOXJV
	WixwrlBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizQw-00000007dSD-1qwB;
	Thu, 22 Jan 2026 18:29:30 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizQu-00000007dRl-2jEX
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:29:29 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so2255858a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106566; cv=none;
        d=google.com; s=arc-20240605;
        b=ALBnQG5nw0tG3ZBrVVaBeqeTU5i9LXt4RO41tD7ASGVAqBp70GxQaLuLcLrlnWLfYT
         t3MTYQoQYgDBvwfmPOKZ5JJWLS5o+boTvv428VXnZlQ/HZ2k5sC5yJWqV7iJ0ta+tuz6
         Fn6sGlu20hrx8IeUMMOBU0O7hZSoEc3IUgsTyeMs8oUgdLyUp7jhx/315HsO1yvk4e9+
         Zcj+zd8jGOKofE9gzMeN9yPYx36gqTGxKjX8wE6KHT9+ZTU+f9eDvxc26XHpVNwusnAa
         VhHGeeJsn/Z76R6MIW6j3Z6SUzzSX4kudA4IgTRbJbn/krjwi7eTzalZ6giZP53XLSqw
         yHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhM6KusIxk5pLuv1MBKQ22c+nR479iQtC12L+zVHy4k=;
        fh=+527nILCHcsIAU8CqKSRS+1gW5drwS2TcurXz9A4Ww8=;
        b=KRHYQYrLI9Ebn16O3F3s/rS1pe2fQFoEtxu49twS0NCw9sEMPhjP88DWlgSIg9D5hf
         R7KtgDVmRg06J+jsRwdSSTg/xo9PODVxfXe4uMfr5zIBD0n/05/3UD25DxUdwZJIQ4pK
         584fJXch7XE5ULaKPjcGj64U6Wa3eEKrBVEG0/XtQqTJ+KH6T2hNcWmF4aIgLjU6jOum
         5RtyfCzWp/VmHU1dDuYCPVP1g5QgLEzCeB6RF7sR/AV7jpTKm1F6k81hKzvaq9jKRoqR
         J3JTu3nR8rG+IG5pyI0fROAVH2YrWgDICnv7270ENh5GAT1iCFpz09TGq9wndxeXssH+
         08qw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106566; x=1769711366; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhM6KusIxk5pLuv1MBKQ22c+nR479iQtC12L+zVHy4k=;
        b=PXG0WqbbBlmWXL8owabFIpINOfLdmEsbaZD6chqoYl5wL309WFt5zPu141RE1f3/0w
         +vF2AKeiVvsFmOY2F2haYJeheKvvZcdW3Txrbd//cikX7YXfvVDV/1w9SKyhrOS9awud
         Hn+892mJUmkk7Yc+5kSWyfdQuEBQNXJYvKEgceh3NFLRmGnYUdxD2taIBw/8+WqGXUda
         zzIbEwYnMKFXxTOilQDiwJSVb1A4ghe5qMGzioNnmwJv72A8ENXfYRyFOpLBJkOT9WyU
         UgdUnOrnNBPR6L0VFGZ9mGZX1BdZmOcskJj6+J2YhYCGrKL0BXEIgdsPKjxhbHxuUsa2
         eO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106566; x=1769711366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhM6KusIxk5pLuv1MBKQ22c+nR479iQtC12L+zVHy4k=;
        b=hcjSn2X+kdfASIQUowVriRBJxXWmv693YDi6h3wL5dwdE6VLkf9ZOkwKxpbP9bGZtf
         NQO+S1gSeLhUx6O8lZRXYQcZTlnoqLPwvo218GKNg5oRFJnDL1vL6I3NNwdfY3F0PxPH
         NFghacuXN9P8ZQGdlk/Xg64TO/EAjPospjbRxsGL46tgVNcYyTTt8Dvgtl6OUxjAIhON
         uf8Xdt+a5pCWNm+Ox45WGtQtk9ndbdM4JVZzXlRaZHKoP2XO9+UcaUsAdjllu/HZrZEZ
         GA68dbQ1HRX5OW58bVj1XRS7HFn/Y0psmzK9X+ej9yJsH+HQLj5D6UZ2F4yNSG+KL2kA
         cLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPWKFinmgjioliV/edSWMkJFMN1JTpDZdLE80jhxApW9DDrbCRagxg2js0Mu+ipvTsnydA5w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwOfzU7/GEi2zYWDAYM4uq69AHQNko/0FFRO7TydTQbl0b9u1ni
	JYa2mxYJOSZMRgUt0erV6BiCp69iSlXoJAP2hP9ZmYmyb2nfIpj68VybKoT9PYAWbr7Tydbahg2
	nurDZQKdTAX+k1MiJKa3LtHMgIdRAg3b7qdXklhBCHw==
X-Gm-Gg: AZuq6aL5+NQSksbhIstiwi2XxFg1mPHrdaWkE7DZ6kkivoiRgAo/Ij39o4PHXGXvBE0
	3DucSj5aFQSs+hC2Q7svPGheR2OiDmebYyopVGtjXySQupsAOxT2wMwN0OowACIWk4ltH8JKw7s
	VBIR5R55v8CvYuxh26JZJgxpIB87mbJX9vLjOFBX0+dUHfjNXpdi3M3lsN5y9v3G/hiATMBVq7n
	N2yRp2UcX30V/KWrGJgTuYQmY03m81AAwyWZVnjHcMjBJpdRPKJ6dGrueCyFjpSJK3ROmJ+AdOg
	YshqraLBpNS2H36IVaE2zM2RIxyse+9h5PElhFsvGFC7x5I=
X-Received: by 2002:a05:6402:268d:b0:658:31e0:4ab5 with SMTP id
 4fb4d7f45d1cf-658487626dcmr360840a12.11.1769106566431; Thu, 22 Jan 2026
 10:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-3-rppt@kernel.org>
In-Reply-To: <20260105165839.285270-3-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:28:50 -0500
X-Gm-Features: AZwV_QiNfRhOr3LvFRxRYZiugzOXBGGS10OWpm02Kx5rrzXcYiqpJE34NwK_FC8
Message-ID: <CA+CK2bAuY0rKenkEbaAfnwYd8q=ER=U38TGga_8CkqZze=9Yjg@mail.gmail.com>
Subject: Re: [PATCH 2/6] kho/abi: memfd: make generated documentation more coherent
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_102928_729138_ACDB408A 
X-CRM114-Status: GOOD (  17.57  )
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

On Mon, Jan 5, 2026 at 11:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> memfd preservation ABI description starts with "This header defines"
> which is fine in the header but reads weird in the generated html
> documentation.
>
> Update it to make the generated documentation coherent.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kho/abi/memfd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.=
h
> index da7d063474a1..c211c31334a3 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -17,8 +17,8 @@
>  /**
>   * DOC: memfd Live Update ABI
>   *
> - * This header defines the ABI for preserving the state of a memfd acros=
s a
> - * kexec reboot using the LUO.
> + * memfd uses the ABI defined below for preserving its state across a ke=
xec
> + * reboot using the LUO.
>   *
>   * The state is serialized into a packed structure `struct memfd_luo_ser=
`
>   * which is handed over to the next kernel via the KHO mechanism.
> --
> 2.51.0
>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

