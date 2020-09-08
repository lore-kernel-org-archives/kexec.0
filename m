Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 1/9] x86: kdump: move CRASH_ALIGN to 2M
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-2-chenzhou10@huawei.com>
 <20200908012138.GA3058@dhcp-128-65.nay.redhat.com>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <c0fc35d0-a9e3-6349-08bc-d2f7a12e3680@huawei.com>
Date: Tue, 8 Sep 2020 11:19:42 +0800
MIME-Version: 1.0
In-Reply-To: <20200908012138.GA3058@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de



On 2020/9/8 9:21, Dave Young wrote:
> Hi,
>
> On 09/07/20 at 09:47pm, Chen Zhou wrote:
>> CONFIG_PHYSICAL_ALIGN can be selected from 2M to 16M and default
>> value is 2M, so move CRASH_ALIGN to 2M, with smaller value reservation
>> can have more chance to succeed.
> Seems still some misunderstanding about the change :(  I'm sorry if I
> did not explain it clearly.
>
> Previously I missed the PHYSICAL_ALIGN can change according to .config
> I mean we should change the value to CONFIG_PHYSICAL_ALIGN for X86
> And I suggest to move back to keep using 16M.  And do not change it in
> this series.
Hi Dave,

Sorry, i misunderstood about this.

Ok, this patch will keep the value of CRASH_ALIGN as it is,
just move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded alignment
with macro CRASH_ALIGN in function reserve_crashkernel().

Thanks,
Chen Zhou
>
>> And replace the hard-coded alignment with macro CRASH_ALIGN in function
>> reserve_crashkernel().
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/include/asm/kexec.h | 3 +++
>>  arch/x86/kernel/setup.c      | 5 +----
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 6802c59e8252..83f200dd54a1 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -18,6 +18,9 @@
>>  
>>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>>  
>> +/* 2M alignment for crash kernel regions */
>> +#define CRASH_ALIGN		SZ_2M
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/string.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 3511736fbc74..296294ad0dd8 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -402,9 +402,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> -/* 16M alignment for crash kernel regions */
>> -#define CRASH_ALIGN		SZ_16M
>> -
>>  /*
>>   * Keep the crash kernel below this limit.
>>   *
>> @@ -530,7 +527,7 @@ static void __init reserve_crashkernel(void)
>>  
>>  		start = memblock_find_in_range(crash_base,
>>  					       crash_base + crash_size,
>> -					       crash_size, 1 << 20);
>> +					       crash_size, CRASH_ALIGN);
>>  		if (start != crash_base) {
>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>>  			return;
>> -- 
>> 2.20.1
>>
> Thanks
> Dave
>
>
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
