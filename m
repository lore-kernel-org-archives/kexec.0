Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7CAC021B5
	for <kexec@archiver.kernel.org>; Fri, 21 Feb 2025 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUlp7EisKMHoz+xilvHRinAU2TQZ+x4bdo9N281fpHY=; b=mF1tnNkgVK8U9dPOSxU9KMJg+T
	5yGkiTad+ibi1RSHVxqcTndruq9OjlWBibvjqM6QDyVV2hJXZLdLjX1k5fAsRpLd0eCJW+iHacAXr
	s1KGByGnpwCD5H0AcQRZBVmCPeHhe1t6x6zZlTAmuLBmRdCsg7hV1jTopdr8URLwMqP7Kdp+yKdHi
	647bhD3M2YAHT58YqbGZJmoFFhw0AK47jBeqOfbOtPl91s/oLFXxYqnBSLB7LyWvzri655aoaxkLC
	HO5hm7zC7gpH6SuD/hqvNwui5rzjnjnldXBkHpCcH82FU/28Igs1JYTVR19KEhwhsDSAcOGaeiT1c
	vRb9zIgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaEW-00000006sPW-0BUM;
	Fri, 21 Feb 2025 21:06:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaEU-00000006sON-1ck3
	for kexec@bombadil.infradead.org;
	Fri, 21 Feb 2025 21:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=FUlp7EisKMHoz+xilvHRinAU2TQZ+x4bdo9N281fpHY=; b=D0+OvjjrSxyrRVe6fF2UYCJ5IF
	iVY3MvROVGq+vvHnNHh4vZYhlCMYGFzLxmD4GvSGgn30gk75V78gFR68vS0crqZJ6sPMMcJtzS8tS
	lxVE4PQpMa2ZeNOFphY+pV+6P0kIMSqplolYSiH1EmaeO+zn2FAmsQQHMi61LQoii0Qk16nN77OJa
	/2lq93+8cOGrRfZ6T221httX7rNZ+OPEukwCn3RASFE6Sq+hzavmHiZJTmSUO4rpP3Rd1LROjXRYN
	ln1ZRZI/hXbn4/lZaT/yTYnGYYWi1e4B54lUJ1qM4lJATjDQbVhGSK41PGSlS5Qo6cr/fICnoHhqQ
	4OLK2LvA==;
Received: from linux.microsoft.com ([13.77.154.182])
	by casper.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaEO-0000000F70K-2Tgg
	for kexec@lists.infradead.org;
	Fri, 21 Feb 2025 21:06:49 +0000
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id E71A0205367B;
	Fri, 21 Feb 2025 13:06:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E71A0205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171999;
	bh=FUlp7EisKMHoz+xilvHRinAU2TQZ+x4bdo9N281fpHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WeswjTuNzlG4W7eElUmgmU2MU266rObyW3PfV6HWjdXePbZxpzFDg8EiYGFrOooe5
	 vuf/vXW9Ail2ZrGQXDQnlcXLJGMjzb3XCnLtB4jBljRm+aVg4EXQOxcOR8DNiyEEGy
	 1+NvYn0GNnuKEqXZY41l+Z4rocZqtw5AooSP98Ps=
Message-ID: <a8814f0f-3613-4efd-afb2-655a5c0c9f38@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:06:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-4-chenste@linux.microsoft.com>
 <1883119129dbeeabad1f5239f042a7b920feef0f.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <1883119129dbeeabad1f5239f042a7b920feef0f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_210644_995600_CD383B75 
X-CRM114-Status: GOOD (  19.59  )
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

On 2/21/2025 7:41 AM, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> kexec_calculate_store_digests() calculates and stores the digest of the
>> segment at kexec_file_load syscall where the IMA segment is also
>> allocated.  With this series, the IMA segment will be updated with the
>> measurement log at kexec execute stage when soft reboot is initiated.
>> Therefore, it may fail digest verification in verify_sha256_digest()
>> after kexec soft reboot into the new kernel. Therefore, the digest
>> calculation/verification of the IMA segment needs to be skipped.
>>
>> Skip the calculating and storing digest of the IMA segment in
>> kexec_calculate_store_digests() so that it is not added to the
>> 'purgatory_sha_regions'.
>>
>> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
>> no change is needed in verify_sha256_digest() in this context.
>>
>> With this change, the IMA segment is not included in the digest
>> calculation, storage, and verification.
> Basically you're saying because the hash verification will fail, don't include
> the IMA buffer.  What's missing is the reason for not caring whether the IMA
> hash is included or not.
>
> I understand this is the best we can do without making some major kexec changes.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> After updating the patch description,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
>> ---
>>   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4dbf806bccef..bd554ced9fb2 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -362,6 +362,9 @@ struct kimage {
>>   
>>   	phys_addr_t ima_buffer_addr;
>>   	size_t ima_buffer_size;
>> +
>> +	unsigned long ima_segment_index;
>> +	bool is_ima_segment_index_set;
>>   #endif
>>   
>>   	/* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..606132253c79 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>>   }
>>   #endif
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
>>   static int kexec_calculate_store_digests(struct kimage *image);
>>   
>>   /* Maximum size in bytes for kernel/initrd files. */
>> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage
>> *image)
>>   		if (ksegment->kbuf == pi->purgatory_buf)
>>   			continue;
>>   
>> +		/*
>> +		 * Skip the segment if ima_segment_index is set and matches
>> +		 * the current index
>> +		 */
>> +		if (check_ima_segment_index(image, i))
>> +			continue;
>> +
>>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>>   					  ksegment->bufsz);
>>   		if (ret)
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index 89088f1fa989..704676fa6615 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -160,6 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;
>>   	kbuf.memsz = kexec_segment_size;
>> +	image->is_ima_segment_index_set = false;
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> @@ -170,6 +171,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	image->ima_buffer_addr = kbuf.mem;
>>   	image->ima_buffer_size = kexec_segment_size;
>>   	image->ima_buffer = kexec_buffer;
>> +	image->ima_segment_index = image->nr_segments - 1;
>> +	image->is_ima_segment_index_set = true;
>>   
>>   	/*
>>   	 * kexec owns kexec_buffer after kexec_add_buffer() is called

Thanks, Mimi. I will update in next version.


