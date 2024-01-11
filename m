Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F3EC47077
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JiqUa/xgFV+ns3bvB8C3PvSY71ZutiYp8Bq9JyMhFGQ=; b=lxu47EnuHBNUO7
	ATaFZMFw4feCIJKX/0EUcIqDuv1girFUiWVNA+lR0QNI7u+AjJ8dOr5YfTKZ4q24GhmA8N3mzqvzM
	sVMUaVt2Nh+W2BpYLQ1dOGcdKj+D55OkKrNKPaqCr8xoiVIJyUP9iAKQVMNOk8gl1a/lVnY1rFYUv
	ePUX3ExudAXnie5bgv2TFQhPiws1UBUrsVgfK4nkJbjHyYEFJ8ziBDHWoo99k4NUDmMVu5wEp/ksJ
	cECIFjLDGT1jNnCN0LyGgghVv8m8CZ5u6+htG53EyGxurFhicxNz83nw7e76cJZ9Ybhm54nSQY7YG
	fb45F4bejXO08zs9Sczw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzHn-000m4Q-1n;
	Thu, 11 Jan 2024 17:56:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzHj-000m35-0D
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 17:56:09 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F7BA20B3CC1;
	Thu, 11 Jan 2024 09:56:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F7BA20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704995765;
	bh=bjDCby8arrnCLXKoPLXG5spNzDaZaj7J3NIFKAE7WLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+Q1w/wMPcaJqMMjIY8snExyEKPtVO+I+LBkepU8x1truvKczkDoaCu5fW2rMK4ZX
	 4hv1052godKnPSya4ggfTvI0z13UEOsHFRnigBnQycASElCjbtB2Ul7NgDQDwLu/6c
	 AaQTiHcvhi0WcTdOi/ehkDuy9cVJXerHOtkRpGP0=
Message-ID: <fcc6cf08-083c-4013-a164-359b2a2140b3@linux.microsoft.com>
Date: Thu, 11 Jan 2024 09:56:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
 <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
 <db16303d-44b7-45d2-b844-cf4d7fe89647@linux.microsoft.com>
 <ddd990a0faeb79260709b973b2b959a89e6c65bc.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ddd990a0faeb79260709b973b2b959a89e6c65bc.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_095607_133069_195D253D 
X-CRM114-Status: GOOD (  10.40  )
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



On 1/7/24 06:24, Mimi Zohar wrote:
> On Fri, 2024-01-05 at 12:22 -0800, Tushar Sugandhi wrote:
>>>> @@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>>>>               return ret;
>>>>       }
>>>>    
>>>> +    buf_size = ima_get_binary_runtime_size();
>>>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>>> +              "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
>>>> +              kexec_segment_size, buf_size);
>>>> +
>>>> +    ima_measure_critical_data("ima_kexec", "kexec_execute",
>>>> +                              ima_kexec_event, strlen(ima_kexec_event),
>>>> +                              false, NULL, 0);
>>>> +
>>>
>>> Please consider including the number of measurement records as well.
>> Will do. I think that would be valuable information.
>>
>> Per my understanding, I will have to use the function
>> ima_show_measurements_count() or ima_show_htable_value() to get the
>> number of measurement records value[1]. So I will have to expose that
>> function from "ima_fs.c" to "ima_kexec.c". Hope that's ok.
>>
>> [1]
>> https://elixir.bootlin.com/linux/latest/sourcesecurity/integrity/ima/ima_fs.c
>>
>>
>> static ssize_t ima_show_measurements_count(struct file *filp,
>>                                            char __user *buf,
>>                                            size_t count, loff_t *ppos)
>> {
>>           return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
> 
> I don't see a need to expose this function.  ima_htable is defined in ima.h.
> You can read the ima_htable.len directly, as ima_show_htable_value does.
> 
Agreed. Thanks for the pointer.
That's what I concluded too when I was implementing this change.
I will use ima_htable.len directly.

~Tushar


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
