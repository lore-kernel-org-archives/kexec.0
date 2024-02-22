Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8BAC48BEB
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 02:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kU6TBFzGyCYmSsvs8EeOEbICybL5fts6phUsdCtPiOE=; b=g51DHLzF49HjDD
	r+P9192qVZrHqZeQeLNSlMo5evmWkUJlbgo6T5E1fca6Ct5lLWEJOe7KfnuDZtOzY2DbXEMax1Jhk
	UA4qhYmxxoDFkRMKthO2oqUCFbnm/PV3JfXpaa3vxpwOQuaN7kZ9CG11qpofFRqKak9iiv+qakFph
	2aV0XslyUsuhUSUDbOAgJ1OtdwBoAQ3LDNBAlrlfNRwk3DchVQKdw9DhZNQ5fVGYnAswz/DNxYKzZ
	WrBu1eeYrxZrIjohtbKmIwWkMty99IxCWDWjwZYvnMSVUPKr1xXtX1hkVkox24595LNLvvKskfWFa
	YRXGRk1EDG41PeJ64fPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcyQo-00000003Cal-0W4h;
	Thu, 22 Feb 2024 02:03:26 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcyQk-00000003CaG-3BjE
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 02:03:24 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-41274cada64so10438465e9.1
        for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708567400; x=1709172200; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpCgjNX1LqPX7oZGVuldx9UiwfGbtf89koJSaGuEDxQ=;
        b=a8yVkFwqG5Kq13Kxsot0UpEedFrgkF6XS+OJinJzQyXC1Fw0WUdazGjLHvWPZT4MuH
         ni2FWnqFy0Utsq5OdSbyZ9ak/ljQ485hK87ME2ynMsE67DbNArib4YriE/lvlsc6ttBO
         2f9rGfeiJPjuxanLKvT4EJmthguaUvteNUFiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708567400; x=1709172200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpCgjNX1LqPX7oZGVuldx9UiwfGbtf89koJSaGuEDxQ=;
        b=RHhyWurClG42gQeXxKg9fu5y0Enlkiu19ipIYCCSXE/kk4rfNSFqWfbCUk4uWSpkg3
         /Dolu1RVbMGKdBx27P+mw3+dIzw9u76/qEQJ15xqgivzF/6A35yXbnAgGKn1Gs6RP9fF
         BQVGbzV9jP1T+y3JycINO028ayDVJgVp99jYuc7tZwJLhgx+dwIn4abtNsJbnM2zWBGb
         cJI9R7TyHcd5tNnhMbEW1X+aW1aGThIcFMYXxzkrWO4QInxl/a8/keOQR03qBwIQKX1t
         n0zDVQgJtq5gQEkG70i/aWupPUm8p/8jAaMTGRQyY27oxENbHG1qoEvzuqS0oMVtFu7l
         nidg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJpAPrr0wO04JW1yJicC4Q8c5OwwDGDp505Qp+jl5o6nVYRS6ZxnVJfGtlXsJm85vh7hCfe9VMBS7btsQCJ1n06kV6Xh/BiZs
X-Gm-Message-State: AOJu0YzFOE1Jz16ShDSQgWV40vW/QJ1FdEhvO4SDYKTlbxc062Vr0vn5
	1ipiuXfvkpe6ZUqctgpshAzTIMVqZTwS1IJegSm21/aAKwGIaRuWAeQg4TwXn1o=
X-Google-Smtp-Source: AGHT+IF17JfDiQPU6La0me//6yi5Ziq+H6StnWpBIOWkvLcTMKHIezhdF+lH9T4BxYSFO+mETuw9kA==
X-Received: by 2002:a05:600c:22c6:b0:411:ef17:9c46 with SMTP id 6-20020a05600c22c600b00411ef179c46mr14985747wmg.39.1708567400316;
        Wed, 21 Feb 2024 18:03:20 -0800 (PST)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b00411e3cc0e0asm19318507wmo.44.2024.02.21.18.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 18:03:20 -0800 (PST)
Message-ID: <08ac69b4-4d12-4454-aa16-40db7e54816f@citrix.com>
Date: Thu, 22 Feb 2024 02:03:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
 <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_180323_185211_64F28246 
X-CRM114-Status: GOOD (  13.28  )
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

On 15/02/2024 8:08 am, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>> +/*
>> + * Primary SLR Table Header

I know it's just a comment, but SLR ought to be written in longhand here.

>> + */
>> +struct slr_table {
>> +       u32 magic;
>> +       u16 revision;
>> +       u16 architecture;
>> +       u32 size;
>> +       u32 max_size;
>> +       /* entries[] */
>> +} __packed;
> Packing this struct has no effect on the layout so better drop the
> __packed here. If this table is part of a structure that can appear
> misaligned in memory, better to pack the outer struct or deal with it
> there in another way.

As you note, __packed does two things not one.

The consumer of the random integer that is expected to be a pointer to a
struct lsr_table doesn't know whether it was invoked by a 16bit
bootloader or a 32bit bootloader, and this really does make a difference
for an ABI described only in C.

Then again, we're holding off on setting the spec in stone until there's
an agreement in principle, so we could retrofit a statement about the
expected alignment of this structure in memory.

The sane choices are either 8b alignment (there are uint64_t's in
entires[], but I also see there are some misaligned uint64_t's too,
which is dull), or using the good old x86 fallback or paragraph
alignment just in case we really want to extend it with a uint128_t in
future.

Thoughts?

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
