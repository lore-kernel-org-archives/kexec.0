Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D878C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 07:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xlKCRyJmUt4oo7s6EMRczgy6MnR0ePY4jhsRQ6cVx4=; b=DgFAvxGm2zNjT25MD5jQ5Xlh73
	kS3hv663tOZGvTQCW7i+UepE/18W3LyMypmn9wtQ9JwJ5OREtipVbqIOGqbtVI/gLK/EwF8PqnRFg
	JLr9DFgnctlWKM3UYX8hLEhA+0IrU+KZUBMD/JqA0QJy6t3JvyeMsNQAdz4G+i4ZQTEVkip6BQkLN
	5opRpnscqL2PZyMBzIEDWlCcR/Loc37WV+joKJMQ0ogbVerzHQogJ3J8dfKKt3OZAmG7D0dfc3mCa
	BML66C2rEG64kn9XM6xJfdYDdbabB3A5DHgq+ZfC0RnukskbjAD6AaHd/P9fn019HIBsuALc0lFzu
	jjm78+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxJWQ-0000000CgRV-1uu3;
	Fri, 21 Aug 2026 07:18:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxJWN-0000000CgQh-42Pt
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 07:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787296713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xlKCRyJmUt4oo7s6EMRczgy6MnR0ePY4jhsRQ6cVx4=;
	b=ZVtc2BRhnWBIk0qs968FqF89K7egDxyl2oeIQ8c0m+ztKZIjTd8wlzGSAAC9D+kMMTgw74
	ObPk0Mg7GYDt1lGOlOB/AhayRL7cuqMf0tjqcP18YUCbMkFy6AfOIW0JzIvcrX1ghd5wsS
	xm2A/Q0UpbXML9dithMa0HScKtloPRM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-9aWPJGPEO1mi0ThmbFvEcw-1; Fri, 21 Aug 2026 03:18:26 -0400
X-MC-Unique: 9aWPJGPEO1mi0ThmbFvEcw-1
X-Mimecast-MFC-AGG-ID: 9aWPJGPEO1mi0ThmbFvEcw_1787296705
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84fb5376cb8so860905b3a.2
        for <kexec@lists.infradead.org>; Fri, 21 Aug 2026 00:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787296705; x=1787901505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xlKCRyJmUt4oo7s6EMRczgy6MnR0ePY4jhsRQ6cVx4=;
        b=V7JqKscM8U35Rz+tlS80VgqPwA1F2dtoNpj+iTrW41ujsNQ9rFX5CCsT7GETnfLqcq
         HW9em0ZpQN/db3o7mTS7Ymsb8CacB6kld5+vGsnZZ24psfFZQ06/tnHvuXtCL6fMbmAd
         7XmlOnD2xlsp1zhFx0SnGa+y+i/Ktfnzd0TaD1OdZJ2J4jnAkKwYs2SDTYjuLHeZFRHd
         193Zzuybpi8nvTUwsZfKOClLxUHFT1yrBq5nBEYTgCWBvCSMccf6VahpKBX/eNR1vAGx
         AsXGB5oNLpNj0GExR1IJQMHrMK04rndWtFYpkTuFt07FEPQ6LFuwVrYPKWtiqZ4SCDXW
         6pnA==
X-Forwarded-Encrypted: i=1; AHgh+Rpnc1GqD7nM4HMXLEijg5UkxnmGirW4RN62jH+QV+6pSNyC5rCNJO/LsCHeICO9gwDeLSohzg==@lists.infradead.org
X-Gm-Message-State: AFuF++n1t0YPyLa4WaF/T4B1t/J5yvIV/p+qPzXV0OMKOdkYbtyxLDeb
	0IyVwQKt0X/6Xm1ifoUjqpE8srcaniEVreE8mKaoU8A9KYO2nA/mj3xGMEuEEhmYP6BMdAo4aNY
	F6rUmIPLYr2dBlInAguMJuRhn/R+ZxREPGuvNe/cJq+6kTlc0ZSXbv9X+7l5ymg==
X-Gm-Gg: AR+sD11EQXFTIdTGgezZNQTwO2yCykCsNSkd+h7Fu5iyGl+Jb52p8SQgWFCS1I8VzCm
	zTJK5Luh5TaA9qxbOytjgq0Wan/jWAdS9b7SWqC4dtuQ/6qt3EooGw8b1JnfrZpN7+vz6mNzq+C
	JJUpHbRt4qy72fGNrPkNsJlMP6260bKabM6yGjtsxQ+0ScbSRRG9dbkMiqJao2MXKaA2xRw9m1g
	CZwDr0wwEb8PGiY/Ey03Z6qcJgcEZtPjTkAtX2sAWklqZ196rJlXHnOlOLkeCIafL2EgPUD0l/6
	IdkLbaCt0ZK0hONJ5YWH9QEA3qmsD7PqfVgZd3evlfla5YEhYELfwqMqscDQCcal3OBwvL0fBhN
	Hfd5kxT4G+ExKrcZGfw==
X-Received: by 2002:a05:6a00:179a:b0:847:8449:2ba6 with SMTP id d2e1a72fcca58-851f9f66789mr6258586b3a.8.1787296705129;
        Fri, 21 Aug 2026 00:18:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:179a:b0:847:8449:2ba6 with SMTP id d2e1a72fcca58-851f9f66789mr6258522b3a.8.1787296704696;
        Fri, 21 Aug 2026 00:18:24 -0700 (PDT)
Received: from [192.168.1.3] ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3361d24sm2509087b3a.5.2026.08.21.00.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 00:18:24 -0700 (PDT)
Message-ID: <713ab0a0-235d-47cf-a0c2-73249fbc8f74@redhat.com>
Date: Fri, 21 Aug 2026 12:48:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
To: Pratyush Yadav <pratyush@kernel.org>, Philipp Rudo <prudo@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Tao Liu <ltao@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
 <20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
 <20260820142114.0a36ac78@rotkaeppchen> <2vxzik54zmpp.fsf@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <2vxzik54zmpp.fsf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f6PRy2ttlFVqcZfgMozOoYOleIP_ogIFf7Hxp3vjfdA_1787296705
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_001836_068214_90404D60 
X-CRM114-Status: GOOD (  22.70  )
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

Hi Philipp,

On 20/08/26 11:41 pm, Pratyush Yadav wrote:
> On Thu, Aug 20 2026, Philipp Rudo wrote:
> 
>> Hi Mukesh,
>> Hi Pratyush,
>>
>> having this patch makes sense. Personally I'd go with having a
>> switch-case rather than individual if-blocks. E.g.
>>
>> 	switch (ret) {
>> 		case 0:
>> 			image->fops = *fops;
>> 			return 0;
>> 		case -ENOEXEC:
>> 			continue;
>> 		default:
>> 			return ret;
>> 	}
>>
>> IMHO that is better readable and easier to extend in case other error
>> codes need special handling as well. But that is only my personal
>> opinion.
> 
> Well, IMO both look roughly the same so I unless Mukesh prefers your
> version more, we can keep it as-is.
> 
Thanks for the review. I agree the switch-case reads nicely, but since
the current version is functionally equivalent and already
reviewed, I'll keep it as-is to avoid re-spinning for a style change.
Happy to switch if you or Pratyush feel strongly about it.

>>
>> Independent on which implementation you use.
>>
>> Reviewed-by: Philipp Rudo <prudo@redhat.com>
> 
> Thanks for reviewing!
> 
> One tiny suggestion. Can you please reply in-line the next time around?
> It is a bit easier reading this response below the code that it refers
> to.
> 
>>
>>
>> On Wed, 19 Aug 2026 23:17:23 +0530
>> Mukesh Pilaniya <mpilaniy@redhat.com> wrote:
>>
>>> kexec_image_probe_default() overwrites ret with each loader's probe
>>> return value and returns whatever the last loader returned when no
>>> probe matches.  The error code reaching userspace depends on whichever
>>> loader happens to be last in kexec_file_loaders[].
>>>
>>> Only continue to the next loader when a probe returns -ENOEXEC.
>>> Propagate any other error such as -ENOMEM immediately. Return -ENOEXEC
>>> only when all loaders have been tried and none matched.
>>>
>>> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>>> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>>> ---
>>>  kernel/kexec_file.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 59fb9d71e9d8..b3060e984ef3 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -68,17 +68,19 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
>>>  			      unsigned long buf_len)
>>>  {
>>>  	const struct kexec_file_ops * const *fops;
>>> -	int ret = -ENOEXEC;
>>>  
>>>  	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
>>> -		ret = (*fops)->probe(buf, buf_len);
>>> -		if (!ret) {
>>> +		int ret = (*fops)->probe(buf, buf_len);
>>> +
>>> +		if (ret == 0) {
>>>  			image->fops = *fops;
>>> -			return ret;
>>> +			return 0;
>>>  		}
>>> +		if (ret != -ENOEXEC)
>>> +			return ret;
>>>  	}
>>>  
>>> -	return ret;
>>> +	return -ENOEXEC;
>>>  }
>>>  
>>>  static void *kexec_image_load_default(struct kimage *image)
>>>
>>
> 


