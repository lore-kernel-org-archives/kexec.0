Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9619C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhpLVOWEQiBjCCnkJmayCrcPxfbCn5Ps77LhW/efDII=; b=u8g0iy2xJB+N91D8mIs9u0Vb45
	gKDm1Wen+k2CjK0TKtTHRUjNw/JwR7/Al1rNMkSfMspL8GpghUZtqfQytmVNeQF3pt+pmMKN78+E1
	2UwQqJqSQwi7oIkjBN1l0fkArtSHifymrUiDTcvYsGzAgrh4MYEn1eNdwtaGf5Q1otb39HDYJmUrx
	BbRNHJF2GQwbJJctqIo2t2p4Fn/xA83pVf5DusR2L6r8HcrczFHge0UloCG+lldTZ8An5e3H0RVsh
	IU0j+hlTomqc7eAVmBilkHkx1aBdV4bVnExdkFCtxGdOsbR+f4hUyQvVK0MniUSD1E7s1HuAPg4H4
	dpiTYvfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6UKF-00000002b9D-3GK8;
	Sun, 20 Apr 2025 13:03:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6UKD-00000002b8G-0fYO
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 13:03:10 +0000
Received: from [100.70.200.26] (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id B007E21165A5;
	Sun, 20 Apr 2025 06:03:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B007E21165A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745154187;
	bh=fhpLVOWEQiBjCCnkJmayCrcPxfbCn5Ps77LhW/efDII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bfxeURb10LnMYzKHDU3I5KE7vfBqNVXcdX73dIcqtHUdWdlsCku8O74+nr0BczmH7
	 HdzIdQhw48R/Adsh0EcCCdSU+tSqNpSjoncm7P4zo9yH/eLqCIOHvX0iwGpEgKuPGG
	 T7I0aMeEDv64fFcBA7aGbX4L5aXUPyfgn4rIrJO0=
Message-ID: <dbc478a0-3bc5-4871-adbf-18ddf76f60fd@linux.microsoft.com>
Date: Sun, 20 Apr 2025 06:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 8/9] ima: make the kexec extra memory configurable
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-9-chenste@linux.microsoft.com>
 <aAIJ/vpJD7GpBwKe@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAIJ/vpJD7GpBwKe@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_060309_299725_7FA67CF8 
X-CRM114-Status: GOOD (  18.71  )
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

On 4/18/2025 1:14 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The extra memory allocated for carrying the IMA measurement list across
>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added during
>> kexec soft reboot.  Ensure the default value of the option is set such
>> that extra half a page of memory for additional measurements is allocated
>> for the additional measurements.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hard-coded one.
>>
>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>     ^^^^^^^^^^^^^^^^

Hi Baoquan,

I will add Co-developed-by tag in next version.

>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     | 11 +++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>   2 files changed, 22 insertions(+), 5 deletions(-)
> The contributor's tag need be updated too, otherwise,

I will add the contributor's tag in next version.

Thanks

> Acked-by: Baoquan He <bhe@redhat.com>
>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 475c32615006..976e75f9b9ba 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,15 @@ config IMA_DISABLE_HTABLE
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>>   
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>> +	range 0 40
>> +	depends on IMA_KEXEC
>> +	default 0
>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>> +	  If set to the default value of 0, an extra half page of memory for those
>> +	  additional measurements will be allocated.
>> +
>>   endif
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index ed867734ee70..d1c9d369ba08 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -118,6 +118,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>>   				  .top_down = true };
>>   	unsigned long binary_runtime_size;
>> +	unsigned long extra_memory;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>>   	size_t kexec_buffer_size = 0;
>> @@ -125,15 +126,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added during kexec.
>>   	 */
>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +		extra_memory = PAGE_SIZE / 2;
>> +	else
>> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +
>> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
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
>> -- 
>> 2.43.0
>>


