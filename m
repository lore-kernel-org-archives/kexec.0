Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4C6C83038
	for <kexec@archiver.kernel.org>; Tue,  1 Jul 2025 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=05DvOPnYJvLbjXIZfvA3qU8pEVrHcgb4vIodN8pGWR8=; b=VE16UJyAeSETsg85Obpfo4ZFsX
	xeay5wNDOLDAptSK9A81rJA6zpmFYUvRetk2bdB3Fohl3dGOL1Cgnn/txMu/xiPHu9/VtCEpL9Pk/
	Byhd4eCVprxV+jpIZv7gaKxVCJJkvTF2VsbPS9tY0bOIqB+jy+izNuReTZZ75UtPTpNdgDBvzAWbY
	is66nl1z/+99qK5/HbXXtwEqzsaelVzPDRfNKCkgGdsRiAz5NEGY0l0PJ+TBTR/uxvDX322DElcxo
	1vmpIgKgjlKBAcARYLJmusCo8xlQ4cq1Tlkv6sYoe89uD0d8NU8XVECpbBxSbmSTV9D6YO8rDD2S2
	ZT6PAq3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWh4m-00000006Vue-3quG;
	Tue, 01 Jul 2025 19:55:32 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWh2v-00000006Var-2KAb
	for kexec@lists.infradead.org;
	Tue, 01 Jul 2025 19:53:38 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so35779995ab.0
        for <kexec@lists.infradead.org>; Tue, 01 Jul 2025 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751399616; x=1752004416; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05DvOPnYJvLbjXIZfvA3qU8pEVrHcgb4vIodN8pGWR8=;
        b=dvTB89XLZORaMp5LVIlYihP1Qsmp0sb4t1ownta2n2OUxYNwl//QbOl+J6y/2oH2wZ
         NNF01UfYDcDDgHJOl9Nf7HbaLKX4pk0IXZAD2Lm7rKovl2Hp4RB/b82ZQipTDTm8DRf8
         /g6pB3jTP01pWW1vdd3+RF+nyxEtv45neM8WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399616; x=1752004416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05DvOPnYJvLbjXIZfvA3qU8pEVrHcgb4vIodN8pGWR8=;
        b=E9/2hWomS/4QHyncSllCSiMFfy65J2lBz2Ionhv7pMrCcOXhks9PxXHI4vLd4ncz6x
         41M0fC4pLwCd5xAtEB7qeBTZQG7zA9Z5OXVdU0g5mWgirk1q6lXb4NAL4bhVNVNbTQvU
         bGzWY2xJ6oxKefwiKTWFY6wBVz2KazjGIWY+z9N2QnLlunOUukLQzU5mix6KL8FQh3fJ
         Y1py+VG+Q9XO0AjQwvmrFy6sIqpydallxTXaU+VBtMtzVU5jcBwcdc4oHWeviT35fZzL
         5RQm4/PtOQcHZzicG6Di5+mivIaPUEA/E/AzElYN5Uj9yprXvU/PChOYmoNwVf3Ylfms
         hgcw==
X-Forwarded-Encrypted: i=1; AJvYcCUhyfsk+EJlsYZ9JB5UOsJFTLw9cJ+tuIkSCitHKOkRDVeIdTq3hF+Wbj4j8MSii43RY26tTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzzNQ23BqysIb4tFI7qgVUeHWawdmUHCh7YvzNquNUnQCZzAXS
	vb8G5+VidkCs1QBz2Qk1IC2kNAu7T5P6f7ykN3bx4kq4uGKhWm1Oc1l6ZMwHw7ICYb0=
X-Gm-Gg: ASbGncsujOiUmS0L24C761TEqlkJHrscqQ/mw/QmmxDiuVVgqWBfi/sHw0UtmLzfmA1
	qlhkWaef1idalo+SwRL6RyJXNRrY2PH2Kf2T0wmuVyy+6pLYjVKdVHqEEdYPa+ngIACmWrBfG4J
	3wSM6AhHqPPS7xuacGAIDyzRxLXnd2dWtEmXCXwk2nWvtuhP2uqqhmdSpzEVpd0ZCq11uKG3O1O
	mr94dEzpJF7vtn4bh/YIhewK5wjrLaBfwwvO2dJicX7d7/2aWVrRMgBzFtpCx1680aBmWb/5aVP
	ejkCGb66uU4ZML2IvJvTBkU+NGdvBbyztt8C1Hcyd7PA0h2L5Gf8SdefHLKarlwKZECcmVoKCQ=
	=
X-Google-Smtp-Source: AGHT+IFvgVmTDNSS6N+w+PWK6OvUgtAsoQ5EvKqtlmkInV+s6ra/2LpzaFJdJKj+QGj0od2XQYkO0w==
X-Received: by 2002:a05:6e02:310b:b0:3dd:b808:be74 with SMTP id e9e14a558f8ab-3e0549e27a5mr3374255ab.13.1751399616134;
        Tue, 01 Jul 2025 12:53:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048636ccsm2592165173.13.2025.07.01.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:53:35 -0700 (PDT)
Message-ID: <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
Date: Tue, 1 Jul 2025 13:53:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/kexec: fix test_kexec_jump build and ignore
 generated binary
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, kexec@lists.infradead.org
Cc: dwmw@amazon.co.uk, mingo@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250624201438.89391-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250624201438.89391-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_125337_614687_1AE6DB4D 
X-CRM114-Status: GOOD (  20.41  )
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

On 6/24/25 14:14, Moon Hee Lee wrote:
> The test_kexec_jump program builds correctly when invoked from the top-level
> selftests/Makefile, which explicitly sets the OUTPUT variable. However,
> building directly in tools/testing/selftests/kexec fails with:
> 
>    make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.
> 
> This failure occurs because the Makefile rule relies on $(OUTPUT), which is
> undefined in direct builds.
> 
> Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
> declare generated test binaries in the kselftest framework. This ensures the
> binary is built regardless of invocation context and properly removed by
> make clean.

The change looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> 
> Also add the binary to .gitignore to avoid tracking it in version control.

There is another patch that adds the executable to .gitignore
https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com

I think you are missing kexec@lists.infradead.org - added it
> 
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>   tools/testing/selftests/kexec/.gitignore | 2 ++
>   tools/testing/selftests/kexec/Makefile   | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/kexec/.gitignore
> 
> diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
> new file mode 100644
> index 000000000000..5f3d9e089ae8
> --- /dev/null
> +++ b/tools/testing/selftests/kexec/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +test_kexec_jump
> diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
> index e3000ccb9a5d..874cfdd3b75b 100644
> --- a/tools/testing/selftests/kexec/Makefile
> +++ b/tools/testing/selftests/kexec/Makefile
> @@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
>   
>   ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
>   TEST_PROGS += test_kexec_jump.sh
> -test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
> +TEST_GEN_PROGS := test_kexec_jump
>   endif
>   
>   include ../lib.mk

thanks,
-- Shuah

