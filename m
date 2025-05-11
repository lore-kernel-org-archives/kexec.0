Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C1C3ABC3
	for <kexec@archiver.kernel.org>; Sun, 11 May 2025 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4uQkbYUBznFuNXz4c8CGp8kAGDKAUw+/namabwsEaag=; b=kC85fa51IJ1QFsus15yhx2UNNG
	DhDXUWIxlbP99CcN2sBhLbeFhEo6EGX9aUxcapAUZQY/3Lb4GaVQoryKYtL3HIEuRBiWQVebxUwSR
	4I1r5OcqAKVFhu4nJjF8ydBQAqrope60XWPbJBuocAsHaCVtoAbFjpin8xb52JXSmFKYVAdWZTzLL
	adch0p5ER0Y6enN7SJWAFkMuwTDEh5ieK5z1vGp/w+qMjoghqP/jM1eJsPKkhYLIsmzpqTqASmcOp
	VyZ+LfVTlntmS3IDveCXvvoPR+zjzxPpXxCJ21aVEAuLtDTtSbg4a2yIZw2FRxsd0KkohnfntlWPM
	AoKnRXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDvul-00000006cTM-1ZZ2;
	Sun, 11 May 2025 01:55:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDvuf-00000006cSx-2TZa
	for kexec@lists.infradead.org;
	Sun, 11 May 2025 01:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746928530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uQkbYUBznFuNXz4c8CGp8kAGDKAUw+/namabwsEaag=;
	b=OIEU3WofpDWdZPtXTgTDZdYi2wubCP97rWo8254yNFx+DtR0+SJf5pL72a2UYHuqsDhd5w
	yCAArpUYCy4BP3mPWFDs40CLfU2xFHk6koCrGT8if/+YIqZSd28njMwL9/NUfPJxPgFMlu
	6Tk8ngnJs3jaW8PTD8tanLBTRPfrRZs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-XS7fhe5CN-ab7yn30POq2w-1; Sat, 10 May 2025 21:55:28 -0400
X-MC-Unique: XS7fhe5CN-ab7yn30POq2w-1
X-Mimecast-MFC-AGG-ID: XS7fhe5CN-ab7yn30POq2w_1746928528
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b00e4358a34so1959294a12.0
        for <kexec@lists.infradead.org>; Sat, 10 May 2025 18:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746928528; x=1747533328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uQkbYUBznFuNXz4c8CGp8kAGDKAUw+/namabwsEaag=;
        b=ZRcMlrwvKZiJptEYfO7kjsS0/kdtMQ7BnY7mPcV+LoYJD/1ZtB3zSdo8yI8v3GiOy+
         rs5jKUPRmJrpjclYz176uGHg4Y2ey8ABeFNf0scx3daux21Rxe/zPH5BDTe7WovRd2bJ
         TSUd0591bijXpFaXfKtKyGpfOrwa01ww6FkPTxRsKgKLWZ6SCTUgKpXlysn1bYvk/SF1
         BRNJoy+JbpjYQSQH0iozyzF7wOPSHv7jBRl1szABmi7Kms3ercckUgZw+8KEs1OFx+Q7
         bhsd8O4+QIehbNjvn8PHLpkk1DDkA70bvyZ5C+dY3qVjOOtAadddvy3BQHho/wqGYDw3
         VoBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGMhaPyQpM3SGq0/k9ue+JwdKw4xPZLyk1DwsWHUSFXGfG7H0D2fbRgmOJfPa6KGHNpFx8Lg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yya1NPPglftNBLc9ycszHn8xBiWS9LwsuC9WcTOhdtj30YAtFX+
	8KdHVZtDKuq1HvsZ8sX7U8Fvh5SIbsIOEFoYkkn2k+w5WMY4GG4txjYKhwO4VagES0Rqqb10ZkY
	0JoLBk0abUms3dvLXgFBYoKqCuzUAYdkhHZye4RSK5NxQ7fvb0Krbq5b7OA==
X-Gm-Gg: ASbGncsWKmar6RHIqmQ2mbUAlcjSSxCjxqu7FrZtb3BFw9kbxov8/zooJNwniYnHkft
	QjrP7/D2mzSOQ7JNfkSQyhsdmjhG+LuorGvUr16/PpD466JlbNzHDTOp6S1kj8YdyIWS8jwbRLM
	l2EGfehvaGBkq5bxM77rbL1WmqmCwOd+sm/GxBoD97L1MmOtDOOiSbf4Cfkt8CABLxU3uamhbtO
	L+nFm+G5TpfoVofASVXXHv2TnXs2fL6/7E7PBkLl935NGQrZV/M3NCCDV7pqw+USqMv7MGztQG5
	9cY=
X-Received: by 2002:a17:902:d581:b0:223:3b76:4e22 with SMTP id d9443c01a7336-22fc8b0b618mr110591015ad.6.1746928527868;
        Sat, 10 May 2025 18:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDx6RUaLbVa6wqIPDY7JA9hMVeUNpQbRiZfwYWvx9E04fi+l1jNbl06XlIH3uqIO3bGNvIA==
X-Received: by 2002:a17:902:d581:b0:223:3b76:4e22 with SMTP id d9443c01a7336-22fc8b0b618mr110590885ad.6.1746928527565;
        Sat, 10 May 2025 18:55:27 -0700 (PDT)
Received: from localhost ([114.222.253.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7555026sm38707635ad.54.2025.05.10.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 18:55:27 -0700 (PDT)
Date: Sun, 11 May 2025 09:52:18 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	fuqiang wang <fuqiang.wang@easystack.cn>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <7u55qeazomjmp2ci4bxf6ffzzt53srk2zyyss4ym6r75atxubi@k3dhgprujnli>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oBJ_08sGMdiSrwx9cA8yUcVGV1ieR0PWcQvzZJ8eftk_1746928528
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_185533_704712_564D6074 
X-CRM114-Status: GOOD (  20.82  )
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

On Fri, May 09, 2025 at 05:58:01PM +0800, Baoquan He wrote:
>On 05/09/25 at 12:04pm, Coiby Xu wrote:
>> On Wed, May 07, 2025 at 10:59:59PM -0700, Andrew Morton wrote:
[...]
>> >
>> > Do we know why this has appeared at such a late date?  The reporter
>> > must be doing something rare.
>>
>> The UBSAN warning happens because flexible array members annotated with
>> __counted_by are accessed without assigning an array element count i.e.
>> crash_mem->ranges[0] is accessed without setting max_nr_ranges after
>> vzalloc,
>>
>>     // include/linux/crash_core.h
>>     struct crash_mem {
>>     	unsigned int max_nr_ranges;
>>     	unsigned int nr_ranges;
>>     	struct range ranges[] __counted_by(max_nr_ranges);
>>     };
>>
>> The bad commit was introduced in 2021 but only recent gcc-15 supports
>> __counted_by. That's why we don't see this UBSAN warning until this
>> year. And although this UBSAN warning is scary enough, fortunately it
>> doesn't cause a real problem.
>>
>> >
>> > Baoquan, please re-review this?
>> >
>> > A -stable backport is clearly required.  A Fixes: would be nice, but I
>> > assume this goes back a long time so it isn't worth spending a lot of
>> > time working out when this was introduced.
>>
>> So I believe the correct fix should be as follows,
>
>Thanks for testing and investigation into these. Could you arrange this
>into formal patches based on your testing and analysis?
>
>It would be great if you can include Fuqiang's patch since it has
>conflict with your LUKS patch. This can facilitate patch merging for
>Andrew. Thanks in advance.

Sure, I'll ask Andrew if a separate patch is needed because both my
Fuqiang's patch and the kdump LUKS support patches fix the UBSAN warning
as a by-product. And I'll resolve any conflict. Meanwhile, I'll need
more time to investigate Fuqiang's patch. For example, because of
commit 6dff31597264 ("crash_core: fix and simplify the logic of
crash_exclude_mem_range()"), cmem->ranges out of bounds doesn't seem to
happen any more because now -ENOMEM will be returned instead.

-- 
Best regards,
Coiby


