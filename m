Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AFCC282D0
	for <kexec@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4AhP6jMEhJGpBHUcIilmpOFGmGyNrWrR7ArRzfcffA=; b=kZ43uR7jNoLO0iE5LBlnz9A2wG
	V/kcgfHgT5d99CWn3h5VzYDOhaO0+Ki9xvw63Ad7+mV3XKAGKEBmTdqDXipbiHrK037QqSy//QiBk
	FILPeZApVCoCX1MrelXKlIUUq1iIw9nFrxMfHK4Ossgl6WPJVVE/uNe5l7GC2KLs67amTNgL5d8JK
	NABtAVekV9RG1XIRWc1gQ+3GtvzAlIEEGgMARqLqhh/CN0OQa8II4EEBa6NJ+04oQ0vx0VudvqYS4
	F9HxDNHZdhcgqKu8ATzposfvwG7Nz1GIlEfhr0rKRPerZDnOPdeZTeEQZHlRolrMhemIQLihukT7q
	KvyVG4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpe33-00000006lQc-1DHK;
	Wed, 05 Mar 2025 01:59:49 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpd2s-00000006feU-3L2y
	for kexec@lists.infradead.org;
	Wed, 05 Mar 2025 00:55:36 +0000
Received: from [10.17.64.124] (unknown [131.107.8.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 719E5210EAF8;
	Tue,  4 Mar 2025 16:55:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 719E5210EAF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741136133;
	bh=H4AhP6jMEhJGpBHUcIilmpOFGmGyNrWrR7ArRzfcffA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q5XbfO3sQRMPEjEjiuHvgPgBodNGY9XthIiuorr4yo2BWztHbo7TU63BQ8w7hPZnQ
	 focqn8ATU2iMizxoVlxHtYUpW2DsOmqrbxT0QCRLf6NmOBplG8GXSEPGPGycsQfZZL
	 a+8Ce6g6xdDS8kmqEjzyXwphUdimgHHXpZnKQBKc=
Message-ID: <97c27a30-a5ee-4825-ab7e-82dcddedd688@linux.microsoft.com>
Date: Tue, 4 Mar 2025 16:55:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-3-chenste@linux.microsoft.com>
 <Z8d9RvRWPOADOgsx@kernel.org>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z8d9RvRWPOADOgsx@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_165534_885278_F1E8A4E2 
X-CRM114-Status: GOOD (  27.98  )
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

On 3/4/2025 2:23 PM, Jarkko Sakkinen wrote:
> On Tue, Mar 04, 2025 at 11:03:46AM -0800, steven chen wrote:
>> The content of memory segments carried over to the new kernel during the
>> kexec systemcall can be changed at kexec 'execute' stage, but the size of
>> the memory segments cannot be changed at kexec 'execute' stage.
>>
>> To copy IMA measurement logs during the kexec operation, IMA needs to
>> allocate memory at the kexec 'load' stage and map the segments to the
>> kimage structure. The mapped address will then be used to copy IMA
>> measurements during the kexec 'execute' stage.
>>
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to subsystems outside of kexec.
> How does IMA work with kexec without having this? Just interested
> (and confused).
Currently, all IMA-related operations during a soft reboot, such as 
memory allocation and IMA log list copy, are handled in the kexec 'load' 
stage, so the map/unmap mechanism is not required.

The new design separates these two operations into different stages: 
memory allocation remains in the kexec 'load' stage, while the IMA log 
list copy is moved to the kexec 'execute' stage. Therefore, the 
map/unmap mechanism is introduced.

Please refer to "[PATCH v9 0/7] ima: kexec: measure events between kexec 
load and execute" for the reason why to add this.

Steven

>> Implement kimage_map_segment() to enable IMA to map measurement log list to
>> the kimage structure during kexec 'load' stage.  This function takes a kimage
>> pointer, a memory address, and a size, then gathers the
>> source pages within the specified address range, creates an array of page
>> pointers, and maps these to a contiguous virtual address range.  The
>> function returns the start virtual address of this range if successful, or NULL on
>> failure.
>>
>> Implement kimage_unmap_segment() for unmapping segments
>> using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
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
>> index c0bdc1686154..63e4d16b6023 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>>   	return result;
>>   }
>>   
>> +void *kimage_map_segment(struct kimage *image,
>> +			 unsigned long addr, unsigned long size)
>> +{
>> +	unsigned long eaddr = addr + size;
>> +	unsigned long src_page_addr, dest_page_addr;
>> +	unsigned int npages;
>> +	struct page **src_pages;
>> +	int i;
>> +	kimage_entry_t *ptr, entry;
>> +	void *vaddr = NULL;
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
>>
> BR, Jarkko



