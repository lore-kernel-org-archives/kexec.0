Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4939C5CFDB
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpKsPUcvfKXegQzg7KkqL+Bcp0KZtYbTU/PRYTZP8pU=; b=JEmM2y0rJDvqT+Ei2JGvLg6h6W
	0piq5Kuq9K6TUtilPO+NSJ3eEmZxlyEt65TSLUEn5PcXzM9SJz34qPrTnIyt/Is7YG5FIaPho4BQm
	rFPY2YTvGHoxc7JYbFiu6iC1ccyIQHalK+qKIpPz02PyvwSfqaIuxmczjPfbM8BRlV5HYtF0f5v5i
	eyfLom3ch1PzxkZYNfAwMZ1wsgJma1xnoGO9hBcr5YMAv+bXSlNE5I33lTrRzKoFB7LoErQ8XgjFh
	m+MgS/twPHJgMsLAAVGFG66I6AopKpXnxaQySarjQC0DuKBuxTSU7Xds87CSCeHJ8vwcWHqPEaNgM
	dbjmWlvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wure8-00000002h3Y-0rix;
	Fri, 14 Aug 2026 13:08:28 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wure5-00000002h34-3mbb
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 13:08:27 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1677c91969so127070366b.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786712903; x=1787317703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpKsPUcvfKXegQzg7KkqL+Bcp0KZtYbTU/PRYTZP8pU=;
        b=gSFAUHCrSmuw5YCc/zuoWphhBA1CYUGhVgIg98J3VTdPs7m8iVc/xG3AjgtchYGisM
         LPwWAGn7vXZE5t7kV9qjJEgfh2UYxfneLj7i1X3dSgti/y1eHF17QOJBmgyuxTFxBthT
         npQb1ij+cux0gqCxpZfbeQpnKJWxzHs0l1citix+nyUUQWuWt8ZbAPH9LNIrPXyWGWzq
         9Li09lUuVMtqoRs3CLjU5nqcdC1iDBur83ruW1seQYAOxAV4U0+OG8hY4qoMCT1aMEVb
         K/LfczsnK9pe2GUBHrQdBCDUNqGeM/5b+1VoXl95XkYbNMBD9p7zk5ynDEyxaJgD3Et/
         rSDg==
X-Forwarded-Encrypted: i=1; AHgh+Ro88OcEGL+o8TrgmyezArTWaq62ekYCi9dJlF/9KmrbgE+3RfyuEQP8nBV2xzF4gAqZZmJaIg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx33eFYdH+YwGPuD+CPlUzUfOt5lA3C39Y+Dom+2Tj2nuqUD0jW
	Eo1INNIRj8bgDGepGXlTyNK2msUHFWlr2uRyWkSq1db5aHtAHeDYktgIhltb1g5IFWA=
X-Gm-Gg: AR+sD12xY9VI8k8PlNO80FsHTD3znQvkb1LeWP5FyA1Y8v8xx5u9Dois2YU20xAFMcd
	50whc+ykznS17fLSBWNlnalMO9UeE7D5mgGwqyCeQrWuS6KoGU5TeR2B1j/7sqinz1iHUem0I0O
	fvOK/8AxFtf6YVRSi8H+A05XC4ZLZxK6mKMUO7/GiSigtz2AtNmDJhJWu65Y57zHSrwbY83F6yl
	ZT7vTK+I/dDLQt6Wg6SBlh+dZlfZ+P/ma5Kw+KKgY+zP0ylHNv+XUc8DGDRl8q1SPkZHGRz/p/M
	P9qsOT/TotAL2he3Yj2yCbTQR5zmnq+4/7uRYafYfNrk7BlHohEJkwGBcwpjUIDWuh1HSW43oWs
	Gx2AP1vVO4MLsWd3f9giVN2R1koxg08UXwVNVofFOBLBv1g5j7gzwopGo/ywAcLwMZC+Z8Vtqz1
	o8TqjK1d857h6l/yOVq44Bh47gspGH1XrWJ/0eVlwbWGsmDYnsRNEki51w3ZT3ZPTkHc4yVh+Li
	vSOfGCGGA+S5oap4qo=
X-Received: by 2002:a17:907:3d50:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c212a14ee9emr280407766b.13.1786712903483;
        Fri, 14 Aug 2026 06:08:23 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a23fesm104682166b.1.2026.08.14.06.08.22
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:08:22 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1408440a12.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 06:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpXP0FRKlQogIc17dD5/FcUkSacQbXdW56dip54JRKCgxVo9hZeg7x2BdaR7hdOqUc/8NuCYw==@lists.infradead.org
X-Received: by 2002:a17:907:980a:b0:c20:eea4:267c with SMTP id
 a640c23a62f3a-c212a8b725amr256899366b.30.1786712901999; Fri, 14 Aug 2026
 06:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260813165654.36098-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260813165654.36098-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 14:08:10 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
X-Gm-Features: AUfX_mzBSOfXwtJ5pD6mo8sbrCNXyHrVNtlB2GQLFDuAwYnXUpBucQGGaS7Lzek
Message-ID: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_060825_984984_6711B161 
X-CRM114-Status: GOOD (  26.52  )
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

On Thu, Aug 13, 2026 at 5:57=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_parse_binary() reads the size field of the certificate table's
> data-directory entry, which sits at fixed index 4 of the PE optional
> header's data directory:
>
>         ctx->certs_size =3D ddir->certs.size;
>
> but nothing ensures index 4 is present. n_data_dirents (the untrusted
> NumberOfRvaAndSizes) is only upper-bounded against header_size and may be
> 0, and header_size need only satisfy cursor < header_size < datalen. A
> crafted PE with n_data_dirents =3D 0 and a tiny header_size therefore cau=
ses
> the ddir->certs.size read to land past the end of the image (CWE-125). Th=
e
> chkaddr() that bounds the certificate blob runs only after this read.
>
> verify_pefile_signature() is reached from kexec_file_load() (the
> lockdown/secure-boot enforced PE-image signature path), and the image is
> parsed before its signature is checked. The trigger needs CAP_SYS_BOOT an=
d
> the access is out-of-bounds read only (no write).
>
> Require the certificate table's data-directory entry (index 4) to be
> present; the existing upper-bound check then keeps ddir->certs within
> [cursor, header_size).
>
> Fixes: 26d1164be37f ("pefile: Parse a PE binary to find a key and a signa=
ture contained therein")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case t=
hat

Any reason not to commit this as well?

> builds a crafted PE (valid MZ/PE/PE32 magics, data_dirs =3D 0, header_siz=
e just
> past the optional header) and calls verify_pefile_signature() with a NULL
> keyring -- the parse runs before any signature check. On an unpatched ker=
nel:
>
>     BUG: KASAN: slab-out-of-bounds in verify_pefile_signature+0x1d6/0x950
>     Read of size 4 ... in pefile_parse_binary() (inlined)
>
> With this patch the crafted image is rejected (-ELIBBAD) before the read =
and
> the case passes with no KASAN report. The test is not included here; happ=
y to
> submit it separately.
>
>  crypto/asymmetric_keys/verify_pefile.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db..e7f8bdb 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -87,6 +87,10 @@ static int pefile_parse_binary(const void *pebuf, unsi=
gned int pelen,
>         if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*d=
de))
>                 return -ELIBBAD;
>
> +       /* The certificate table entry is at fixed index 4 of the data di=
rectory. */
> +       if (ctx->n_data_dirents <=3D 4)

My agent suggested replacing 4 with offsetof(struct data_directory,
certs) / sizeof(*dde) to make it more obvious, however not married to
it.

> +               return -ELIBBAD;
> +
>         ddir =3D pebuf + cursor;
>         cursor +=3D sizeof(*dde) * ctx->n_data_dirents;
>
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> --
> 2.53.0
>
>

Ignat

