Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078AB10FC466
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n31YwgANNxir0IqZ1AmWTsXElIZ9bdMo1T2ZdsadX0c=; b=G0n8VeBmaZ1zpVDVrdGpOG4x5S
	vMfzFwrLEFJfYx8JMtboUgD91I1Ye63PEkZVdwDZTuOVhoRLq4hOeI83PSb0IpmsAxr6Ah+3FUwsj
	aANjv1OlAlUSd1bGx2nJi/7TVZAhR6NUtcHNq+7aJY/ce6+7YdhPIRnY4Jqpp0FJr749qehBgIKdH
	NoSU4eJuv9Y8UpJ5qGAq+HXiwo5Kq8weBG19Kehm5Ipsn9EN7KZ5i9+hEGiYjlk150eZTbf20atpI
	6VrHx6xw5s6VRZmfkk36Vx3E0nAKr0D6Au7k2cG+qVjextNYCYE6V7Lb5X/Uxz60TPerLDHO5fEIV
	SDPr9A4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAed2-00000009awY-3Z3F;
	Thu, 09 Apr 2026 01:56:20 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAecz-00000009aw4-2Pic
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 01:56:19 +0000
Message-ID: <ea389ca2-8980-4022-a7d0-d96c913f671c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775699772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n31YwgANNxir0IqZ1AmWTsXElIZ9bdMo1T2ZdsadX0c=;
	b=Z++eKhxRA2Fx5lMqcc9QiWiaKIcOsEsIaqTo65xxhhAB1eEcdUlus0AgWBHz7JWp7YdmuQ
	lAx2vZTt4Q9xjLSYWqhFVk699bTbT7e4TgBO+TMySfVWZIAIfyMF+WznhPdBWXIbwHw8hQ
	5CbFC2X/WzxINA8aTk1aTBiDeHCd4vs=
Date: Thu, 9 Apr 2026 09:55:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
To: Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20260404074103.506793-1-youling.tang@linux.dev>
 <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
 <adZYpnwOxgvFMLaT@MiWiFi-R3L-srv>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <adZYpnwOxgvFMLaT@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_185617_832980_58F473FC 
X-CRM114-Status: GOOD (  18.51  )
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

Hi, Baoquan

On 4/8/26 21:32, Baoquan He wrote:
> On 04/08/26 at 10:01am, Sourabh Jain wrote:
>> Hello Youling,
>>
>> On 04/04/26 13:11, Youling Tang wrote:
>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>
>>> The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
>>> automatic size selection based on system RAM, but it always reserves
>>> from low memory. When a large crashkernel is selected, this can
>>> consume most of the low memory, causing subsequent hardware
>>> hotplug or drivers requiring low memory to fail due to allocation
>>> failures.
>>
>> Support for high crashkernel reservation has been added to
>> address the above problem.
>>
>> However, high crashkernel reservation is not supported with
>> range-based crashkernel kernel command-line arguments.
>> For example: crashkernel=0M-1G:100M,1G-4G:160M,4G-8G:192M
>>
>> Many users, including some distributions, use range-based
>> crashkernel configuration. So, adding support for high crashkernel
>> reservation with range-based configuration would be useful.
> Sorry for late response. And I have to say sorry because I have some
> negative tendency on this change.
>
> We use crashkernel=xM|G and crashkernel=range1:size1[,range2:size2,...]
> as default setting, so that people only need to set suggested amount
> of memory. While crashkernel=,high|low is for advanced user to customize
> their crashkernel value. In that case, user knows what's high memory and
> low memory, and how much is needed separately to achieve their goal, e.g
> saving low memory, taking away more high memory.
>
> To be honest, above grammers sounds simple, right? I believe both of you
> know very well how complicated the current crashkernel code is. I would
> suggest not letting them becomre more and more complicated by extending
> the grammer further and further. Unless you meet unavoidable issue with
> the existing grammer.
>
> Here comes my question, do you meet unavoidable issue with the existing
> grammer when you use crashkernel=range1:size1[,range2:size2,...] and
> think it's not satisfactory, and at the same time crashkernel=,high|low
> can't meet your demand either?

Yes, regular users generally don't know about high memory and low memory,
and probably don't know how much crashkernel memory should be reserved
either. They mostly just use the default crashkernel parameters configured
by the distribution.

For advanced users, the current grammar is sufficient, because
'crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary'
can definitely be replaced with 'crashkernel=size,high'.

The main purpose of this patch is to provide distributions with a more
reasonable default parameter configuration (satisfying most requirements),
without having to set different distribution default parameters for 
different
scenarios (physical machines, virtual machines) and different machine 
models.

Thanks,
Youling.
>
> Thanks
> Baoquan
>

