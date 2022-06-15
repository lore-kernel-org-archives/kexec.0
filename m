Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45C1CCA47B
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1clKYcv+EcTAvgRrX0aKc0SJ0CBGFF83P4wbS/nBMfY=; b=ylTsBufmto0GhI
	A6Zsgotz94sspSpzrVMDDstG9nKWuZO/o+ZbIfRLz1bGzhaIb6Yp0aRB4AxX+/yscBBTFWQDyeRB+
	20/vkzsJwemrbfPLA1Z/umiKTe3zSdAjDKV4kHoNX2vkwdBmcT1hftqZRsaxeIzHEH5nR290v50Mo
	Z6Fz9L5atKOfwjq58N2NztDjJsNLJE/jOataS0XKMTLa70OKicKdL1f9SvAsXXOb2Jks1tH/ZzEle
	Zsp15F2cU9GLmgLTiN+2C20w2UdqCVMbK480zBjk55RbKzUL7J9mOaFjMFaiICx/Xy24V9DLH4gfU
	N0Z3jSCOv4pt+7UbHxAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Pic-00DbUf-79; Wed, 15 Jun 2022 09:53:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1PiY-00DbPD-3j
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 09:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655286817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw6uD4GNioRfBtX3jEJXdTt3T/W8UHiD+VjqDyMbLsw=;
	b=P3Y/SSdNaeYZkaSrs/nFyrmHU+Fe8ND4NQWQCsU/r9FDYDCPs0VwJScdtjOJPzZHil9YxC
	pOVN7yGkHzCPUeFRB/6RPeDU9sJXWQmftCh97oG8E6uXR47qmn1juA38vtHTAVwLh6tORi
	wFoMvJzT7+UMaufahRH6CI/RR1Bwk2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-KOLpDszDN_mfqe4yt2g9GA-1; Wed, 15 Jun 2022 05:53:35 -0400
X-MC-Unique: KOLpDszDN_mfqe4yt2g9GA-1
Received: by mail-wm1-f72.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso1039173wms.0
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Sw6uD4GNioRfBtX3jEJXdTt3T/W8UHiD+VjqDyMbLsw=;
        b=txZRJ6W66w3rU42kUmgRkKaKGvShLk4laoRkiSnz3IHvnUkum3fNFzOUAQoH1rETeq
         IzxBeHYfbB0s87tm3XNDSv/LAhzvusuGE5ln41gbfvOpxmmIC1QLhRq/bZWfgByW0BQ9
         w/jpA9CHmTHRUHkpjUcz2L7m8AzY3oeR7OK2OMoCZNi5khV41wuvS0mRQfDdAHzsct7J
         r1mQm/K3FGswbvV2WLm0eInG9dOttFj3KtPLkenIYHZMAHweY+TthzBbY/PhtxQ3rxi5
         LN8jXQTxjEBg+6M90H3sn0S1M+sA6tqw8ax0WBh8zDa37D2XC0SO7yAkMNFLW5hsdGcD
         3Vtg==
X-Gm-Message-State: AJIora9PZMtKuouExDTv+BX5tBmcdkOV8hsu/IQJVqiFsNBAEBoTTWTp
	fSyC7noNAKCWePa94ssQXR8X5/Hby/2oHA0yNsmu3ZlPcjT0BceAm9CKeVkXMvq5R/I2OJU0c+K
	c5+lb4oFuXfWrLwPR8JJd
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr9020420wrv.345.1655286814572;
        Wed, 15 Jun 2022 02:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWQshi2ag3X1ZGvSLVqvcGr6liU6e5hkf80ENh4j2nNiQ3afv4GT3be4CkAz8Cckl+MchtEw==
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr9020398wrv.345.1655286814297;
        Wed, 15 Jun 2022 02:53:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0039c95b31e66sm2130939wms.31.2022.06.15.02.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:53:33 -0700 (PDT)
Message-ID: <1ef10873-c20f-afd8-e560-3b7fb5516f2b@redhat.com>
Date: Wed, 15 Jun 2022 11:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
 thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
 <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
 <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
 <24513679-d92d-ead1-2c1d-98db6a9bbdac@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <24513679-d92d-ead1-2c1d-98db6a9bbdac@oracle.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_025342_300744_F5EFD929 
X-CRM114-Status: GOOD (  13.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 01.06.22 00:25, Eric DeVolder wrote:
> 
> 
> On 5/31/22 08:15, David Hildenbrand wrote:
>> On 12.05.22 18:10, Eric DeVolder wrote:
>>> David,
>>> Great questions! See inline responses below.
>>> eric
>>
>> Sorry for the late reply, travel and vacation ...
> No problem, greatly appreciate the feedback!
> eric
> 
>>
>>>>
>>>>> +
>>>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>>>>> +							unsigned int hp_action, unsigned int cpu)
>>>>> +{
>>>>> +	WARN(1, "crash hotplug handler not implemented");
>>>>
>>>>
>>>> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
>>>> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
>>>> triggering?
>>>>
>>> You're correct. What about: printk_once(KERN_DEBUG "...") ?
>>
>> Why even bother about printing anything? If the feature is not
>> supported, there should be some way for user space to figure out that it
>> sill has to reload on hot(un)plug manually, no?
> 
> I've changed this to WARN_ONCE(). If that isn't agreeable, I'll remove it.

Please don't use WARN* on expected error paths.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
