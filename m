Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971CF43683
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bxhLWlsH38nctCN2Sqtp0FNUJjg3XOl8ORoFvMkTgNY=; b=NhJ5t+ISwEnNoRktC4k2oQ0Q2v
	LjB6F8gVcUwWa4wi873d+7gdujQDxg0R7kwqgap086m6cLdbMrzj6a/IaZ4PeuuUMckigPRBHccig
	CQPM8JDY356+/V2oFeKypek3VC6KIX3C27nol4aVBdR+Px/zeDSeBYdCBwQP0D/p+YwWUwG2ky2ac
	Q+4edN0cZ3gP/UyH8Uq1EyfPoSBGQHN3Lb4CZpVC8rf8OE4yJOkf/ugb/dVsN766ag3S37ZOqo6m5
	E1W9fAmL+xZoidUsKFv0B28dMvGJ/L9VEuwnu8VLVC7JDeXIza0cbW3ZPerjHzYQur/qOP0LqpsIG
	8pTvkR5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDfQp-00000003kWO-3IcO;
	Fri, 17 Apr 2026 09:24:11 +0000
Received: from out-182.mta0.migadu.com ([2001:41d0:1004:224b::b6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDfQn-00000003kVE-0ZDs
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 09:24:10 +0000
Message-ID: <a2232eec-34b9-49d0-b671-9a184ef1e4b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776417833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxhLWlsH38nctCN2Sqtp0FNUJjg3XOl8ORoFvMkTgNY=;
	b=GeHGYql+K62K8092FrXUYkINVPGvfXquj4jyvdTo+JSuGTjL5B8ClIhv1zP7YKhBMDtf0/
	NGGgAAwA2FD9QX03Un9qjIK61VERnBWP7G8rwQ7IkhurYQCIzE3WLR2PRxiZ1w2gZLXQta
	MJuHFpGc5a2dC95vxgwH+m5V1dETojQ=
Date: Fri, 17 Apr 2026 17:23:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
To: Baoquan He <baoquan.he@linux.dev>
Cc: Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20260404074103.506793-1-youling.tang@linux.dev>
 <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
 <adZYpnwOxgvFMLaT@MiWiFi-R3L-srv>
 <ea389ca2-8980-4022-a7d0-d96c913f671c@linux.dev>
 <ad92ix7d7I8jsykV@MiWiFi-R3L-srv>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <ad92ix7d7I8jsykV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_022409_320781_FE18BD18 
X-CRM114-Status: GOOD (  13.93  )
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

On 4/15/26 19:29, Baoquan He wrote:

> On 04/09/26 at 09:55am, Youling Tang wrote:
>> Hi, Baoquan
>>
>> On 4/8/26 21:32, Baoquan He wrote:
>>> On 04/08/26 at 10:01am, Sourabh Jain wrote:
>>>> Hello Youling,
>>>>
>>>> On 04/04/26 13:11, Youling Tang wrote:
>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>
>>>>> The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
>>>>> automatic size selection based on system RAM, but it always reserves
>>>>> from low memory. When a large crashkernel is selected, this can
>>>>> consume most of the low memory, causing subsequent hardware
>>>>> hotplug or drivers requiring low memory to fail due to allocation
>>>>> failures.
>>>> Support for high crashkernel reservation has been added to
>>>> address the above problem.
>>>>
>>>> However, high crashkernel reservation is not supported with
>>>> range-based crashkernel kernel command-line arguments.
>>>> For example: crashkernel=0M-1G:100M,1G-4G:160M,4G-8G:192M
>>>>
>>>> Many users, including some distributions, use range-based
>>>> crashkernel configuration. So, adding support for high crashkernel
>>>> reservation with range-based configuration would be useful.
>>> Sorry for late response. And I have to say sorry because I have some
>>> negative tendency on this change.
>>>
>>> We use crashkernel=xM|G and crashkernel=range1:size1[,range2:size2,...]
>>> as default setting, so that people only need to set suggested amount
>>> of memory. While crashkernel=,high|low is for advanced user to customize
>>> their crashkernel value. In that case, user knows what's high memory and
>>> low memory, and how much is needed separately to achieve their goal, e.g
>>> saving low memory, taking away more high memory.
>>>
>>> To be honest, above grammers sounds simple, right? I believe both of you
>>> know very well how complicated the current crashkernel code is. I would
>>> suggest not letting them becomre more and more complicated by extending
>>> the grammer further and further. Unless you meet unavoidable issue with
>>> the existing grammer.
>>>
>>> Here comes my question, do you meet unavoidable issue with the existing
>>> grammer when you use crashkernel=range1:size1[,range2:size2,...] and
>>> think it's not satisfactory, and at the same time crashkernel=,high|low
>>> can't meet your demand either?
>> Yes, regular users generally don't know about high memory and low memory,
>> and probably don't know how much crashkernel memory should be reserved
>> either. They mostly just use the default crashkernel parameters configured
>> by the distribution.
>>
>> For advanced users, the current grammar is sufficient, because
>> 'crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary'
>> can definitely be replaced with 'crashkernel=size,high'.
>>
>> The main purpose of this patch is to provide distributions with a more
>> reasonable default parameter configuration (satisfying most requirements),
>> without having to set different distribution default parameters for
>> different
>> scenarios (physical machines, virtual machines) and different machine
>> models.
> OK, do you have a concrete case? e.g in your distros, what will you set
> with this patchset applied? Let's see if it can cover all cases with one
> simple and satisfying parameter.

For our production deployment across various hardware configurations
(physical servers, VMs with different memory sizes), I'm planning to
use the following crashkernel configuration:
crashkernel=1G-4G:256M,4G-12G:384M,12G-48G:512M,48G-128G:768M,128G-:1024M,>384M

Thanks,
Youling.

