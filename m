Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF5D41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FvslQc65aENI3hEYLOLPSKjFwPZ7g8ph6b5fImcrBLU=; b=x4nnV8Vr3xgBb+IrIrKCfchR5S
	80yn1lozurf/c7pe/tpZ+Qw+TcPjgB6aPuux6qzM8S1k6o6BNEzt7bEr0yE8CM1S1kqTUAeq8jfqr
	Z+KkNqNv3KDzRJ2uicRezcaZtiRF661drPJed46c2Q7qEtMepNz/pjTU7qnnnuSM0ovW+wM/sfd70
	c9ckR9uZYR93ppew8rKD7KViWnBeofgpH2Ghl0GnJBmKgfwgsAyYrBJ5vaPNVkZW6KjqXaIptMoJY
	gsL4JMH/mc1W0rAInRVf33g1NNZeqB/Mvtfs3NLhy2i8/7CWysEI+1eKHO8XkngywL0e83+bzL795
	NSHhb0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4jc-00000003M4b-0NOq;
	Mon, 15 Dec 2025 09:19:16 +0000
Received: from smtpbguseast2.qq.com ([54.204.34.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV4jZ-00000003M2v-133Z
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 09:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765790325;
	bh=FvslQc65aENI3hEYLOLPSKjFwPZ7g8ph6b5fImcrBLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gqbinV+PIe7WmagOrXrscn68KZesjbDBCyYOJWDbGsDYhxSWXikTUrArQVS5+7NZt
	 gDL/opL1Mv2q51t/oCFLnr/Ul9sdjjMNy9wFf3GVbIHI4xH9Wo9wXHmsPq9oZQkNtX
	 g7+Uy5Htg/OMDddnxcdNq+u+rEkkidLFE/d7ZYpc=
X-QQ-mid: esmtpgz14t1765790323tb19af6eb
X-QQ-Originating-IP: 3eJeZu1mbx0OfYz+fhe/uoxpa+1X4vBEVSncsyDAjEU=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Dec 2025 17:18:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1042281400405732488
Message-ID: <4F91083B8C9DC587+11236f66-0903-4fec-93e6-b628f9767934@uniontech.com>
Date: Mon, 15 Dec 2025 17:18:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
 <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
 <aT9h54lX3J+cO0gf@MiWiFi-R3L-srv>
 <C2FBF39E1F0503D4+8030be33-fd88-4f18-b631-a4fecaf62c5a@uniontech.com>
 <aT/LzbCZ2io2YBBX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aT/LzbCZ2io2YBBX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NCLBmlAWuUrdUy4FT2oTs9mGF+F3fK9ISkNvwqjGTczRXrnS6ivGZ+a5
	oyesh95kgNwCquPbfcaCgf37+4nZI5n/pNgtK8CBhgMcWgOqg/xgvpn6geiM/ye2uWKWIab
	0bQqbmho09cr5T5D8NA0v3Tjy9luBrvpdypDFQzC+1rvvyJSe2jlfvs+1QP5IS2e3ZiYFAF
	J50JO/8gImsa/LEN+636ZWRE8dj7cTCv2XJPUt+uXH0xuweJ4OY3bGZPJBNPuLC3BaWnY9N
	akudzX/4B8klueXBNeSva6yMNDyaDBmGBFZZ+N18a4QvkNZoC15MPcSQIUie6+sRBQLM82n
	n5cer1yH/Tpbi4Nn4RgMH5V8l0O4Dbi60yA/h4IiL8j7jx6zFVDyjuIVZbyzw7jbLPeU3ec
	LSPvNIkQiw4rn6T6Gq3/YuLqSTtQyqZwGJg1UzX5knoJKcMwW2twn7erOQAVpEK4UNqhdKR
	OXLkfAfdah8i3dMM8ml8ymVEVZsARkNkbVNoCSE4hyNGcMGISpoPjdl9Mz81uEcSqZF6d+L
	P7h/2PT39mLGB4K3/N5XAh0rvuhUtMDjcWzp+RFotrEj07LeBwzEHYINWXbgcB6WkrP/uU+
	53o41FsjYU4fGZfOux0446EYpDeciQQd4m7ETLA99Cd94qbhyhz6GDJZiLsWqRFa1UZxBur
	qe+1C0LwohYvA6dBtrAlR8v7V902pb/EOnvqQWE172eGdUXfB7L3MoCcKU3y9wz6ahEch5b
	2kY0AMy69JNHyEnbJ2RXW1iUW2eF6iQrXlzkmM0nQPCYi9G9aDub+MZA+RXbYuQdvemBUdQ
	vdi9bkvriKQJrYkuQ9X1QA5H0Lh+JloEd9ntYzLHLWmVcVOC11e2p72l7w358c0jTmCySwv
	qxJExrKM+rk33pLoWklFLgvkOP0biyKcTt53HkgtivOBGF/gtF6hvlo967niy6PErUfti1u
	4vwaLfEJEJkeQGza4yC/aCJmxqJdJaX6BRg+8bmLrINLo8+b35yDkBIlG2i1YF0Sl/hiVHb
	f26NZ8s4wQQw3Au8mcQa+8MwICJKqANRtssboq9Gwv86abEj+75Pni75imayODc5oZ6h0Yr
	CqtZyx6HpzQ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_011914_115430_138D4309 
X-CRM114-Status: GOOD (  13.78  )
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


在 2025/12/15 16:50, Baoquan He 写道:
> On 12/15/25 at 12:41pm, Qiang Ma wrote:
>> 在 2025/12/15 09:18, Baoquan He 写道:
>>> On 12/14/25 at 07:35pm, Qiang Ma wrote:
>>>> 在 2025/12/12 18:53, Baoquan He 写道:
>>>>> On 12/12/25 at 03:16pm, Qiang Ma wrote:
>>>>>> The image is initialized to NULL. Then, after calling kimage_alloc_init,
>>>>>> we can directly goto 'out' because at this time, the kimage_free will
>>>>>> determine whether image is a NULL pointer.
>>>>> Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
>>>>> allocated memory are all freed via out_free_control_pages and
>>>>> out_free_image accordingly, any place missed? If no, I think the current
>>>>> code is correctly handled.
>>>> I rechecked the code and found no omissions.
>>> Hmm, my bad, I didn't say my question clearly. I checked code, didn't
>>> find anything wrong in the current code. In kimage_alloc_init(), the
>>> allocated memory are all freed on failure, no memory leaked. Means you
>>> are fixing correct code.
>> Oh, I see. I recalled that this fix was in preparation for patch
>> "kexec: add kexec flag to control debug printing" for kexec_dbg_print
>> to be reset to false in kimage_free.
>>
>> In that case, I don't think this patch should be posted separately.
> If it's prepared for later patch, it should not be saying it's fixing
> issue. People may be confused and try to add it to stable kernel.
That makes sense. I renamed it: "kexec: Replace the goto out_unlock with 
out" in v2.
>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>>> ---
>>>>>>     kernel/kexec.c | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>> Acked-by: Baoquan He <bhe@redhat.com>
>>>>>
>>>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>>>> index 28008e3d462e..9bb1f2b6b268 100644
>>>>>> --- a/kernel/kexec.c
>>>>>> +++ b/kernel/kexec.c
>>>>>> @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>     	unsigned long i;
>>>>>>     	int ret;
>>>>>> +	image = NULL;
>>>>>> +
>>>>>>     	/*
>>>>>>     	 * Because we write directly to the reserved memory region when loading
>>>>>>     	 * crash kernels we need a serialization here to prevent multiple crash
>>>>>> @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>     	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
>>>>>>     	if (ret)
>>>>>> -		goto out_unlock;
>>>>>> +		goto out;
>>>>>>     	if (flags & KEXEC_PRESERVE_CONTEXT)
>>>>>>     		image->preserve_context = 1;
>>>>>> -- 
>>>>>> 2.20.1
>>>>>>
>


