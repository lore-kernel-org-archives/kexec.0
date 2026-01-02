Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A0EFA374F
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4uNqY5r0cWL7e4gE2mSIbtSpXgssK+f0V6w+g1HxwU=; b=wgvtIYtoiya/jSYboeFb6M9Diz
	57YV5VYVRszX2MF1FNxxkIH6kALPjNKZh/ZQjzuM3UT1ajRoMo6zZdEB+S7vLtUmh+ZLq2NtLRvEk
	xdbS96HbbhJGOLf/RMeXzNKtle+szIqUdz003sJJxVy1iquQrNvMfS9VMywzC4wm83XVUxL/gBXd/
	UE7AOb9ZzJpVABdjoqnTqDeNZHzAsPrqX6Mu5/WvCbI1GKqoa0gfUmI0b6mRq1MXlTtk7PRo78vw2
	IHj8iqfyOHXLRQ4PjMQ2nvevqN/sUXfskrWvGOLPAOLFiqwr8j6CpTlhZfF5eP2XPGRA1wBG/SQhn
	p57IWm+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh7T-00000008RHJ-475z;
	Fri, 02 Jan 2026 15:31:15 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh7R-00000008RGu-0Jvl
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:31:15 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so89639325e9.0
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367871; x=1767972671; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4uNqY5r0cWL7e4gE2mSIbtSpXgssK+f0V6w+g1HxwU=;
        b=Cz/fF/4wUnAX2xRGNIqwfirObfyYOYaSZIUZL9NbGhGwCyRJSMQ9AWMcybkwfsXD0O
         rr6wORxsZcZ0esQ+s+oamWRMG9kMDRJNgcVnO9XSltDoleK5uI1eBnivG+QnsKWy7byJ
         pcMWiudmpJK4Ay9GY3WcPttTj31eXF4ZzCX/6cpjP/OpwNUMSO+D6UCswXT8CzMAT5uu
         hq5r+f5Tsj1y+KH2t4oMiw5FunuC9iZn9ZFuwL2JWM1PEef4m2S840Y/iy/w0b1qYPuQ
         QalFoUHrORbyKEZfTnDM0+yuWuUqUBvwRjMc9PA3sL8evDcvbcGmx11pt8MbxFYcEdlx
         D9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367871; x=1767972671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4uNqY5r0cWL7e4gE2mSIbtSpXgssK+f0V6w+g1HxwU=;
        b=TfwB+iTie6mWvrCEk1763/YMZQzfv8LC1QuEE5qP52znG4Jf0uXZXq8/11bsTyyDXV
         SZBRTdwqkWlGjZ53wsDbN+jKTrjacuxQT0g4fjELVvrJ1Ep+W+qifVpQIPnWn6DHw4ba
         xYvNnqh6Pjmaf7j8/dMpqwNdPIiFvxg9oTu4yi8aw5IghkXSsRXAIHK2VBY1N6BoZqv3
         nCf9TWAqZGUnUhSTq05Rj6Oy+kINTxu71IFZpuEW26uaRmDs/+U75pBdqnmRZ7B2UbEW
         wek8gLVSzpPsz0AhU6zwrrZSbAVwFvzxoB6ciXZ0MmptgfZxw96rb3Rvo11tp8m1vp2N
         R/ag==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZGsD8arSW5HkJfHQBqkn8QkzddexBOb9HuCflYP2ZFWwHV/7TUfisdaR9GBXDkKlMQjktg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGCmmE4P08YKx4EbxqQFUgjk/0tYe0ZNgaee0Lk60MEI9v4t7u
	BGJ291A4WaDmb8JJFjq5Fo652FEtY6ElYtDQ5umKKa1mXxJ9KwuzZaQQ
X-Gm-Gg: AY/fxX6G7dY+x0d4hpxBQ9bumV3dqINfeBuVOPOwwBTw+BoTWtLQV1+D65d8L4TtS4a
	FupZIOpZNnJXUoQmzVXSwZ8ZxTP1kenUrHePULFsIg5xgpjPMVDBU/IxWPp375B6X6sfc8BD/pb
	UxicT69BJTmE3axpGhcZ4Pq6wivKVncXJeV2cgSk2qzlIA4NKHk9WNv2xeyBsJMPsoBfSxhEskO
	n5oLLd+VtZ4bHlC4Gzf6iMUs+No+pwBqAzMTcWteI1/yf0hLtGq/MfHA9KeOkxLnvlghW3elQ8r
	GEpp+4tnRPTKK8A5dVa3hFX3zVA0Fu5Ui9g+uIvb840mxHYWPH4tE/KtzlZ0oXI6DLGhUeDHuWJ
	VSLHs0caAYJLpvN7wpvqityp2jpGBlZim3Sh64hWTz+4DF/FbilFQ1KpUqVPGifvuzRTW7Ax9RA
	GoUsc1sP7keIfgek+C1SpX5uQP6CrGdQArT/GlOg/9DpiBdVjCWLqoXXqDlIgjr4ToE+kUtxpvI
	zY/9805wHFU
X-Google-Smtp-Source: AGHT+IHBT9YlOVOXNiWvFipggdEYaegBM5I94nBU4m8bda8nrXYoAOcEMlAFzjbdkmpGlrMqkrvPEg==
X-Received: by 2002:a05:600c:3146:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d1959f776mr535335675e9.32.1767367870730;
        Fri, 02 Jan 2026 07:31:10 -0800 (PST)
Received: from ?IPV6:2001:16a2:c8d2:2b00:183a:1350:d3a4:d89? ([2001:16a2:c8d2:2b00:183a:1350:d3a4:d89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba40a50sm919985e9.7.2026.01.02.07.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 07:31:10 -0800 (PST)
Message-ID: <2bed4bbf-256a-4918-be53-1d4c6999a46b@gmail.com>
Date: Fri, 2 Jan 2026 18:31:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, rmikey@meta.com, clm@fb.com,
 riel@surriel.com, kernel-team@meta.com
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
 <fc542a5e-db54-4d7e-b363-42cc253b1a8c@gmail.com>
 <rsygqnm3qahkfoqo6usrz3jhpya3c3rqebz6rotl33dsx3rsbo@2v4yeabi7fda>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <rsygqnm3qahkfoqo6usrz3jhpya3c3rqebz6rotl33dsx3rsbo@2v4yeabi7fda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_073114_058043_C9A51D70 
X-CRM114-Status: GOOD (  20.43  )
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



On 02/01/2026 18:24, Breno Leitao wrote:
> Hello Usama,
> 
> On Fri, Jan 02, 2026 at 06:09:57PM +0300, Usama Arif wrote:
>>
>> On 02/01/2026 17:53, Breno Leitao wrote:
>>> Track and display the number of kexec boots since the last cold reboot
>>> when CONFIG_KEXEC_HISTORY is enabled.
>>>
>>> This extends the previous kernel release tracking feature by adding
>>> a counter that increments with each kexec boot. The counter provides
>>> visibility into the kexec chain depth, which is useful for understanding
>>> boot history in production environments.
>>>
>>> Add a new property, "kexec-count" in KHO FDT alongside the existing
>>> "previous-release" property. The counter is:
>>>
>>>  - Initialized to 0 when kho_in is instantiated.
>>>  - Incremented by 1 on each subsequent kexec.
>>>  - Printed alongside the previous kernel release version.
>>>
>>> The counter is stored as a 32-bit unsigned integer in FDT format and is
>>> only active when CONFIG_KEXEC_HISTORY is enabled.
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> ---
>>>  kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>>> index 06d99627bb3c..fe5a2c5c4c86 100644
>>> --- a/kernel/liveupdate/kexec_handover.c
>>> +++ b/kernel/liveupdate/kexec_handover.c
>>> @@ -38,6 +38,7 @@
>>>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>>>  #define PROP_SUB_FDT "fdt"
>>>  #define PROP_PREVIOUS_RELEASE "previous-release"
>>> +#define PROP_KEXEC_COUNT "kexec-count"
>>>  
>>>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>>>  
>>> @@ -1257,6 +1258,7 @@ struct kho_in {
>>>  	phys_addr_t scratch_phys;
>>>  #ifdef CONFIG_KEXEC_HISTORY
>>>  	char previous_release[__NEW_UTS_LEN + 1];
>>> +	u32 kexec_count;
>>>  #endif
>>>  	struct kho_debugfs dbg;
>>>  };
>>> @@ -1330,6 +1332,9 @@ static __init int kho_out_fdt_setup(void)
>>>  	void *root = kho_out.fdt;
>>>  	u64 empty_mem_map = 0;
>>>  	int err;
>>> +#ifdef CONFIG_KEXEC_HISTORY
>>> +	u32 kexec_count;
>>> +#endif
>>>  
>>>  	err = fdt_create(root, PAGE_SIZE);
>>>  	err |= fdt_finish_reservemap(root);
>>> @@ -1340,6 +1345,10 @@ static __init int kho_out_fdt_setup(void)
>>>  #ifdef CONFIG_KEXEC_HISTORY
>>>  	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
>>>  				   init_uts_ns.name.release);
>>> +	/* kho_in.kexec_count is set to 0 on cold boot */
>>> +	kexec_count = cpu_to_fdt32(kho_in.kexec_count + 1);
>>
>> Should this be kexec_count = cpu_to_fdt32(kho_in.kexec_count) + 1; ?
> 
> I don't think so. Basically we want to increment the counter in native
> endianess and then convert to the Big Endian (FDT/DT are big endian
> AFAIK) and then store (line below) to the DT.
> 
> If we convert to big endian and then sum 1, it will mess with the
> result. 

ack, Thanks for explaining, I didnt think of endianess!

> 
>> +    err |= fdt_property(root, PROP_KEXEC_COUNT, &kexec_count,
>>> +                sizeof(kexec_count));
> 
> Thanks for the review,
> --breno


