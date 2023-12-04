Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AFEC4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWH5IlC5Qp6+qYEOAytKM6QDGhQoVXrW/ekU/q2ByKk=; b=wtDlTdJs+qSPTZ
	FgsPzwVahMlR2TI7sSPPXirnSnnrogSF2vJbY1kSsnKnlZoQJ40tO3Mjm55Tzc+6faZt86iSJoQXv
	It44S4LsV4TnJc/C5l1nZZbVTS4OUmuRrBV3mSXl1K/+BnwvTFtrQR5qRInq6eX58Dhoe+RyOup/L
	2hvO72/t9R5ons3xbynlqa9yllbbyrVucSCbANqMlR8s9PP9BL006FWlnr4kanTn+sFDgiRqj/Yvc
	4aElI7weYs+O9YkKY9yiVLsI/6KxawCluJE1Xzqr0mOQNXR3ky9nt8AeVVD9G9C6K+WKtwyF1lsBi
	qye+Tk6OQeoG6c/EdYig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEM8-005QAE-1H;
	Mon, 04 Dec 2023 19:11:48 +0000
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEM4-005Q9i-2R;
	Mon, 04 Dec 2023 19:11:44 +0000
Message-ID: <bcb0ec3f-d0ca-48fa-a201-1737ed5ddaec@infradead.org>
Date: Mon, 4 Dec 2023 11:11:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
 ignat@cloudflare.com, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, eric_devolder@yahoo.com
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
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

Hi,

On 12/3/23 18:10, Baoquan He wrote:
> eric_devolder@yahoo.com, ignat@cloudflare.com,
> 	Linux Next Mailing List <linux-next@vger.kernel.org>,
> 	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
> 	linux-riscv <linux-riscv@lists.infradead.org>,
> 	kexec <kexec@lists.infradead.org>
> Bcc: bhe@redhat.com
> Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
> Reply-To: 
> In-Reply-To: <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
> 
> On 12/01/23 at 11:53am, Randy Dunlap wrote:
>>
>>
>> On 11/30/23 18:37, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20231130:
>>>
>>
>> on riscv 32-bit or 64-bit, with
>> # CONFIG_MMU is not set
> 

[]

> I made two patches to decouple the kexec/crash code with CONFIG_MMU. Not
> sure if risc-v wants that.
> 
> Or we can simply add dependency on MMU for ARCH_SUPPORTS_CRASH_DUMP.
> Then when CONFIG_MMU=n, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
> CONFIG_CRASH_CORE will be unset too. Please help check which one need be
> taken.
> 
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 24c1799e2ec4..03d290da7262 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -708,6 +708,7 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
>  
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
> +	depends on MMU=y
>  
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_CORE
> 

That works if the RISC-V folks prefer it.


Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
