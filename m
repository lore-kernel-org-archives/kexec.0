Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1254DC982CC
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=; b=jLEMHoUORMQPxhXHK51EsxRXxM
	+97MMfj1MHOcnMZWVlVyxT8V3/jfUyeYX0tkmNYB2n+L/x8bf4Kh0BezhdoZN1kaRe2/yPUVZBJ8x
	tUlB9OIC+iiB6faovtGFFwWQVZAAUt6xznukZT9oDbENOuh1bO9iNarsklWz495SAsIpkecxJfMUQ
	nPLHq1lrz2R3i8bCH23swVM63eB1YjJMHu3IsyQp9LzTuCUpbY8qF9xS74IzyTzeAcHfdyvmsQKaL
	JViTnnIC7ALhlQ0Y3u5fsJXg8RH3/CQmVBDhf3wO7tioCZm4rfenxAeA3F492GMM34P3dSrO/LUgT
	Ytv5Ewkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8CTs-0000000H4ke-0sum;
	Sun, 20 Sep 2026 08:01:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8CTr-0000000H4jb-0CNN
	for kexec@bombadil.infradead.org;
	Sun, 20 Sep 2026 08:00:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=; b=RqPpf1Mbl8hpBVfac0fgX/4uqW
	SwUjMuzm1O+60N9yTLa6cum59+awjcmkknw16awzjhl85OSuvJwcTo0Ue7Ij1atmBTZT/XKVSxTpv
	36jiIsFvjhvPyURfr6C1u6mCOMKjXw5LQg8PPCJp6kX1haxrnjeKa1CAjav1aZm5nPmg79zpfqoHb
	upCz+aNbE55PmcNAzEp14Yiwo1aPtQnqapxVJBi6iHCAztsx7XCpTs92oUDNHsK444Eu79Ow2DKFC
	vEfDGrtQnhIFRLdnbFbq/w1QouiXW4nr66yFC17fo1QlEL7ZeLZfne4dAruJM+jx2ajfFRaW7ENJB
	4lnQt5FQ==;
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8CTm-0000000BGJM-0q7F
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 08:00:57 +0000
Received: by mail-pj2-x03.google.com with SMTP id 98e67ed59e1d1-3859292bb51so199535a91.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789891251; x=1790496051; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=;
        b=UEe7jbfthxw2A+D6/MgwTFOk0tiTKD42Yr43bITfe/EgKyLe1p4WMvte6tMuG4FkFH
         XHMWRBojJzRPQb172aRuGl2WTA5J7WKjOXe7929R+IuC6Oys+8O6iL3AatTA1kd+g4E7
         /BUe8/CwCXzKZ2sjQYgusn60JDnMp0c0MdH82S7qypUDsTpt0iS9gNlu9++RpOUQqc5M
         i8mTqbVTXm4v/MqkSi0lCxHFAhvcx4yhJVCUjlg5/f30S00eVmmOWFMfhwLJkAg3cwwD
         1klFNkzXXlRON9n9M4sNZ6T6OXDzzvdd4UYun0wxdCNEsDhrffausGjA2XS3bL8g0AcO
         CKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789891251; x=1790496051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=;
        b=Oqy57ZBNr49ABZ5S593RlX7jbATnKT07ByQlEcqmqkp8h84l8sKF9Y2C+//qRcphXh
         gfyrVHWJL8DxYrtPlEGmhWc0/TI48V3lD9DJiAPBMO6otS3fZs9OFLTUts6qT0U52d1y
         pf2hxmdZndbZdd/JXpPLwZYwIUdzhbPC9Aeegyr6wPBddqIsTsroGZoBZtfo5B8jQWaF
         Qo0pjHsL1JDmFUSvtXs4vXFqoExa1ZFkRoWrVpPjQ/4y3jM6NiuXF2VewHzX583nCPwc
         nJv1ZX9dGEC0i0ARSEyXsYqhnLHEydmpHKMbRj9J+jNJXQdY+wy+iSBBMUbW+IUfzgYr
         9rEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/4CGI0FpW9VU4jAXhUj07J+trQBP2G8Y6TCQjLxKErVParYu/ZkDsWUsCI1VMYhHZYIDm3g==@lists.infradead.org
X-Gm-Message-State: AFuF++kuiiN+jvWdDjLG8rBO0ttiaVoNqgI3uebDrE9CoHVb7tMsozZQ
	R0/4tgf9bVU+rPYKy+NgMq8vmpAYm1TzgibNyrN0X+i+fQrJur9oGg93
X-Gm-Gg: AYBFou1aTudo6jc0v4aO1P31jF7G2/RIou3VVeMrHcXY/UoTeS47fUzny4N9OvXnHIf
	eEcAff5WkQKPkv4DyC1XX9exhd4Ji1SdB60fYmMtXf+RIzW/WZid25/SoPcPvF6XTtwLUastao0
	XGXHudblRB2Oh4l50YOzIQZSlHtG5J2iKs8gbfTApA6+a0OoSnBinB+VwBIwGzKAKuSwxUyu8jJ
	Xp6mtOKa3oubdOzOW8+CIjiT73mchVxxmKhEwts1OCoGO4j4E1NTiuvGsiGgfkVifLiOU+GSJzx
	Lihu/FYypw6AQyUu4A8mH/BsSLKKv/987tpJflW4EOMG2XVqTpk5yk9ErQRH9Pt1H7Sm83nM/iK
	4Scllp1BeNtF9QMbs7pWIssQ1Lg7tQQdSwed9FG5LurulTr+skhqyxsuPCfomuE5k5c7Pd4qJR1
	L2RJkBad1ZqmPDHcpCgUmcNEigRuQkU1myrnym1NndrU1GoYlmPFgbYPZ8bPbLMX803dm9jMfc6
	9sybg==
X-Received: by 2002:a17:90a:fc4b:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3a02900f85dmr2402815a91.29.1789891251509;
        Sun, 20 Sep 2026 01:00:51 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm7876986a91.11.2026.09.20.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 01:00:49 -0700 (PDT)
Message-ID: <32b00102-0961-49e3-b780-74d6db182809@gmail.com>
Date: Sun, 20 Sep 2026 16:00:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
To: Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, m.szyprowski@samsung.com,
 mark.rutland@arm.com, kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
 ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com> <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org> <aq9UGXeqmCfuPHdD@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aq9UGXeqmCfuPHdD@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_090054_559217_5DFEF036 
X-CRM114-Status: GOOD (  17.77  )
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



On 9/20/26 11:33, Baoquan He wrote:
> On 09/19/26 at 10:11am, Mike Rapoport wrote:
>> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
>>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> ...snip... 
>>>> +/**
>>>> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
>>>> + * @base: the base phys addr of the region
>>>> + * @size: the size of the region
>>>> + *
>>>> + * Mark the region as not to be included in crash dumps.
>>>> + *
>>>> + * Return: 0 on success, -errno on failure.
>>>> + */
>>>> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
>>>       ~~~~~~~~~~~~~~^
>>> Is it impossible to use at runtime even thought it claims to be generic?
>>
>> This should only happen at boot.
>>
>> Allowing modifications of memblock properties in runtime is a can of worms
>> I don't want to open.
> 
> Thank you. This is why I said this can't be claimed as a generic way to
> mark memory region as no dump. The generic way I'd like to see is
> at any time of system we can mark any unwanted memory region as no dump.
> And it won't impact the behaviour of the current system.

Thanks Mike for the explanation and Baoquan for the suggestion.
I'll drop the "generic" related description in the next version.


Baoquan, by the way, patch 2 is still awaiting review. It rewrites
the riscv side of the code that patch 3 (which you've acked) then
folds into the weak defaults, if you could take a look at it too,
that would be very helpful.

Best regards,
Wandun


> 
>>  
>>>> +{
>>>> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
>>>> +				    MEMBLOCK_NODUMP);
>>>> +}
>>>> +
>>>>  static bool should_skip_region(struct memblock_type *type,
>>>>  			       struct memblock_region *m,
>>>>  			       int nid, int flags)
>>>> @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
>>>>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>>>>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>>>>  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
>>>> +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
>>>>  };
>>>>  
>>>>  static int memblock_debug_show(struct seq_file *m, void *private)
>>>> -- 
>>>> 2.43.0
>>>>
>>
>> -- 
>> Sincerely yours,
>> Mike.


