Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C37EC04AA5
	for <kexec@archiver.kernel.org>; Thu, 25 Aug 2022 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4AS8tsw9TPPmT8FrpF1XfZJJ7YcRxVD47s2X9FIRSbs=; b=5DW9A3OYU84sVB
	w9AuOvPG35M7MMYUWoMvoPcaIQcO2k70jA4fCzbZrQ1wfkIS17PDSXaukfAJtzOcc4nz5vWtC51zx
	6082Fn1plAxaqJ08Bhsf8ies+Y8q0LR5QIZ+UomSwVhkPA+nvTF8EgUZsIdQZSqqopbIc03728kHr
	9qPP/NtQA+E28iRnS3WEeNXvJ9l4bglxWgFyTz9xSL92LlxqUSUuTUiyvGYK+RKvETUQ45I5Cs9sW
	Xt8uOTcx4AUwBLa5hzgFLEaNxSJAL9AYc47gdo4FB5000hGomFMOvDrHoDQx6QqKHbEzQEnbfUMYV
	Of/ruCuNI7g30fTs61hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBOO-00D0T6-Bg; Thu, 25 Aug 2022 11:51:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBOL-00D0Rh-TE
	for kexec@lists.infradead.org; Thu, 25 Aug 2022 11:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661428280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtM1BEUnONM80EGQIlSjFJxOzxx4asObkPOcf/dUoJ4=;
	b=Lyr54WD1q0IE6LrorPtddJy0VppvUkGqsnwW5MLVOF5qrswTQjoK2e2RKO7L80ceNr38Wd
	d6WAaWa7HdZihIUhJn2v+hxgUNuroHOOODk/OhOsmrVJ7Mdews4NXURnzKIOr2LRmkT00M
	+J1wNXNa5AJKmDTiCil0A8s2i3BbFbo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-l18t5UtRMCmKgY2OlJ0-wg-1; Thu, 25 Aug 2022 07:51:19 -0400
X-MC-Unique: l18t5UtRMCmKgY2OlJ0-wg-1
Received: by mail-wm1-f69.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso2368306wme.3
        for <kexec@lists.infradead.org>; Thu, 25 Aug 2022 04:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=FtM1BEUnONM80EGQIlSjFJxOzxx4asObkPOcf/dUoJ4=;
        b=2TsIyyQ84N/kUwN/8FsgJZ875nmxv+H3X+ZG9oTStIwcsDXVx7/OCvxPHiwZ4H2X5U
         TtouKL518DwKlsZew8CjZvdMyFwYhQUEgHdM3uzgscDD3iJ4sbPzceyOOREa8f/yiPyw
         +yZMnbEWUekoqSNzya/f0D2UjaRAcIAf3ZljmGEdqYLyPWK6/88OK0PGVlH4D+MZOWYf
         up4GU1yDEbPRgSoxPhFPvVLGH+tLk+3DRy1kV3D6ms3U2rhZLmTP0Ucrhb+Nk7S2Mt28
         ySIW1vqtvRlZ8vUEiiz5jcLMZUN6z6ri3FkN+zps8SJ/EbzaHk9P895BW0HNa62owBcx
         eRAg==
X-Gm-Message-State: ACgBeo1luvkNmIWawBXoUxGK9R+mCqsJkkxSOIarTr6dIC75SUSN/2IA
	YRSLTcLKza8/6re/JLNiLM81BDzDDaz7017jsZRp7WAlUSWFvQAaUrQVZ2wd6j5QVtZZ0sMf/Gb
	j7f0h2W27/DPXZL7ltP2a
X-Received: by 2002:a5d:5711:0:b0:225:2884:cc88 with SMTP id a17-20020a5d5711000000b002252884cc88mr2042073wrv.141.1661428278224;
        Thu, 25 Aug 2022 04:51:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ItDcDX1kgqfGm06T3zwrfPTH11v1D3bxOfe8g8QfbYHQI/EKxqMNESF+ugudGdiYuS0nzTQ==
X-Received: by 2002:a5d:5711:0:b0:225:2884:cc88 with SMTP id a17-20020a5d5711000000b002252884cc88mr2042062wrv.141.1661428277919;
        Thu, 25 Aug 2022 04:51:17 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b002205a5de337sm19282158wrs.102.2022.08.25.04.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 04:51:17 -0700 (PDT)
Message-ID: <7d146520-52e2-bd8d-3c53-a444e93e4006@redhat.com>
Date: Thu, 25 Aug 2022 13:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
To: Jani Nikula <jani.nikula@linux.intel.com>, Joe Perches <joe@perches.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
 <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com> <87y1vch7ll.fsf@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87y1vch7ll.fsf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_045122_045412_9C59031B 
X-CRM114-Status: GOOD (  19.24  )
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

On 25.08.22 13:43, Jani Nikula wrote:
> On Thu, 25 Aug 2022, David Hildenbrand <david@redhat.com> wrote:
>> On 24.08.22 18:52, Joe Perches wrote:
>>> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>>>> checkpatch does not point out that VM_BUG_ON() and friends should be
>>>> avoided, however, Linus notes:
>>>>
>>>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>>>     no different, the only difference is "we can make the code smaller
>>>>     because these are less important". [1]
>>>>
>>>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>>>> clearer that the kernel really shouldn't be crashed.
>>>>
>>>> Note that there are some other *_BUG_ON flavors, but they are not all
>>>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>>>> flags KVM as being buggy, so we'll not care about them for now here.
>>> []
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -4695,12 +4695,12 @@ sub process {
>>>>  			}
>>>>  		}
>>>>  
>>>> -# avoid BUG() or BUG_ON()
>>>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>>>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>>>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
>>>
>>> Perhaps better as something like the below to pick up more variants
>>>
>>
>> Trying to find more possible variants and exceptions
> 
>> CI_BUG_ON(
>> -> Bad with CONFIG_DRM_I915_DEBUG
>> GEM_BUG_ON(
>> -> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE
> 
> These are hidden behind debug knobs that we use in our CI to
> specifically catch "should not happen" cases fast and loud. Should not
> be a problem for regular users.
> 

I tend to agree but I don't think this is worth an exception.
VM_BUG_ON also requires CONFIG_DEBUG_VM and absolutely shouldn't
be used as I learned.

Quoting Linus:

   Really. BUG_ON() IS NOT FOR DEBUGGING. [1]

   This kind of "I don't think this can happen" is _never_ an excuse for it. [2]


For CI work, it might be sufficient to use WARN_ON_ONCE() combined with panic_on_warn.

[1] https://lore.kernel.org/all/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com/
[2] https://lore.kernel.org/all/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com/ 

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
