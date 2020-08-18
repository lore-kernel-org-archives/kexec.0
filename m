Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vRo-0007Tp-Hz
 for kexec@lists.infradead.org; Tue, 18 Aug 2020 06:50:17 +0000
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200817134224.GA8381@bug>
From: Sang Yan <sangyan@huawei.com>
Message-ID: <97b12762-cee1-67fd-2c6f-b0bfe1cf14fc@huawei.com>
Date: Tue, 18 Aug 2020 14:49:56 +0800
MIME-Version: 1.0
In-Reply-To: <20200817134224.GA8381@bug>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: luanjianhai@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, luchunhua@huawei.com, ebiederm@xmission.com, guohanjun@huawei.com, zhuling8@huawei.com


On 8/17/2020 9:42 PM, Pavel Machek wrote:
> Hi!
> 
>> +config QUICK_KEXEC
>> +	bool "Support for quick kexec"
>> +	depends on KEXEC_CORE
>> +	help
>> +	  Say y here to enable this feature.
> 
> ?
> 
>> +	  It use reserved memory to accelerate kexec, just like crash
> 
> uses
> 
>> +	  kexec, load new kernel and initrd to reserved memory, and
>> +	  boot new kernel on that memory. It will save the time of
>> +	  relocating kernel.
> 
> loads a new.... boots new... 
> 
>>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>>  	IORES_DESC_RESERVED			= 7,
>>  	IORES_DESC_SOFT_RESERVED		= 8,
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	IORES_DESC_QUICK_KEXEC			= 9,
>> +#endif
>>  };
> 
> Remove ifdef.
> 
>>  /*
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 9e93bef52968..976bf9631070 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -269,9 +269,12 @@ struct kimage {
>>  	unsigned long control_page;
>>  
>>  	/* Flags to indicate special processing */
>> -	unsigned int type : 1;
>> +	unsigned int type : 2;
>>  #define KEXEC_TYPE_DEFAULT 0
>>  #define KEXEC_TYPE_CRASH   1
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_TYPE_QUICK   2
>> +#endif
>>  	unsigned int preserve_context : 1;
> 
> Here, too.
> 
>> +++ b/include/uapi/linux/kexec.h
>> @@ -12,6 +12,9 @@
>>  /* kexec flags for different usage scenarios */
>>  #define KEXEC_ON_CRASH		0x00000001
>>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_QUICK		0x00000004
>> +#endif
>>  #define KEXEC_ARCH_MASK		0xffff0000
> 
> And here.
> 
> 									Pavel
> 
> .
> 

Thanks a lot for your review.

Sang Yan.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
