Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v14 02/11] x86: kdump: make the lower bound of crash
 kernel reservation consistent
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-3-chenzhou10@huawei.com>
 <20210224143547.GB28965@arm.com> <20210225070717.GG3553@MiWiFi-R3L-srv>
 <20210225144237.GA23418@arm.com> <20210225154446.GI3553@MiWiFi-R3L-srv>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <d844360b-35c4-d9e8-12c2-2e6bac9ad911@huawei.com>
Date: Fri, 26 Feb 2021 15:32:43 +0800
MIME-Version: 1.0
In-Reply-To: <20210225154446.GI3553@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, John.P.donnelly@oracle.com, wangkefeng.wang@huawei.com, arnd@arndb.de, horms@verge.net.au, corbet@lwn.net, dyoung@redhat.com, xiexiuqi@huawei.com, guohanjun@huawei.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, rppt@kernel.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, kexec@lists.infradead.org, nsaenzjulienne@suse.de



On 2021/2/25 23:44, Baoquan He wrote:
> On 02/25/21 at 02:42pm, Catalin Marinas wrote:
>> On Thu, Feb 25, 2021 at 03:08:46PM +0800, Baoquan He wrote:
>>> On 02/24/21 at 02:35pm, Catalin Marinas wrote:
>>>> On Sat, Jan 30, 2021 at 03:10:16PM +0800, Chen Zhou wrote:
>>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>>> index da769845597d..27470479e4a3 100644
>>>>> --- a/arch/x86/kernel/setup.c
>>>>> +++ b/arch/x86/kernel/setup.c
>>>>> @@ -439,7 +439,8 @@ static int __init reserve_crashkernel_low(void)
>>>>>  			return 0;
>>>>>  	}
>>>>>  
>>>>> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
>>>>> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
>>>>> +			CRASH_ADDR_LOW_MAX);
>>>>>  	if (!low_base) {
>>>>>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>>>>>  		       (unsigned long)(low_size >> 20));
>>>> Is there any reason why the lower bound can't be 0 in all low cases
>>>> here? (Sorry if it's been already discussed, I lost track)
>>> Seems like a good question.
>>>
>>> This reserve_crashkernel_low(), paired with reserve_crashkernel_high(), is
>>> used to reserve memory under 4G so that kdump kernel owns memory for dma
>>> buffer allocation. In that case, kernel usually is loaded in high
>>> memory. In x86_64, kernel loading need be aligned to 16M because of
>>> CONFIG_PHYSICAL_START, please see commit 32105f7fd8faa7b ("x86: find
>>> offset for crashkernel reservation automatically"). But for crashkernel
>>> low memory, there seems to be no reason to ask for 16M alignment, if
>>> it's taken as dma buffer memory.
>>>
>>> So we can make a different alignment for low memory only, e.g 2M. But
>>> 16M alignment consistent with crashkernel,high is also fine to me. The
>>> only affect is smaller alignment can increase the possibility of
>>> crashkernel low reservation.
>> I don't mind the 16M alignment in both low and high base. But is there
>> any reason that the lower bound (third argument) cannot be 0 in both
>> reserve_crashkernel() (the low attempt) and reserve_crashkernel_low()
>> cases? The comment in reserve_crashkernel() only talks about the 4G
>> upper bound but not why we need a 16M lower bound.
> Ah, sorry, I must have mixed this one with the alignment of fixed
> memory region reservation in patch 1 when considering comments.
>
> Hmm, in x86 we always have memory reserved in low 1M, lower bound
> being 0 or 16M (kernel alignment) doesn't make difference on crashkernel
> low reservation. But for crashkernel reservation, the reason should be
> kernel loading alignment being 16M, please see commit 32105f7fd8faa7b
> ("x86: find offset for crashkernel reservation automatically").
Sorry, i didn't mention in the commit message about this.

We discussed about this and the CRASH_ALIGN sounds better, so just use CRASH_ALIGN.
https://lkml.org/lkml/2020/9/4/82

Thanks,
Chen Zhou
>
> So, for crashkernel low, keeping lower bound as 0 looks good to me, the
> only reason is just as patch log tells. And it can skip the unnecessary
> memblock searching under 16M since it will always fail, even though it
> won't matter much. Or changing it to CRASH_ALIGN as this patch is doing,
> and adding code comment, is also fine to me.
>
> Thanks
> Baoquan
>
> .
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
