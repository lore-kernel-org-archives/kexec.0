Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC886C36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRk5YV40nQnvrqNi6qYQSLR/DJ1q+CacJtEHwZzWwL0=; b=RjiRuZDbgh3MDaIJpNCIrdXpvd
	8S3OTFJsOGLM1mb+5Vc9O8iXK4H9uagpEkp2gsGa8hGEaa5WI16JtnqBW1gjyIDSdkJw9J6tulJF1
	7zSsZcD90sE1RrC6yZniNeCr9PDQ4x53BJ6IQXPjhvtHrqRxpsR0fhhQYBHXuU6Z7YGkXi5F/Swpb
	or4y4plPeAybB59yVvKVadrEJdABxAjuQP/tYeUzkO70imIYhd32haiBrd4zzmGNyJ1SaYj6DnKM+
	61GcCkYd6o4/Lg5ceMZORNXk/iH4N0qoFSctEqZt4hyq7LDdkPD1HMvLE+pHuAZi15pjtQZ7xd3yW
	IhX3ePrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf3l-0000000FSsY-16sR;
	Fri, 21 Mar 2025 16:17:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf28-0000000FSTh-2f7H
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 16:15:45 +0000
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0789A202537E;
	Fri, 21 Mar 2025 09:15:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0789A202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573743;
	bh=BRk5YV40nQnvrqNi6qYQSLR/DJ1q+CacJtEHwZzWwL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WS/NuTZEgk78GqVwM3nFClW8xzukz70tjDPQUa2/c9PImhrHqnFS8JINSAkDvZogj
	 1drLwzHZRHarZ6+GcvPRgaIKKlIwhcQakJWrrcHRjK/sRGhi/kEkVBmIAQZYjwc+oI
	 QfmV1YnYZG1Z37HpAO1VA87Qo/Nq3xNO+NXzrxE0=
Message-ID: <b8882b36-e3ef-424e-9dc1-564e3d1944f9@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:15:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
To: Baoquan He <bhe@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
 <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_091544_710006_823A2DDF 
X-CRM114-Status: GOOD (  13.03  )
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

On 3/18/2025 7:43 PM, Baoquan He wrote:
> On 03/18/25 at 11:10am, Stefan Berger wrote:
>>
>> On 3/17/25 9:04 PM, steven chen wrote:
>>> The name of the local variable "file" of type seq_file defined in the
>>> ima_dump_measurement_list function is too generic. To better reflect the
>>> purpose of the variable, rename it to "ima_kexec_file". This change will
>>> help improve code readability and maintainability by making the variable's
>>> role more explicit.
>>>
>>> The variable ima_kexec_file is indeed the memory allocated for copying IMA
>>> measurement records. The ima_dump_measurement_list function calculates the
>>> actual memory occupied by the IMA logs and compares it with the allocated
>>> memory. If there is enough memory, it copies all IMA measurement records;
>>> otherwise, it does not copy any records, which would result in a failure
>>> of remote attestation.
>>>
>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>
>>> ---
>>>    security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>>>    1 file changed, 24 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>> index 9d45f4d26f73..8567619889d1 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -15,33 +15,41 @@
>>>    #include "ima.h"
>>>    #ifdef CONFIG_IMA_KEXEC
>>> +/*
>>> + * Copy the measurement list to the allocated memory
>>> + * compare the size of IMA measurement list with the size of the allocated memory
>> Compare the size of the IMA ... memory.
>>
>>
>>> + *    if the size of the allocated memory is not less than the size of IMA measurement list
>>> + *        copy the measurement list to the allocated memory.
>>> + *    else
>>> + *        return error
>> If the size of the allocated memory is not less than the size of IMA
>> measurement list, copy the measurement list to the allocated memory, return
>> an error otherwise.
> Ack the suggested change.

Thanks for the comments.


