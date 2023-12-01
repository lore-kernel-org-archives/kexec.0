Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB32C10DCE
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O928VNh9uVVbDDtwhjeIIx227wIHCAZjaKECnU565TA=; b=KO1cqAYBm8nkk/UTZte+dEpOSv
	j0vsiLfKFVQ89MT9fGHTwmkDSVtkq4fXKY/4gUVQk2NsDuQaaI/LC89oAk1MsjVEjPf0RBouk5bEV
	Vo1BhSld71jFax2VIbH/InrGuhNmyEg6zfVbiqCxrqwlfOIgfRCxnr2BYRUYh/sAc/T9kT+WRJzZQ
	I2NIYQEgSn2QtNH3A4aPoQKZDNVsUzBNTe7fyb6OAH3AcHZmzJfZVZd13Hfvtg24RZoX90K0sTUO2
	JlAxJ/lkbSOE/H3D5jY2ciixr13kfG1zbyu+0E3fhmmLrO3Al5kTkSiwGoIhDrZo2vDQO9Nn3r+BS
	y3xNCecw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r90vT-00DETK-1b;
	Fri, 01 Dec 2023 10:39:15 +0000
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r90vQ-00DESI-3C;
	Fri, 01 Dec 2023 10:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701427152; x=1732963152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kND13bhhr35acgxOCU8wE4eGgbORidUOksqg08kH6S0=;
  b=wmNYji2d2217Xfb0X0j49YoQ06JjO8ozghgkyktmkirxTWBU5YK26GOT
   fGMES5f+4FEs8qtwB4d91cE2gmY9c0L+6JLtIZ/9qMUOxe0x2UoDdAYdp
   M3mHXf4/23Mr3IDUE3kjxua6zNZbV7+//rt94womlF01ehlX2bMRGDq1e
   FQWjR3SP4iabzjfJ+ssZxwZ12vkp05u/77ggXJi6nHMVYZwew7YGq64+z
   XKK0/pgM/JvarxrWx3mYk72Nm4HTPYaWX/J34QkU3LHsOAIta104K56ZC
   xQUzETVVQ8SQylbtVXmn2Hu1ncsy2SvM0rPrIWVLyTdfvY1JGZpdk4zy4
   w==;
X-CSE-ConnectionGUID: 7PeIiSJ3S3Sf51tB+gQejg==
X-CSE-MsgGUID: 5laFXParRc6ZcUs/oGnMUw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="13412417"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 03:39:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 03:38:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 03:38:42 -0700
Date: Fri, 1 Dec 2023 10:38:13 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-parisc@vger.kernel.org>, <akpm@linux-foundation.org>,
	<joe@perches.com>, <nathan@kernel.org>
Subject: Re: [PATCH v3 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <20231201-blog-blasphemy-985d2665903c@wendy>
References: <20231130023955.5257-1-bhe@redhat.com>
 <20231130023955.5257-6-bhe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231130023955.5257-6-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_023913_219473_6685E5CD 
X-CRM114-Status: GOOD (  21.93  )
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
Content-Type: multipart/mixed; boundary="===============1777004235965798896=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============1777004235965798896==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wYVOP/ERUSSrsdpK"
Content-Disposition: inline

--wYVOP/ERUSSrsdpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:39:53AM +0800, Baoquan He wrote:

$subject has a typo in the arch bit :)

> Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> loading related codes.

Commit messages should be understandable in isolation, but this only
explains (part of) what is obvious in the diff. Why is this change
being made?

>=20
> And also remove kexec_image_info() because the content has been printed
> out in generic code.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/riscv/kernel/elf_kexec.c     | 11 ++++++-----
>  arch/riscv/kernel/machine_kexec.c | 26 --------------------------
>  2 files changed, 6 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index e60fbd8660c4..5bd1ec3341fe 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -216,7 +216,6 @@ static void *elf_kexec_load(struct kimage *image, cha=
r *kernel_buf,
>  	if (ret)
>  		goto out;
>  	kernel_start =3D image->start;
> -	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> =20
>  	/* Add the kernel binary to the image */
>  	ret =3D riscv_kexec_elf_load(image, &ehdr, &elf_info,
> @@ -252,8 +251,8 @@ static void *elf_kexec_load(struct kimage *image, cha=
r *kernel_buf,
>  		image->elf_load_addr =3D kbuf.mem;
>  		image->elf_headers_sz =3D headers_sz;
> =20
> -		pr_debug("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\=
n",
> -			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> +		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=3D0=
x%lx\n",
> +			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> =20
>  		/* Setup cmdline for kdump kernel case */
>  		modified_cmdline =3D setup_kdump_cmdline(image, cmdline,
> @@ -275,6 +274,8 @@ static void *elf_kexec_load(struct kimage *image, cha=
r *kernel_buf,
>  		pr_err("Error loading purgatory ret=3D%d\n", ret);
>  		goto out;
>  	}
> +	kexec_dprintk("Loaded purgatory at 0x%lx\n", kbuf.mem);
> +
>  	ret =3D kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
>  					     &kernel_start,
>  					     sizeof(kernel_start), 0);
> @@ -293,7 +294,7 @@ static void *elf_kexec_load(struct kimage *image, cha=
r *kernel_buf,
>  		if (ret)
>  			goto out;
>  		initrd_pbase =3D kbuf.mem;

> -		pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
> +		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_pbase);

This is not a pr_debug().

>  	}
> =20
>  	/* Add the DTB to the image */
> @@ -318,7 +319,7 @@ static void *elf_kexec_load(struct kimage *image, cha=
r *kernel_buf,
>  	}
>  	/* Cache the fdt buffer address for memory cleanup */
>  	image->arch.fdt =3D fdt;

> -	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
> +	kexec_dprintk("Loaded device tree at 0x%lx\n", kbuf.mem);

Neither is this. Why are they being moved from pr_notice()?

Thanks,
Conor.

>  	goto out;
> =20
>  out_free_fdt:
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 2d139b724bc8..ed9cad20c039 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -18,30 +18,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> =20
> -/*
> - * kexec_image_info - Print received image details
> - */
> -static void
> -kexec_image_info(const struct kimage *image)
> -{
> -	unsigned long i;
> -
> -	pr_debug("Kexec image info:\n");
> -	pr_debug("\ttype:        %d\n", image->type);
> -	pr_debug("\tstart:       %lx\n", image->start);
> -	pr_debug("\thead:        %lx\n", image->head);
> -	pr_debug("\tnr_segments: %lu\n", image->nr_segments);
> -
> -	for (i =3D 0; i < image->nr_segments; i++) {
> -		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
> -			image->segment[i].mem,
> -			image->segment[i].mem + image->segment[i].memsz);
> -		pr_debug("\t\t0x%lx bytes, %lu pages\n",
> -			(unsigned long) image->segment[i].memsz,
> -			(unsigned long) image->segment[i].memsz /  PAGE_SIZE);
> -	}
> -}
> -
>  /*
>   * machine_kexec_prepare - Initialize kexec
>   *
> @@ -60,8 +36,6 @@ machine_kexec_prepare(struct kimage *image)
>  	unsigned int control_code_buffer_sz =3D 0;
>  	int i =3D 0;
> =20
> -	kexec_image_info(image);
> -
>  	/* Find the Flattened Device Tree and save its physical address */
>  	for (i =3D 0; i < image->nr_segments; i++) {
>  		if (image->segment[i].memsz <=3D sizeof(fdt))
> --=20
> 2.41.0
>=20

--wYVOP/ERUSSrsdpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWm3lQAKCRB4tDGHoIJi
0nX0AQCpYcMDvEZkiURX4HuWR6f07qzIgnGA3t5YUQXybVgkdgEA8aFCzMsJ+OAw
e4Eamn2O6nkQzVIqTW2OfkCeXoYouAk=
=MSGD
-----END PGP SIGNATURE-----

--wYVOP/ERUSSrsdpK--


--===============1777004235965798896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1777004235965798896==--

