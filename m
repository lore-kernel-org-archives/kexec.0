Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F56AC369A2
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxXwkdEOn7BTRh/cnvKn+B0GcVvl6i4koOpR5p1bqWc=; b=zHVmzKfwrWwNYzeEiEu+fsu8vb
	3zaNeO8sByHJ5VkS7xChQ1KoJHWillzUSJ4gstkVzN0q4NknwKe+sgrCcQdIcgM/P8VOsqxgsdptY
	JVK9NGwE0ErTvxSZOiR9DGFysEgqi+tSyDzkjsgMg3B8whybpHMvoruL3NXWmAMi07EhzQkUqfCi+
	4PY3YHETyjd0J6u52dpCIVJazc1rUMsJzRfx/IQm9WKu7uiCT6cgZK43pt35NOxbhNu+fs6gi6c9C
	QMzNKcxBzhPML35UPL/17ofbDKSojZlobjOyzApfSX9uy1K5J1pAhLKbNV3WLg0L0lZTWjN6HUE7q
	oE/CLE8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2w8m-0000000BSgm-0SDV;
	Thu, 10 Apr 2025 17:56:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2vFi-0000000BIOz-1sc0
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 16:59:47 +0000
Received: from [100.70.65.11] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C81DA2113E87;
	Thu, 10 Apr 2025 09:59:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C81DA2113E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744304385;
	bh=vxXwkdEOn7BTRh/cnvKn+B0GcVvl6i4koOpR5p1bqWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JHT8LCdCXgjdyTqcygVEM0A4oBfxyGSsACAFVgSqpF/r46yj9ypHpbSf9+HHuLb0X
	 pmX4Hwe5MUrRUG6uvpniItcbSKg3gVhZwQfhXHOUMDNCscbXA/4LlNcntMgVGA1fl7
	 7Dm1oub7U52nP9dRwCvWoI+slg2g3jGZNsdYjDak=
Message-ID: <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
Date: Thu, 10 Apr 2025 09:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-9-chenste@linux.microsoft.com>
 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_095946_540552_9601E6FD 
X-CRM114-Status: GOOD (  18.91  )
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

On 4/10/2025 2:54 AM, Baoquan He wrote:
> On 04/02/25 at 05:47am, steven chen wrote:
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
> Usually a new Kconfig item which accepts a range should define the range
> boundary, otherwise it's not clear to people how large or how small it
> can be set. For example, can I set it as value of 1<<40? We should at
> least estimate a possible upper limit for it for other people's
> reference. My personal opinion.

Hi Baoquan,

How about I set range 2-40? Default set as 2, same as the fixed setting.

Thanks,

Steven

> The rest looks good to me.
>
>
>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>> +	  If set to the default value of 0, an extra half page of memory for those
>> +	  additional measurements will be allocated.
>> +
>>   endif
> ...snip...



