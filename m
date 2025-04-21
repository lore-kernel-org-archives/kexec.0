Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CA1C369AB
	for <kexec@archiver.kernel.org>; Mon, 21 Apr 2025 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g0iye+uMwzSnSSeghwU6QTJxGHXm0NSZS7e1/drAZPU=; b=mo4riL7XaFAMH1wq4K4jZbD7Wh
	aBILIBXQ4GLVbRrGr3+UzU3rzdrvSwb8NNanFvopj3rfUvVGXMn0wWOokzJ/yWiLl6ta+oXG3fjBo
	yZBhxPK0QTNF9MRPiLvmQj6y48/9iTCu+C3li42XdL6c4GV1AQmfGTNJrjKBHwSrgmPy/jhv082M9
	MXW1u4PGt5j9Xjm0pkdDTO5YTQuwcZChP9id4iOyV88rtkitJYhQanE+GLcR2/BCH4ROB4qD7OJ5S
	AzzSQyf3E5zIX/3vitW3HUTr/nU+mJKHCva2P+rHYaWxsdUaqpcPddAKciNkLG/EHBQ1X4EOBIbX+
	eVmCCSsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6xx1-0000000578e-1d7u;
	Mon, 21 Apr 2025 20:41:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6xww-0000000577E-0LFI
	for kexec@lists.infradead.org;
	Mon, 21 Apr 2025 20:41:10 +0000
Received: from [100.70.226.168] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D1FE203B867;
	Mon, 21 Apr 2025 13:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D1FE203B867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745268060;
	bh=g0iye+uMwzSnSSeghwU6QTJxGHXm0NSZS7e1/drAZPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYBrkbU/LFFdjvk6DLcNcYdLDKhhaGSQR/VM+5s0eBYMJ1WmqQvw2jeEg+kjCCJcr
	 mAZrX5xhGwPSSokj4TSa6TuNWe4itLJKu6yqKfDtdvb6ksfjPB/Ztl36SqHC6mcAdR
	 PVjR03iqBgEl8blRnYvobIEdJlyW2oh2xpSBveQM=
Message-ID: <a9e3713f-4edf-479c-8be1-fe5b3dc22866@linux.microsoft.com>
Date: Mon, 21 Apr 2025 13:40:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-4-chenste@linux.microsoft.com>
 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
 <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
 <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_134106_175195_240C5997 
X-CRM114-Status: GOOD (  14.50  )
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

On 4/21/2025 7:18 AM, Mimi Zohar wrote:
> On Mon, 2025-04-21 at 09:51 -0400, Mimi Zohar wrote:
>> On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
>>> On 04/15/25 at 07:10pm, steven chen wrote:
>>>> From: Steven Chen <chenste@linux.microsoft.com>
>>>   ^^^^^^
>> As James Bottomley previously explained[1], if you haven't made any changes to
>> Tushar's patch, then the very first line of the patch description would be
>> "From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a blank line.
>> If there is a minor change, you would add "<your email address>: explanation".
>> For example:
>>
>> Steven Chen <chenste@linux.microsoft.com>: modified patch description
> To clarify: This line would be included below with your Signed-off-by tag.
>
>> [1]
>> https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com/
>>
>>>> Implement kimage_map_segment() to enable IMA to map the measurement log
>>>> list to the kimage structure during the kexec 'load' stage. This function
>>>> gathers the source pages within the specified address range, and maps them
>>>> to a contiguous virtual address range.
>>>>
>>>> This is a preparation for later usage.
>>>>
>>>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>>>
>>>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>    ^^^^^^
>> Neither "Author:" nor "From:" belong here.  Please remove.
>>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>    ^^^^^^^
>> Having Tushar's "Signed-off-by" tag and yours below indicate that you modified
>> the original author's patch.
> To clarify: "Just" having Tushar's "Signed-off-by" tag and yours below indicate
> that you modified the original author's patch.

Hi Mimi,

I will update it in next version.

Just wandering are you done reviewing or still need more time?

Thanks,

Steven

>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> Cc: Baoquan He <bhe@redhat.com>
>>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>>> Cc: Dave Young <dyoung@redhat.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>    ^^^^^
>>>
>>> The signing on this patch is a little confusing. I can't see who is the
>>> real author, who is the co-author, between you and Tushar. You may need
>>> to refer to Documentation/process/5.Posting.rst to make that clear.
>>>
>>>> Acked-by: Baoquan He <bhe@redhat.com>



