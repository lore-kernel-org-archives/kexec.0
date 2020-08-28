Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
 <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
 <20200819120301.GA13727@dhcp-128-65.nay.redhat.com>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <a2e6def1-f81a-d90d-e0a9-c7bdee6675a9@huawei.com>
Date: Fri, 28 Aug 2020 09:59:19 +0800
MIME-Version: 1.0
In-Reply-To: <20200819120301.GA13727@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, catalin.marinas@arm.com
Cc: John.P.donnelly@oracle.com, guohanjun@huawei.com, xiexiuqi@huawei.com, arnd@arndb.de, bhe@redhat.com, corbet@lwn.net, horms@verge.net.au, bhsharma@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, wangkefeng.wang@huawei.com, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, nsaenzjulienne@suse.de

Hi Catalin,


On 2020/8/19 20:03, Dave Young wrote:
> On 08/18/20 at 03:07pm, chenzhou wrote:
>>
>> On 2020/8/10 14:03, Dave Young wrote:
>>> Hi,
>>>
>>>>> Previously I remember we talked about to use similar logic as X86, but I
>>>>> remember you mentioned on some arm64 platform there could be no low
>>>>> memory at all.  Is this not a problem now for the fallback?  Just be
>>>>> curious, thanks for the update, for the common part looks good.
>>>> Hi Dave,
>>>>
>>>> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
>>> I meant about this reply instead :)
>>> https://lkml.org/lkml/2020/1/16/616
>> Hi Dave,
>>
>> Sorry for not repley in time, I was on holiday last week.
> Hi, no problem, thanks for following up.
>
>> The platform James mentioned may exist for which have no devices and need no low memory.
>> For our arm64 server platform, there are some devices and need low memory.
>>
>> I got it. For the platform with no low memory, reserving crashkernel will  always fail.
>> How about like this:
> I think the question should leave to Catalin or James, I have no
> suggestion about this:)
Any suggestions about this?

Thanks,
Chen Zhou
>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index a8e34d97a894..4df18c7ea438 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -147,7 +147,7 @@ static void __init reserve_crashkernel(void)
>>         }
>>         memblock_reserve(crash_base, crash_size);
>>  
>> -       if (crash_base >= CRASH_ADDR_LOW_MAX) {
>> +       if (memstart_addr < CRASH_ADDR_LOW_MAX && crash_base >= CRASH_ADDR_LOW_MAX) {
>>                 const char *rename = "Crash kernel (low)";
>>  
>>                 if (reserve_crashkernel_low()) {
>>
>>
>> Thanks,
>> Chen Zhou
>>
>>> Thanks
>>> Dave
>>>
>>>
>>> .
>>>
>>
>
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
