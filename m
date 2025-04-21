Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DB3C369AB
	for <kexec@archiver.kernel.org>; Mon, 21 Apr 2025 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ff+h7YRAkELws4CRWM7YOB1YCS1xo5ywus2jMjXmZLo=; b=nig69oFymuLvS5znrDfWQSZ0yf
	BH6K9QggG+/QeVtEFXPsUhkZ8XlIkMlQscM8BYZ3t2rRG9/T32YNElz3jjPrbsN4tK7Kx7SPPEjD5
	jfcHmVa6VEEvY88g4BZ8Mi1j/QcdyVKX8oQ97m13Ca8pJAPNPR1Cix64wv6E8U/ogTUa/9wt8X8Wp
	MMg+IB5czIvpHucwnWoOFAG34qAPfbzIyjPM0PCn3cv0QmEf6W+pgS9pEYj3v0aVQN0XAuU9F7gGe
	ZP4hC64+J2vViQjZ+z5EXGQfSJIX5jjb+jKOGBlrviw4Z0oya49i9xouXeuKPJW3u2uKQjdVnvdFB
	fEZqqPpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6v9P-00000004qeJ-1sIp;
	Mon, 21 Apr 2025 17:41:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6v9O-00000004qe7-41r6
	for kexec@bombadil.infradead.org;
	Mon, 21 Apr 2025 17:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ff+h7YRAkELws4CRWM7YOB1YCS1xo5ywus2jMjXmZLo=; b=ORG0IapudPPt0kyVA64pyXTGLZ
	2ozgqSwMiwrIoNUfzdXuzOgGfP16RJ+MkH+lgjykjY8nOmzW5/NkJ2DMvgGjKDk0z6wNysFJIgBuW
	eQ+XYGrRi2LiWjjRcBFJl3+4TtqK8TqlR5M40OMEp71P/4+ZG8I6M8Wv9gNwdcts8y4lgfRgiy4J4
	R4jpTc/Z0wW2DChYSHRG5jQxNZZcs17DWw7J8iCANSTwDCOCGVvTT2hkZwh5+AZNMOiAVAIUEGf+N
	qORbtkQuyYEPCvSKOXk/2pk6sanGbLe+QCLnJLbDWUVNAgzwNXST9tHHRVyjKQUMMk49qS98WYQhD
	VTpPUq1A==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u6v9F-0000000B5HO-0I13;
	Mon, 21 Apr 2025 17:41:37 +0000
Message-ID: <e1e3dc8f-ca16-4cce-a670-bb8ef566213d@infradead.org>
Date: Mon, 21 Apr 2025 10:41:27 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 4/21/25 9:26 AM, Ross Philipson wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..badde1e9742e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2001,6 +2001,17 @@ config EFI_RUNTIME_MAP
>  
>  	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>  
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256

It's normal to select needed library symbols instead of depending on them.
Nothing else in the kernel tree uses depends on for these 2 Kconfig symbols.
(CRYPTO_LIB_SHAxxx)

> +	help
> +	   The Secure Launch feature allows a kernel to be loaded
> +	   directly through an Intel TXT measured launch. Intel TXT
> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
> +	   where the CPU measures the kernel image. This feature then
> +	   continues the measurement chain over kernel configuration
> +	   information and init images.

-- 
~Randy


