Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v13 1/8] x86: kdump: replace the hard-coded alignment with
 macro CRASH_ALIGN
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-2-chenzhou10@huawei.com>
 <20201111013815.GC24747@MiWiFi-R3L-srv>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <a72cb0ba-91b9-0bd7-7f61-020ae9269d1a@huawei.com>
Date: Wed, 11 Nov 2020 21:26:02 +0800
MIME-Version: 1.0
In-Reply-To: <20201111013815.GC24747@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

Hi Baoquan,


On 2020/11/11 9:38, Baoquan He wrote:
> On 10/31/20 at 03:44pm, Chen Zhou wrote:
>> Move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded
>> alignment with macro CRASH_ALIGN in function reserve_crashkernel().
> Seems you tell what you have done in this patch, but don't like adding
> several more words to tell why it's done like that. Please see below
> inline comments.
>
> In other patches, I can also see this similar problem.
Thanks for your review. I will update relevant commit messages.
>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> ---
>>  arch/x86/include/asm/kexec.h | 3 +++
>>  arch/x86/kernel/setup.c      | 5 +----
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 6802c59e8252..8cf9d3fd31c7 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -18,6 +18,9 @@
>>  
>>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>>  
>> +/* 2M alignment for crash kernel regions */
>> +#define CRASH_ALIGN		SZ_16M
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/string.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 84f581c91db4..bf373422dc8a 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -395,9 +395,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> -/* 16M alignment for crash kernel regions */
>> -#define CRASH_ALIGN		SZ_16M
>> -
>>  /*
>>   * Keep the crash kernel below this limit.
>>   *
>> @@ -515,7 +512,7 @@ static void __init reserve_crashkernel(void)
>>  	} else {
>>  		unsigned long long start;
>>  
>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>  						  crash_base + crash_size);
> Here, SZ_1M is replaced with CRASH_ALIGN which is 16M. I remember I ever
> commented that this had better be told in patch log.
got it.

Thanks,
Chen Zhou
>
>>  		if (start != crash_base) {
>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> .
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
