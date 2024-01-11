Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4AAC47077
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pk0kCYF55Mx1S+upG6SaH5FRNX8w1YyhMMLTzykI7QI=; b=YO68+ynkCUYzox
	UbMjqhGSDJoZXgpsOUkB8TbmAzz4Cyctmggp4Qd6GLThA+tJcbeoTaK2oet1mb1oVtkja8/z6SH8b
	UvZZOFxImVR++V6vmTsg9ew6BSHMjX+UYHgSTooZYD6A+qbl/nvQFSchQlFamT+WDGj+Qom+G84YN
	W0BYilctJnlNHpy3O536kuxiwjxRdFoXPbNNzPaGtKWCUjIuyV04Y7F9/iNrKvBgQd89pUjb7Gy2t
	53p193HFJro5HCOukAsRbwhEa8AWihZ7dOjUFfwqLE2CQmEGzQbm3dT3FY9RtFSymh7qHxQLvBQlr
	Xxb6bLAgFEhQFhzA8T5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzYD-000nxI-2t;
	Thu, 11 Jan 2024 18:13:09 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzYA-000nwv-2g
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 18:13:08 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7A4D20B3CC1;
	Thu, 11 Jan 2024 10:13:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7A4D20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704996786;
	bh=6JRTcEUnC+WOlcfZNNfu0nkVnWX6JBwrj/f9yBFqx5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JxGPW4SUQfxzLbSDhLF7m4Lgw3jTCh9x5KmQoG54jsR3J+UaEA1dlIfi1YkbUK0dK
	 qlvu8SVGDMsDf8LpV8XpboTauk+GLakOeRhbvDQZsd6KCqd8UNiaFkXB7ZJiTNUSEt
	 cWfltyTluKCPrX9ZlbtomBezJODK0BsdDCT+5z2U=
Message-ID: <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
Date: Thu, 11 Jan 2024 10:13:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_101306_934620_C54E45D4 
X-CRM114-Status: GOOD (  23.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 1/7/24 09:00, Mimi Zohar wrote:
> On Fri, 2024-01-05 at 12:20 -0800, Tushar Sugandhi wrote:
>>>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>>>> index 60a511c6b583..8792b7aab768 100644
>>>> --- a/security/integrity/ima/Kconfig
>>>> +++ b/security/integrity/ima/Kconfig
>>>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>>>       default n
>>>>       help
>>>>          This option disables htable to allow measurement of duplicate records.
>>>> +
>>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>>> +    int
>>>> +    depends on IMA && IMA_KEXEC
>>>> +    default 64
>>>
>>> Since this isn't optional, the default should remain as a half page.
>>> Since a page is architecture specific, the default will need to be arch
>>>    specific
>>>
>> It was a feedback from Stefan in the V2 of this series to convert it
>> from number of PAGES to KB.[1]
>>
>> But I can revert it to number of pages again.
>>
>> Also, making the default value as a fraction (1/2 page) feels weird for
>> a CONFIG variable.
>>
>> Is it ok to make the default value as one page rather than half page?
> 
> The point is not whether the extra memory is specified in terms of pages or KB.
> For backwards compatibility the existing default should be the same as
> previously.  This means the default needs to be architecture specific.b
>   
> $ uname -m; getconf PAGESIZE
> x86_64
> 4096
>   
> $ uname -m; getconf PAGESIZE
> ppc64le
> 65536
> 
> For example:
> 
> default 32 if PPC_64K_PAGES
> default 2
> 
Ok. Thanks for the clarification.


Do we want to support only 64K or 4K as possible PAGE_SIZE values?
I spot checked a few architectures, there are scenarios where PAGE_SIZE
could be 8K, 16K, 128K, 256K etc. And of course mega pages with
PAGE_SIZE IN MBs (details below).

About the unit of the config value (KB v/s num_pages), if we go with
num pages, I am having hard time figuring out how to set the config
value to a float - if we truly want to support 1/2 a page (0.5) as
a default. Majority are bools or ints. I couldn't find any
config value with float which I can refer to.

Being said that, I can think of two ways to handle it:
Option (A) fine tune it to half a page given arch specific page size
config.

Option (B) Keep it simple and make the default extra memory to be
a single page rather than half-a-page.

(A) seems fragile, and I am worried we will not cover all the scenarios.

(B) Even though we are technically breaking the backward compatibility
by changing the default extra memory from half-a-page to a full page,
I don't see it adversely affecting anything else in the IMA/kexec
functionality.

I am leaning towards (B), but please let me know your thoughts.

Sample code for both the options:

Option A:
---------
config IMA_KEXEC_EXTRA_MEMORY_KB
     int
     depends on IMA && IMA_KEXEC
     default 128 if PAGE_SIZE_256KB
     default 32 if PPC_64K_PAGES || PAGE_SIZE_64KB || PARISC_PAGE_SIZE_16KB
     default 16 if PAGE_SIZE_32KB
     default 8 if PAGE_SIZE_16KB || ARC_PAGE_SIZE_16K || 
PARISC_PAGE_SIZE_16KB
     default 4 if PAGE_SIZE_8KB || ARC_PAGE_SIZE_8K
     default 2
	  IMA_KEXEC_EXTRA_MEMORY_KB determines the number of extra
	  memory (in KB) to be allocated for IMA measurements added
	  during kexec soft-reboot.

Option B:
--------
config IMA_KEXEC_EXTRA_PAGES
	int
	depends on IMA && IMA_KEXEC
	default 1
	help
	  IMA_KEXEC_EXTRA_PAGES determines the number of extra
	  pages to be allocated for IMA measurements added during
	  kexec soft-reboot.


Below are a few PAGE_SIZE configs I found for a some architectures.


---------------------------------------------------------------------------------
https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/arc/Kconfig
choice
prompt "MMU Page Size"
default ARC_PAGE_SIZE_8K

config ARC_PAGE_SIZE_8K
bool "8KB"
help
  Choose between 8k vs 16k

config ARC_PAGE_SIZE_16K
bool "16KB"

config ARC_PAGE_SIZE_4K
bool "4KB"
depends on ARC_MMU_V3 || ARC_MMU_V4

endchoice

choice
prompt "MMU Super Page Size"
depends on ISA_ARCV2 && TRANSPARENT_HUGEPAGE
default ARC_HUGEPAGE_2M

config ARC_HUGEPAGE_2M
bool "2MB"

config ARC_HUGEPAGE_16M
bool "16MB"

endchoice
---------------------------------------------------------------------------------------------------------
https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/hexagon/Kconfig
choice
prompt "Kernel page size"
default PAGE_SIZE_4KB
help
  Changes the default page size; use with caution.

config PAGE_SIZE_4KB
bool "4KB"

config PAGE_SIZE_16KB
bool "16KB"

config PAGE_SIZE_64KB
bool "64KB"

config PAGE_SIZE_256KB
bool "256KB"

endchoice
---------------------------------------------------------------------------------------------------------
https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/loongarch/Kconfig

config PAGE_SIZE_4KB
bool

config PAGE_SIZE_16KB
bool

config PAGE_SIZE_64KB
bool

---------------------------------------------------------------------------------------------------------

https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/mips/Kconfig
choice
prompt "Kernel page size"
default PAGE_SIZE_4KB

config PAGE_SIZE_4KB
bool "4kB"
depends on !CPU_LOONGSON2EF && !CPU_LOONGSON64
help
  This option select the standard 4kB Linux page size.  On some
  R3000-family processors this is the only available page size.  Using
  4kB page size will minimize memory consumption and is therefore
  recommended for low memory systems.

config PAGE_SIZE_8KB
bool "8kB"
depends on CPU_CAVIUM_OCTEON
depends on !MIPS_VA_BITS_48
help
  Using 8kB page size will result in higher performance kernel at
  the price of higher memory consumption.  This option is available
  only on cnMIPS processors.  Note that you will need a suitable Linux
  distribution to support this.

config PAGE_SIZE_16KB
bool "16kB"
depends on !CPU_R3000
help
  Using 16kB page size will result in higher performance kernel at
  the price of higher memory consumption.  This option is available on
  all non-R3000 family processors.  Note that you will need a suitable
  Linux distribution to support this.

config PAGE_SIZE_32KB
bool "32kB"
depends on CPU_CAVIUM_OCTEON
depends on !MIPS_VA_BITS_48
help
  Using 32kB page size will result in higher performance kernel at
  the price of higher memory consumption.  This option is available
  only on cnMIPS cores.  Note that you will need a suitable Linux
  distribution to support this.

config PAGE_SIZE_64KB
bool "64kB"
depends on !CPU_R3000
help
  Using 64kB page size will result in higher performance kernel at
  the price of higher memory consumption.  This option is available on
  all non-R3000 family processor.  Not that at the time of this
  writing this option is still high experimental.

endchoice

----------------------------------------------------------------------------
https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/parisc/Kconfig

choice
prompt "Kernel page size"
default PARISC_PAGE_SIZE_4KB

config PARISC_PAGE_SIZE_4KB
bool "4KB"
help
  This lets you select the page size of the kernel.  For best
  performance, a page size of 16KB is recommended.  For best
  compatibility with 32bit applications, a page size of 4KB should be
  selected (the vast majority of 32bit binaries work perfectly fine
  with a larger page size).

  4KB                For best 32bit compatibility
  16KB               For best performance
  64KB               For best performance, might give more overhead.

  If you don't know what to do, choose 4KB.

config PARISC_PAGE_SIZE_16KB
bool "16KB"
depends on PA8X00 && BROKEN && !KFENCE

config PARISC_PAGE_SIZE_64KB
bool "64KB"
depends on PA8X00 && BROKEN && !KFENCE

endchoice

----------------------------------------------------------------------------
https://elixir.bootlin.com/linux/v6.7-rc8/source/arch/sh/Kconfig

config ENTRY_OFFSET
hex
default "0x00001000" if PAGE_SIZE_4KB
default "0x00002000" if PAGE_SIZE_8KB
default "0x00004000" if PAGE_SIZE_16KB
default "0x00010000" if PAGE_SIZE_64KB
default "0x00000000"


~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
