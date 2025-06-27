Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A82C7EE32
	for <kexec@archiver.kernel.org>; Fri, 27 Jun 2025 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5iXgYBlAwd33V1zlwBhehhaKVgL6D6G6eNQgnNmF2Q=; b=gOsV+6seGHHZQQZJnowX7wBkUn
	q/5xp60yMwLnarFvkgbiQwiYtLbiBtty9O/T9ChvVlvUEQbgI9MbpsLm723dLkzYxw01RFooJEZA7
	0CxeWgnsiMnAetGQitFVf0ez0VLuyDjYxNeQDzBrgTG64s/XwlCf6VWI6hLms+AV4n2HrO2DDqtc9
	OmKSlBUBkEWI1i6fbcVmQVh/KWiopLPZ11hwJFmMmV2pgQCjEU1GYZBJmisfFcaKOB3k5h9WkhM2m
	npwpWHKx064GVPOGtabdsPxRs42nHPS5d0f52+8EyGp280fc4L7dvc4EKqIlHxYFfn2ikT2HWR/0A
	sC4xNovw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV8g7-0000000Ei6j-0wYh;
	Fri, 27 Jun 2025 12:59:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV80W-0000000EcR6-3hhe
	for kexec@lists.infradead.org;
	Fri, 27 Jun 2025 12:16:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751026599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z5iXgYBlAwd33V1zlwBhehhaKVgL6D6G6eNQgnNmF2Q=;
	b=O1+4S4L59cEXY4u9w5b04QyaUQFNOs8P0Lnwx7jDpIPN0Xc+xxtlNdGnKtuLIZE4A9R9Q9
	OwCkG91wj3ANWrfela/SS3tpSO7OxgBrKkumu3ltyxAR4GyiDtUfQSDwX3TwUSDTICV5Lc
	6tNTvQXK2eZiO+YbkvuH5Fr93aeAng0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-XE4Rm1wEM0GD9ge4URyhxQ-1; Fri, 27 Jun 2025 08:16:38 -0400
X-MC-Unique: XE4Rm1wEM0GD9ge4URyhxQ-1
X-Mimecast-MFC-AGG-ID: XE4Rm1wEM0GD9ge4URyhxQ_1751026597
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1062732f8f.2
        for <kexec@lists.infradead.org>; Fri, 27 Jun 2025 05:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026597; x=1751631397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5iXgYBlAwd33V1zlwBhehhaKVgL6D6G6eNQgnNmF2Q=;
        b=H0ln0hTyVFBGZE7gA4n16Q6yqNhYKI4uGEoKS73RcbPk4ZtEGCrSaErrqpT2JFX4VJ
         /x/hLcon5rZLyAObupkVBiGMMM9rFWvwcWmFlWaBU+9pEWc8nN87qKFksGHADzUyydzS
         aU/TX9Z4bbTai1rFaPYp1eLDwO0J8qNItI1F3nATnTzxDiGVuIFwkt9arMd3JPt88vxg
         Lh9fxAAPmty/AdHjOj2mEGR0+DBgxtByQ6KwaqHBLE1luUIxsLYE7kPDuYa1zFX9LoNQ
         yhq96cPjxXF10TUtb0nHqYfaDY2oF35ELQkxsfHxdI9X3F5ff/MBOgPQVFORgJJ8dsls
         pVSA==
X-Forwarded-Encrypted: i=1; AJvYcCVJDWFZJLlB9jQ3zgBxDE/4eb8gDBj876i2pUXgpTYVi1pvgAhOGiQLj3nmhbF7Nl59mdWqUA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8LzX7SqsG7taMgMyU9yjal+vQNfSEqjs7H3GApBfChGurNdOr
	RXs+EvuAHMbJnuGOuVbslej2uboePvey9Gkox1df5F6oebbNHYXkCftghCIZyD32CrGnkqGzogt
	jihR1E8UVY/AgkFAGNvxpwNzBPg7JZtiAIUv8jMg/1vV8c/RkmzeMjPmz3zDWSw==
X-Gm-Gg: ASbGncvqSWhMI0SrlcAgp09DPcfqvZLJA4phnHM0RfkuTpd6kH0pTgY8E5ivByA3oQs
	bsujKK+yTafGtq6JAiQ0QVqw4GtCOJw3LGEEjscQkoQZNCW4aNX/ij7edJIli//Z1MB5urNketY
	yVnHSllhCMWqOMPJ+5fNURKzRv+V3kHU4NNnalWwsF0MuVc8lR4fAUInXX5vNjuoyM6qQ1jFrrh
	QYWFXmz6NC8Tbf+Ot3V1lnVpFagcYX79c6c/lpN4F4CmrP/uQagSha9+I0cgiwLW5St+kukAzJW
	EmLsm/ly/XcpMhaY5Zsk6sneMr8RnQ4mBumPeC7NJLKuy9hJ0c4csxHFGx77G1pSReEUTUSPFQi
	DQflN9Ll/lD5q7Sr7TqCCYrKSXnaqKD3XfYt9SuZeEPNR007wzA==
X-Received: by 2002:a05:6000:1acc:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3a8f435e017mr2954016f8f.1.1751026597231;
        Fri, 27 Jun 2025 05:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFXCaDmfg79ltzhkJvrafzPaymAbe7A7YchbEapX8dANRC8wG38l5KXwh1B/WTFpadmove+w==
X-Received: by 2002:a05:6000:1acc:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3a8f435e017mr2953995f8f.1.1751026596736;
        Fri, 27 Jun 2025 05:16:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:5d00:f1a3:2f30:6575:9425? (p200300d82f2d5d00f1a32f3065759425.dip0.t-ipconnect.de. [2003:d8:2f2d:5d00:f1a3:2f30:6575:9425])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8e1sm2528578f8f.88.2025.06.27.05.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 05:16:36 -0700 (PDT)
Message-ID: <053f8c6d-0acd-465b-8d9f-a46d50ccce71@redhat.com>
Date: Fri, 27 Jun 2025 14:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] kdump, documentation: describe craskernel CMA
 reservation
To: Baoquan He <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
 David Hildenbrand <dhildenb@redhat.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz> <Z9H4E82EslkGR7pV@dwarf.suse.cz>
 <Z9Of+RYjpcDN7+ji@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9Of+RYjpcDN7+ji@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lD1Wh8Rr1Ij3vdGzSa5QfZndXcfx65hawdxX8cmxgDI_1751026597
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_051641_015240_6F5EC99F 
X-CRM114-Status: GOOD (  18.63  )
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

On 14.03.25 04:18, Baoquan He wrote:
> Hi Jiri,
> 
> On 03/12/25 at 10:09pm, Jiri Bohac wrote:
> ......
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index fb8752b42ec8..895b974dc3bb 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -987,6 +987,28 @@
>>   			0: to disable low allocation.
>>   			It will be ignored when crashkernel=X,high is not used
>>   			or memory reserved is below 4G.
>> +	crashkernel=size[KMG],cma
>> +			[KNL, X86] Reserve additional crash kernel memory from
>> +			CMA. This reservation is usable by the first system's
>> +			userspace memory and kernel movable allocations (memory
>> +			balloon, zswap). Pages allocated from this memory range
>> +			will not be included in the vmcore so this should not
>> +			be used if dumping of userspace memory is intended and
>> +			it has to be expected that some movable kernel pages
>> +			may be missing from the dump.
> 
> Since David and Don expressed concern about the missing kernel pages
> allocated from CMA area in v2, and you argued this is still useful for
> VM system, I would like to invite David to help evaluate the whole
> series if it's worth from the VM and MM point of view.

Balloon pages will not be dumped either way (PageOffline), so that is 
not a convern.

Zsmalloc pages ... are probably fine right now. They should likely only 
be storing compressed user data. (not sure if they also store some other 
datastructures, I think no, but might be wrong)

My comment was rather forward-looking: that CMA memory only contains 
user space memory is already not the case (but the existing cases might 
be okay). In the future, as we support other movable allocations (as 
raised, leaf page tables at some point, and there were discussions about 
movable slab pages, although that might be challenging) this can change 
(unless we find ways of not placing these allocations on CMA memory).

So as is, this should be fine, but it's certainly something to be aware 
of in the future.

-- 
Cheers,

David / dhildenb


