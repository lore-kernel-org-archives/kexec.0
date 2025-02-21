Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B019C021B3
	for <kexec@archiver.kernel.org>; Fri, 21 Feb 2025 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nEtVawYrUgdWCquTzf4DrLN6Eub03km1393TBgkgBY=; b=nr/I7Sz6Pbylfr1lEO6S4tzrfC
	8LCy1L6ubVDJdpup8zYOWlB2CMKZ8r+kfhuxANUqR0+zncXfwjC2N57udNA7jqZb3nuZ0JH7ihSg0
	e/+mdoRqTlfmBQiDBZGWdkCV39y9Obz9FklTSn6LQQPxHzF19pndpG9JkzlqN2R92wc5vO9cbhvh1
	xBxhkbE00SXOGfZijcVH5+oKNvuG03ELouVcksUCTJ6wwUZ2VJgVlLlJvh0UJ7M3UcLQZ4kUcIq6U
	fHE4+MXZ0nwABfYpNpNLx1Zs81xA6nf1Txj2faOoBbxv74IJkON4q8nSHhoKwWGtR2LzkgFzQqTfj
	b4GU4z3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaEJ-00000006sL7-2hrL;
	Fri, 21 Feb 2025 21:06:39 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlaDT-00000006sFL-21MA
	for kexec@lists.infradead.org;
	Fri, 21 Feb 2025 21:05:48 +0000
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79933205367B;
	Fri, 21 Feb 2025 13:05:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79933205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171946;
	bh=5nEtVawYrUgdWCquTzf4DrLN6Eub03km1393TBgkgBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PlsqIhZPJD1i6y0OPUbwIhXXlgdZ2AbNoe6SqE2MjQUSTscFXcpAUHNYPtGCSI4aO
	 zae24HXFY1JXGtlF6KOJZNxQJHpqNqfoDlqC7Z9on+58eJbtbYIP25EFvxuYHf3STS
	 zjNseWrCXv0uqFFduPb3oK8ysGVSKzllqRinz820=
Message-ID: <3723d5f8-12b7-417f-9030-218e561e9397@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:05:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_130547_538960_855E844F 
X-CRM114-Status: GOOD (  15.78  )
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

On 2/20/2025 9:22 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
> Obviously up to now Kexec was mapping the segments. Missing from this patch description is
> the reason "why" these functions are needed now.  It's not enough to say "is needed when
> IMA is allocating the memory segments during kexec 'load' operation".  The question is why
> does "IMA" need to allocate the memory segments.  Don't make the kexec/kexec_dump
> maintainers guess.
>
> Refer to the section "Describe your changes" in
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>
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
> Again, no such thing as an "Author" tag.  Refer to the comments on 1/7.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> As previously requested, please add the Cc's inline here and in all the kexec/kdump
> related patches:
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> thanks,
>
> Mimi

Mimi, thanks. I will update in next version.

Steven


