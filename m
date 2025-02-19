Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA34C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 19:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SIn0KEqlm9nusvZbQvKrV+qoJtOUkbrZ9gXi403g2M=; b=bIvjIANFsMC0v/GVpu2jm4ToXu
	WqaJ9XyzHTCkmgcQLe3YqISpp08gu9w6OYH3o5cNOLqSUjtpvtheqqvraRfmrouux4FqucoZe7sPY
	qfneE3LjzP3lJKZIUHe2O0xnBW0rJ3ihb2KbZ9wcdCeX/IzhhMxDfmZg2atdWmgNcBXcfTtAfy250
	PrZOjKadJSdZ1/lXzhxcqqir8Dur7WWkwRPprG+H4+wdhe5XoqcyDpeK/lwsekUs+12Zq+bNoAfmn
	4Zos4Q8kLY2tfRrhwGE4o2agWyDV2lmBF6AlLlZr3ClHWTfapMrg0HZTCSv/G5GVA1EFCnJ9BD0Kk
	LAUPfMkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpxe-0000000EheX-2fyz;
	Wed, 19 Feb 2025 19:42:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpfP-0000000EbO3-3t0Y
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 19:23:33 +0000
Received: from [10.17.64.130] (unknown [131.107.147.130])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6ED742043DE8;
	Wed, 19 Feb 2025 11:23:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6ED742043DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739993010;
	bh=0SIn0KEqlm9nusvZbQvKrV+qoJtOUkbrZ9gXi403g2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BO5yjTWXkGV8MGmGnwQNRpnqTe2FKGMuucfvw7j6NumL7pAGfGHso77tlxgNbZPJZ
	 DRGGgy0A9GxLN95k+v4YuwX8B6+QoY7nYZND6aMKl0fW5FMrS1ub8bkRwwNjUMIqLm
	 uRDJmKhJ7mMj3h06WawbhgiTAECDL3AM2bXj3LyE=
Message-ID: <53a254d2-3aec-4bfa-9eca-e17f22e47b5c@linux.microsoft.com>
Date: Wed, 19 Feb 2025 11:23:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to
 execute
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
 <20250218225502.747963-6-chenste@linux.microsoft.com>
 <7433b986-f048-494d-a66a-5888cd37b081@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <7433b986-f048-494d-a66a-5888cd37b081@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_112332_011437_A1EBAE64 
X-CRM114-Status: GOOD (  25.13  )
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

On 2/19/2025 7:57 AM, Stefan Berger wrote:
>
>
> On 2/18/25 5:55 PM, steven chen wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot.  It needs
>
> ... due to missed measurements that only occurred after kexec 'load'. 
> Therefore, this function needs to be ...
>
>> to be called during kexec 'execute'.
>>
>> This patch includes the following changes:
>>   - Implement kimage_file_post_load() function to be invoked after 
>> the new
>>     Kernel image has been loaded for kexec.
>
> s/Kernel/kernel
>
>>   - Call kimage_file_post_load() from kexec_file_load() syscall only for
>>     kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It 
>> will
>>     map the IMA segment, and register reboot notifier for the function
>>     ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>>     reboot.
>>   - Make kexec_segment_size variable local static to the file, for it 
>> to be
>
> ... to the file so that it becomes accessible ...
>
>>     accessible both during kexec 'load' and 'execute'.
>>   - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>>     to ima_update_kexec_buffer().
>>   - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>>     that the buffer is being copied at kexec 'execute', and resetting 
>> the
>>     file at kexec 'load' will corrupt the buffer.
>
> s/will/would
>
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>
> With  the above changes:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> ---
>>   kernel/kexec_file.c                |  8 ++++++
>>   security/integrity/ima/ima_kexec.c | 43 +++++++++++++++++++-----------
>>   2 files changed, 36 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 606132253c79..76b6a877b842 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -201,6 +201,11 @@ kimage_validate_signature(struct kimage *image)
>>   }
>>   #endif
>>   +static void kimage_file_post_load(struct kimage *image)
>> +{
>> +    ima_kexec_post_load(image);
>> +}
>> +
>>   /*
>>    * In file mode list of segments is prepared by kernel. Copy relevant
>>    * data from user space, do error checking, prepare segment list
>> @@ -428,6 +433,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
>> int, initrd_fd,
>>         kimage_terminate(image);
>>   +    if (!(flags & KEXEC_FILE_ON_CRASH))
>> +        kimage_file_post_load(image);
>> +
>>       ret = machine_kexec_post_load(image);
>>       if (ret)
>>           goto out;
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 0fa65f91414b..f9dd7ff95b84 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -19,6 +19,7 @@
>>   #ifdef CONFIG_IMA_KEXEC
>>   static struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>> +static size_t kexec_segment_size;
>>   static bool ima_kexec_update_registered;
>>     static void ima_reset_kexec_file(struct seq_file *sf)
>> @@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       /* use more understandable variable names than defined in kbuf */
>>       void *kexec_buffer = NULL;
>>       size_t kexec_buffer_size = 0;
>> -    size_t kexec_segment_size;
>>       int ret;
>>         /*
>> @@ -154,13 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>           return;
>>       }
>>   -    ret = ima_dump_measurement_list(&kexec_buffer_size, 
>> &kexec_buffer,
>> -                    kexec_segment_size);
>> -    if (ret < 0) {
>> -        pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
>> -        return;
>> -    }
>> -
>>       kbuf.buffer = kexec_buffer;
>>       kbuf.bufsz = kexec_buffer_size;
>>       kbuf.memsz = kexec_segment_size;
>> @@ -178,12 +171,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       image->ima_segment_index = image->nr_segments - 1;
>>       image->is_ima_segment_index_set = true;
>>   -    /*
>> -     * kexec owns kexec_buffer after kexec_add_buffer() is called
>> -     * and it will vfree() that buffer.
>> -     */
>> -    ima_reset_kexec_file(&ima_kexec_file);
>> -
>>       kexec_dprintk("kexec measurement buffer for the loaded kernel 
>> at 0x%lx.\n",
>>                 kbuf.mem);
>>   }
>> @@ -194,7 +181,33 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>                      unsigned long action, void *data)
>>   {
>> -    return NOTIFY_OK;
>> +    void *buf = NULL;
>> +    size_t buf_size = 0;
>> +    int ret = NOTIFY_OK;
>> +
>> +    if (!kexec_in_progress) {
>> +        pr_info("No kexec in progress.\n");
>> +        return ret;
>> +    }
>> +
>> +    if (!ima_kexec_buffer) {
>> +        pr_err("Kexec buffer not set.\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = ima_dump_measurement_list(&buf_size, &buf,
>> +                    kexec_segment_size);
>> +
>> +    if (ret)
>> +        pr_err("Dump measurements failed. Error:%d\n", ret);
>> +
>> +    if (buf_size != 0)
>> +        memcpy(ima_kexec_buffer, buf, buf_size);
>> +
>> +    kimage_unmap_segment(ima_kexec_buffer);
>> +    ima_kexec_buffer = NULL;
>> +
>> +    return ret;
>>   }
>>     struct notifier_block update_buffer_nb = {

Hi Stefan, thanks for your comments. I will update in next version.


