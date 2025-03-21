Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A746C36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w60sAgvcLAWgVyv6WquYLLOQicpf5ZRmpFvyjyfnVwE=; b=37O4F9XeU/3kOxR7l+b5PqXy8S
	kNzCYyIZ1GU8sbGTFRmS30YPMXpy6Xecjg0KHM5sFg7peXFjTN6+46JGWAmDrdriGrdlSA86Dgpu+
	irlFuputbOdvuDB2VbjWP173pfFsQKrSQhP+f1PwnTFaeNAszR9O33mmk5rcSEEiZnXO7Xpj5GqwH
	TzSvzsvc5AEjcUWkNnMmptwCKY1Lacc79bd8/r0knK2DUTU8/nRlfAAKm+GZKetlg5nkmZhc4u4Na
	h4aYjIV8zCnoZblahDvvez9A8MPkDPx4jCyqZ5KO/+6xYpQXRo+VU5OHAWNaG5PIHBsB3peedB4U8
	LBQ3fdng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf9d-0000000FUMw-3wjG;
	Fri, 21 Mar 2025 16:23:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf9b-0000000FUL4-1PYI
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 16:23:28 +0000
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DE9D2025381;
	Fri, 21 Mar 2025 09:23:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DE9D2025381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742574206;
	bh=w60sAgvcLAWgVyv6WquYLLOQicpf5ZRmpFvyjyfnVwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHwfb+/I4DJcL3178I7/xgS79wmL4RJO6TCuOPNtrXBsqnt20gS+HlmY70drCXBK9
	 N55lDPEhKf9tFwz2tFyqK+ir/EQGbFp9Z+CMRku9V4+w7lbUOIdXiFn9daYeQRORsY
	 bwElckzWHCPbK3gRP/HyJr/E1Irv9GxEIBnXOSW4=
Message-ID: <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:23:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
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
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_092327_402586_D76BEFE8 
X-CRM114-Status: GOOD (  10.77  )
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

On 3/19/2025 7:06 PM, Baoquan He wrote:
> On 03/17/25 at 06:04pm, steven chen wrote:
> ...snip...
>> ---
>>   kernel/kexec_file.c                | 10 ++++++
>>   security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>>   2 files changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 606132253c79..ab449b43aaee 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>>   }
>>   #endif
>>   
>> +static void kimage_file_post_load(struct kimage *image)
>> +{
>> +#ifdef CONFIG_IMA_KEXEC
>> +	ima_kexec_post_load(image);
>> +#endif
>> +}
>> +
>>   /*
>>    * In file mode list of segments is prepared by kernel. Copy relevant
>>    * data from user space, do error checking, prepare segment list
>> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>   
>>   	kimage_terminate(image);
>>   
>> +	if (!(flags & KEXEC_FILE_ON_CRASH))
>> +		kimage_file_post_load(image);
> machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> we should use it to do things post load, but not introducing another
> kimage_file_post_load().

Hi Baoquan,

Could you give me more detail about this?

Thanks,

Steven

>
>> +
>>   	ret = machine_kexec_post_load(image);
>>   	if (ret)
>>   		goto out;
> ...snip...



