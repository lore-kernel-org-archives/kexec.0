Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7B7C3DA6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XL4UEYNdIFEpwOk0nhCOsJ+B8LI7MB1gUC+ZVqswwPc=; b=lBo2MUWM3MQAo1
	5DNwCuc0ylrELRqZGXZvG4eYwWQI3emo7nu2XIjLxMvAP7m3i9Fy1N8Qsx4C7RcbOdAswp3kz0wTb
	AkI7X7NnQpVnriAaLuXyRoj7GOpMA6yiK6zE6edM3X0ReTAY/DEgY5l7NsgP9ia4pD7tDryjuynn2
	kA/oOBQhvqbM363U5oUJRoQKBfXezVmcA9Nl2WHXsPp2lQPlYDOjgn9oiu26+7ne+v8WT9MdkO6QQ
	Pbw4vJuGqIf7MRFxcDYSsC+KlAiEBLfS+Pb5gs+ZPsRueEuy+ULakJvZ/BkG4a64DwkDSbMyR0yxT
	N5Jtr3OFApwjnl+f8eZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqgG-000Aq9-2K;
	Fri, 05 Jan 2024 20:20:36 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqgD-000ApZ-0y
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 20:20:35 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3002920ACF28;
	Fri,  5 Jan 2024 12:20:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3002920ACF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704486032;
	bh=Jng59x8KZZzeeKQplCW4Mnyyjjv+JKhOVrV66k6VW20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NylGFNP1gdVXY97xo9R3nBgGfCVDcGECUYt/azKYbEkf7ePEKLvaPlks7Hc4YdjxT
	 w0ATGMkoBy9Iap8+TEPoaZShTqzAHtrZn8y0LSf1fO3uO7JnzhtNnA1c4km55YFUc/
	 e1NCtdxDwm+h5T64l3nvvz5K2CYNKHQWVcJvl/5A=
Message-ID: <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
Date: Fri, 5 Jan 2024 12:20:31 -0800
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_122033_385892_85B33BC6 
X-CRM114-Status: GOOD (  29.32  )
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



On 12/20/23 12:15, Mimi Zohar wrote:
> Hi Tushar,
> 
> The Subject line should include the word "extra".   The use of the
> extra memory isn't limited to the measurements between the kexec load
> and exec.  Additional records could be added as a result of the kexec
> load itself.  Let's simplify the title to "ima: make the kexec extra
> memory configurable".
> 
> Please remove any references to measurements between kexec load and
> execute.
> 
Thanks Mimi. I will make these changes.

> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> IMA currently allocates half a PAGE_SIZE for the extra events that would
>> be measured between kexec 'load' and 'execute'.  Depending on the IMA
>> policy and the system state, that memory may not be sufficient to hold
>> the extra IMA events measured after kexec 'load'.  The memory
>> requirements vary from system to system and they should be configurable.
> 
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hardcoded as a half a PAGE.   Make it configurable.
> 
Will do.
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added in the
>> window from kexec 'load' to kexec 'execute'.
> 
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hardcoded one.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     |  9 +++++++++
>>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 60a511c6b583..8792b7aab768 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>   	default n
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>> +
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int
>> +	depends on IMA && IMA_KEXEC
>> +	default 64
> 
> Since this isn't optional, the default should remain as a half page.
> Since a page is architecture specific, the default will need to be arch
>   specific.
> 
> thanks,
> 
> Mimih
> 
It was a feedback from Stefan in the V2 of this series to convert it 
from number of PAGES to KB.[1]

But I can revert it to number of pages again.

Also, making the default value as a fraction (1/2 page) feels weird for 
a CONFIG variable.

Is it ok to make the default value as one page rather than half page?

[1]
https://lore.kernel.org/all/15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com/
 >>> +config IMA_KEXEC_EXTRA_PAGES
 >>> +    int
 >>> +    depends on IMA && IMA_KEXEC
 >>> +    default 16
 >>> +    help
 >>> +      IMA_KEXEC_EXTRA_PAGES determines the number of extra
 >>> +      pages to be allocated for IMA measurements added in the
 >>> +      window from kexec 'load' to kexec 'execute'.
 >>
 >>
 >> On ppc64 a page is 64kb. I would ask for additional kb here.
 >>
 >>
 > Not sure I understand.  Do you mean I should make the default value of
 > the config IMA_KEXEC_EXTRA_PAGES 64 or something?


No, what I mean is you should ask the user for how many extra kilobytes
(kb) to allocate - not ask for pages.


     Stefan

>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added in the window
>> +	  from kexec 'load' to kexec 'execute'.
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 55bd5362262e..063da9c834a0 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -128,15 +128,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added in the window from
>> +	 * kexec 'load' to kexec 'execute'.
>>   	 */
>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	binary_runtime_size = ima_get_binary_runtime_size() +
>> +			      sizeof(struct ima_kexec_hdr) +
>> +			      (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024);
>> +
>>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>   		kexec_segment_size = ULONG_MAX;
>>   	else
>> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -					   PAGE_SIZE / 2, PAGE_SIZE);
>> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>   	if ((kexec_segment_size == ULONG_MAX) ||
>>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>   		pr_err("Binary measurement list too large.\n");
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
