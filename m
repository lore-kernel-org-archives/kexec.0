Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C4DC021B1
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGIv90AETr+F5tSvcvrDjMjlon7SVhu4HONEQ2ljSLg=; b=RfX212eDgZsrd/o/kkDqWRWRU8
	DGCtw33yNLIZ2ppEyejVU4Vvt4ROvfOVjA/k3qVve35DqRsc61IhWlM9zDj4/g8aY9BJ9GzWs6Fo/
	xrivplSZ2fun9/JGdDxFlj2qYGp7k8n1ZMaSndCqgZWeQi6PD4zz/waGmzNOhimufrmDc8EW9G98n
	knIunviYMwlSj08K5iH7PffMs4hYxkk6TP7HZSFgHH8ZPoCn1fHOX7lZ1e6JC14DtHe4O5knrcFNW
	EbmcHms2SXrqY/CXEZpfB3QnvQEgWvdlIrA/MUjV0zCtN4J1oso+3KCgfKTP2wIs6ZFJpFLEfVktQ
	p374kJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpxf-0000000Eheh-07F1;
	Wed, 19 Feb 2025 19:42:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpfy-0000000EbWL-2Q5s
	for kexec@bombadil.infradead.org;
	Wed, 19 Feb 2025 19:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zGIv90AETr+F5tSvcvrDjMjlon7SVhu4HONEQ2ljSLg=; b=BHAtVUIfblyhaF7akEdSFBsz/W
	6gB//fg8TfdWcLz2RrQpHEJJOn78DprfCINZGjT96kcC6hX24OU9VDT01VeKZPyKg6mopPhhexaf5
	QFRKnBunLMKmf6OsiPg8WPyOAI1drHvoMjrunL6RqfTTIv+Dx8ask/5eNpnOVko02vXe9/mGO28jh
	aq8XlOc6Xw1KZQRMZzsgWWjMn6OmowWo84HEoC9XTfZ6IE+k80YsY62ouzIIvZ6hXX4QgMKJ1/ac8
	xI7OTd3/AmgKCRJawk0diTyxV4VsFzkiSR5u7DH6eYkw7JYiyvbr63DvQ0x5SkdFS1j7XeF2rMF/B
	Cql5xwUA==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpfv-00000002JUD-1dfb
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 19:24:05 +0000
Received: from [10.17.64.130] (unknown [131.107.147.130])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEAFE2043DEA;
	Wed, 19 Feb 2025 11:24:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEAFE2043DEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739993041;
	bh=zGIv90AETr+F5tSvcvrDjMjlon7SVhu4HONEQ2ljSLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YmybRIfnRELUqn3fz4oLv3t+43EmM0vEAosrgZzK4zuF4kMjaRej7RQQmwZz43BbQ
	 RoSN7K2JH38nTdaoVil/zfpSVltiGWOo/jCF3EnSKNoAREqH2Nlb1ismwyB+bkaQc2
	 ohrySFsliKcwZKvQmiIFDtxDfax6BW5JgHL/v5Kw=
Message-ID: <6532f9e4-0c02-439d-a2d1-d3ddfa5342f3@linux.microsoft.com>
Date: Wed, 19 Feb 2025 11:24:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] ima: measure kexec load and exec events as
 critical data
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-8-chenste@linux.microsoft.com>
 <152e2efc-732f-40bf-9aeb-6e50faa018c0@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <152e2efc-732f-40bf-9aeb-6e50faa018c0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_192404_009659_5088FD11 
X-CRM114-Status: GOOD (  20.89  )
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

On 2/19/2025 8:23 AM, Stefan Berger wrote:
>
>
> On 2/18/25 5:55 PM, steven chen wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement 
>> list.  The
>> indeterminate interval between kexec 'load' and 'execute' could 
>> exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> The 'kexec_load' event IMA log can be found using the following command:
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>>     grep kexec_load
>>
>> The 'kexec_load' event IMA log can be found using the following command:
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>>     grep kexec_execute
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  6 ++++++
>>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c |  5 +++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 4428fcf42167..1452c98242a4 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key 
>> *keyring, struct key *key,
>>                      unsigned long flags, bool create);
>>   #endif
>>   +#ifdef CONFIG_IMA_KEXEC
>> +void ima_measure_kexec_event(const char *event_name);
>> +#else
>> +static inline void ima_measure_kexec_event(const char *event_name) {}
>> +#endif
>> +
>>   /*
>>    * The default binary_runtime_measurements list format is defined 
>> as the
>>    * platform native format.  The canonical format is defined as 
>> little-endian.
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 6c8c203ad81e..8d0782e51ffa 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>     #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>>   static size_t kexec_segment_size;
>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct 
>> seq_file *sf)
>>       ima_reset_kexec_file(sf);
>>   }
>>   +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +    size_t buf_size = 0;
>> +    long len;
>> +
>> +    buf_size = ima_get_binary_runtime_size();
>> +    len = atomic_long_read(&ima_htable.len);
>> +
>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +          "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +         "ima_runtime_measurements_count=%ld;",
>> +         kexec_segment_size, buf_size, len);
>
> Indentation and n = scnprintf(...), as Mimi mentioned in v7.
>
>> +
>> +    ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
>> +                  strlen(ima_kexec_event), false, NULL, 0);
>
> Replace strlen(ima_kexec_event) with 'n'.
>
> With these fixes:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> +}
>> +
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>>       /*
>> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>> segment_size)
>>   out:
>>       ima_kexec_file.read_pos = 0;
>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* 
>> reserved space */
>> +    ima_measure_kexec_event("kexec_load");
>>         return 0;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c 
>> b/security/integrity/ima/ima_queue.c
>> index 3dfd178d4292..6afb46989cf6 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct 
>> notifier_block *nb,
>>                      unsigned long action,
>>                      void *data)
>>   {
>> +#ifdef CONFIG_IMA_KEXEC
>> +    if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>> +        ima_measure_kexec_event("kexec_execute");
>> +#endif
>> +
>>       ima_measurements_suspend();
>>         return NOTIFY_DONE;

Hi Stefan, thanks for your comments. I will update in next version.


