Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC8C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdZ/uDQtZb8rk+qu5u0Z4m4Ap1sKgFkFGaXTq+duMqI=; b=sr/UFuKDIb15qumvGa4urrue8B
	MupDzCZIDtngX61fOon2ZTYHoDQHN4YBHAgRfy/BPswUMk4UfyqoI3h2Oz6VelnN++8CQpHRx/var
	gnXOqG8XBftugb8x4P2U/FfFp4iaL2j3+Z5WXQXrpYa7zhpCXKegdlbeojVO7TC2qz6wi/4OpG4qo
	fJIy1LhPofXCdIvE5XnWuT6BajsRW9GTHhRFB9HKxj9Z6yonSlek/DPXG1uu7VT4h9ZIgJ9prKVUH
	AF3pWrb5Vb5AZpd1Vn3mvklqK6zGTkZV9il9Vzfxbt/MG6HkjmEeOhnxRtSMoUsVukneYoadrYIeb
	9OtHw8IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTuO-0000000AsuO-2H29;
	Fri, 07 Feb 2025 19:21:00 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTuL-0000000AstT-2R5D
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:20:58 +0000
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB5A02107306;
	Fri,  7 Feb 2025 11:20:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB5A02107306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956056;
	bh=zdZ/uDQtZb8rk+qu5u0Z4m4Ap1sKgFkFGaXTq+duMqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvGq8pOEV0DjerwLjO87ymq3rSfWYanj6xtSiX++XRQgflsNRMWR6me86+9TXWzhp
	 4YVqiTb0mdXUHK8dOoZ8t0WSesAi+/zHZ69b7M6yjtUdxwKgRIDcKuvcch/nhd6qD/
	 VyzY5kPOdQccOJRDHSXj9B4DRfUsMYuTj54kJffU=
Message-ID: <3ef51a84-b300-49a3-87f1-b850c5978264@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:20:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-2-chenste@linux.microsoft.com>
 <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_112057_670205_E58A0AA7 
X-CRM114-Status: GOOD (  20.63  )
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

On 2/6/2025 8:49 AM, Mimi Zohar wrote:
> Thanks, Steven, for picking up and working on Tushar's patch set.
>
> I normally finish reviewing the patch set, before commenting.  In this case, there's
> a generic comment that relates to all of the patches.  It's also a way of letting you
> know that I've started reviewing the patch set.  The remaining comments will come
> after I finish reviewing the patch set.
>
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Carrying the IMA measurement list across kexec requires allocating a
>> buffer and copying the measurement records.  Separate allocating the
>> buffer and copying the measurement records into separate functions in
>> order to allocate the buffer at kexec 'load' and copy the measurements
>> at kexec 'execute'.
>>
>> This patch includes the following changes:
>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>     a local static to the file, so that it can be accessed from
>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>     there is enough memory for the entire measurement record.
>>   - Copy as many measurement events as possible.
>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>     the above two functions.
>>   - Compared the memory size allocated with memory size of the entire
>>     measurement record. If there is not enough memory, it will copy as many
>>     IMA measurement records as possible, and this situation will result
>>     in a failure of remote attestation.
>>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> I understand you want to credit Tushar for the patch, but the mechanism is described
> in Documentation/process/submitting-patches.rst.  Refer to the paragraph on "Co-
> developed-by".  There is no tag named "Author".
>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> "Suggested-by" goes before the Signed-off-by tag(s). "Reviewed-by" tag goes after
> your and/or Tushar's Signed-off-tag.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Before the "Co-developed-by" tag was defined, it was implied simply by this ordering
> of the "Signed-off-by" tags.
>
> For those patches you didn't modify, simply import Tushar's patch with him as the
> author and add your Signed-off-by tag after his.
>
> thanks,
>
> Mimi

Thanks Mimi, will update it in next release.


