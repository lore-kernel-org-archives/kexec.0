Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA4C369AB
	for <kexec@archiver.kernel.org>; Mon, 21 Apr 2025 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=; b=U+6P+U34MMATKDaFDh/AEDLPec
	CtxNjlhPiLU2RcYuonWiFdIxV4NoyI7QzryMFcnvp98issaOFFuULGAfZoqkk4n1NiBDVFqTQ7eZ+
	68gFYYCYweHjk8ipSzE2IgI/pi7gi/PkDzlks+YIeZJUsxL35IYihhGgppdpeZOehdXrjyFaLmMEh
	Aa7rLcuCx3Ra1OpCFOU87hIKxM2vFyKgzCjD1r8TSHn78vnxOmYAIL8VLWaKBozX5Kuc1WnyypCGn
	K/+3rQ/J5zmYIv11D18FR5Yv2thET6MwWqYju8EiwbhXO+8QtpMb0CP5+8t6B8sj7DkuZiPn1WWII
	rpdnBsKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6yGF-00000005965-0b68;
	Mon, 21 Apr 2025 21:01:03 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6yGB-0000000591k-1pTW
	for kexec@lists.infradead.org;
	Mon, 21 Apr 2025 21:01:01 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so51400925e9.2
        for <kexec@lists.infradead.org>; Mon, 21 Apr 2025 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1745269258; x=1745874058; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=;
        b=CsCGvjuUT34T1/tzYpZFQethi5XMqvCv6M5TD0JApoQ5zeOwQiq5MPErWMfF25uvaP
         o3rsFI/BmAyL9OraAV0ighJIxHBSKPec7rpsjWvyudwMJgudb9emPmYLXzTm+FA+cOCj
         tFls0zhTRy22LLBuV24XoniG9rtA88XNpJHuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269258; x=1745874058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=;
        b=NhSn7CgXpAbhI25CW0JPLfNRtac7V3W9OZptZXAxC6ZTE8u5Cwy1BCP02k0FLsHiGc
         cVkUoyqNuk04SfvQNPzDdV2P+NQ7ahY4jCtwfepViO74/bFyULctRccqi9V9ij2SCc2V
         N5bQPGnvz+wtzA8W49vfcPedoa1K1k0g0R0KW2/01jpYxRakHWta4kVLYP8fPk+XtNJt
         ICSoPr51bBef3JwmXzFvQLn0f80Lm2gZwnuVWmFSjKOX9lpDdzfNLQObEcdQ6NLqmVD+
         f8MJheGrP0XO+VSYV/Xn8sAQUPrjZwg8/QPLCoGNv05ck44vILWU20e0v8NPDHB9O+DI
         AItQ==
X-Forwarded-Encrypted: i=1; AJvYcCXssTIgNe3OOwN4tCfXc7H+OsZWNnN0QS/8mbxxAj5rVKBpNNpdB9Jym9gK0gpX8+vVjwOHSA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9h756AuI/PPTPT9qMURqfAeEMmI5bGEVVQUcZXebsjgPYJ2pu
	UlwKnX3W089QyplzTOIFn074bVw50W9p3Jf/bE+kGAaRXoP5LlhDK/rMsjg3Viw=
X-Gm-Gg: ASbGnct2EUj7/gjcEnmaJRTS5um3wYxeQWRZIBuXZuSe04la9NFrB03F64LMyStRM2n
	ARiRoy68D9tItY7SY53YHVp+h2FJfstzk71zURu3VsY0KUBXezehM1YshJ7VfAppWBF0eVWBKi5
	o2FRNbstvFTcGAZS+J+VLiX/k12NW3qLHDBEYy8Cjqeuh6TJsNoKga5GajOMR/Ew/1CMYehbWB3
	oipCWCKr2Jjo5Suq+HPaWogWjDxlgcWRHyu40/NdVxmq0peYo246EXSE8WppkhSEsu0yYJIqihZ
	pFoOgnYntZ+CTXQx2camU4KFPYcmdcyNFwPhIo+tackI6LCoiFONdw==
X-Google-Smtp-Source: AGHT+IEqZcEurBsEwpQNvMEBz98hVptC58D9hX1qopJkxrFk/Vkqpzpoey4oDYw4HKljgsecLmBIZw==
X-Received: by 2002:a05:600c:1c12:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-4406ac20146mr103140445e9.32.1745269257767;
        Mon, 21 Apr 2025 14:00:57 -0700 (PDT)
Received: from [192.168.86.29] ([83.104.178.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc5dsm150288735e9.9.2025.04.21.14.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 14:00:56 -0700 (PDT)
Message-ID: <693a7733-0e03-4236-bdd1-13441b1ca3a5@citrix.com>
Date: Mon, 21 Apr 2025 22:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_140059_641766_B25EB205 
X-CRM114-Status: GOOD (  12.07  )
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

On 21/04/2025 9:52 pm, Dave Hansen wrote:
> On 4/21/25 09:26, Ross Philipson wrote:
>> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity in a unified manner.
> Hey Folks,
>
> It isn't immediately apparent what these 5,000 lines of code do which is
> new, why they are important to users and who will use them. I've
> wondered this from v1 and I was hoping it would have gotten better by
> v14, but alas...
>
> Purely from the amount of interest and review tags and the whole "v14"
> thing, it doesn't look like this is very important to anyone. Not to be
> to flippant about it, but if nobody else cares, why should I (or the
> other x86 maintainers)?

The very-tl;dr is:

This is an implementation of Intel TXT which isn't a piece of
abandonware with unaddressed CVEs (i.e. isn't tboot).

AMD and ARM support of equivalent technologies will be coming next.

~Andrew

