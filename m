Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE0C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfQcgycMxq4nFFdzo1bb4Mu23pE71kIy82/gI3Q5HR8=; b=WX14kM5TnyDihWRzP2K1fV8G3w
	XTDyWzWRe2zJpDuujQrJKcJ4k7q8rE/2uJrLVO0vqiqnddwZQoynnKluvaOWUe94KM+86hmcR8K2G
	iEJCEYJUdxGwXAHjuge/G1deWbZZL2XqIBHOgBY0wIBQFG+xXO8JbZH5SD8ZlZ2LTVnPGNClIZJxR
	MrhJG58MRQiImkHPoeY1ggXIhfGSXyA5E07q2MUKk0K+4QvIZNu1hds4gVfU6e5L1tciRr5NaXMyi
	C5c0daAVi3GVbJWeRLkACQS2e+MoQEumQVCM614OOEV+5JmtsBzANjZqTJDiIwQZbaFLWTyLdVsrE
	WQFCnXHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Ton-00000002YeS-277I;
	Sun, 20 Apr 2025 12:30:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Tok-00000002Ye6-2Rb3
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 12:30:39 +0000
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C47DB2052525;
	Sun, 20 Apr 2025 05:30:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C47DB2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745152237;
	bh=QfQcgycMxq4nFFdzo1bb4Mu23pE71kIy82/gI3Q5HR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V4Np+vMsDXuWmgqdQ24dSBKB/bda0EoaXO8SXIxFdLnBzuuvLGiSX/cekoo3Hwt1o
	 1dztDlj5ZtHUC6mkUaJwEeOWc//MQYrhn1kmFDTtX0EDpakTFURgS0JngBVI+clV2A
	 LBPBfKqpczgqlm1OR0izf5GVEK+quBc6jq6LbZEk=
Message-ID: <95d249ef-bfb3-431f-b633-8b3de383e067@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:30:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap segments
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
 <20250416021028.1403-4-chenste@linux.microsoft.com>
 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_053038_680026_7531032E 
X-CRM114-Status: GOOD (  20.99  )
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

On 4/17/2025 9:36 PM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>   ^^^^^^
>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> gathers the source pages within the specified address range, and maps them
>> to a contiguous virtual address range.
>>
>> This is a preparation for later usage.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^^
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^^^
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>    ^^^^^
>
> The signing on this patch is a little confusing. I can't see who is the
> real author, who is the co-author, between you and Tushar. You may need
> to refer to Documentation/process/5.Posting.rst to make that clear.

Hi Baoquan,

 From my understanding, if there is no change from the original author 
patch, need to add
 From tag and Signed-off-by tag; otherwise, if there are changes, 
Signed-off-by can be used.

Thanks,

Steven

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
>> 2.43.0
>>


