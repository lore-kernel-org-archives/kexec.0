Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21E2C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/3eCoZjg7mu8R6Bq5pSmqZNIvQz/fiHmbLODIdsQAo=; b=DAE0UsAxIQje8NS3cHQPS4hfNZ
	nlL8sqwPamEo4aETstar8UL/SOyWghtY6ZHCWLhG487BIK67OaqcHv7qUjD4qCCqt2xXWNljtamqi
	oxAYZZSwVHcbV5AHeK4PlghWJIBWnsO6mY9ihW13MAP9nN4Na/c7YKEKaPhr0svo52ZQWTvFosoHk
	cEACuGALUD280JB01FyW5XVCss/05A+3mcTYCkEOz4ZOCwk4y5c5KJI7xvNj9cMPgANbA4RysfJdq
	gO3nPbgDNcCnjiR8uesSDzm0iuuP29gk8LkRhbJKJstX0pei2BExBXrbMk/nXlEi12tBRmj5JBFb0
	w+FY9FXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhk-0000000DvPs-0WwG;
	Fri, 07 Jun 2024 12:28:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhh-0000000DvO7-2qVX
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
	b=jLBoj+/i+CxUyGxtkgZj99hKUjhQGqTNSLM9nKIujnA/kspmvkSiMedz1YB+YRrNwI4Brp
	9TW0WloS52xusRvuMcAlRwo3R+yLwwtLRETrkxgOtXAQYIZ737d9vMu2epuch3B64PxDss
	rN8qE7KYVzFLGCVObzYfomsDq4xi9MM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-wi2ogzEEMsatid_bKoBGHw-1; Fri, 07 Jun 2024 08:28:19 -0400
X-MC-Unique: wi2ogzEEMsatid_bKoBGHw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6fb22ecd976so1413938b3a.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763298; x=1718368098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
        b=ecKMFnJ5WdlBj4+oTC9do9ZIXvo16dPdiSBTdqb8x3HXcupb1OgBcxCJhxeiUDD+uK
         Q8YMNj1UudQY57um4GNpCrP4dUnqwOlOM5R+tEX5DIULC1jzbtZdbi7WFdyiNNR7UVH8
         iCTzovQE4x2Dv+E1gcaHDRT2F0BEQ6ESS9/WK9ByuMNfP/fmNXn5YqDWpqaABKDjPQML
         nCeYyl8lpdpkXt9oBMLKuDdnXOgYENGwY3laBF+YiwoWC65/sLK1hcPO6dYSQLIFwPJw
         UWGA7+fNelsOZEu5y4DVgLVpiBCeaAkT32BOAM0bgUrsPhatD/ZfecvvU/OjVQP+7P9I
         MfrA==
X-Gm-Message-State: AOJu0Yxgs9mVt3GBYbeia4M0nbUAWhU0nkmR4wa4ycMUt9cKihUg+YW6
	8SHD13eOnncHR5GdUzFRmkItet9pz1jzKB7+9i3jPlq0zQ6fOnroIitwJJZMT5m2w3pb8taApmo
	BCu3s1dfU1XgwQRfUgu/F3j66AE0hMYaQplsjRuEII36fD3eKJx3X+ymIlw==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817550b3a.15.1717763297899;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqa9G1P1Nfp6M4MFxgwat4T28EeXX617ZqUou6xSlSloKgK/kupjGqVmTHU4L88C/jIn2KRQ==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817489b3a.15.1717763297022;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3a3a87sm2486990b3a.82.2024.06.07.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:16 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052821_863067_B0B404DE 
X-CRM114-Status: GOOD (  21.88  )
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

On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>>
>> User space can also read this API to learn about current state.
>
>From the subject, can I think the luks keys will persist forever? or
>only for a while? 

Yes, you are right. The keys need to stay in kdump reserved memory.

> If need and can only keep it for a while, can you
>mention it and tell why and how it will be used. Because you add a lot
>of codes, but only simply mention the sysfs, that doesn't make sense.

Thanks for raising the concern! I've added
Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
cover letter to this patch in v5. 

>
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |   5 +-
>>  kernel/Kconfig.kexec         |   8 +++
>>  kernel/Makefile              |   1 +
>>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  22 +++++++
>>  5 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 44305336314e..6bff1c24efa3 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>>  static inline void arch_kexec_unprotect_crashkres(void) { }
>>  #endif
[...]
>> +static int init(const char *buf)
>              ~~~~ A more interesting name with more description?

Thanks for the suggestion! I've added some comments for this function
in v5. But I can't come up with a better name after looking at current
kernel code. You are welcome to suggest any better name:)

>> +static int process_cmd(const char *buf, size_t count)
>                                                  ~~~~
>If nobody use the count, why do you add it?

Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
buffer overflow.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
