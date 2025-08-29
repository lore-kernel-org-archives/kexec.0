Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B6CA1005
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YMG2hjYDplEAn5LWv3MpjvQ+a5gZ6WKPCO72/I7KThc=; b=JV3xgya46XBmWd
	lMTVp4J7kl9y19l3heEdFYtqTyoE0xWrGvJVdg94AQBNvZsoqWLQEC3ibzd4nhfSLB39pSpl8N6+j
	08qGyJjVC2I0nTf9CzV+Rt1SYmESRIIj1gCfer+kdzzX7Zn/175PdvPnMXSHsKvRL324iCoiMgJwy
	vqSj8AUh5msrL51TBGJlC+C1YwNSbeFtInb7zwMi5XUXZUzbK4a2szYFVkgS7HHq6JZdouad6cx2u
	qouU2wktZc17mLht7vTRJSxh7cHNTi1glJoor6ZFwjouhciX5slZI+cqlOhLTde9eMY2PM4uOj9VR
	xQ8al7lwyvZRISTOhz7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPgC-00000008GAn-1FC7;
	Sat, 30 Aug 2025 17:47:56 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqte-00000004Luf-43Ct
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 04:39:32 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7720b23a49fso1918052b3a.0
        for <kexec@lists.infradead.org>; Thu, 28 Aug 2025 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756442370; x=1757047170; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMG2hjYDplEAn5LWv3MpjvQ+a5gZ6WKPCO72/I7KThc=;
        b=N2TIZCcFigva6e+g0F4XyUawTeHoig4hOHIjwM190ZjWlqH0GhreBSSJTJr9dxzFg2
         v4ArQW8n7OFzyWQHqO47RB8nBISdMVUtfAee/8+wRov9C4/Vt/1EN6Ul0lYBlqZi6g+e
         63WnRkJVNmpgAh+m7JsRKnkxh/zjV12fHy4wxIGZ2DI/ka/O9M7KJG5l37dXe40yRqpY
         mg7vOobHTbX92EzNDkoj4NhfJy0Bcb6chi0e1VNBqWrM1aRoZ27yltmcVXDoT/Bihaan
         RWzRu522FAgfG/m1i6m5e2YDuhXRss537LrbYEYjEnqas3VAgfrKC/CziEgNyxpCB9Aa
         upXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756442370; x=1757047170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMG2hjYDplEAn5LWv3MpjvQ+a5gZ6WKPCO72/I7KThc=;
        b=ppld0HrArC1qLbiDrynlDjhG9b/DaIW2Er2LHHdd1aOzDowsbXhTIuIRsPjBh2xUbv
         ybSuh2Xqpg73OT7OiJzjlt019zP3k8ohDaqQBzy6WbJ/8vl0XUivev+AIBQHEZCqIbNn
         NOMwAxYR7dCB76/cDuiLmWvB9rUsta8e2XvTN8qJIlreXx57TFs00n7n8snRlcyoIkn4
         bWabW02/6i7tC9s7G6bxu70xrLpXeYIiFDqJn5l8aL6buua2iX14C5IATAv+fWR1NO0o
         p/Skz29qIMj7epfX1/Llk0j6kwTCZbEPWlhKfLxsmFT6MV1cmRsEm0zs9F1jnRcyy90d
         GwHw==
X-Forwarded-Encrypted: i=1; AJvYcCVSahf0ZstApMxB4axVU0SlNqN7xNPDHXu+MNOZlYKANWY7aGGQb3yKb/2sK2fLQUCDJBKV+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxGnr5ZfkLaXdHt+2czpijd14m7yRh6txpD08q69LzGSxje5/E9
	1NB/G5EV1OdQZuNqzV42N2T+xJ4Lw+5QdhF+njlxyYmIS/SHUlSFsMKY
X-Gm-Gg: ASbGncusXkPTE/Il7Q5HX9Cqjg7/x3nXpDWeptk0o26T8piORRCg6hs8AhYPNCa/KKe
	jqbYWS1pfF6Ioq6YKPz+G+h67Ct0F4F5CTxA6E2gB7zvy6urOUV9y+OALsa4IuinFNeZicEnFGE
	NMf7NzMLaGzvWGlVYdUpEy2r/vhOMbq5sq4cuaWf45wiqoqRiBluLtIf0XQ1dln0CkdeGgJPQJ5
	i2hVwQyx4aPotkKPaPFjHP2Dw4wTRxMq6OF/6tWK29UHFlaYHz+4Da4CbNywMwPG3Gi3Ql58gs6
	0RWvYq+C9FLTZTdCR3ysRvwXnInntd0esUGErbJJQjDErFnhIivCtAShJ7lSQ0vdqyXgO4IPQTz
	LY0nPeCcjnyV6zA1et/RR3P+uyFM21pBdYtQtFSTmgLAEklo=
X-Google-Smtp-Source: AGHT+IGJUc7Yk+JHWAKY9iaRV2EhpE+ow/DVQcP8YQgFsIIxjRV2hvCIR3RWEDtRtL041w/+SYnwCQ==
X-Received: by 2002:a05:6a00:bd92:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-7702f9df039mr32683745b3a.4.1756442369806;
        Thu, 28 Aug 2025 21:39:29 -0700 (PDT)
Received: from [127.0.0.1] ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm1070875b3a.19.2025.08.28.21.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 21:39:29 -0700 (PDT)
Message-ID: <58e87116-a8af-4c8f-b5b4-3d0540cd3333@gmail.com>
Date: Fri, 29 Aug 2025 12:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] crash_core: use panic_try_start() in crash_kexec()
To: Qianqiang Liu <qianqiang.liu@163.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-4-wangjinchao600@gmail.com>
 <aLEQy-srX89Rndch@debian.debian.local>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aLEQy-srX89Rndch@debian.debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_213931_027455_17C0C5EC 
X-CRM114-Status: GOOD (  19.75  )
X-Mailman-Approved-At: Sat, 30 Aug 2025 10:29:56 -0700
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
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <kees@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, Yicong Yang <yangyicong@hisilicon.com>, linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Max Kellermann <max.kellermann@ionos.com>, John Ogness <john.ogness@linutronix.de>, Baoquan He <bhe@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>, Joel Granados <joel.granados@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Petr Mladek <pmladek@suse.com>, Zsolt Kajtar <soci@c64.rulez.org>, Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, dri-devel@lists.freedesktop.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Luo Gengkun <luogengkun@huaweicloud.com>, Feng Tang <feng.tang@linux.alibaba.com>, Shixiong Ou <oushixiong@kylinos.cn>, Anna Schumaker <anna.schumaker@oracle.com>, Tony Luck <tony.luck@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, kexec@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Li Huafei <lihuafei1@huawei.com>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 8/29/25 10:30, Qianqiang Liu wrote:
> On Mon, Aug 25, 2025 at 10:29:31AM +0800, Jinchao Wang wrote:
>> crash_kexec() had its own code to exclude parallel execution by setting
>> panic_cpu. This is already handled by panic_try_start(). Switch to
>> panic_try_start() to remove the duplication and keep the logic consistent.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   kernel/crash_core.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index a4ef79591eb2..bb38bbaf3a26 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>>    */
>>   
>> +#include "linux/panic.h"
> 
> Can you change this line of code to #include <linux/panic.h>?
Yes, I will.
Thanks for the feedback.>
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>>   #include <linux/buildid.h>
>> @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
>>   
>>   __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>>   {
>> -	int old_cpu, this_cpu;
>> -
>> -	/*
>> -	 * Only one CPU is allowed to execute the crash_kexec() code as with
>> -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
>> -	 * may stop each other.  To exclude them, we use panic_cpu here too.
>> -	 */
>> -	old_cpu = PANIC_CPU_INVALID;
>> -	this_cpu = raw_smp_processor_id();
>> -
>> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
>> +	if (panic_try_start()) {
>>   		/* This is the 1st CPU which comes here, so go ahead. */
>>   		__crash_kexec(regs);
>>   
>> @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>>   		 * Reset panic_cpu to allow another panic()/crash_kexec()
>>   		 * call.
>>   		 */
>> -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
>> +		panic_reset();
>>   	}
>>   }
>>   
>> -- 
>> 2.43.0
> 


-- 
Best regards,
Jinchao

