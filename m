Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02BDE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 05:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMJt/YhwUnBzvs59wX/sgUOAGddtx1maXOTnOv1QH5s=; b=IO0ydtA9Q0GR4yuqAc+p6LNpCd
	CFMnfFUpl+TKLwSZg+UJDt06IjSId4eFIBTJCMCiZXxZ7lf/wCFrKUPiHXJ5Rr3lEL5eOkTUlQ8Ed
	8vShW7oPJfTsanedVstltP7UN2xc2d/87PdcVITPakoWo0zDo57r7iBdI8sFcm73JN1kawLF3qJIS
	szRj7ULnHyP9fqlOOP4JX6muGGa+CZRmHxJ2MbyGPsqaUKXfqY/r8QSYfZeXrqM4PEbMJRiape1ux
	veeBFUR4KukZATNc17O+BR2gqx8d56ZXOjWZQQ8HGdQ1FgRCky0He+WoIMIW3woByszeeVHKCOtz4
	JzXNzdjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl6n-0000000AoFR-2wcH;
	Thu, 09 Jan 2025 05:29:29 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl6l-0000000AoF0-0DHx
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 05:29:28 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-218c8aca5f1so10422915ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 21:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736400566; x=1737005366; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMJt/YhwUnBzvs59wX/sgUOAGddtx1maXOTnOv1QH5s=;
        b=hVq6+iLuIUpnw1HdT7w1U3FIUKWdiskic16dFbQciJXnZXFU+QZMqnUuGR29xzZBku
         Z9vOskJqxbs3wE1irXSemvxRAEW29wg1LOJrMeDQ0LnqWbXEgLu3C0nn9qWcqRDOhwOq
         5XXH1kmq4UQ17HrlmY4G+iCORc0ywErdM3Ux7y05+iPeBnK2Xm1+z9eWnkCrndhixgV6
         vp87fNrztrcAaEqZ7BFoakdM8oUn2VFyLdE9Uh/xKBtygfrmkH+Gr+En61xzeaEhzplT
         Wi8gFJnm58ebI3iaDS7F4mJl0D5KDOp/EcAusEnTy//Mr0OtdP/k51BqUHm95kjZEll5
         E6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736400566; x=1737005366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMJt/YhwUnBzvs59wX/sgUOAGddtx1maXOTnOv1QH5s=;
        b=tKloYUP3fmFRLbnL7NwIameHSe3vsmgLf7/Q48NPS/0jkH502xOXNOAzx9H2x0NEfc
         uI6+b5PyrsZnblrhXKZG+jqSkkGuvnKTznW4npOh82VATPtcVnTXVWzqIaZFsVMQczrM
         7oTiHdfbYgxFBY9udHQWDTJudAM6vWnz5U5/o+S8fxFZKr0xD22bSLw4683kTLzH82B7
         vaxC0KV4S5dtL33095hNoOW99wYZT6pYwbb/5ONx+Vka7pgo0frcOutJk3tdwOyXsKsi
         +uDRMGpdT5KfSA5jcTx1FIwxea4ENdoAxvm4xil3WfHS/mnuoof6L7flv0U5WgPcuwYQ
         dCcA==
X-Forwarded-Encrypted: i=1; AJvYcCWoDlValIAlgjSXDDBUtRuDS42i1nkIM2j+Eu+nnh5G18HEFDtfVGjeUWyumqpmFPU5Rfo/ug==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2jEySuk1eV+dr6srf8AlFYLAQCYHKKjP6Wa0LyzhHA2LnJ2Ee
	tuYaQNzmHdLaM6VTP/8wfCXAfkmGeGcl2YFceXy6nzp0lHQDySSDwjkfHzR8IUU=
X-Gm-Gg: ASbGncu83A9QdNaAcTCr+sJiGI2qDyfDhcldEaQ1G4rvw9ZMiH6OQsd/avpwZXZxHVd
	zDL6xhDKccex9KA8dwaNDjdXIPODOvnpDcp6csqb9IO2HXYYgS1V2gXttisqUd3LXQ605tA+1Jl
	iaa6Z67Vxzmv+wGPKapChNP6/6SkHVkERMwlffNIaFK9eNWX5hYa4emwz5p/ueqITMXM7W5usKP
	yaqUnWYyejrBfJJEhv+bICKE6Rb2GbehTZJiUqwKHtTuJwwfh2u9uA4qh5mqYCv70E=
X-Google-Smtp-Source: AGHT+IHb0FVyvp1dm7B/1h/x9uzjYQ//zMkoJ4qWj36+ahLI4sk0W30C74Z9uJRWuq6gqr8rh892HA==
X-Received: by 2002:a17:902:f681:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21a840094b7mr86342285ad.48.1736400565988;
        Wed, 08 Jan 2025 21:29:25 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91744580sm3702405ad.84.2025.01.08.21.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 21:29:25 -0800 (PST)
Message-ID: <2ad7234d-bfc5-49e3-abe6-7a85d992329d@daynix.com>
Date: Thu, 9 Jan 2025 14:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
 <Z36Cljsz2p0hYsFd@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z36Cljsz2p0hYsFd@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_212927_399064_6CF06ABB 
X-CRM114-Status: GOOD (  13.94  )
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

On 2025/01/08 22:50, Dave Martin wrote:
> On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
>> On 2025/01/08 1:17, Dave Martin wrote:
>>> Hi,
>>>
>>> On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
>>>> Use note name macros to match with the userspace's expectation.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>>>>    1 file changed, 23 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
>>>
>>> [...]
> 
>>>> +#define NT_INIT(buf, type, desc) \
>>>> +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> [...]
> 
>>> (Note also, the outer parentheses and the parentheses around (buf)
>>> appear redundant -- although harmless?)
>>
>> They only make a difference in trivial corner cases and may look needlessly
>> verbose.
> 
> (In case there was a misunderstanding here, I meant that some
> parentheses can be removed without affecting correctness:
> 
> #define NT_INIT(buf, type, desc) \
> 	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> It still doesn't matter though -- and some people do prefer to be
> defensive anyway and err on the side of having too many parentheses
> rather than too few.)

Well, being very pedantic, there are some cases where these parentheses 
have some effect.

If you omit the outer parentheses, the following code will have 
different consequences:
a->NT_INIT(buf, PRSTATUS, desc)

The parentheses around buf will make difference for the following code:
#define COMMA ,
NT_INIT(NULL COMMA buf, PRSTATUS, desc)

But nobody will write such code.

Regards,
Akihiko Odaki

