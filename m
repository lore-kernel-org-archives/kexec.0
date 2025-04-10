Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2130DC3601E
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ndaXbg+9v01LL+JaSf57t3QrfsbQ+JsySlifsbzGHw=; b=ixBR6vfLfd4hVJyqjmG3nAgcKM
	Y76iqQbxSYWgUXZ8rXUk4dUIMDZmOcEqx06Fg/QWYt82sDfR85LuJ8wkhXQ3b+86kS/BTB+fa1zXl
	Abreys7od+wsCjbGLgj+/tAoHusitDF7SPxfoa6yvkVuYaZrqBrnAPOP/ru0iL5yf7HFVtkhPoLwx
	3OdfQDVgwbUSiudQSFfm1u6xIh676oCZea78TwZZWNMIrmUKn8OHDiPi1QIML1/FRYsy93qEK38t+
	aIPOoHRq2uyVGcHJBhaT6Ojnxdkw02h6UKABSI7p1xPnQl8lA0ciJJ87HG9kfa6Hoxdn2ANOoIxNU
	L2sJ96lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2wy6-0000000BZWm-0Mhn;
	Thu, 10 Apr 2025 18:49:42 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2wy4-0000000BZVx-0CeF
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 18:49:41 +0000
Received: from [100.70.201.233] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FE082113E91;
	Thu, 10 Apr 2025 11:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FE082113E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744310978;
	bh=/ndaXbg+9v01LL+JaSf57t3QrfsbQ+JsySlifsbzGHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sJT/EtBhK6kS9ZV0DuQvKzTSzMgAmh4uIVBXW9o3Qsow8w45ejI+kA5lHTo09ob1i
	 r131ZsQvexMDa4v+EQ8veAHhPotTwRSr5j5W6ck1zpgt3QfJA/51R9XShcL5cC/Jgy
	 tdC1djBy4E3RUno7NNDs8cLChbPzQAfGzLAUcjDY=
Message-ID: <692121f5-fc17-45b5-b4c0-c4393bb05bc4@linux.microsoft.com>
Date: Thu, 10 Apr 2025 11:49:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-9-chenste@linux.microsoft.com>
 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
 <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
 <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_114940_148425_A6B3A88D 
X-CRM114-Status: GOOD (  20.51  )
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

On 4/10/2025 11:04 AM, Mimi Zohar wrote:
> On Thu, 2025-04-10 at 09:59 -0700, steven chen wrote:
>> On 4/10/2025 2:54 AM, Baoquan He wrote:
>>> On 04/02/25 at 05:47am, steven chen wrote:
>>>> The extra memory allocated for carrying the IMA measurement list across
>>>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>>>
>>>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>>>> extra memory (in kb) to be allocated for IMA measurements added during
>>>> kexec soft reboot.  Ensure the default value of the option is set such
>>>> that extra half a page of memory for additional measurements is allocated
>>>> for the additional measurements.
>>>>
>>>> Update ima_add_kexec_buffer() function to allocate memory based on the
>>>> Kconfig option value, rather than the currently hard-coded one.
>>>>
>>>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>> ---
>>>>    security/integrity/ima/Kconfig     | 10 ++++++++++
>>>>    security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>>>    2 files changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>>>> index 475c32615006..d73c96c3c1c9 100644
>>>> --- a/security/integrity/ima/Kconfig
>>>> +++ b/security/integrity/ima/Kconfig
>>>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>>>    	help
>>>>    	   This option disables htable to allow measurement of duplicate records.
>>>>    
>>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>>>> +	depends on IMA_KEXEC
>>>> +	default 0
>>> Usually a new Kconfig item which accepts a range should define the range
>>> boundary, otherwise it's not clear to people how large or how small it
>>> can be set. For example, can I set it as value of 1<<40? We should at
>>> least estimate a possible upper limit for it for other people's
>>> reference. My personal opinion.
>> Hi Baoquan,
>>
>> How about I set range 2-40? Default set as 2, same as the fixed setting.
> 0, the current default, sets the "extra" memory to the existing "extra half a
> page of memory for the additional measurements".  For backwards compatibility,
> please do not change this.
>
> The requirement for a larger "extra" measurement is coming from Microsoft. If
> this isn't any longer a requirement, we could drop this patch.  Lakshmi, do you
> have any thoughts on this?
>
> thanks,
>
> Mimi

How about the range set as 0-40 and the default as 0?

We (Microsoft) are ok with 0 as the default.

Thanks

>>> The rest looks good to me.
>>>
>>>
>>>> +	help
>>>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>>>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>>>> +	  If set to the default value of 0, an extra half page of memory for those
>>>> +	  additional measurements will be allocated.
>>>> +
>>>>    endif
>>> ...snip...
>>
>>


