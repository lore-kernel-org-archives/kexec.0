Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898F4C3DA6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BkI1ngl+hE3mTKOSO8GhNJkDxuOUSWRtM88qLzlsuKo=; b=eKf/Si4nCb6AN+
	tmCgptVHNGn7LqQJQKRR6MhesqIuZfjGTHpxBbcy2fyMGfy0wb/QEdupaxlh1cSOl9FR4uQPqDNVB
	m+RTfDWrki5I4RNAVL0AqHmnKAQWaYhUWm+/kDSoK7MEEcaPH3iyy7IzK08rLVmPByuI5FHcCFaRT
	JrKnU+Zu85Wphqc+AVtGIC+tRlSxXGA7C5K4Ve07K5u1wZfdpImbnHulMuI9nfX4ridbbfMqOe+ov
	P2avAfvPdQReG4uc4Vm4m7pcsW6KMBXbUVRrK5U85mJosqH8i/6ea9o7L3Y/iYDdLibSTDamxn734
	9+AeVVkJVZeITRDi8BoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqAT-00081w-1k;
	Fri, 05 Jan 2024 19:47:45 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqAQ-00081X-0v
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 19:47:43 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85E2E20ACF28;
	Fri,  5 Jan 2024 11:47:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85E2E20ACF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704484056;
	bh=//O+s2IfcYrX6IMP4gFeQbnbUrrcIy652CQFn9huHd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c7dpog5Kw6vi7OmOvfTXHy41bnAunvDs2O0xeOHploiw1/+jAzghfY5X5j0FDB9Vk
	 3FIikwBHk7L/lkLoUrrjg61781w7Y9G7DKF9xgTZxX30wmllyCKa+acI/k6nny7ViG
	 vmXVaETnyxhbMTzl5+zSHuIdXyOqJOK0Pbfs957k=
Message-ID: <81a68238-614d-4576-91ef-1b12771d6c14@linux.microsoft.com>
Date: Fri, 5 Jan 2024 11:47:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-2-tusharsu@linux.microsoft.com>
 <ea2a4524bfd0af5515a547ce6e7fbbec8067e490.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ea2a4524bfd0af5515a547ce6e7fbbec8067e490.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_114742_377470_81AD0641 
X-CRM114-Status: GOOD (  17.72  )
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

Thanks Mimi for the feedback on V3.

Sorry for the late response, I was on vacation during the holidays.

Responses inline.

Happy new year! :)

On 12/20/23 08:13, Mimi Zohar wrote:
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_file_buf() to allocate buffer of
>> size 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>> function ima_dump_measurement_list() global, so that they can be accessed
>> from ima_alloc_kexec_file_buf().
> 
> Only ima_kexec_file is being moved and does not need to be global, but
> should be defined as local static.
> 

Will do.
I followed your comment on V2 of this series [1], and didn't make the
change last time. But making it local static scoped to this source file
(ima_kexec.c) makes sense.


[1] From v2 of this series
https://lore.kernel.org/all/2c9e3b71-5416-4336-82f1-cd78e26dd62e@linux.microsoft.com/
 >> Define "ima_kexec_file" as static since it only used in this file.
 >> Since the variable does not need to be global, is there still a reason
 >> for changing its name?   Minimize code change.
 >
 > Adding "static" would make ima_kexec_file a global static variable.
 > Please ignore my comment about reverting the variable name change.
 >
 > Mimi
 >


>> Make necessary changes to the function
>> ima_add_kexec_buffer() to call the above two functions.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
>>   1 file changed, 67 insertions(+), 29 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 419dc405c831..ae27101d0615 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,62 +15,93 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +struct seq_file ima_kexec_file;
> 
> ^static.
> 
Will do.

>> +void ima_free_kexec_file_buf(struct seq_file *sf)
> 
> ^static
Will do.

~Tushar
> 
>> +{
>> +	vfree(sf->buf);
>> +	sf->buf = NULL;
>> +	sf->size = 0;
>> +	sf->read_pos = 0;
>> +	sf->count = 0;
> 
> --
> thanks,
> 
> Mimi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
