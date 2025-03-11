Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995BEC282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glSiauzVyj5TpLPTPm8NokxVZzNbbmHbEu15WDGOzEM=; b=V8Xx+KKEFPIQcHo0aHMRcXPviZ
	mM8wqC+2B3O8aey2gH2YrWH08a2knu0WbF5hGB9R7rXkVu/mfzead77m4jyUccCqzkmieKlYhfBuF
	ZIm/bcvMyYa8lSxtHcB+8e8jXzUpDOuuG9C0iGuDiU058gA94FhRGse9PGUJ+qulGvZByqDybBdTh
	XyxHqRYptRIZjpirLvwBWxfqnYTLrKkzt3b0QwwiIK+/qFMmNWfsCxEq4xai1gYrlhKjZmrA0NaLQ
	OTtV5AurhAevvVE/v7Na8O1F5I0nOztNUw4p7WJreIm2AyWVwC39gspRbNhy5ckklvuf3N1FxMXoV
	PQbO4BdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts9K3-00000007D9z-1QBx;
	Tue, 11 Mar 2025 23:47:43 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts9He-00000007Cuv-0ums
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 23:45:15 +0000
Received: from [10.17.64.106] (unknown [131.107.1.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 31B3D2045FE6;
	Tue, 11 Mar 2025 16:45:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31B3D2045FE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741736712;
	bh=glSiauzVyj5TpLPTPm8NokxVZzNbbmHbEu15WDGOzEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbnG89nPuznMR4y1um2+WpeUgFAWN+cSKpbbFCY0CZ6BbVtYRj36XwUOl2La2ZtgM
	 qHDla5pUHmQcAVc3ubJSgLl1id0h/ReIkhzSDMOu2kmXmu5NZaeDI/EzqlGPhjmgld
	 jRd56jOpbDqDoh9kSebk1g7Khjhgqd1s/amhakBw=
Message-ID: <a952eaa2-faf4-4312-87bd-7cb6a9100df5@linux.microsoft.com>
Date: Tue, 11 Mar 2025 16:45:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records across
 kexec
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-2-chenste@linux.microsoft.com>
 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
 <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
 <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
 <69f43be0ed70eee45d3d9d9ac2aeaf39def5770a.camel@linux.ibm.com>
 <631f326006226e23f4f755fd32255792f6514a90.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <631f326006226e23f4f755fd32255792f6514a90.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_164514_309022_D47F5D28 
X-CRM114-Status: GOOD (  24.25  )
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

On 3/11/2025 5:44 AM, Mimi Zohar wrote:
> On Thu, 2025-03-06 at 21:51 -0500, Mimi Zohar wrote:
>> On Thu, 2025-03-06 at 14:45 -0800, steven chen wrote:
>>> On 3/5/2025 4:27 AM, Mimi Zohar wrote:
>>>> On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
>>>>> On 03/04/25 at 11:03am, steven chen wrote:
>>>>>> Carrying the IMA measurement list across kexec requires allocating a
>>>>>> buffer and copying the measurement records.  Separate allocating the
>>>>>> buffer and copying the measurement records into separate functions in
>>>>>> order to allocate the buffer at kexec 'load' and copy the measurements
>>>>>> at kexec 'execute'.
>>>>>>
>>>>>> This patch includes the following changes:
>>>>> I don't know why one patch need include so many changes. From below log,
>>>>> it should be split into separate patches. It may not need to make one
>>>>> patch to reflect one change, we should at least split and wrap several
>>>>> kind of changes to ease patch understanding and reviewing. My personal
>>>>> opinion.
>>>> Agreed, well explained.
>>>>
>>>> Mimi
>>>>
>>>>>>    - Refactor ima_dump_measurement_list() to move the memory allocation
>>>>>>      to a separate function ima_alloc_kexec_file_buf() which allocates
>>>>>>      buffer of size 'kexec_segment_size' at kexec 'load'.
>>>>>>    - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>>>>>      a local static to the file, so that it can be accessed from
>>>>>>      ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>>>>>      there is enough memory for the entire measurement record.
>>>>>>    - Copy only complete measurement records.
>>>>>>    - Make necessary changes to the function ima_add_kexec_buffer() to call
>>>>>>      the above two functions.
>>>>>>    - Compared the memory size allocated with memory size of the entire
>>>>>>      measurement record. Copy only complete measurement records if there
>>>>>>      is enough memory. If there is not enough memory, it will not copy
>>>>>>      any IMA measurement records, and this situation will result in a
>>>>>>      failure of remote attestation.
>>>>>>
>>>>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>> I will split this patch into the following two patches:
>>>
>>>       ima: define and call ima_alloc_kexec_file_buf
>>>       ima: copy measurement records as much as possible across kexec
>> Steven, breaking up code into patches is in order to simplify patch review.
>> This is done by limiting each patch to a single "logical change" [1].  For
>> example, the change below has nothing to do with "separate allocating the buffer
>> and copying the measurement records into separate functions".
>>
>>          /* This is an append-only list, no need to hold the RCU read lock */
>>          list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>> -               if (file.count < file.size) {
>> +               entry_size += ima_get_binary_runtime_entry_size(qe->entry);
>> +               if (entry_size <= segment_size) {
>>                          khdr.count++;
>> -                       ima_measurements_show(&file, qe);
>> +                       ima_measurements_show(&ima_kexec_file, qe);
>>                  } else {
>>                          ret = -EINVAL;
>> +                       pr_err("IMA log file is too big for Kexec buf\n");
>>                          break;
>>                  }
>>          }
>>
>> The original code potentially copied a partial last measurement record, not a
>> complete measurement record.  For ease of review, the above change is fine, but
>> it needs to be a separate patch.
>>
>> Patches:
>> 1. ima: copy only complete measurement records across kexec
>> 2. ima: define and call ima_alloc_kexec_file_buf()
> Steven,
>
> The alternative would be to revert using ima_get_binary_runtime_entry_size() and
> simply use "ima_kexec_file.count < ima_kexec_file.size".  Only
> ima_kexec_file.size would be initialized in ima_alloc_kexec_buf().  The rest
> would remain in ima_dump_measurement_list().  get_binary_runtime_size() wouldn't
> need to be made global.
>
> To further simplify the patch review, first define a separate patch to just
> rename the seq_file "file" to "ima_kexec_file".
>
> Mimi

Hi Mimi,

I will work on it.

Thanks,

Steven


