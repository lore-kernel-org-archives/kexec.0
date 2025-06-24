Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D472C7115B
	for <kexec@archiver.kernel.org>; Tue, 24 Jun 2025 03:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=SE0rA7xubGFapAtwf8e1moTnTm98c5XUyXDYZhZQebM=; b=mQAwkE0wWuWaMKUxU/QFqSZJWJ
	Gt6yawc2JaZu5w/6D+sZtLCEW5riz3GvE6c1NP04HkGEzo+Kc2ULxkkjdOuPV5B4jQLi2wicdb+xN
	F6lTmpKZ/fWHCiVziMkU+wIS7DJxvt6EILE2cwvVfwcPLS0sU+PabpAceuuZlOm1qTa8xSPLXelbD
	epQmIX2LjERIvK2QDVxx8k/xj0QB4CCHrnzAVZDQjSsF9U1p7EJLjgWp8VWYyrdz7RPAonWuo0Sn+
	5lR0Syf2xHtzaiNrDiFZxHcNb+4ITAXivc/bskjVeJ0fLcUzmRavNExnb9KexJ+dHNj394LpM4uwb
	Wbpl8EVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTuFt-00000004XP5-1CqZ;
	Tue, 24 Jun 2025 03:23:29 +0000
Received: from [42.101.60.213] (helo=mail.nfschina.com)
	by bombadil.infradead.org with smtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTtH7-00000004T2H-06uJ
	for kexec@lists.infradead.org;
	Tue, 24 Jun 2025 02:20:42 +0000
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id DD45060108125;
	Tue, 24 Jun 2025 10:20:35 +0800 (CST)
Message-ID: <ac035aaa-f7b4-42a6-8f5c-e0a93faf5c6b@nfschina.com>
Date: Tue, 24 Jun 2025 10:20:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <33a9a2a5-a725-4ab0-865c-1d26e941e054@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_192041_238335_A625643D 
X-CRM114-Status: GOOD (  15.23  )
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

On 2025/6/23 23:06, Dan Carpenter wrote:
> On Mon, Jun 23, 2025 at 06:47:05PM +0800, Su Hui wrote:
>> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
>> type from 'size_t' to 'unsigned int' for the consistency of data->size.
>> Return -ENOMEM directly rather than goto the label to simplify the code.
>> Using scoped_guard() to simplify the lock/unlock code.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/proc/vmcore.c | 33 ++++++++++++++-------------------
>>   1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 10d01eb09c43..9ac2863c68d8 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   {
>>   	struct vmcoredd_node *dump;
>>   	void *buf = NULL;
>> -	size_t data_size;
>> +	unsigned int data_size;
>>   	int ret;
> This was in reverse Christmas tree order before.  Move the data_size
> declaration up a line.
>
> 	long long_variable_name;
> 	medium variable_name;
> 	short name;
Got it,  and this 'usgined int' will be removed because of 'size_t' can
avoid overflow in some case.
>>   
>>   	if (vmcoredd_disabled) {
>> @@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   		return -EINVAL;
>>   
>>   	dump = vzalloc(sizeof(*dump));
>> -	if (!dump) {
>> -		ret = -ENOMEM;
>> -		goto out_err;
>> -	}
>> +	if (!dump)
>> +		return -ENOMEM;
>>   
>>   	/* Keep size of the buffer page aligned so that it can be mmaped */
>>   	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
>> @@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   	dump->size = data_size;
>>   
>>   	/* Add the dump to driver sysfs list and update the elfcore hdr */
>> -	mutex_lock(&vmcore_mutex);
>> -	if (vmcore_opened)
>> -		pr_warn_once("Unexpected adding of device dump\n");
>> -	if (vmcore_open) {
>> -		ret = -EBUSY;
>> -		goto unlock;
>> -	}
>> -
>> -	list_add_tail(&dump->list, &vmcoredd_list);
>> -	vmcoredd_update_size(data_size);
>> -	mutex_unlock(&vmcore_mutex);
>> -	return 0;
>> +	scoped_guard(mutex, &vmcore_mutex) {
>> +		if (vmcore_opened)
>> +			pr_warn_once("Unexpected adding of device dump\n");
>> +		if (vmcore_open) {
>> +			ret = -EBUSY;
>> +			goto out_err;
>> +		}
>>   
>> -unlock:
>> -	mutex_unlock(&vmcore_mutex);
>> +		list_add_tail(&dump->list, &vmcoredd_list);
>> +		vmcoredd_update_size(data_size);
>> +		return 0;
> Please, move this "return 0;" out of the scoped_guard().  Otherwise
> it's not obvious that we return zero on the success path.
Yes, it's better. Will update in v2 patch.
Thanks again!

Regards,
Su Hui

