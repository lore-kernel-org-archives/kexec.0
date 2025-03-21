Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1766C36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nSvjsrtvsYH0Ut5RuXHshDg+2Of7/6QpJwrxhRT3jP0=; b=hp7JP0dhafaHf1ZsRAPp0ZUSY0
	CDjKwYHNDg0sjIFeuqZK87Y4INk3BfcykfpaufNwhDE0h6KNl+Rl3aIoyITLnqEVZxiLOYDvNdbwJ
	IIVaGzZeY1lhjP4odJsp2OyG18nm5tpyppV9Kh9qqs1/2j98zY3/B3lC9Yn067/Np+MQBM9JdYQ95
	dtszzZas1I08Dim4CrKc9BrtlEp9L19W0bFBZ/UNaGOhvr1e8uzXr0kWIW9gRaJuYFuOZegr+jXpu
	xe1kcU0UVk/u0vTEZnAxzSl4fpivrayx3Nu7R276aAq91IwBrKgggUS5DEVbRpU1R3pkv9d1Z2/XG
	0RntvYfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvfYX-0000000FZto-2yke;
	Fri, 21 Mar 2025 16:49:13 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvfWC-0000000FZE1-24zv
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 16:46:49 +0000
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id E44CC202538A;
	Fri, 21 Mar 2025 09:46:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E44CC202538A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575607;
	bh=nSvjsrtvsYH0Ut5RuXHshDg+2Of7/6QpJwrxhRT3jP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9QOP+IxLavnYNz3HjFdNVhXARehD6rMEeIKlMfzV30fLZ18gZbKafDdW6lpavtKj
	 9lCPhW7bRpf0k84LU5RZMQ+izAFR/wJqqLapseL5CO+fGtFaWf2Q8KZ4cRx9ZYESsb
	 iBKjV0fTVKuBXQZYXx4q+MftjeIboA0uvV+k59p8=
Message-ID: <c050bff0-6a0d-402b-884b-fe991cd30cf3@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] ima: make the kexec extra memory configurable
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-8-chenste@linux.microsoft.com>
 <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_094648_585881_8C0C785A 
X-CRM114-Status: GOOD (  19.59  )
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

On 3/19/2025 7:52 PM, Baoquan He wrote:
> On 03/17/25 at 06:04pm, steven chen wrote:
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
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/ima/Kconfig     | 10 ++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 475c32615006..d73c96c3c1c9 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>>   
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>> +	depends on IMA_KEXEC
>> +	default 0
> Is there range for this memory, e.g [0, max] and max will be a value
> according to our current perception?

Hi Baoquan,

In the code below there is value check for this

  	if ((kexec_segment_size == ULONG_MAX) ||
  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {

Hi Mimi,

Could you provide any guidance if we need to set the range?

Thanks,

Steven

>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>> +	  If set to the default value of 0, an extra half page of memory for those
>> +	  additional measurements will be allocated.
>> +
>>   endif
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index c390c745f882..0f214e41dd33 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -131,6 +131,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>>   				  .top_down = true };
>>   	unsigned long binary_runtime_size;
>> +	unsigned long extra_memory;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>>   	size_t kexec_buffer_size = 0;
>> @@ -138,15 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
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
>> 2.25.1
>>
>>


