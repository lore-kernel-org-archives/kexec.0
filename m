Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224AAC4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uvYqDTJCt+M4e3o1kWwZblw5wp3W8FFrXe9J3YwhWCE=; b=UgiHqKP/TN4174
	IfcQDUdznCJWKLLoXJaCJbe4O8MY5xTXe823mtP7yU/KN9p/TMHUcS57wJBZu1p8o4PAu1QUr+/Tz
	+hmMetE/MJUGCRAp+PA32ru3etK53O93a1SDwalkhRtp307eXNAroUA6Vw0GJQkW0QKcov6siIT3a
	iH1gCX5EUdw49PEVGaPIRpPLoayRRErnEsDy+SHxETcILSTT0hrT27yuNYCRqVUtWIyORo/U9BLYd
	g7bOGDqp/C6hG8+8JtRay5UH4bU68VrB4xmgu3NFEEODMmQzEO3OxRgL5kS0BvN5qSnNZaLopg5yO
	UWFZpVPtnxiRGW1yBTtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWen-0000000FHKt-2UYa;
	Thu, 15 Feb 2024 07:59:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWel-0000000FHKV-0So9
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 07:59:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82E1561C7B
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 07:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B6C43601
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707983981;
	bh=lglMDlZkFJKsCIT7Fn8mnC0sShe/3fOaUD6KwdKeRb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CEYad3Pec9rSmWPcYhdduNgmoa7KOhGjCI0MBxDg7AhPRC8sNL1DTZ/tqGc5Sb4/V
	 nUYef9ls3xuZTT8BD2qUJZphInbwGWoKoejY0HkhKGoToxxzxy712koyGEOSkvQnKy
	 CsfiJYgrfZGeLpwaHirxGD+uIirvYSDmo+Cc9elHJcXSTd6MC8nuduwJBbwdzF/rrM
	 9f4TbAphPqfEcpd3Unrvc72PbWm43zAscaXJQT4LPOV0Zk+S4Wr3CzErkLe8uTS31Q
	 vLSVtVt2UZspkYhZju46AepuPzW8elm1OLcb07F8K/1rPKJm2sJEu9gMY8pSDl1UIa
	 wJQX4cTjoJg4Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5116b540163so937631e87.1
        for <kexec@lists.infradead.org>; Wed, 14 Feb 2024 23:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4j8acyjs6e/k0YvbKbU57/5JMpnJcoceqcPcLYHc5IsZAO04QiVeKaQnVU+gFwSXe4RqAPojM4iZgyBExHQ6g81FBVfWc7j6P
X-Gm-Message-State: AOJu0YwSUmQnMrKRKHAJQ013zMcRuA2m5j05SG76R2ZSR3+Ph6Pt00/H
	JQjM71ZuO13KhlyS0PKXnLvaGeQu0sM9qod9lXCPBLGXQVjqWL12BNUlWEuafiPlYomZbPRhFSZ
	fxMlsoXXQ8Nego5PHnnEdd+Kgrws=
X-Google-Smtp-Source: AGHT+IE1UYvZkxI1EHEg3S8OzBox7W7fKR3c8y6QpY2+mbq0oQnr/WTTSEAnxqLhggjEtq/NwYteLwaSmzpeW6JkJSE=
X-Received: by 2002:a19:f70b:0:b0:512:55c8:da20 with SMTP id
 z11-20020a19f70b000000b0051255c8da20mr789212lfe.56.1707983979967; Wed, 14 Feb
 2024 23:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-4-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-4-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 08:59:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
Message-ID: <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/15] x86: Secure Launch Kconfig
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_235943_258883_EED9270E 
X-CRM114-Status: GOOD (  15.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..d96d75f6f1a9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2071,6 +2071,18 @@ config EFI_RUNTIME_MAP
>
>           See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>
> +config SECURE_LAUNCH
> +       bool "Secure Launch support"
> +       default n

'n' is already the default, so you can drop this line.

> +       depends on X86_64 && X86_X2APIC

This depends on CONFIG_TCG_TPM as well (I got build failures without it)

> +       help
> +          The Secure Launch feature allows a kernel to be loaded
> +          directly through an Intel TXT measured launch. Intel TXT
> +          establishes a Dynamic Root of Trust for Measurement (DRTM)
> +          where the CPU measures the kernel image. This feature then
> +          continues the measurement chain over kernel configuration
> +          information and init images.
> +
>  source "kernel/Kconfig.hz"
>
>  config ARCH_SUPPORTS_KEXEC
> --
> 2.39.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
