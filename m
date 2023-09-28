Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D2E732FE
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jV71c4JtkvanFnfPReIdfaagr7I7Jm2d3JOD9QWg3/g=; b=aIgeZoz2gtF0pI
	BE6LAdbraXZFNqTrCEgXy/+FsABW7py0bjKCC6zAm0qFB0Nd+8YWa+j6WyFf1yjzd0HRPEMkJlc2M
	FD2OmkplCmJXRYXl1dY2fpe6iY/qZ3U1YWIIKjulWrhZgxAEeNoPDjKFJhWmR9WaWNZa/LbXqdksS
	THpXuMwFaN2o3TK5uF/YOng2MhR4fzXi4+L/MJm0Fun6FUquv7n30YaSQu2vUwLUAnqbJsihNdLEI
	qTHhcFukWUFD0PZyXQFX7480KUpsLQb6GQXOSw0LUZvQkBzW8JDSJ5o4WUIxCnH1ewV0zPIab6D7H
	ameFbnPzUay+4kOdBmJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlupv-006Qjg-2E;
	Thu, 28 Sep 2023 17:30:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlupr-006Qhr-2H
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695922198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4sYcMfxqTnzgFrCEZfVXXlsFEBmmiyRD3TMJswsdYg=;
	b=HwES4ypJ6CMPI066Brj0Vg/ypPSLh1TDgRTX92UuayJwNVwOssjNuhuN6CLpLGyd6leNX3
	qB6ZvNI9aO7LaZgnzlTNe2X9mER9TJcfJOFPVals6EA3x1TlEeovAiTWKMIS2Cu2iVBc8w
	vvjuwFAfVg+y9MHOoVcTTaqd5IWnM5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-5pFOHsqeM-Gntql8re8c6A-1; Thu, 28 Sep 2023 13:29:56 -0400
X-MC-Unique: 5pFOHsqeM-Gntql8re8c6A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32329974dbdso6787572f8f.0
        for <kexec@lists.infradead.org>; Thu, 28 Sep 2023 10:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695922195; x=1696526995;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4sYcMfxqTnzgFrCEZfVXXlsFEBmmiyRD3TMJswsdYg=;
        b=iUKz01VyIUCzslYciIKwJ6PBTeBx6uEbsripmmmJefdyFTrrF5v42Z+ycojC2gfTyg
         x24YgdCcHRvH6XeEL/duq4LJlf1UZsM4cWdbCSu3gzm6o4eJXzawEI9gWSLz65chzWXt
         0bivT2Qp9uBNbR9ocBSYb9gieZl0/VTtgjHSNlgniW6+trRzWNb8ueQcK25vd4JFdEMP
         qGb3IqDaBzs4mYbYADsXPGkbQzWr8T2OjVo9px9zGppmdjiG/ymNbTSfYnaWwukoGpVM
         Jq7s8bhRwnIPleWrwEej/hSYtVNHwLaWojnKSgh+c+nzvsm9F+N3v5xrWH7mE7IuLLbn
         73AQ==
X-Gm-Message-State: AOJu0Yz9By9f4AMdbooEjldMv+zkYwMhWWyyY4MQyTlgDjpSmOUI6x0f
	81HYVS8Lr26Iqs4l78ALE5RD5vzOa9Zv4hrZs7gZh4QExmNHuc8PZOf/yRS2kzz4QEbrU0uABPk
	BV8MOuUwf++ySiov5rUgM
X-Received: by 2002:a5d:58c1:0:b0:31c:3136:60af with SMTP id o1-20020a5d58c1000000b0031c313660afmr1404422wrf.61.1695922195727;
        Thu, 28 Sep 2023 10:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdjAUBqA8qaoWqAi1QmoFnrMG8cfswCS9Yn7LtSlgQgV/g93InbG4ZlwdY0nlh4hq9SurwA==
X-Received: by 2002:a5d:58c1:0:b0:31c:3136:60af with SMTP id o1-20020a5d58c1000000b0031c313660afmr1404390wrf.61.1695922195320;
        Thu, 28 Sep 2023 10:29:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031ad2f9269dsm19862621wrw.40.2023.09.28.10.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:29:54 -0700 (PDT)
Message-ID: <838c24a6-5866-a800-ba50-0311d4a4f1d2@redhat.com>
Date: Thu, 28 Sep 2023 19:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Baoquan He <bhe@redhat.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <58146.123092712145601339@us-mta-73.us.mimecast.lan>
 <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
In-Reply-To: <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_102959_816935_5F4329BE 
X-CRM114-Status: GOOD (  19.44  )
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

On 28.09.23 12:25, Baoquan He wrote:
> On 09/27/23 at 09:13am, Stanislav Kinsburskii wrote:
>> On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
>>> Hi Stanislav,
>>>
>>> On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
>>>> This patch introduces a memory allocator specifically tailored for
>>>> persistent memory within the kernel. The allocator maintains
>>>> kernel-specific states like DMA passthrough device states, IOMMU state, and
>>>> more across kexec.
>>>
>>> Can you give more details about how this persistent memory pool will be
>>> utilized in a actual scenario? I mean, what problem have you met so that
>>> you have to introduce persistent memory pool to solve it?
>>>
>>
>> The major reason we have at the moment, is that Linux root partition
>> running on top of the Microsoft hypervisor needs to deposit pages to
>> hypervisor in runtime, when hypervisor runs out of memory.
>> "Depositing" here means, that Linux passes a set of its PFNs to the
>> hypervisor via hypercall, and hypervisor then uses these pages for its
>> own needs.
>>
>> Once deposited, these pages can't be accessed by Linux anymore and thus
>> must be preserved in "used" state across kexec, as hypervisor state is
>> unware of kexec. In the same time, these pages can we withdrawn when
>> usused. Thus, an allocator persistent across kexec looks reasonable for
>> this particular matter.
> 
> Thanks for these details.
>   
> The deposit and withdraw remind me the Balloon driver, David's virtio-mem,
> DLPAR on ppc which can hot increasing or shrinking phisical memory on guest
> OS. Can't microsoft hypervisor do the similar thing to reclaim or give
> back the memory from or to the 'Linux root partition' running on top of
> the hypervisor?

virtio-mem was designed with kexec support in mind. You only expose the 
initial memory to the second kernel, and that memory can never have such 
holes. That does not apply to memory ballooning implementations, like 
Hyper-V dynamic memory.

In the virtio-mem paper I have the following:

"In our experiments, Hyper-V VMs crashed reliably when
trying to use kexec under Linux for fast OS reboots with
an inflated balloon. Other memory ballooning mechanisms
either have to temporarily deflate the whole balloon or al-
low access to inflated memory, which is undesired in cloud
environments."

I remember XEN does something elaborate, whereby they allow access to 
all inflated memory during reboot, but limit the total number of pages 
they will hand out. IIRC, you then have to work around things like 
"Windows initializes all memory with 0s when booting, and cope with 
that". So there are ways how hypervisors handled that in the past.

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
