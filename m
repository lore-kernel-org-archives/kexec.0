Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC42C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v8/kjfMBX5j8otcEjoEy9F00J/rSQ+ksJRgSx0LzXFY=; b=vC2UcfQ882KRxJlYMn4zMF8Yj6
	qaSE4+/G9FyFKo2HIctXEMEe55GSsW9GaX3+HMShkpQzprqKG3hI8TO0CHGdG0kitboO1Zmr2TMwJ
	IdXJM+GAUHZd2dAUU6DYPtQ+TNU8zkJ4bsCpYvbPfrEaUXCB0lw9rnwAVPWs2QaTJJc+NIp4ovplM
	X8xmiylz9bm92oRIgBKO7tNTwN/2Z4BJFDj30wOSQuX/C3nAfT3mFatyVSMOOipIwXB2wEV4eP8Oy
	/b0gBX125yc9LUVM8x6mhHq69Pp5OlJMInq35FnmmA6V2IbO+a9xxbOqhDdQdcMzrv3EwhjVbmajK
	a+FPmrBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6URM-00000002bbT-09sn;
	Sun, 20 Apr 2025 13:10:32 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6URI-00000002bar-40a7
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 13:10:30 +0000
Received: from [100.70.200.26] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id DACD921165A5;
	Sun, 20 Apr 2025 06:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DACD921165A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745154627;
	bh=v8/kjfMBX5j8otcEjoEy9F00J/rSQ+ksJRgSx0LzXFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pHx/vc/NZF4cnSWNIalzxFIb81vkZ06zt+dIWhi+JXx6jLz53S9tgyJir/YVKLwwf
	 iWeQDP1iuyZ+YGDvQFdV14T7ikZPiervu0iRYlmO7wFtxh5C5uZFCkgC/WUix0HTjn
	 EfXaB0QH27xlDR2BK3JPVWLxifSMYg3/yoqgs+A0=
Message-ID: <193deea5-c1b4-4189-a5a0-a3e29841225a@linux.microsoft.com>
Date: Sun, 20 Apr 2025 06:10:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] ima: measure kexec load and exec events as
 critical data
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
 <20250416021028.1403-10-chenste@linux.microsoft.com>
 <aAIWcwzuht+GCn29@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAIWcwzuht+GCn29@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_061029_050295_8EA0570F 
X-CRM114-Status: GOOD (  20.05  )
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

On 4/18/2025 2:08 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  The
>> indeterminate interval between kexec 'load' and 'execute' could exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> These critical data events are displayed as hex encoded ascii in the
>> ascii_runtime_measurement_list.  Verifying the critical data hash requires
>> calculating the hash of the decoded ascii string.
>>
>> For example, to verify the 'kexec_load' data hash:
>>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>> | grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
>>
>>
>> To verify the 'kexec_execute' data hash:
>>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>> | grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>    ^^^^^
Hi Baoquan,

I will add Co-developed-by tag in next version.

Thanks,

Steven
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h       |  6 ++++++
>>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c |  5 +++++
>>   3 files changed, 32 insertions(+)
> Acked-by: Baoquan He <bhe@redhat.com>
>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 24d09ea91b87..34815baf5e21 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>   				   unsigned long flags, bool create);
>>   #endif
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +void ima_measure_kexec_event(const char *event_name);
>> +#else
>> +static inline void ima_measure_kexec_event(const char *event_name) {}
>> +#endif
>> +
>>   /*
>>    * The default binary_runtime_measurements list format is defined as the
>>    * platform native format.  The canonical format is defined as little-endian.
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index d1c9d369ba08..38cb2500f4c3 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static bool ima_kexec_update_registered;
>>   static struct seq_file ima_kexec_file;
>>   static size_t kexec_segment_size;
>> @@ -31,6 +33,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   	sf->count = 0;
>>   }
>>   
>> +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +	size_t buf_size = 0;
>> +	long len;
>> +	int n;
>> +
>> +	buf_size = ima_get_binary_runtime_size();
>> +	len = atomic_long_read(&ima_htable.len);
>> +
>> +	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +		      "ima_runtime_measurements_count=%ld;",
>> +		      kexec_segment_size, buf_size, len);
>> +
>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
>> +}
>> +
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>>   	/*
>> @@ -53,6 +73,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   out:
>>   	ima_kexec_file.read_pos = 0;
>>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>> +	ima_measure_kexec_event("kexec_load");
>>   
>>   	return 0;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 83d53824aa98..590637e81ad1 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>>   			       unsigned long action,
>>   			       void *data)
>>   {
>> +#ifdef CONFIG_IMA_KEXEC
>> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>> +		ima_measure_kexec_event("kexec_execute");
>> +#endif
>> +
>>   	ima_measurements_suspend();
>>   
>>   	return NOTIFY_DONE;
>> -- 
>> 2.43.0
>>


