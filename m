Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDB6C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpjMk3pZQOHEwt3Sr15b3n4nFe//isbVm/Zdun/kS94=; b=PuNOis1wjprCa30eCRpjKZHDfA
	bjEH9IGvRNH6IkZ/QSYLBhuh1xQaYLH9mtVq3uTpmqXhcuBXUlbaorSauWhXiTAX70KB7I+jb6BBH
	U4bCoNUKV03AjEvl4q2ZWpW0fNlaph9rojAfxQYAvSEk5YpK5dU515CPvbshvHXsvcWZ0D3LcCxxw
	09ruXbPn0v2q7SP9z4tt5DLYu6sDb7BlnKao64LK1PJOM0iDAwi7xZm0arXKiv+3c8d8ZSj0KxFb5
	ruYjvC49dsAAN+QypRt7XX6Zrr6Kkv5btmVwjlb8oXOR01BdCyEg4gwBAK//4dFxaURAfS8peTs7S
	C33kNlzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6TqV-00000002YnH-48Cq;
	Sun, 20 Apr 2025 12:32:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6TqU-00000002YmT-02rA
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 12:32:27 +0000
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47A5C2052525;
	Sun, 20 Apr 2025 05:32:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47A5C2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745152345;
	bh=HpjMk3pZQOHEwt3Sr15b3n4nFe//isbVm/Zdun/kS94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e+HeHWTsWBSiPxDfBksXj0boaynvyG/tRMj8vO8X27olU3ekHBfA2yieo4xDHzKds
	 cqT3qN4y8AhB9XEKONazg6BFnQRW7NOhanEaNvXSavejOFhBrw7HfHBcT1HPlPLgV1
	 SlilaOnJrDvVPsANwKMaYez8gnNJxQVLGI2hx3LQ=
Message-ID: <01c4d9b8-6e69-45ee-9552-413be6a44de9@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:32:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/9] ima: kexec: skip IMA segment validation after
 kexec soft reboot
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
 <20250416021028.1403-5-chenste@linux.microsoft.com>
 <aAH9rGzumUIMMR7R@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAH9rGzumUIMMR7R@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_053226_103534_4C95AD83 
X-CRM114-Status: GOOD (  27.19  )
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

On 4/18/2025 12:37 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Currently, the function kexec_calculate_store_digests() calculates and
>> stores the digest of the segment during the kexec_file_load syscall,
>> where the  IMA segment is also allocated.
>>
>> Later, the IMA segment will be updated with the measurement log at the
>> kexec execute stage when a kexec reboot is initiated. Therefore, the
>> digests should be updated for the IMA segment in the  normal case. The
>> problem is that the content of memory segments carried over to the new
>> kernel during the kexec systemcall can be changed at kexec 'execute'
>> stage, but the size and the location of the memory segments cannot be
>> changed at kexec 'execute' stage.
>>
>> To address this, skip the calculation and storage of the digest for the
>> IMA segment in kexec_calculate_store_digests() so that it is not added
>> to the purgatory_sha_regions.
>>
>> With this change, the IMA segment is not included in the digest
>> calculation, storage, and verification.
>>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> You may need to set tags as below for this patch:
>
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>
> =======Quoted from Documentation/process/5.Posting.rst=====
>   - Co-developed-by: states that the patch was co-created by several developers;
>     it is a used to give attribution to co-authors (in addition to the author
>     attributed by the From: tag) when multiple people work on a single patch.
>     Every Co-developed-by: must be immediately followed by a Signed-off-by: of
>     the associated co-author.  Details and examples can be found in
>     :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
> ========
>
> Other than this nit, this looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>

Hi Baoquan,

I will add Co-developed-by tag in next version.

Thanks,

Steven

>> ---
>>   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 7d6b12f8b8d0..107e726f2ef3 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -362,6 +362,9 @@ struct kimage {
>>   
>>   	phys_addr_t ima_buffer_addr;
>>   	size_t ima_buffer_size;
>> +
>> +	unsigned long ima_segment_index;
>> +	bool is_ima_segment_index_set;
>>   #endif
>>   
>>   	/* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..606132253c79 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +#else
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>   static int kexec_calculate_store_digests(struct kimage *image);
>>   
>>   /* Maximum size in bytes for kernel/initrd files. */
>> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   		if (ksegment->kbuf == pi->purgatory_buf)
>>   			continue;
>>   
>> +		/*
>> +		 * Skip the segment if ima_segment_index is set and matches
>> +		 * the current index
>> +		 */
>> +		if (check_ima_segment_index(image, i))
>> +			continue;
>> +
>>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>>   					  ksegment->bufsz);
>>   		if (ret)
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index b12ac3619b8f..7e0a19c3483f 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -145,6 +145,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;
>>   	kbuf.memsz = kexec_segment_size;
>> +	image->is_ima_segment_index_set = false;
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> @@ -155,6 +156,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	image->ima_buffer_addr = kbuf.mem;
>>   	image->ima_buffer_size = kexec_segment_size;
>>   	image->ima_buffer = kexec_buffer;
>> +	image->ima_segment_index = image->nr_segments - 1;
>> +	image->is_ima_segment_index_set = true;
>>   
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>>   		      kbuf.mem);
>> -- 
>> 2.43.0
>>


