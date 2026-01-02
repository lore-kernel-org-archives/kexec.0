Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6187EFA3728
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FeZaCTR83z0zU9PAa5SGiNPoY7YhOVNF5fZwh0fGq9E=; b=P33G4OcZDYEcRKJrls2T1BWpxF
	HXdQZd+vgBRLuTPkrvAReLgRGXKExqKQQBDTmQ1OwqBxae1fm9VeG3LH8w7Q4cxPNTGOvASkbBQIy
	GOzYmx/H4T1uUA4ehPuJwVBcLRMHSxdu/Vx0z1NEE1diWdG/54XScfxZ8ZaJbjhauYA/UKdFmeT9z
	13a1ZpviG2ClHhhIsEktvt/jcG9GeXa1t2IUP7MbOvGaEox2w75F+FDRjkLGTA2BGhC3DCHzPf0ZL
	6nXCey9qOJN0Vxm94gPoSb3B4stqFCqjQXlnLe3xfI/YszmDvzMbZL1Jyrff/OMrqM9DhFY4yo9vB
	jV3NNO/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbhu9-00000008Uiy-19jR;
	Fri, 02 Jan 2026 16:21:33 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbhu6-00000008UiR-0LKT
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 16:21:31 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so1029189a12.3
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767370888; x=1767975688; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeZaCTR83z0zU9PAa5SGiNPoY7YhOVNF5fZwh0fGq9E=;
        b=YfVZ7+WtTv30Ts6Ma+kfTDJyAoyxnlqrLOPw2tai4LLWKo05SYbU+LZg1nxsPdefvi
         Nv9Ikpwb/9v/RWCY+KLNwk3mTbZRaWBQ+hbFZYtbXTqvllOGAfHN8xyK6cfVoleNoMhd
         dED8zLqlZoQYxbCnYlMV+rGr3sWYbkjT4v02dW0hPPQk5B7LmvT1v0KHtGAIdWHz4tRH
         xNJI1WaIb9DYL9W9Gi4IILX/WV3QfI5j5lzpaD01SffGHj48BtG1xqKUDR3hJ2O9yogF
         ++0+7dGgHcPpM9EnrnWUN2+Asxx/0dYVGdFwWI/aIa4PiU001SkR0sE1M+q5j2wbfrXm
         ZbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370888; x=1767975688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FeZaCTR83z0zU9PAa5SGiNPoY7YhOVNF5fZwh0fGq9E=;
        b=TBYu4w6llVyN/FMzcA3GtzbaUZmz1Bf5EUNxCjo96sawA4qIxHbc0hOvPSQTLmJomy
         ZSjmKMrf+uqR0bOHZ++cL9IGFs9dAjRRAWhGaah8hPgaUnhdoCKEWAX0cbYTsNkYkSOm
         rfOThUBbbbb4Os8KaaAR+W8+poWWv7kJEEQpDzezJrt7GjOWCo0vPO0hmIcLG2VDKK94
         mOqZ6le0zShuNQmWIyMswvQ6X/0GfijivXPLooOLATB7q+zhHfG9SyTEO7DTY6rHsG8B
         kyZ8EIpH9jbl5c+HXKJyAOsmSDMx83gx2CigezlBHoEChRGgGJcKyRFqSfpMf2TmDJ1h
         mwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEUpUS8IT8WeLWc5p2oRUdRrZP/JrWjiGC+ISWrP2mr83l4cZAYV76rTLvwJIEZL+T0iX6lA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdTxBPJuYGF+Zg9EUbjwHa3MI3JB2oJ+9Q/nqZo8IaOQ+SdO5S
	qJRG+r2LunYXV4e9kFDarq4M7z5EIn9PbXxc93uQlB4GP6VV5Le/lbzISTvCvdRwZlh2B8bL/OB
	Vy2LlW/SZk3EiXwPFKeKOVsG7hYvrdEAB8gDXYGiO6A==
X-Gm-Gg: AY/fxX6svs0CiVM9yjlzYVxvR28sRCNHbwgWxhw50LP+AZBmQRKHg9WtcndBFAQxf5g
	HpMw5rnoDJpjxwoZ5Ga4eGhw0tnFS03cX3ulsx/jiK3+9tifAjhPG66vxdn0kGIJ43dq89PbJN2
	yZj12IpeDjRZZuIH9MwVLfdtRLSfYLvaDQ+51ARAF9bCyFCwe1SPvoY+uDiAsMAdpVTGvcMVYqr
	q1xGpnvP46sklhm6Y9AGaFvUMIHK9uofW2zPhKRLJp61s1MIw496yEv4vJ1BzhvdFkpSWmpjzOQ
	Cwf12e6yPD1Q7JF+K6VB8BnDcA==
X-Google-Smtp-Source: AGHT+IG7pmsPoAofQfznQM6e2Gh/kun3kkcPtsdi4WWJd7drsOJjX7U23lVDS62/R4Qi/xosq4n1IxN1VMCakePPrbw=
X-Received: by 2002:aa7:c243:0:b0:64b:60e4:f898 with SMTP id
 4fb4d7f45d1cf-64b8ea51482mr31916241a12.15.1767370887834; Fri, 02 Jan 2026
 08:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org> <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
In-Reply-To: <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Jan 2026 11:20:49 -0500
X-Gm-Features: AQt7F2oOU_yPnIxT4iWmDlamG3MPvPG4XuJIPEA1lsvAsNmoyAWk5nXnBh5YsIA
Message-ID: <CA+CK2bCnBD6afWcbdmqPFBmybeH8BKLo8YSbSCUEJEY+hOij4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, usamaarif642@gmail.com, 
	rmikey@meta.com, clm@fb.com, riel@surriel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_082130_153882_C62CAC36 
X-CRM114-Status: GOOD (  24.98  )
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

On Fri, Jan 2, 2026 at 9:53=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Track and display the number of kexec boots since the last cold reboot
> when CONFIG_KEXEC_HISTORY is enabled.
>
> This extends the previous kernel release tracking feature by adding
> a counter that increments with each kexec boot. The counter provides
> visibility into the kexec chain depth, which is useful for understanding
> boot history in production environments.
>
> Add a new property, "kexec-count" in KHO FDT alongside the existing
> "previous-release" property. The counter is:
>
>  - Initialized to 0 when kho_in is instantiated.
>  - Incremented by 1 on each subsequent kexec.
>  - Printed alongside the previous kernel release version.
>
> The counter is stored as a 32-bit unsigned integer in FDT format and is
> only active when CONFIG_KEXEC_HISTORY is enabled.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 06d99627bb3c..fe5a2c5c4c86 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -38,6 +38,7 @@
>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>  #define PROP_SUB_FDT "fdt"
>  #define PROP_PREVIOUS_RELEASE "previous-release"
> +#define PROP_KEXEC_COUNT "kexec-count"
>
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>
> @@ -1257,6 +1258,7 @@ struct kho_in {
>         phys_addr_t scratch_phys;
>  #ifdef CONFIG_KEXEC_HISTORY
>         char previous_release[__NEW_UTS_LEN + 1];
> +       u32 kexec_count;
>  #endif
>         struct kho_debugfs dbg;
>  };
> @@ -1330,6 +1332,9 @@ static __init int kho_out_fdt_setup(void)
>         void *root =3D kho_out.fdt;
>         u64 empty_mem_map =3D 0;
>         int err;
> +#ifdef CONFIG_KEXEC_HISTORY
> +       u32 kexec_count;
> +#endif
>
>         err =3D fdt_create(root, PAGE_SIZE);
>         err |=3D fdt_finish_reservemap(root);
> @@ -1340,6 +1345,10 @@ static __init int kho_out_fdt_setup(void)
>  #ifdef CONFIG_KEXEC_HISTORY
>         err |=3D fdt_property_string(root, PROP_PREVIOUS_RELEASE,
>                                    init_uts_ns.name.release);
> +       /* kho_in.kexec_count is set to 0 on cold boot */
> +       kexec_count =3D cpu_to_fdt32(kho_in.kexec_count + 1);

For KHO preserved data we use native endiness, so do not bother with
cpu_to_fdt32.

> +       err |=3D fdt_property(root, PROP_KEXEC_COUNT, &kexec_count,
> +                           sizeof(kexec_count));
>  #endif
>         err |=3D fdt_end_node(root);
>         err |=3D fdt_finish(root);
> @@ -1468,6 +1477,7 @@ void __init kho_memory_init(void)
>  static void __init kho_print_previous_kernel(const void *fdt)
>  {
>         const char *prev_release;
> +       const u32 *count_ptr;
>         int len;
>
>         prev_release =3D fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len)=
;
> @@ -1476,8 +1486,19 @@ static void __init kho_print_previous_kernel(const=
 void *fdt)
>
>         strscpy(kho_in.previous_release, prev_release,
>                 sizeof(kho_in.previous_release));
> -       pr_info("This kernel was kexec'ed from kernel release: %s\n",
> -               kho_in.previous_release);
> +
> +       /* Read the kexec count from the previous kernel */
> +       count_ptr =3D fdt_getprop(fdt, 0, PROP_KEXEC_COUNT, &len);
> +       if (WARN_ON_ONCE(!count_ptr || len <=3D 0))

This function is called only once anway.

> +               /*
> +                * PROP_KEXEC_COUNT should exist if PROP_PREVIOUS_RELEASE
> +                * exists.
> +                */
> +               return;
> +       kho_in.kexec_count =3D fdt32_to_cpu(*count_ptr);
> +
> +       pr_info("This kernel was kexec'ed from kernel release: %s (kexec =
count: %u)\n",
> +               kho_in.previous_release, kho_in.kexec_count);
>  }
>  #else
>  static void __init kho_print_previous_kernel(const void *fdt) { }
>
> --
> 2.47.3
>

