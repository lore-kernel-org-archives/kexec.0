Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BDBC4706C
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bgmPoRv9JCakF+39wHnFMILkRj5Uo9kPr8YMjQRAZL8=; b=Y4UvYLGbhIdkz5
	djQ2xIdGEBg+C1CNA/93RpbunZrmj6m8vHPxWV8HhOboLSomsoTq7jASNBHgPBxgxXsdl4EgaC3XT
	4vnrPSJtEOGOrkaJROAhqHnOIok3v27f+21Vb8mJ1TXsxL9Q70s4UhqgT8LNrfF3sW+s/319AZEnL
	b9IkxeAH2LXI6kUYuAxp6reDUJTx4DQ0r2tv8PqTnh/UNMxBi7HmDjkYEOZq/rZImOw/GgGVLeB5n
	saJgPNI1lRypKHyPsj1EDfdwLJgPZncboe90Sq0fSPnKsswbboFL3UPMg10wfHDoKVHJRkTZDLlNY
	yBAn5oJstOnm4EU8ehbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOLIT-003T5i-2D;
	Fri, 12 Jan 2024 17:26:21 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOLIR-003T4Z-1B
	for kexec@lists.infradead.org;
	Fri, 12 Jan 2024 17:26:20 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC05820B3CE1;
	Fri, 12 Jan 2024 09:26:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC05820B3CE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705080376;
	bh=KbxatyazcGOb5nVqjoWrzE226sOvTe/q3xt20G4j/YQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNjnAYa7dcmhzXN7wy7JcWFS/2uApgDBtTWnXOtv+Q8Hxtkf8v3wL+QrK6p7iHJYR
	 68TBJoI8PALpcCVnvowTMykrVzELltaSIcSUp632A8ZSmvs3ji1xUZJNPgHB0FbyGJ
	 LeMkB9++4X88Gfj4MeZh/KIH2yv/V9uNaTdCIpE0=
Message-ID: <30910120-2a44-46fd-b8d3-c7bff38b6269@linux.microsoft.com>
Date: Fri, 12 Jan 2024 09:26:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] ima: kexec: move ima log copy from kexec load to
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
 <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
 <c2ec280f-4789-4654-a7b4-7a9534476173@linux.microsoft.com>
 <8f5deffb34c9a948a20e63eae44a1e3343e2ffe4.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f5deffb34c9a948a20e63eae44a1e3343e2ffe4.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_092619_435838_EF468DE3 
X-CRM114-Status: GOOD (  15.47  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 1/12/24 09:06, Mimi Zohar wrote:
> 
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index f989f5f1933b..bf758fd5062c 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>>>    		if (ksegment->kbuf == pi->purgatory_buf)
>>>>    			continue;
>>>>    
>>>> +		/*
>>>> +		 * Skip the segment if ima_segment_index is set and matches
>>>> +		 * the current index
>>>> +		 */
>>>> +		if (image->is_ima_segment_index_set &&
>>>> +		    i == image->ima_segment_index)
>>>> +			continue;
>>> With this change, the IMA segment is not included in the digest
>>> calculation, nor should it be included in the digest verification.
>>> However, I'm not seeing the matching code change in the digest
>>> verification.
>>>
>> Fair question.
>>
>> But I don't think anything else needs to be done here.
>>
>> The way kexec_calculate_store_digests() and verify_sha256_digest()
>> are implemented, it already skips verification of the segments if
>> the segment is not part of 'purgatory_sha_regions'.
>>
>> In kexec_calculate_store_digests(), my change is to 'continue' when the
>> segment is the IMA segment when the function is going through all the
>> segments in a for loop [1].
>>
>> Therefore in kexec_calculate_store_digests() -
>>    - crypto_shash_update() is not called for IMA segment [1].
>>    - sha_regions[j] is not updated with IMA segment  [1].
>>    - This 'sha_regions' variable later becomes 'purgatory_sha_regions'
>>      in kexec_calculate_store_digests  [1].
>>    - and verify_sha256_digest() only verifies 'purgatory_sha_regions'[2].
>>
>>    Since IMA segment is not part of the 'purgatory_sha_regions', it is
>>    not included in the verification as part of verify_sha256_digest().
>>
>>> Please make ignoring the IMA segment a separate patch.
>>>
>> Sure. Will do.
> Thank you for the explanation.  Please include in the patch description a
> statement about the "sha_regions" not including the IMA segment, so nothing is
> needed on the verify side.
Definitely.  Will do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
