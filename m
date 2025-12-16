Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E205D5E14E
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Owz+SqmUbMxEza/nbiqSp1ZviUjX8HAPBLSYA5hAFI=; b=XbgSq5Jh7iNVorFyDAzRzmQRRv
	lEsWFNESekN4fSLqxYDmOvzZ/DynC9b30m02TxryQTzv2EYu6JPeNjp6uUpwSI1vkQfROgQqCgeHm
	eivSl+JmzJUvIo1X1TFePRNEgBTmRpjvFe3ylZQseTZ1I2WqbcwzFKaLCivvNxuNV4E9JHTKJqD7u
	RvNZlCC/RcvZEPyDPtwJ5tdTKdLF8sNnIX25fJsMosA4Cq9t5c0ehMht4/V1fBqzsnS6wS9S1gVEV
	z9/9/iLe5lk4YOjcdGWgnShMc2Bj/dgkKgTl/EskPGoLoy7oPAoVGzzwIhJQtamajIJxj8XEkMZYe
	/lftQhdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV3D-00000005FGx-1zEa;
	Tue, 16 Dec 2025 13:25:15 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV3A-00000005FGS-2c3p
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 13:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765891512; x=1797427512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Owz+SqmUbMxEza/nbiqSp1ZviUjX8HAPBLSYA5hAFI=;
  b=cA7Vz9X8aUlAndfnieBCiLZ8SreOYorjfnTs6zXd/MrStNha3CA2U7CF
   fCRHXU/INWpuTNfEBPkgizOVQZ/LmXSXe8RfBocrpnzmHtR7yn98CEHpK
   co5W9oQlxtxr219ifXT2731YeAfwYA9QrvArTwfY8wHd/o0R0XklSNfL1
   SGuUjp1xYlESZrBwbcZW+VLE0kbZa5a/GpK2mIg6ss7bxYPLQsahjVWqz
   W4++GYvIm0WG4gsp68eNGsX2Aga9FuFPKCh9QQUomBHrwNlB5S4xO+IGr
   hI80iinX9x7rRS6/h1NLzMfpu49budx0+jVP+MPQoMFN5zT+T/yloZqQz
   w==;
X-CSE-ConnectionGUID: K5ndT0gFQmeqj3A9lSSyfQ==
X-CSE-MsgGUID: 8SweK6QCRJ6oI+XRhjCbsA==
X-IronPort-AV: E=Sophos;i="6.21,153,1763424000"; 
   d="scan'208";a="9177461"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 13:25:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17082]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.145:2525] with esmtp (Farcaster)
 id 8dfd8098-be01-4286-baba-bb6b63f882de; Tue, 16 Dec 2025 13:25:07 +0000 (UTC)
X-Farcaster-Flow-ID: 8dfd8098-be01-4286-baba-bb6b63f882de
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 16 Dec 2025 13:25:00 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 16 Dec 2025
 13:24:58 +0000
Date: Tue, 16 Dec 2025 13:24:55 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Pratyush Yadav <pratyush@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>, Jason Miu <jasonmiu@google.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
Message-ID: <aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20251211042624.175517-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251211042624.175517-1-pratyush@kernel.org>
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_052512_766879_FC5D29E6 
X-CRM114-Status: GOOD (  33.67  )
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

On Thu, Dec 11, 2025 at 01:26:22PM +0900 Pratyush Yadav wrote:
> As live update evolves, there will be a need to update the serialization
> formats for the different file types. This could be for adding new
> features, for supporting a change in behaviour, or to fix bugs.
> 
> If the current kernel does not understand the same set of versions as
> the next kernel, live update will inevitably fail. The next kernel will
> be unable to understand the handed over data and will be unable to
> restore memory, devices, IOMMU page tables, etc.
> 
> List the set of versions the kernel understands in a section in vmlinux.
> This can then be used by userspace tooling to make sure the set of file
> descriptors it uses have the same version between both kernels. If there
> is a mismatch, the tooling can catch this early and abort live update
> before it is too late.
> 
> The versions are listed in a section called ".liveupdate_versions". The
> section has a header that contains a magic number and the version of the
> data format. The list of version strings directly follow this header.
> Only the version strings are listed, and it is up to userspace to map
> them to file descriptor types.
> 
> The format of the section has the same ABI rules as the rest of LUO ABI.
> 
> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
> file handler while also adding its version string to the right section.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e04d56a5332e..a474c9529a5f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -342,6 +342,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define THERMAL_TABLE(name)
>  #endif
>  
> +#ifdef CONFIG_LIVEUPDATE
> +#define LIVEUPDATE_VERSIONS						\
> +	. = ALIGN(8);							\
> +	.liveupdate_versions : AT(ADDR(.liveupdate_versions) - LOAD_OFFSET) {	\
> +		KEEP(*(.liveupdate_sec_hdr))				\
> +		KEEP(*(.liveupdate_versions))				\
> +	}
> +#else
> +#define LIVEUPDATE_VERSIONS
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	__dtb_start = .;						\
> @@ -544,6 +555,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  	RO_EXCEPTION_TABLE						\
>  	NOTES								\
>  	BTF								\
> +	LIVEUPDATE_VERSIONS						\
>  									\
>  	. = ALIGN((align));						\
>  	__end_rodata = .;
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 4a1cc6a5f3f8..57ef75695f62 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -244,4 +244,38 @@ struct luo_flb_ser {
>  #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
>  #endif
>  
> +#define LIVEUPDATE_VER_HDR_MAGIC 0x4c565550 /* 'LVUP' */
> +#define LIVEUPDATE_VER_HDR_VER   1
> +
> +/**
> + * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
> + * @magic:     Magic number.
> + * @version:   Version of the header format.
> + *
> + * This struct is the header for the vmlinux section ".liveupdate_versions". The
> + * section contains the list of file handler versions that the kernel can
> + * support.
> + */
> +struct liveupdate_ver_hdr {
> +	u32 magic;
> +	u32 version;
> +};

I believe we are going to have two main classes of LUO objects that are
going to participate in Liveupdates, when it comes to their criticality

- Core/Mandatory components. Theese components are necessary for the
kexec to be succesfull. Think components like IOMMU page tables, as
you have mentioned.

- Acceleration/Optional Components. As we strive to minimise the blackout
time, we will trying to persist more and more state across kexec, that
are currently being initialised from scratch during boot. Thing of
certain optimisation like PCI onboarding (at least parts of it)
and the PCI Config Space Cache. If theese components are incompatible
between versions, we might still want to proceed, with the LU, at the
cost of increased blackout time.

I believe it will be quite usefull to be able to have the ability
to differentiate between the two.

> +
> +/**
> + * struct liveupdate_ver_table - Table of file handler versions that the kernel
> + * can support.
> + *
> + * @hdr:        Table header.
> + * @versions:   List of versions the kernel supports. The strings ate
> + *              NUL-terminated, but to keep the format simpler always take up
> + *              LIVEUPDATE_HNDL_COMPAT_LENGTH bytes.
> + *
> + * The list of versions immediately follows the header. The number of versions
> + * are determined by section length.
> + */
> +struct liveupdate_ver_table {
> +	struct liveupdate_ver_hdr hdr;
> +	char versions[][LIVEUPDATE_HNDL_COMPAT_LENGTH];
> +};
> +
> -- 
> 2.43.0
>

Kind Regards,
Evangelos



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


