Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16597C3601E
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BWbmMbT74Sn7SqaSDZAyAFKEL0RW1KrKKLxHKERd89Y=; b=WKuTCR1WWGOX+MSy25/+1Bj2iI
	UNOgZ/GanA9Hz2rhu6pOXr4YJ3fD701N56Ox0iXbtyKGvD7e4dSK2rsjyWcxLujdicOfdN/6RVz43
	Cn2eBXt2srygCra2wijiDrRNQ0ckciFIrnQYvYOfM18tLDK7Ie2txEHJhnyGGUPgXtb+lA67hqAbU
	yN9cUPDjlMFzfetlQqLXcx/h1nzeVNKyePM6cZ5fwYhmHjmBGtW1gYONtnV0Lj2tvx78J7av4OlTL
	BkPwWd2C6rU25t+3ZbRaGhhvtNCznUIQH0FcMmWfeTaMvqhxPIWiX3CElO2AL1gsYgyJUZ65grseF
	isn6w3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2sdG-0000000AnHT-10U8;
	Thu, 10 Apr 2025 14:11:54 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2sdE-0000000AnFz-1AvC
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 14:11:53 +0000
Received: from [100.70.200.180] (unknown [20.1.194.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08FA62114D81;
	Thu, 10 Apr 2025 07:11:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08FA62114D81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294310;
	bh=BWbmMbT74Sn7SqaSDZAyAFKEL0RW1KrKKLxHKERd89Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STHC8Vd7L34139AsmAyauJpLmZYgvBtIRXy/VamhTZgHJvxW/gIalruqNdVHSTXQB
	 vQWTNgyRHU8fwPKdVhRWubSzYL4iRWCx2ULcGRFgEimMvmVCqWuATr7BF0eHfuDBa4
	 c1bqXcyCOYoZ43yTOLlQkqcQJW/sJXQnd/qQpMRQ=
Message-ID: <1e176b0c-13a2-42bd-8879-b22f459a04de@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/9] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-4-chenste@linux.microsoft.com>
 <Z/STl3Jjt4/gMQHL@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z/STl3Jjt4/gMQHL@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_071152_380639_0BCE2C0A 
X-CRM114-Status: GOOD (  33.99  )
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

On 4/7/2025 8:10 PM, Baoquan He wrote:
> On 04/02/25 at 05:47am, steven chen wrote:
>> Currently, the kernel behavior during kexec load is to fetch the IMA
>> measurements logs and store logs in kernel memory. When a kexec reboot is
>> triggered, these stored logs in the kernel memory are carried over to the
>> second kernel. However, the time gap between kexec load and kexec reboot
>> can be very long. During this time window, new events extended into TPM
>> PCRs miss the chance to be carried over to the second kernel. This results
>> in a mismatch between TPM PCR quotes and the actual IMA measurements list
>> after kexec reboot, leading to remote attestation failure.
>>
>> To solve this problem, the new design defers reading the IMA measurements
>> logs into the kexec buffer to the kexec reboot phase, while still allocating
>> the necessary buffer at kexec load time because it is not appropriate to
>> allocate memory at the kexec reboot moment.
>>
>> The content of memory segments carried over to the new kernel during the
>> kexec system call can be changed at the kexec 'execute' stage, but the size
>> of the memory segments cannot be changed at the kexec 'execute' stage.
>>
>> To copy IMA measurement logs during the kexec operation, IMA allocates
>> memory at the kexec 'load' stage and map the segments to the kimage
>> structure. The mapped address will then be used to copy IMA measurements
>> during the kexec 'execute' stage.
>>
>> Currently, the mechanism to map and unmap segments to the kimage structure
>> is not available to subsystems outside of kexec.
> There's no need to describe the plan of the whole series. From my point
> of view, the first few patches are prepared for later change. We can
> just mention this, and briefly tell what it's doing if it's complicated.
> For log of this patch, I would go with:
>
> ====
> Implement kimage_map_segment() to enable IMA to map the measurement log
> list to the kimage structure during the kexec 'load' stage. This function
> gathers the source pages within the specified address range, and maps them
> to a contiguous virtual address range.
>
> This is a preparation for later usage.
> ====
>
> Other than this, the code change looks good to me.

Hi Baoquan,

Thanks for your comments. Will update in next version.

Steven

>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> takes a kimage pointer, a memory address, and a size, then gathers the
>> source pages within the specified address range, creates an array of page
>> pointers, and maps these to a contiguous virtual address range. The
>> function returns the start virtual address of this range if successful,
>> or NULL on failure.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/kexec.h |  6 +++++
>>   kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..7d6b12f8b8d0 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>>   #define kexec_dprintk(fmt, arg...) \
>>           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>>   
>> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>> +extern void kimage_unmap_segment(void *buffer);
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> +struct kimage;
>>   static inline void __crash_kexec(struct pt_regs *regs) { }
>>   static inline void crash_kexec(struct pt_regs *regs) { }
>>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>>   static inline int kexec_crash_loaded(void) { return 0; }
>> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
>> +{ return NULL; }
>> +static inline void kimage_unmap_segment(void *buffer) { }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index c0bdc1686154..a5e378e1dc7f 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>>   	return result;
>>   }
>>   
>> +void *kimage_map_segment(struct kimage *image,
>> +			 unsigned long addr, unsigned long size)
>> +{
>> +	unsigned long src_page_addr, dest_page_addr = 0;
>> +	unsigned long eaddr = addr + size;
>> +	kimage_entry_t *ptr, entry;
>> +	struct page **src_pages;
>> +	unsigned int npages;
>> +	void *vaddr = NULL;
>> +	int i;
>> +
>> +	/*
>> +	 * Collect the source pages and map them in a contiguous VA range.
>> +	 */
>> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
>> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
>> +	if (!src_pages) {
>> +		pr_err("Could not allocate ima pages array.\n");
>> +		return NULL;
>> +	}
>> +
>> +	i = 0;
>> +	for_each_kimage_entry(image, ptr, entry) {
>> +		if (entry & IND_DESTINATION) {
>> +			dest_page_addr = entry & PAGE_MASK;
>> +		} else if (entry & IND_SOURCE) {
>> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>> +				src_page_addr = entry & PAGE_MASK;
>> +				src_pages[i++] =
>> +					virt_to_page(__va(src_page_addr));
>> +				if (i == npages)
>> +					break;
>> +				dest_page_addr += PAGE_SIZE;
>> +			}
>> +		}
>> +	}
>> +
>> +	/* Sanity check. */
>> +	WARN_ON(i < npages);
>> +
>> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
>> +	kfree(src_pages);
>> +
>> +	if (!vaddr)
>> +		pr_err("Could not map ima buffer.\n");
>> +
>> +	return vaddr;
>> +}
>> +
>> +void kimage_unmap_segment(void *segment_buffer)
>> +{
>> +	vunmap(segment_buffer);
>> +}
>> +
>>   struct kexec_load_limit {
>>   	/* Mutex protects the limit count. */
>>   	struct mutex mutex;
>> -- 
>> 2.25.1
>>


