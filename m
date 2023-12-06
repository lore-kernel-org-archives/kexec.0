Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E14C4167B
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FsZSDOasN3ccCwaNajvBPcsBucFgzfai4rUJUl9nohc=; b=LiRAQ2jwHTr/VS
	WAKT2oYNXVi3QaNNUd4egUHJH9JAVZ5kXeCgoodkL1B8nL88sgwHk3l00Va6XwjusIOLa/B8AblVC
	VHgfTt+khQVZ028b6oS0JftDU8FK2q1LUdEzoRshE2eKE4V6pny1WnC6Wj0+FqTEI3rvtAcWcYRk5
	pNWzPh/1iKtcRHzyJgJuK0esEKdC+YZ9TmPII6WU+cQ95GL1bmiUOmXxZ7otgkQ0ejtouZwA4QP46
	x+o5OuytIh5t87Ac4AinS0RKmGrx5dStfRvPk6yFamDGq95h6wNYy0+Ix+tEyvT20zYW+iPBiO8Pc
	U75PO+eVqJi6RMzl8VlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAq09-009uzW-1k;
	Wed, 06 Dec 2023 11:23:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAq06-009uym-1Z
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 11:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701861811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dTdzAM2G0G6A3InngHk4xwKmBZnIONVNmg6lQUrZqnI=;
	b=bXwrJeLWn9OIUjS2ao+6e/qigYTCVLi44okk/2Himy1VDY0VDJzt+yptuydVlsFHjPEmux
	5ZXFfA6nwHr1t41oTDWyw9ikibPcwqLimVCap5CfKO2DIT7DTf+tsx2vP1Zbr0G5llrSFz
	HZxWEhKJbov/uEXXdG8Ckx7YNJqFo1g=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-V7OZ6HGKNGegQ6YeNcyniQ-1; Wed, 06 Dec 2023 06:23:30 -0500
X-MC-Unique: V7OZ6HGKNGegQ6YeNcyniQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ce824ba5a5so629614b3a.2
        for <kexec@lists.infradead.org>; Wed, 06 Dec 2023 03:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861809; x=1702466609;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTdzAM2G0G6A3InngHk4xwKmBZnIONVNmg6lQUrZqnI=;
        b=vbd0MMI12gLoIHTVDespxM2oSh4AgtYpc60XBYUQtPwCw9ldkUwpQcpsCtvyO2jKU8
         1xcR8xn7Xy4FkA68/VUeTSqVaSqEGX0FY8lggcCcB5J3T4BFCfugq+sd9l71sksELmCs
         5XSI9Pi4aHM38WzH1cNKmVPbDLSGBR46RaejQHb3XeuCfhkcxAA1liAlRk66318Y8sxS
         v/DLH2xExJdoXNmTkNumG3+Ud9fqmriR+yhMwORzcJlk/g7LE2l/lXoGKjr0wq1UYmwJ
         F/qUzgkfLFQ/QKHMLf1qJNfTsbjssSGn/UM9kDQm41qrwFvUBhVxWAb4aDluJ1y8lmzG
         tOyQ==
X-Gm-Message-State: AOJu0YzIhMaswQR79ssbswYcDV7MyoUclmqlCYhoV8SXX1QaUZrL3fKj
	LhZVU7L14TWuF+Gl2fwHaKD1CHxAXGGxADFe4XhiLWHplOf4iHv6clATHvnzPC8yjEhPxycrkew
	htwUj/bqR/zsWWui8Qzoc
X-Received: by 2002:a05:6a00:218e:b0:6cb:4c60:7398 with SMTP id h14-20020a056a00218e00b006cb4c607398mr357907pfi.13.1701861808922;
        Wed, 06 Dec 2023 03:23:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdJ4aPIXyp2D+xmjLndL5jvhL7JFuQG34UhR/kOw3JrP66kr5cB7iVVU3ci0Dfg7IIxZGlPQ==
X-Received: by 2002:a05:6a00:218e:b0:6cb:4c60:7398 with SMTP id h14-20020a056a00218e00b006cb4c607398mr357899pfi.13.1701861808392;
        Wed, 06 Dec 2023 03:23:28 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b006ce69a70254sm3095744pfn.56.2023.12.06.03.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:23:27 -0800 (PST)
Message-ID: <c7b1c2c6-cf9f-493a-be5b-a84da124306e@redhat.com>
Date: Wed, 6 Dec 2023 12:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Philipp Rudo <prudo@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>
References: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv> <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv> <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka> <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka> <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka> <20231206120805.4fdcb8ab@rotkaeppchen>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231206120805.4fdcb8ab@rotkaeppchen>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_032334_599611_EC7F0991 
X-CRM114-Status: GOOD (  32.53  )
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

On 06.12.23 12:08, Philipp Rudo wrote:
> On Fri, 1 Dec 2023 17:59:02 +0100
> Michal Hocko <mhocko@suse.com> wrote:
> 
>> On Fri 01-12-23 16:51:13, Philipp Rudo wrote:
>>> On Fri, 1 Dec 2023 12:55:52 +0100
>>> Michal Hocko <mhocko@suse.com> wrote:
>>>    
>>>> On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
>>>> [...]
>>>>> And yes, those are all what-if concerns but unfortunately that is all
>>>>> we have right now.
>>>>
>>>> Should theoretical concerns without an actual evidence (e.g. multiple
>>>> drivers known to be broken) become a roadblock for this otherwise useful
>>>> feature?
>>>
>>> Those concerns aren't just theoretical. They are experiences we have
>>> from a related feature that suffers exactly the same problem regularly
>>> which wouldn't exist if everybody would simply work "properly".
>>
>> What is the related feature?
> 
> kexec
> 
>>> And yes, even purely theoretical concerns can become a roadblock for a
>>> feature when the cost of those theoretical concerns exceed the benefit
>>> of the feature. The thing is that bugs will be reported against kexec.
>>> So _we_ need to figure out which of the shitty drivers caused the
>>> problem. That puts additional burden on _us_. What we are trying to
>>> evaluate at the moment is if the benefit outweighs the extra burden
>>> with the information we have at the moment.
>>
>> I do understand your concerns! But I am pretty sure you do realize that
>> it is really hard to argue theoreticals.  Let me restate what I consider
>> facts. Hopefully we can agree on these points
>> 	- the CMA region can be used by user space memory which is a
>> 	  great advantage because the memory is not wasted and our
>> 	  experience has shown that users do care about this a lot. We
>> 	  _know_ that pressure on making those reservations smaller
>> 	  results in a less reliable crashdump and more resources spent
>> 	  on tuning and testing (especially after major upgrades).  A
>> 	  larger reservation which is not completely wasted for the
>> 	  normal runtime is addressing that concern.
>> 	- There is no other known mechanism to achieve the reusability
>> 	  of the crash kernel memory to stop the wastage without much
>> 	  more intrusive code/api impact (e.g. a separate zone or
>> 	  dedicated interface to prevent any hazardous usage like RDMA).
>> 	- implementation wise the patch has a very small footprint. It
>> 	  is using an existing infrastructure (CMA) and it adds a
>> 	  minimal hooking into crashkernel configuration.
>> 	- The only identified risk so far is RDMA acting on this memory
>> 	  without using proper pinning interface. If it helps to have a
>> 	  statement from RDMA maintainers/developers then we can pull
>> 	  them in for a further discussion of course.
>> 	- The feature requires an explicit opt-in so this doesn't bring
>> 	  any new risk to existing crash kernel users until they decide
>> 	  to use it. AFAIU there is no way to tell that the crash kernel
>> 	  memory used to be CMA based in the primary kernel. If you
>> 	  believe that having that information available for
>> 	  debugability would help then I believe this shouldn't be hard
>> 	  to add.  I think it would even make sense to mark this feature
>> 	  experimental to make it clear to users that this needs some
>> 	  time before it can be marked production ready.
>>
>> I hope I haven't really missed anything important. The final
> 
> If I understand Documentation/core-api/pin_user_pages.rst correctly you
> missed case 1 Direct IO. In that case "short term" DMA is allowed for
> pages without FOLL_LONGTERM. Meaning that there is a way you can
> corrupt the CMA and with that the crash kernel after the production
> kernel has panicked.
> 
> With that I don't see a chance this series can be included unless
> someone can explain me that that the documentation is wrong or I
> understood it wrong.

I think you are right. We'd have to disallow any FOLL_PIN on these CMA 
pages, or find other ways of handling that (detect that there are no 
short-term pins any).

But, I'm also wondering how MMU-notifier-based approaches might 
interfere, where CMA pages might be transparently mapped into secondary 
MMUs, possibly having DMA going on.

Are we sure that all these secondary MMUs are inactive as soon as we kexec?

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
