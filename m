Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5342AC83F12
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 05:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GAAi6WZLxvSrMwWyp1e63w8yWynryf1tqqKUUItpO14=; b=wdhfvBbk32UWVb
	pGu2x0BtSAxDX+ufBGO94XJsiCsmutPLPFcV04aJtyV+fm9LGDOTjUQUvzQHll56VzbaryWLAwYty
	d80xL59kizZDLkgsHeoniOF1L9P79fTI/Ksqj4ryhlkj5tIs8bd0Ri/KQ7bOD+sohbqM3dtD6RjOe
	OUX4kzqrRaMCAfSqiGD1NDbWd50Bi2NFofeFmM3qIZarUySDcrT9KVTKKaGfW5AtOOH+k5O96DQO7
	3bjOrYihzTcI24yQjegFnR/sPMIcAAUwrJzimM760mD4HMt24ihebhQhnKU/zQUMUByN45zbap/nK
	7S+qEShdIO5/hqxHaKuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaUlp-008smN-31;
	Mon, 28 Aug 2023 05:26:37 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaUll-008slM-00
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 05:26:34 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41215efeb1aso13453971cf.1
        for <kexec@lists.infradead.org>; Sun, 27 Aug 2023 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693200391; x=1693805191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=108AsllHoPT0Lzt6ytjY6pwVBBXW6+UeWb5fHpdiN2Q=;
        b=ldkG786to9BGWtLjh1WpxPRqStCYl8LmG4rHbPoL584Ls+asn+5YyMI61vJLYr6C4t
         2fmq2AzgCsmbCOMiBqUszMj3zNyh9TcrZRbKwG4w4ulMng1rF9U39n1QYbXcMwqMl9mw
         YTmukQHhLrSUlJeclpPyPGv9x4XYuLCD/EVOt2l3sRuMUOFkPha71hxR9S1i1sVc530C
         TRJoYH624KKJC61vtkAJYiKDE+NAzAIIDnM9fJrG/+3B8/IW4DTJhPOtbxJX1OSgt0Zd
         JKfXUgJ5WriQuw+RZOisBtZYZqkwfLR66g527y4cNsWVAQ6cCcO8kAiUmku2CsbPLZVH
         VuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693200391; x=1693805191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=108AsllHoPT0Lzt6ytjY6pwVBBXW6+UeWb5fHpdiN2Q=;
        b=eKYNT9Q9JylKYG2Vts+fZ/9mmEzW766YaClLQImEpXyNjzcMVuMQUl34oIKQFgDylV
         RUNe8aD/idGmsmfujxxRwJSW29t81ftw1cvP0E/aakv0PkLaKy2ZQ64u3aQ7vVc39lbm
         dWTUYvwOBFXx2Wb2ycsV4CggIhIEip0/KM4T7rLZp3ojv+Kk0eIPM5XDR596vu+FjMQ0
         7D5y76PYtbsyioQob8zEeNSd6Nis0q3i/UkJ1DS1YWKb26odCPI5NWhQJkFBHTZTI+gF
         iapO4BUJZlXjTi8ECzhkeuhMtUZpUIXeNO+tRbLnFnsXbqkvjXvga17En7ZOrUGqM0HF
         4XIQ==
X-Gm-Message-State: AOJu0YxU8QPoY90EBLbl5DQNbb9clfk8locpMrZYcOK5bMxjZIBU5AtM
	nBhNrLVU2/nZc6GSQtyzWITW+lyGAKT66x5byvU=
X-Google-Smtp-Source: AGHT+IHEQKuNBZ6qJ4N2xNz7ofrzmnsHi+TY1oiaRD1gEJ0FxfGbS6fr0a1lahg4MRvwzZ6B70mZTw==
X-Received: by 2002:a05:622a:1182:b0:410:9855:aae with SMTP id m2-20020a05622a118200b0041098550aaemr25612358qtk.19.1693200391084;
        Sun, 27 Aug 2023 22:26:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6140:58e3:2550:7e99? ([2600:1700:2000:b002:6140:58e3:2550:7e99])
        by smtp.gmail.com with ESMTPSA id bt4-20020ac86904000000b00403f1a7be90sm2084094qtb.88.2023.08.27.22.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 22:26:30 -0700 (PDT)
Message-ID: <15058508-9e21-0d10-4eca-2c8a5562d36c@sifive.com>
Date: Mon, 28 Aug 2023 00:26:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] crash_core.c: remove unneeded functions
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, thunder.leizhen@huawei.com, dyoung@redhat.com,
 prudo@redhat.com, linux-kernel@vger.kernel.org
References: <20230827101128.70931-1-bhe@redhat.com>
 <20230827101128.70931-9-bhe@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230827101128.70931-9-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_222633_054899_548968E7 
X-CRM114-Status: GOOD (  12.41  )
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

Hi Baoquan,

On 2023-08-27 5:11 AM, Baoquan He wrote:
> So far, nobody calls functions parse_crashkernel_high() and
> parse_crashkernel_high(), remove both of them.

minor typo: should be parse_crashkernel_low().

Regards,
Samuel

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  4 ----
>  kernel/crash_core.c        | 18 ------------------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 2f732493e922..0c512a80a768 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -80,10 +80,6 @@ void final_note(Elf_Word *buf);
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
>  
>  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 6bc00cc390b5..61a8ea3b23a2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -323,24 +323,6 @@ int __init parse_crashkernel(char *cmdline,
>  	return 0;
>  }
>  
> -int __init parse_crashkernel_high(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_HIGH]);
> -}
> -
> -int __init parse_crashkernel_low(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_LOW]);
> -}
> -
>  /*
>   * Add a dummy early_param handler to mark crashkernel= as a known command line
>   * parameter and suppress incorrect warnings in init/main.c.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
