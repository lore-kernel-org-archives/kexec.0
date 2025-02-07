Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5933EC02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCF9KTGATV07tkTcQHYttgvePnMruMM0SaW9KUYhyWk=; b=RWigrfdfyUuobhJ13FS7qdRys7
	YDbd7h5wmkfMR54o1rBHeu5JjAHgpeuXEdbl78fyLLV7JzBICeJX3/Vd48mNEFt6ga+1zQIws8P9z
	mD89zwn1DYwLFfiBVaikJlznItNwZxgVu0P2uI4WtAbmYWVwUOU/lpIPKZ1oNCNSTWhAPEMEkToue
	vgsnlZQkzjO5VR1Flojiz5IAXYScX1urx9blIWACBN2ik2zPu1HJsy7nlsfyvIgbHaqlwQE8O/alE
	VcS5x1FbIEtLmYnTXb9+oKIJPpgFSowY2R4UM+5y0qTbpuOxfz1uNyzzX0aHBrpDDTxD0SmhY5dgy
	Gr52Fb5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgU00-0000000AtoP-0OX7;
	Fri, 07 Feb 2025 19:26:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTzy-0000000Ato1-2Fxz
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:26:47 +0000
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C0222107303;
	Fri,  7 Feb 2025 11:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C0222107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956403;
	bh=bCF9KTGATV07tkTcQHYttgvePnMruMM0SaW9KUYhyWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A1xWaKB3sPBOuKnzR+J7xb/jHr9BG4z4xks8EZD/eSp0Zxg8MMXkQYlOffSa75eJj
	 pZMXYw1o6gNaeR8HpOvw0I56iSAso+PFdDhAlIuOCP+xfNcUcpF1fcAHN2GerYoN+H
	 eFI8cYlRYpqtLtwTWq5CmSMWfXRSsdLm/oncwKS8=
Message-ID: <f1591776-d2bd-4e7b-b308-220b0edd93d3@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:26:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] ima: measure kexec load and exec events as
 critical data
To: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-9-chenste@linux.microsoft.com>
 <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
 <b2b3fa5d3d20284f790ce74bb97da2b9795a0e0e.camel@linux.ibm.com>
 <8ca0bdd9-7cae-4adf-b4c0-eebf057d4c5b@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8ca0bdd9-7cae-4adf-b4c0-eebf057d4c5b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_112646_625558_16FB830B 
X-CRM114-Status: GOOD (  18.07  )
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

On 2/7/2025 9:48 AM, Stefan Berger wrote:
>
>
> On 2/7/25 12:06 PM, Mimi Zohar wrote:
>> On Fri, 2025-02-07 at 10:16 -0500, Mimi Zohar wrote:
>>> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>>>> The amount of memory allocated at kexec load, even with the extra 
>>>> memory
>>>> allocated, might not be large enough for the entire measurement 
>>>> list.  The
>>>> indeterminate interval between kexec 'load' and 'execute' could 
>>>> exacerbate
>>>> this problem.
>>>>
>>>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>>>> measured as critical data at kexec 'load' and 'execute' respectively.
>>>> Report the allocated kexec segment size, IMA binary log size and the
>>>> runtime measurements count as part of those events.
>>>>
>>>> These events, and the values reported through them, serve as 
>>>> markers in
>>>> the IMA log to verify the IMA events are captured during kexec soft
>>>> reboot.  The presence of a 'kexec_load' event in between the last two
>>>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>>>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>>>> after kexec soft reboot implies missing events in that window which
>>>> results in inconsistency with TPM PCR quotes, necessitating a cold 
>>>> boot
>>>> for a successful remote attestation.
>>>
>>> As a reminder, please include directions for verifying the buffer 
>>> data hash against
>>> the buffer data.  The directions would be similar to those in commit 
>>> 6b4da8c0e7f
>>> ("IMA: Define a new template field buf").
>>>
>>>>
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>> ---
>>>>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/security/integrity/ima/ima_kexec.c
>>>> b/security/integrity/ima/ima_kexec.c
>>>> index c9c916f69ca7..0342ddfa9342 100644
>>>> --- a/security/integrity/ima/ima_kexec.c
>>>> +++ b/security/integrity/ima/ima_kexec.c
>>>> @@ -17,6 +17,8 @@
>>>>   #include "ima.h"
>>>>     #ifdef CONFIG_IMA_KEXEC
>>>> +#define IMA_KEXEC_EVENT_LEN 256
>>>> +
>>>>   static struct seq_file ima_kexec_file;
>>>>   static void *ima_kexec_buffer;
>>>>   static size_t kexec_segment_size;
>>>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct 
>>>> seq_file *sf)
>>>>       ima_reset_kexec_file(sf);
>>>>   }
>>>>   +static void ima_measure_kexec_event(const char *event_name)
>>>> +{
>>>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>>> +    size_t buf_size = 0;
>>>> +    long len;
>>>> +
>>>> +    buf_size = ima_get_binary_runtime_size();
>>>> +    len = atomic_long_read(&ima_htable.len);
>>>> +
>>>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>>> + "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>>>> +            "ima_runtime_measurements_count=%ld;",
>>>> +                kexec_segment_size, buf_size, len);
>>>
>>>  From scripts/checkpatch.pl, "Alignment should match open parenthesis".
>>>
>>>> +
>>>> +    ima_measure_critical_data("ima_kexec", event_name, 
>>>> ima_kexec_event,
>>>> +                    strlen(ima_kexec_event), false, NULL,
>>>> 0);
>>>
>>>  From the kernel-doc scnprintf(), returns the number of bytes.  
>>> There should be no
>>> need to calculate it using strlen().
>>>
>>>> +}
>>>> +
>>>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>>   {
>>>>       /*
>>>> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>>>> segment_size)
>>>>   out:
>>>>       ima_kexec_file.read_pos = 0;
>>>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* 
>>>> reserved
>>>> space
>>>> */
>>>> +    ima_measure_kexec_event("kexec_load");
>>>>         return 0;
>>>>   }
>>>> @@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct 
>>>> notifier_block
>>>> *self,
>>>>           return ret;
>>>>       }
>>>>   +    ima_measure_kexec_event("kexec_execute");
>>>> +
>>>>       ret = ima_dump_measurement_list(&buf_size, &buf,
>>>>                       kexec_segment_size);
>>>
>>> After fixing up and applying this patch set to 6.14.0-rc1, I'm not 
>>> seeing the
>>> "kexec_execute".  Even after changing the default extra memory, I'm 
>>> still not
>>> seeing
>>> the measurement.
>>
>> FYI, after reverting commit 254ef9541d68 ("ima: Suspend PCR extends 
>> and log appends
>> when rebooting"), I'm seeing the "kexec_execute" measurement.
>
> I would try sth. like this:
> static int ima_reboot_notifier(struct notifier_block *nb,
>                    unsigned long action,
>                    void *data)
> {
>     if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>         ima_measure_kexec_event("kexec_execute");
>>
>> Mimi
>>
>>
Thanks, will fix this in 6.14.0-rc1 in next version


