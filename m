Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74298C369AB
	for <kexec@archiver.kernel.org>; Mon, 21 Apr 2025 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqS4FuLxGEljkPeVAmETGzCYTa7oTLpRxOsxhZi2z6I=; b=c+7fPNNJlVwXLXXGDZZYVzk3du
	N905wJLFLjKQdbQpB9kuk+WwohP3IE0QKN+tcThpaXLVw+j5KD5+fcqPaCpIzYPH3/2tB6wVHDlKL
	UgJQpKTIWcPfPmla7RzZDW79tXKEcEuMahmyivw4ogKmphQ1T2A6L36hCMsM0jvEC/CvZSxASBYo9
	OBMTS9pZ7/bPmfWk1Fu342Qez3Ur70OYyCuBU+hCbS7UqTg/ZC8ggMtBTK1A/XPhI0wm84tRAYCqv
	TDMRwEYeQWrDvhT6n6rH1kQ5vNbSozl7eFSOeuqpuh/TvDlJGZFEODvReNathbxlJb5lJmVURAIp7
	2fNx6SkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6z4X-00000005F2m-22G4;
	Mon, 21 Apr 2025 21:53:01 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6ywD-00000005CqR-3qbV
	for kexec@lists.infradead.org;
	Mon, 21 Apr 2025 21:44:29 +0000
Received: from [100.70.160.93] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC27F20BCAD1;
	Mon, 21 Apr 2025 14:44:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC27F20BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745271865;
	bh=aqS4FuLxGEljkPeVAmETGzCYTa7oTLpRxOsxhZi2z6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GbSjsjQDyLZCMRTA1svAS4y/9qHUB+OZmR0RALHX7CiHBX0SfVDQF2KvSK/aRO5Eh
	 iS4wa32R1E8AI+ZpHnNY6B7Yxbxk2a+kpdOHCMOyvB+YEfqMVPxAavxLO747qIkUzH
	 PLMsOCr0PoA0zODXoafNJko3zm3p9RoVwF3oMBj4=
Message-ID: <2434013a-72d2-450d-a043-fcea916ef22d@linux.microsoft.com>
Date: Mon, 21 Apr 2025 14:44:21 -0700
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
 <a9e3713f-4edf-479c-8be1-fe5b3dc22866@linux.microsoft.com>
 <6c3aca6815edf25828bad6f0b4587a040ada03c5.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <6c3aca6815edf25828bad6f0b4587a040ada03c5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_144426_015314_B79C9C73 
X-CRM114-Status: GOOD (  20.12  )
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

On 4/21/2025 2:35 PM, Mimi Zohar wrote:
> On Mon, 2025-04-21 at 13:40 -0700, steven chen wrote:
>> On 4/21/2025 7:18 AM, Mimi Zohar wrote:
>>> On Mon, 2025-04-21 at 09:51 -0400, Mimi Zohar wrote:
>>>> On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
>>>>> On 04/15/25 at 07:10pm, steven chen wrote:
>>>>>> From: Steven Chen <chenste@linux.microsoft.com>
>>>>>    ^^^^^^
>>>> As James Bottomley previously explained[1], if you haven't made any changes to
>>>> Tushar's patch, then the very first line of the patch description would be
>>>> "From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a blank line.
>>>> If there is a minor change, you would add "<your email address>: explanation".
>>>> For example:
>>>>
>>>> Steven Chen <chenste@linux.microsoft.com>: modified patch description
>>> To clarify: This line would be included below with your Signed-off-by tag.
>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com/
>>>>
>>>>>> Implement kimage_map_segment() to enable IMA to map the measurement log
>>>>>> list to the kimage structure during the kexec 'load' stage. This function
>>>>>> gathers the source pages within the specified address range, and maps them
>>>>>> to a contiguous virtual address range.
>>>>>>
>>>>>> This is a preparation for later usage.
>>>>>>
>>>>>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>>>>>
>>>>>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>>>     ^^^^^^
>>>> Neither "Author:" nor "From:" belong here.  Please remove.
>>>>
>>>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>>>     ^^^^^^^
>>>> Having Tushar's "Signed-off-by" tag and yours below indicate that you modified
>>>> the original author's patch.
>>> To clarify: "Just" having Tushar's "Signed-off-by" tag and yours below indicate
>>> that you modified the original author's patch.
>> Hi Mimi,
>>
>> I will update it in next version.
> Sigh, after reviewing your discussion with Baoquan, I'm not sure whether my
> comment this morning added more confusion.
>
> Option 1: Include a single "From:" line at the very top to change the author
> from yourself to someone else.  The following from line would make Tushar the
> patch author:  From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>
> In addition, any minor changes you made should be added before your Signed-off-
> by tag.  For example: Steven Chen <chenste@linux.microsoft.com>: modified patch
> description
>
> Option 2: As mentioned previously and now discussed with Baoquan, adding "Co-
> developed-by:"
>
>> Just wandering are you done reviewing or still need more time?
> Yes, I just finished reviewing/testing.  The patch descriptions are looking much
> better.  As Baoquan reminded you, please remember to update the "ima: define and
> call ima_alloc_kexec_file_buf()" patch description.
>
> thanks,
>
> Mimi
Thanks a lot!
>>>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>>>> Cc: Baoquan He <bhe@redhat.com>
>>>>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>>>>> Cc: Dave Young <dyoung@redhat.com>
>>>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>>>     ^^^^^
>>>>>
>>>>> The signing on this patch is a little confusing. I can't see who is the
>>>>> real author, who is the co-author, between you and Tushar. You may need
>>>>> to refer to Documentation/process/5.Posting.rst to make that clear.
>>>>>
>>>>>> Acked-by: Baoquan He <bhe@redhat.com>



