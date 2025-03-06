Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC9BC282D1
	for <kexec@archiver.kernel.org>; Thu,  6 Mar 2025 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3h7ftrzvKeXTY/PZI7hZ0Sx+af2u9JaEQAn6P8Go0PY=; b=AGHj9KZ5wKm8tpk26InZRxO442
	LIti5WBJm+TOXtRIcwRHZdYRVx1/1EsZlEbn0THNqgU24dMbw3pLcHiaH+38UCEUdxxPvGVGqagVO
	Zbe3rP/oAKedeBxU79VCzj6EngMPyHLihxlZYZicjmy3yk7BmIxuYKoRs6UjJZ6wd1kf7/bgRBaJq
	S09v2JaUEV/KdxDjjppLnZoqK2BObQkQJ6lRhgabjNjEsT10zwxSSYf0uBXyggo/M6mvs3yBBuOty
	s9ol3vqGnsT9xNpYOXii69ELXRwvUbwHtqvLxpi87jfenrnj3IJ1jCQ507QUd8ZqP89oJFRhKGcjL
	3e2sffTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqJyV-0000000CP4L-1rz0;
	Thu, 06 Mar 2025 22:45:55 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqJyT-0000000CP3U-0Y7A
	for kexec@lists.infradead.org;
	Thu, 06 Mar 2025 22:45:54 +0000
Received: from [10.17.64.156] (unknown [131.107.174.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id A21DB211049E;
	Thu,  6 Mar 2025 14:45:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A21DB211049E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741301151;
	bh=3h7ftrzvKeXTY/PZI7hZ0Sx+af2u9JaEQAn6P8Go0PY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=frZ2g56CJBXLTlvFGP10n2vV/Lei/JOHKPeR+oJ+BoOYE4NEjI4GdM5s5AvOja4F1
	 e9x3Q4hPs5Z9OFTrxEDuZSVeSuZf2eaMpxJ46AbqeZBCaiFvT54SezOOZdv8w5cOZw
	 CccLoMZbeAJsRhpSgj0J0ugVr2zhbfTBS/qXOFTU=
Message-ID: <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
Date: Thu, 6 Mar 2025 14:45:50 -0800
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
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_144553_218749_35CB6AAA 
X-CRM114-Status: GOOD (  12.50  )
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

On 3/5/2025 4:27 AM, Mimi Zohar wrote:
> On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
>> On 03/04/25 at 11:03am, steven chen wrote:
>>> Carrying the IMA measurement list across kexec requires allocating a
>>> buffer and copying the measurement records.  Separate allocating the
>>> buffer and copying the measurement records into separate functions in
>>> order to allocate the buffer at kexec 'load' and copy the measurements
>>> at kexec 'execute'.
>>>
>>> This patch includes the following changes:
>> I don't know why one patch need include so many changes. From below log,
>> it should be split into separate patches. It may not need to make one
>> patch to reflect one change, we should at least split and wrap several
>> kind of changes to ease patch understanding and reviewing. My personal
>> opinion.
> Agreed, well explained.
>
> Mimi
>
>>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>>     a local static to the file, so that it can be accessed from
>>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>>     there is enough memory for the entire measurement record.
>>>   - Copy only complete measurement records.
>>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>>     the above two functions.
>>>   - Compared the memory size allocated with memory size of the entire
>>>     measurement record. Copy only complete measurement records if there
>>>     is enough memory. If there is not enough memory, it will not copy
>>>     any IMA measurement records, and this situation will result in a
>>>     failure of remote attestation.
>>>
>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>

I will split this patch into the following two patches:

     ima: define and call ima_alloc_kexec_file_buf
     ima: copy measurement records as much as possible across kexec

Thanks,

Steven


