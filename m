Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE28C4828D
	for <kexec@archiver.kernel.org>; Fri,  2 Feb 2024 03:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqF6iIiIeK8VH7SYkH5IyIn8v1iHA1K4r2QwP7fYTc0=; b=H/4gNrop+VT/nVqslxWInKhbpm
	EPwP+1t/opo4RorrJtDwHpz6PmiIiaV8x7DAuhvzyqctKlj5CSSdRNt4b40ZoyCg44wmkS+1nfPdQ
	FOfKfv/JGyr7AxtU6xWq2T6ZPRIWwvfgS0blIb0eXyvou+1pEz+MrzOwGBbRvSM1JPvDL7yF0OugD
	mZyyH9xhx3Mn19CKSuoqNhjmGybeLpWXkQH0+MF06Si8rJNdaBfra8VGev02EAiz5vlxVMSeviduk
	AT5putjMxQbG829yxsOjF3lcEaMN2RghZMdqbELvLFUX7pODhg/ePBHUp43PeRFYTIfHiEWj9X4us
	0HpNETrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVjrs-00000009yJS-25eF;
	Fri, 02 Feb 2024 03:05:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVjro-00000009yHh-1Huy
	for kexec@lists.infradead.org;
	Fri, 02 Feb 2024 03:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706843122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rikg3IyPI30DupfJGcK0L76LAW4MutprC7uWEBJoegI=;
	b=FmSTtoJQWigViDV4+7DvZTfsU9G3sIY61j4vJ1286SbJfgJRcSrPrwRJRMXf6EhtIbdjcP
	a0phQzHh+HDE+qjYthJ5xtTmrEDcX12QfXGSksXVFoULhR2Ed1LhwWmzM5gE9cyGsMo5UP
	4sahyJp0s0bL3pIRKJyy0zi0tZvE+y8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-S5L11LLPPRGf8kfEUYzn1w-1; Thu, 01 Feb 2024 22:05:21 -0500
X-MC-Unique: S5L11LLPPRGf8kfEUYzn1w-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bfbaf59036so792144b6e.3
        for <kexec@lists.infradead.org>; Thu, 01 Feb 2024 19:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843120; x=1707447920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rikg3IyPI30DupfJGcK0L76LAW4MutprC7uWEBJoegI=;
        b=qO7BE62FWJkVHu0li6tMXCH/lfZzkB6ETWb1O3Fu8S/J3Rcb3m/jy882v6Xn3MdGmS
         bUjBa8ZL9EoPwSvWMqmVKv0GLdgPHrfn2Kr35kQLLmvQPhsr4crf4i8e1WWviD+fDgoG
         nRE5XV9N8QCas+MKwUIi9cmohD0829YU2UKHaoS1//X19NnvNS5yXsP9AN961jnIw0za
         +3mPaoaYb2XPxw7XHf7wHX9hzO3LMuiNSbOQrSGzu5jL1m3u/M7wKacO0e66uhfBlBYv
         Gad5GJuQvexLJi/+v/lCBLNhjVVQ6lk6VUWmBLn8RFGWDEHDZsbtvhtf2jcBQ/nYxt7L
         nAGQ==
X-Gm-Message-State: AOJu0YxEwKiIbsutx61n37Mpk0TuKHcYwCdxczDH5T/jxcWCRWiIliq9
	6V69h1qJlVoK4eJ4AI2zUpnIPH/95zyOsSWFo7TRoTTpyvy1DseF3GwShLFAChz6UUysnnMR61w
	v/JqU6VzQig4m1H3uixE6puge83Xp55smmiPN6Rbqv0meDZpUIkISJao64w==
X-Received: by 2002:a05:6808:10c7:b0:3bd:ca59:8f4 with SMTP id s7-20020a05680810c700b003bdca5908f4mr7895749ois.33.1706843120300;
        Thu, 01 Feb 2024 19:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnz7/7+wqJo8inkQbqsKe9NIuOmtW6B5mnIpGfK3QjmNCMEfoL4xvqB6ttFDQ4eR0XyA8J1w==
X-Received: by 2002:a05:6808:10c7:b0:3bd:ca59:8f4 with SMTP id s7-20020a05680810c700b003bdca5908f4mr7895725ois.33.1706843119954;
        Thu, 01 Feb 2024 19:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWzlvDUIZkD3Okqjhu/B3jLb5/UsYqJ2N4Aibmf4lMU0CYn7I+dRGwEeTOhB0stIuts0cl27sCWwbSaRDAovTUI8BGt5euZAJthq41iy+ZmBIYV+4qc6tHOljFJWrdpB0O0CoqGG5Ry2WVN0UgQPalay5a+M0tTxMPnkKUOVv16FX0=
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b006dd9ff236b6sm485386pfo.177.2024.02.01.19.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 19:05:19 -0800 (PST)
Date: Fri, 2 Feb 2024 11:01:38 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Michel Lind <salimma@fedoraproject.org>, 
	Sergei Trofimovich <slyich@gmail.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>
Subject: Re: Re: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Message-ID: <ok66kbhzu2xczopdsjhjuedt2h3snt3omjc3jlzbs3ujo6ra75@bu3mvwtuveck>
References: <20240131100508.2013016-1-slyich@gmail.com>
 <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_190524_444718_0CFAB3DB 
X-CRM114-Status: GOOD (  18.48  )
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

Hi,

FYI, before this patch, Michel already sent 
"[PATCH] Fix building on x86_64 with binutils 2.41" 
to address the same issue. Currently I almost know nothing about
assembly but Michel's patch seems to be more complete because two more
files are touched.

On Wed, Jan 31, 2024 at 07:04:57PM +0800, Baoquan He wrote:
>On 01/31/24 at 10:05am, Sergei Trofimovich wrote:
>> `binutils-2.42` introduced stricter checks on what `.arch` can be used
>> in 64-bit mode and started failing the build as:
>>
>>     $ as-2.42 --64 -o entry32-16-debug.o entry32-16-debug.s
>>     purgatory/arch/i386/entry32-16-debug.S: Assembler messages:
>>     purgatory/arch/i386/entry32-16-debug.S:28: Error: 64bit mode not supported on `i386'.
>>
>> The change moves `.code32` before `.arch 386` as suggested in
>> https://sourceware.org/PR31319
>
>I am not familiar with the gas behaviour, the fix sounds good from
>discussion in above link.
>
>Reviewed-by: Baoquan He <bhe@redhat.com>
>
>>
>> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
>> ---
>>  purgatory/arch/i386/entry32-16-debug.S | 2 +-
>>  purgatory/arch/i386/entry32-16.S       | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
>> index 5167944..297d6f5 100644
>> --- a/purgatory/arch/i386/entry32-16-debug.S
>> +++ b/purgatory/arch/i386/entry32-16-debug.S
>> @@ -25,10 +25,10 @@
>>  	.globl entry16_debug_pre32
>>  	.globl entry16_debug_first32
>>  	.globl entry16_debug_old_first32
>> +	.code32
>>  	.arch i386
>>  	.balign 16
>>  entry16_debug:
>> -	.code32
>>  	/* Compute where I am running at (assumes esp valid) */
>>  	call	1f
>>  1:	popl	%ebx
>> diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
>> index c051aab..7a84565 100644
>> --- a/purgatory/arch/i386/entry32-16.S
>> +++ b/purgatory/arch/i386/entry32-16.S
>> @@ -20,10 +20,10 @@
>>  #undef i386	
>>  	.text
>>  	.globl entry16, entry16_regs
>> +	.code32
>>  	.arch i386
>>  	.balign 16
>>  entry16:
>> -	.code32
>>  	/* Compute where I am running at (assumes esp valid) */
>>  	call	1f
>>  1:	popl	%ebx
>> --
>> 2.43.0
>>
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
