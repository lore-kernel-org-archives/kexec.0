Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB3DD6CFA2
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgleVbWoUUJU7J/5S8L5DRHuujiCZGV/xdGRb4522Uk=; b=IIqqCk72+nkuc+pMsS/y2h3T0B
	LggYihHMkF8KDu+hPQF/b93Vgr9JzGHcOpU6F9uT33Wto4nyL1D/hmNW48x+6kjJ0Qis2AzNVu3pX
	+d55xx63AsxLFLbFw4ONLZppcfMX3Lom+A1cLw1OF5sJuRbBUp4BMftlakTnMtthBGLtVve/yrTaZ
	jpkDFZSaQ4cH7FoVYrmnkEuu0KKTY+fsp3z7VWLmrFzNfq1sZ7bnZcBYlrVwX/i/VfE8mEe8MF2XC
	1OTdMOEmVh++HNy+MmP5/1kO/eGvYUBX6LVOLK5mtxqJMaeNNzdSz1ZUQ1aJOpbyStm6Qg/DiqAuv
	oB+j8zJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizAz-00000007cAR-3zxV;
	Thu, 22 Jan 2026 18:13:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizAy-00000007cAK-1T6o
	for kexec@bombadil.infradead.org;
	Thu, 22 Jan 2026 18:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cgleVbWoUUJU7J/5S8L5DRHuujiCZGV/xdGRb4522Uk=; b=ECkTI5/2G1tkjXjRtoZdZR1Q2K
	iRCF8qmmy7DFjh1EGgPeHQFFLUz886decgYi7SnEtNBnkAQI79Ll/hkXqXdgPiigI81K80urDeCAG
	mMcDbnBRmKyGvG/ZMDmLY7+DCwICNbjlaf7kTq8YcJvrd9J8ptjkuOBdgydNaGUvjfe38smFliDEj
	+sDtapmeNx8BwtzNNFg65O8Ak/cnohrQF+d8Oei3nhjnF/EQu5Ql/sJITKNV1L1drYg+kYwSJy7fD
	Nks2NEFgQRxU+h4NMxYO5E3eHv5+/UtZjdtCGalZDwYjIdB3cL9FD9Bsr9aMFh46u35o0boSp5IYq
	57wsx9bA==;
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizAv-000000011pv-2Rf3
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:12:59 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so1973964a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:12:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105576; cv=none;
        d=google.com; s=arc-20240605;
        b=lGuFgJJVkj+H5gWFoxRAu+w/UC2311Zp3CSSZa/She0UYeHBIHXvAMlaSJzKqxPWz1
         5TWzPzmNFoh4WjMDgz9T6nOEJBArtJVJXWeUyjEU3y4NO6EaqsBemqyAhLyAgNvZIgQw
         aioZLO81HJRjosftLRgTSVrnGJ6mYSjbH1DYCf36ZDYxgsIZ10H9Ot5iU0hAzrKGZkU4
         rk4gJNLLuSuRYkai1YAcrbq5d45OxlkSux7wttF0vwOeSf8jGUcYogsGTPKbzlYTiFV4
         UBUDlw0l4XzTsjTzVexFs2ShdIEz2FpkmSTh7Wq2DLIOwxStLnkcBWorFf7jDIYEyHkx
         foew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cgleVbWoUUJU7J/5S8L5DRHuujiCZGV/xdGRb4522Uk=;
        fh=Oe8H9KeAPwslpRakU0pSiJnI7xMnp7K+Yjr2umoSzRk=;
        b=cIUzni81zjv/frXtnx492kmkhp1232cAIAcBEvwyjmZSUreg9LYcAqNu17/1uwCF2x
         MSAWd3WjbvrpuY1sa301iuLhJNzxsnSCj6PUTzGL3syIlO38uYgkcnE8MJzcfOkCdA/3
         40mXuF1fad2+P6dBnIEs+87RCgu/DJC8EWLqx1D5YixBgz0Zp4vXi3qKWVwULSTbKc+H
         8+pGC50Wg84BlNEX4m/p/mizqNfwYJk28GjsZOf+dpZbpthS7gl8kWkZy+m2+8ltxli+
         T/iLipAwCriM8icV/723uTQjDgaVy1SrSuTExqWkU0uXkrI/d5Fr38ln3iewae+G3zO7
         d6RQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769105576; x=1769710376; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgleVbWoUUJU7J/5S8L5DRHuujiCZGV/xdGRb4522Uk=;
        b=ScbY7AmZMkieyVQilpKuI+LLAOc1KhMo1Z71v1BOq72dxVGJO1wmm3V8keeiSEvbts
         ip+FC4nJMyvRgmAfXbOWwy1F24Gy0JPH/5+tGFaqTPHzplRfvIapZAqZJEAE9CfLPyId
         AtfBTfX/fll6ZDtpNC0afiR72Xc7ooQ9fVXsEVVox+uFNgEVxvscQ9vc+GPxpQgKXhPY
         xPVWOU1I1jeFJoiDBuN/mDI3E8V48FehsE7bZbQFc2K7Dp3kamMhlD+wY4/fsB9ainOJ
         WcVjzdIpSQS/IqcHOG5V4mBu8JIW36uaoM7wmIG7k9RPP7GwtdYZJGu5ZcPixuUdxnck
         eskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105576; x=1769710376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgleVbWoUUJU7J/5S8L5DRHuujiCZGV/xdGRb4522Uk=;
        b=VeCmmDDjGEfxLxS7Ihmt4ZnvfKvP7VLM4c7C019tep+7Rzvy1qVPGUQaL+y3Aazn25
         BN2M9xmlr5fk6eCYmk8LDMADJ8MbKSqMnCJwDqFBAd5+lsXNA6vE+VRRVQxRtfgcnrPW
         qrXiN+12JaVFrzXvchsDsc5CdtFKznOoHxPPAUMpBJDKqQzgsUNRi9EA6TcsWUXX/2Ea
         PimyyS3m0fSuznqhURI+D353Im83wmlZPutG+0nvWVOj+XCYoZx9fG4UH9chf3bo1EQA
         tmUm1s7A5BS/9a1gAmaKYnYU3q8uttVyleudSoTbjD4qDEFH36q4LX4hikJ7QuOIgVYV
         6X8A==
X-Forwarded-Encrypted: i=1; AJvYcCX/lccQ6R5QeyYNPDKGuqFu9eI9IMSAy44MzqXbo7pSpWV6YqdR2r/YociP2k/0Cs9pSabyWA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBGHEhqiqZ891iN4G3neVAbny9sxQYP/Lwt+DqVa2yWKDr3a7U
	p5rf8ObE08F+KZ1bVqLxQVqPtabw3nI0MMnOQLn6FU0Hpui1/yPZlWfLcwCFubQPQP3Gjdni6Ez
	UiwT40Xx2WNRHJxfrAteJxGmOGC9RXk1lo5GRZi1IpQ==
X-Gm-Gg: AZuq6aK8NPLMJBUm9oBJI99T8y2zYpOSSGVW1pInGAbv1BHlXXf/7Gms/9116Ta9oi9
	am8Nm5nl98qUDWOiiKONIofDY8wCz6bLp1URWWnf1EzrC+1R3pxQEj7++r097Wx7dWj5mD2idF8
	psTeo87gz1g6nWEKReQH83nqtsDYmjuJQroFOa9seEV4HQQYBAfuEXLbIE446Tfbe4IArF5ZUKx
	e1mSIs+5qqStmwAjdhQ3NHHeDYdd1wvguHGohTkIdz64jmuVhodYWyoJyazAGygxFGny0l01szu
	PdLVpoDOH7TNt8EWc13b5K2lbQ==
X-Received: by 2002:a05:6402:2745:b0:64b:46d4:5d54 with SMTP id
 4fb4d7f45d1cf-65848763bd9mr334433a12.11.1769105575867; Thu, 22 Jan 2026
 10:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20260122121757.575987-1-rppt@kernel.org>
In-Reply-To: <20260122121757.575987-1-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:12:18 -0500
X-Gm-Features: AZwV_QjD1qdgR1i_TWwWe-f0Ky_qgOK6uSXJjfLb15ZCQS_D3qhs3-TkGlSTUFo
Message-ID: <CA+CK2bB-JZEFp57rCYK8wGKoGP8U1NX_nLd=RRu3ozuVn339UQ@mail.gmail.com>
Subject: Re: [PATCH] kho: cleanup error handling in kho_populate()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Pratyush Yadav <ptyadav@amazon.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_181257_739357_96E7DA09 
X-CRM114-Status: GOOD (  20.28  )
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

On Thu, Jan 22, 2026 at 7:18=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> * use dedicated labels for error handling instead of checking if a pointe=
r
>   is not null to decide if it should be unmapped
> * drop assignment of values to err that are only used to print a numeric
>   error code, there are pr_warn()s for each failure already so printing a
>   numeric error code in the next line does not add anything useful
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 39 +++++++++++++-----------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index d4482b6e3cae..e248ce2e04b7 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1441,46 +1441,40 @@ void __init kho_memory_init(void)
>  void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>                          phys_addr_t scratch_phys, u64 scratch_len)
>  {
> +       unsigned int scratch_cnt =3D scratch_len / sizeof(*kho_scratch);
>         struct kho_scratch *scratch =3D NULL;
>         phys_addr_t mem_map_phys;
>         void *fdt =3D NULL;
> -       int err =3D 0;
> -       unsigned int scratch_cnt =3D scratch_len / sizeof(*kho_scratch);
> +       int err;
>
>         /* Validate the input FDT */
>         fdt =3D early_memremap(fdt_phys, fdt_len);
>         if (!fdt) {
>                 pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_p=
hys);
> -               err =3D -EFAULT;
> -               goto out;
> +               goto err_report;
>         }
>         err =3D fdt_check_header(fdt);
>         if (err) {
>                 pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
>                         fdt_phys, err);
> -               err =3D -EINVAL;
> -               goto out;
> +               goto err_unmap_fdt;
>         }
>         err =3D fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
>         if (err) {
>                 pr_warn("setup: handover FDT (0x%llx) is incompatible wit=
h '%s': %d\n",
>                         fdt_phys, KHO_FDT_COMPATIBLE, err);
> -               err =3D -EINVAL;
> -               goto out;
> +               goto err_unmap_fdt;
>         }
>
>         mem_map_phys =3D kho_get_mem_map_phys(fdt);
> -       if (!mem_map_phys) {
> -               err =3D -ENOENT;
> -               goto out;
> -       }
> +       if (!mem_map_phys)
> +               goto err_unmap_fdt;
>
>         scratch =3D early_memremap(scratch_phys, scratch_len);
>         if (!scratch) {
>                 pr_warn("setup: failed to memremap scratch (phys=3D0x%llx=
, len=3D%lld)\n",
>                         scratch_phys, scratch_len);
> -               err =3D -EFAULT;
> -               goto out;
> +               goto err_unmap_fdt;
>         }
>
>         /*
> @@ -1497,7 +1491,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 =
fdt_len,
>                 if (WARN_ON(err)) {
>                         pr_warn("failed to mark the scratch region 0x%pa+=
0x%pa: %pe",
>                                 &area->addr, &size, ERR_PTR(err));
> -                       goto out;
> +                       goto err_unmap_scratch;
>                 }
>                 pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &s=
ize);
>         }
> @@ -1519,13 +1513,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u6=
4 fdt_len,
>         kho_scratch_cnt =3D scratch_cnt;
>         pr_info("found kexec handover data.\n");
>
> -out:
> -       if (fdt)
> -               early_memunmap(fdt, fdt_len);
> -       if (scratch)
> -               early_memunmap(scratch, scratch_len);
> -       if (err)
> -               pr_warn("disabling KHO revival: %d\n", err);
> +       return;
> +
> +err_unmap_scratch:
> +       early_memunmap(scratch, scratch_len);
> +err_unmap_fdt:
> +       early_memunmap(fdt, fdt_len);
> +err_report:
> +       pr_warn("disabling KHO revival\n");

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Nice clean-up, thanks.

Pasha

