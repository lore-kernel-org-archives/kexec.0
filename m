Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B62BD5C0C5
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHYvE/RwhbWxyv6LR2HFPMM/SlGaue2aVCL8Y+jEiaA=; b=DgkLszw0qXH22Zh0lzvPLyRAM6
	SH9vSBJq5LlKdnRbp8hnRVGmsN+7aDcKnE2lH/fRqb5VWzolOTy6jkGL2QDd7N+YcESzfbOyEZEGb
	TiEi07hKM/2W2mkSQO4Gvygiuxb8McixGOl9IXLdqELlEGFElPn74mLxlrCJyB2rd3w2YCQ9kh39Q
	PsrlpbmPvqq1vSj9M/+UFsFi0SY8gS7mAipXkL3TGy1CJ0NlttHXVxq7xqezVIK6D/3XawAJC+Jja
	t+X4Tx3Cw78aAkCeWa+aIhVEtsiRiUjSU7yX0KRssUHQVAj5RoKDF3xKJN9hVjfou5XMEsasO/wdE
	R5aj6Bkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLbo-00000004cW7-2Uk3;
	Tue, 16 Dec 2025 03:20:20 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLbi-00000004cU4-4Bg6;
	Tue, 16 Dec 2025 03:20:15 +0000
Message-ID: <f2b1d24f-86fd-4b90-b6c0-126a4a2368ec@infradead.org>
Date: Mon, 15 Dec 2025 19:20:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/28] x86: Secure Launch Kconfig
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
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-14-ross.philipson@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251215233316.1076248-14-ross.philipson@oracle.com>
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



On 12/15/25 3:33 PM, Ross Philipson wrote:
> Add a Kconfig option for compiling in/out the Secure Launch feature.
> Secure Launch is controlled by a singel boolean on/off.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/Kconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..9404d207c420 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1975,6 +1975,20 @@ config EFI_RUNTIME_MAP
>  
>  	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>  
> +config SECURE_LAUNCH
> +	bool "Secure Launch DRTM support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
> +	select CRYPTO_LIB_SHA1
> +	select CRYPTO_LIB_SHA256
> +	help
> +	  The Secure Launch feature allows a kernel to be launched directly
> +	  through a vendor neutral DTRM (Dynamic Root of Trust for Measurement)

	                           DRTM

> +	  solution, with Intel TXT being one example.  The DRTM establishes an
> +	  environment where the CPU measures the kernel image, employing the TPM,
> +	  before starting it. Secure Launch then continues the measurement chain
> +	  over kernel configuration information and other launch artifacts (e.g.
> +	  any initramfs image).
> +
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SUPPORTS_KEXEC

-- 
~Randy


