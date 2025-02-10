Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FE2C02198
	for <kexec@archiver.kernel.org>; Mon, 10 Feb 2025 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBpyYwH84HCTrmNtrOfgoYnF3s0Iwvrtgi04480qzkU=; b=Cc/Ew74FImeoR8f2nHr8Ws2xwO
	zCvUYDp+msgA0xr9C519uJSxoWXoga46qBKlppUOKxIqe0r5KRtYormPnnP+uSnAaYxfKj1lzXjle
	paTYypPDiqRBEsoHrFz1jLLRaL0vqCQlcCjvx7aV4aLOnVTaRtM5sAAhfgDxM1AcqO4mTLOxfbfTF
	ZW/X+GCS7/3IOI7nKGcFMlCt2bXKQIdTXEyntDTPAqM2kKODkkCYwBDsmm6PifNRG+Y0a11ob1vF8
	f4+8ZRw+68v9KHedk3GuirwJqiHeZmCneeSiryIwYlU5AQm+qT6wn933V4DDL+QdF95VHYn27b5Oo
	LfBH2vwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thYfl-00000000xDg-1pOb;
	Mon, 10 Feb 2025 18:38:21 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thXF6-00000000eNM-2ynD
	for kexec@lists.infradead.org;
	Mon, 10 Feb 2025 17:06:45 +0000
Received: from [10.17.64.80] (unknown [131.107.8.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2DF12107A8C;
	Mon, 10 Feb 2025 09:06:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2DF12107A8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739207203;
	bh=hBpyYwH84HCTrmNtrOfgoYnF3s0Iwvrtgi04480qzkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wu7tXo2u19roGC3JKJIuc8Lip2MC7atTL9MEET8GC+paes93zHV3Yvh2rI8g8qFpL
	 y/spmSThEjUpGTNvdL4+4tQuc4XJNZ1C7kcxFZoCP1LLSdiijmgaaolHCZg5wutVe6
	 OP3RuYFwggt0BggyJQqLZhfsTwaAkzWUM4DFTQCk=
Message-ID: <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
Date: Mon, 10 Feb 2025 09:06:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-3-chenste@linux.microsoft.com>
 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_090644_795286_11565851 
X-CRM114-Status: GOOD (  18.52  )
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

On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
>>
>> Implement kimage_map_segment() to enable mapping of IMA buffer source
>> pages to the kimage structure post kexec 'load'.  This function,
>> accepting a kimage pointer, an address, and a size, will gather the
>> source pages within the specified address range, create an array of page
>> pointers, and map these to a contiguous virtual address range.  The
>> function returns the start of this range if successful, or NULL if
>> unsuccessful.
>>
>> Implement kimage_unmap_segment() for unmapping segments
>> using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> I don't recall previously adding my "Reviewed-by" tag.
>
> Eric, I'd appreciate your reviewing this and the subsequent patch "[PATCH v7 3/7]
> ima: kexec: skip IMA segment validation after kexec soft reboot" in particular.
Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   include/linux/kexec.h |  7 ++++++
>>   kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..f8413ea5c8c8 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -467,6 +467,9 @@ extern bool kexec_file_dbg_print;
>>   #define kexec_dprintk(fmt, arg...) \
>>           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>>   
>> +extern void *kimage_map_segment(struct kimage *image,
>> +					unsigned long addr, unsigned long size);
> scripts/Checkpatch.pl complains about the parenthesis alignment here and elsewhere.
>
> Mimi
>
>> +extern void kimage_unmap_segment(void *buffer);
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> @@ -474,6 +477,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>>   static inline void crash_kexec(struct pt_regs *regs) { }
>>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>>   static inline int kexec_crash_loaded(void) { return 0; }
>> +static inline void *kimage_map_segment(struct kimage *image,
>> +					unsigned long addr, unsigned long size)
>> +{ return NULL; }
>> +static inline void kimage_unmap_segment(void *buffer) { }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   

Thanks, Mimi, I will update in next version


