Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C066C71157
	for <kexec@archiver.kernel.org>; Wed, 18 Jun 2025 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oG1jOWrTQFrY7bmKtK5Zy2/iqOGLNGtdVkwrWEVZWdo=; b=bZmPPPZMWOzZyU/ldfr9VHht3W
	TCA6AMZWnJMHJx5jZS3EVauQ+Ll6VxGzrRoPjrk0ER6nEqrBQQaZuHwcI41gvbLuN9h36r5zLTR+f
	TsG7oJ2U99xbhPhaS7Bjfk/ebHM1w6JseuDJkr8r7c7u5azzHRn0jZ2UnSBkgVLR1sBAtcad1pvW6
	UG4SATjZhOUBjxEbAI7XNNs67YrRd41p5fTlOBa7CjK/nDrmxBO0u+GCOsl05EMp7RDbP++gWB2Lj
	xDnNzm8xin+mRJb2/lj/+zV84iMCN+33qbMTwDYexbvTjPw+2SOf+tlJUWQGyuu/XmepaI06njVvF
	Y3L4FojQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRoEg-00000009Q3s-1H8W;
	Wed, 18 Jun 2025 08:33:34 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRoDg-00000009PtN-0sDV
	for kexec@lists.infradead.org;
	Wed, 18 Jun 2025 08:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750235552; x=1781771552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fIu3H0X1ir+ab5DgfWZw8Zxf2egqeIQlXSOMOU+My5c=;
  b=Xmanw83lxbDqXUAWBcB00GhikJFnqSdlwXfW6Vw66TMRdXzePjbEjAs4
   D61fIDG895Gr29vo/12YODoJ+/L0oAoM0AJcn3ngl+DMqIJjHehauUzHl
   lk0A8T7kFEBL0Vf2KIiNOkkeAq21AKalrtnOW0+lrtZe9ZeQ9CI1LPkzG
   YrFdZLsElYNgBWQlFQxvgUtOMsaQ2YcRl+oYLgVNcgC2zcjap+iYSQemQ
   fmL2YGA5IlBmbETiQAEyOS9/qAw3Xn/HXwibsn9Zqt7kxVPR3U/AAEjbA
   756MllepzrWblufUKDkGU2Dx5MLRkXC4TpkxGLlhPViUu0yvoX/HMQY00
   A==;
X-CSE-ConnectionGUID: 8/ogm+rUQVKA2sqFs4PYbA==
X-CSE-MsgGUID: TlybXbCoTEuHX91IAYo+Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63048650"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63048650"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:32:27 -0700
X-CSE-ConnectionGUID: XdbUQy3CRfOUfn7iOGHy+w==
X-CSE-MsgGUID: HBtqD8F8So280xiJlFKgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149986926"
Received: from mmowka-mobl.ger.corp.intel.com (HELO [10.245.101.212]) ([10.245.101.212])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:32:20 -0700
Message-ID: <231e4cef-2e44-4e25-9169-f298e72e8e07@linux.intel.com>
Date: Wed, 18 Jun 2025 10:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] x86: Secure Launch Kconfig
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Language: pl
From: "Mowka, Mateusz" <mateusz.mowka@linux.intel.com>
In-Reply-To: <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_013232_291694_FEA9EA15 
X-CRM114-Status: GOOD (  12.71  )
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


On 21-Apr-25 6:26 PM, Ross Philipson wrote:
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Acked-by: Mateusz Mowka <mateusz.mowka@linux.intel.com>

> ---
>   arch/x86/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..badde1e9742e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2001,6 +2001,17 @@ config EFI_RUNTIME_MAP
>   
>   	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>   
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
> +	help
> +	   The Secure Launch feature allows a kernel to be loaded
> +	   directly through an Intel TXT measured launch. Intel TXT
> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
> +	   where the CPU measures the kernel image. This feature then
> +	   continues the measurement chain over kernel configuration
> +	   information and init images.
> +
>   source "kernel/Kconfig.hz"
>   
>   config ARCH_SUPPORTS_KEXEC

