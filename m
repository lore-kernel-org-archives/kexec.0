Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03198EB64DD
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRd90s6EziiKhYT+QNJhq3CJcXZ7sEIToA5kQmaNmuE=; b=AAFLEpDGRwy/zjqhy8367rO68h
	+L+lXIGzjCMexTVT47pNsbf5rQCr+9AyzUwtoeBL7ZACDOjUi1exB0py7CeVqwguO9er9zFqyaBEl
	recMVNvbrAwJKVayV11HIDLHUYWhn7ySsFriJzuxvhHEv0KXnH4N+9pyPY7WG7ucnLIT1YhVMkuSW
	kfYuWB+xu4Q46npoGLzKzv6bOcVvpaE8CTCkW4VbtyFR+FP8GzcBkwQSkp0CTUHZS3BEFggOd2TuU
	kFbxGuVDwqTlN24FZNZinEJsHnGEJAavam5Z6bzzhBa9NnjRMgB/Laxtzn3QpWsJ4/ZEB7pBIvTNq
	7bj7L/3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVU8-00Gu95-0w;
	Mon, 14 Aug 2023 11:11:44 +0000
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVU5-00Gu8O-01;
	Mon, 14 Aug 2023 11:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692011500; x=1723547500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dfZiIx9DNqYYM4TCX83FaAZWRe4fSUR0kNXOUi2IisI=;
  b=yTN0jXbWHiwWpnn1Lr9jwEgYvScY98RSR4hBFoMAJxgSeh4pRZV9/dCN
   8/Qu/pv5mVuyVGUUW6bm9UT54LnE1tkgoi/GAchBthdfbkx9UXthvGOcW
   go0YsOjbg8UDsR71Ul5buX1r0ShuWizsem5wP4+sVa6nQe5VxbsW8HHZu
   oamgtLHOSFuq/dUjjV0jTkQc4szHsFZV93XAcHY9OeAenPqaAOlo8RV9g
   M9ArP146fNXKqqquAGRjCRAMyDJklp1mCLhJZXvgQ4WSiREoiVq1Dl0tq
   dlVmV/f4I0FMU9W6Y4AzeAdseHzyVaKUa+F56BE1pXcBbcl2PJRUkVXAj
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="228811539"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 04:11:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 04:11:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 04:11:36 -0700
Date: Mon, 14 Aug 2023 12:10:58 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Song Shuai <songshuaishuai@tinylab.org>
CC: <xianting.tian@linux.alibaba.com>, <guoren@kernel.org>,
	<horms@kernel.org>, <huanyi.xj@alibaba-inc.com>, <mick@ics.forth.gr>,
	<yixun.lan@gmail.com>, <kexec@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] RISC-V: Use linux,usable-memory-range for crash
 kernel
Message-ID: <20230814-hefty-reformist-ac79d3c6b84b@wendy>
References: <20230811104117.91406-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
In-Reply-To: <20230811104117.91406-1-songshuaishuai@tinylab.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_041141_071179_C93FF662 
X-CRM114-Status: GOOD (  22.39  )
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
Content-Type: multipart/mixed; boundary="===============3104680897740961569=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============3104680897740961569==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QZ2sEnMXCis/Ln1"
Content-Disposition: inline

--5QZ2sEnMXCis/Ln1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 06:41:16PM +0800, Song Shuai wrote:
> Now we use "memeory::linux,usable-memory" to indicate the available
> memory for the crash kernel.
>=20
> While booting with UEFI, the crash kernel would use efi.memmap to
> re-populate memblock and then first kernel's memory would be corrputed.
> Consequently, the /proc/vmcore file failed to create in my local test.
>=20
> And according to "chosen" dtschema [1], the available memory for the
> crash kernel should be held via "chosen::linux,usable-memory-range"
> property which will re-cap memblock even after UEFI's re-population.
>=20
> [1]:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/ch=
osen.yaml

nit: Please use Link: tags for links rather than free-form text.

This doesn't apply to fixes, for-next or master. What is your base?

>=20
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  kexec/arch/riscv/kexec-riscv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-risc=
v.c
> index fe5dd2d..5aea035 100644
> --- a/kexec/arch/riscv/kexec-riscv.c
> +++ b/kexec/arch/riscv/kexec-riscv.c
> @@ -79,20 +79,20 @@ int load_extra_segments(struct kexec_info *info, uint=
64_t kernel_base,
>  		}
> =20
>  		ret =3D dtb_add_range_property(&fdt->buf, &fdt->size, start, end,
> -					     "memory", "linux,usable-memory");
> +					     "chosen", "linux,usable-memory-range");
>  		if (ret) {
> -			fprintf(stderr, "Couldn't add usable-memory to fdt\n");
> +			fprintf(stderr, "Couldn't add usable-memory-range to fdt\n");
>  			return ret;
>  		}
> =20
>  		max_usable =3D end;
>  	} else {
>  		/*
> -		 * Make sure we remove elfcorehdr and usable-memory
> +		 * Make sure we remove elfcorehdr and usable-memory-range
>  		 * when switching from crash kernel to a normal one.
>  		 */
>  		dtb_delete_property(fdt->buf, "chosen", "linux,elfcorehdr");
> -		dtb_delete_property(fdt->buf, "memory", "linux,usable-memory");
> +		dtb_delete_property(fdt->buf, "chosen", "linux,usable-memory-range");
>  	}
> =20
>  	/* Do we need to include an initrd image ? */
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

--5QZ2sEnMXCis/Ln1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNoLvgAKCRB4tDGHoIJi
0oOUAQCEp5U+5Ar86ZfDeRrzBoiGwGx7PTBlQ7jVzWiQwlvX9wEAhS4CE94PDiPO
ygkuN38oB73zZDDXHraP1MBYmHVi1ws=
=02+3
-----END PGP SIGNATURE-----

--5QZ2sEnMXCis/Ln1--


--===============3104680897740961569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3104680897740961569==--

