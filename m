Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB211C47422
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 19:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=izMDG4QiRsZgHRaVzF+3vFzb2RzHnG5Z0jAyBQnI5Mk=; b=VK0xpv6tOXtZVq
	TBzi4ShWCHxbWjkRwB8Vw0+bsP+UiY2LV57kFrHqn9A+NTIsrdSdT4gpeWCeitzBvhaY0xke549lh
	L3kDwhllAeSl7S5X52SBQ2zWDknTtSChB+q07ECN1t+0rOFJqaNAkI5yZ2g73W17Vac260SNxVQZz
	/LBGgxnTT/gD9du/MmlTTYpAfnFum+i+8jqvolRwwY2mGtB0ua6kwB+dBLlr6EickTadk9ZV0g1kP
	5+rekK3ZuJ4pZBeI/SuLups0GZvJ19MhkWwcHzqXuqEXpf24+D39h7PQaqRbx5DvKKhS4HASn5XUB
	ow/SBvyjfc6gpniGzt3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT5Bl-00000001Uyg-0omU;
	Thu, 25 Jan 2024 19:15:01 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT5Bi-00000001UyK-29Mc
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 19:14:59 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 628A020E56B9;
	Thu, 25 Jan 2024 11:14:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 628A020E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706210097;
	bh=imB7GEmJRnpBmqjAfJIzLKPCa+cI90b46QJV+T438zM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+8GQMfzeS5nZJjz4KsL3R51MaGu9oHzZZ04j/wOkJsGBTJwlqYO5+L9Z6SFIfBih
	 dHbFB7yhEuEpLepq9OOs8+ZQB+88ultvx4qy1nJ+SV7vn60NZg0z1H9MTUoZ71u+4k
	 fehrYpDRP9xi/ikfQziSmgZ8Ev9BezJ+w3bmwzgs=
Message-ID: <2bdabacb-fafb-48c5-9328-6749f70f9a96@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:14:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
 <e2b67ca4e3f0869bcab683feef9b8f4ad773e38e.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e2b67ca4e3f0869bcab683feef9b8f4ad773e38e.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_111458_692189_17D43F48 
X-CRM114-Status: GOOD (  14.14  )
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



On 1/24/24 06:07, Mimi Zohar wrote:
> 
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>>   				  .top_down = true };
>>   	unsigned long binary_runtime_size;
>> +	unsigned long extra_size;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>>   	void *kexec_buffer = NULL;
>> @@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added during kexec.
>>   	 */
> 
> The memory is still being allocated at kexec "load",  so the extra memory is for
> additional measurement records "since" kexec load.
> 
> Mimi
> 
This wording was an attempt to address the comment in v3[1].
So I tried to make the comment generic.  But maybe I made it too generic.
I will update.

[1] Re: [PATCH v3 6/7] ima: configure memory to log events between kexec 
load and execute
https://lore.kernel.org/all/fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com/

"Additional records could be added as a result of the kexec
load itself.
...
Please remove any references to measurements between kexec load and
execute."

~Tushar

>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +		extra_size = PAGE_SIZE / 2;
>> +	else
>> +		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
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
