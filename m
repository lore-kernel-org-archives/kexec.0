Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com> <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com> <YbseAX6X1VHUF12f@zn.tnic>
 <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
Message-ID: <20d765ff-59bb-7bb3-df06-9f02eada3cb0@huawei.com>
Date: Thu, 16 Dec 2021 20:23:31 +0800
MIME-Version: 1.0
In-Reply-To: <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>



On 2021/12/16 20:08, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/16 19:07, Borislav Petkov wrote:
>> On Thu, Dec 16, 2021 at 10:46:12AM +0800, Leizhen (ThunderTown) wrote:
>>> The original value (1ULL << 32) is inaccurate
>>
>> I keep asking *why*?
>>
>>> and it enlarged the CRASH_ADDR_LOW upper limit.
>>
>> $ git grep -E "CRASH_ADDR_LOW\W"
>> $
>>
>> I have no clue what you mean here.
> 
> #ifdef CONFIG_X86_32
> # define CRASH_ADDR_LOW_MAX     SZ_512M
> # define CRASH_ADDR_HIGH_MAX    SZ_512M
> #endif
> 
> 		if (!high)
> (1)                     crash_base = memblock_phys_alloc_range(crash_size,
>                                                 CRASH_ALIGN, CRASH_ALIGN,
>                                                 CRASH_ADDR_LOW_MAX);
>                 if (!crash_base)
> (2)                     crash_base = memblock_phys_alloc_range(crash_size,
>                                                 CRASH_ALIGN, CRASH_ALIGN,
>                                                 CRASH_ADDR_HIGH_MAX);
> 
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low())
> +(3)	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low())
> 
> If the memory of 'crash_base' is successfully allocated at (1), because the last
> parameter CRASH_ADDR_LOW_MAX is the upper bound, so we can sure that
> "crash_base < CRASH_ADDR_LOW_MAX". So that, reserve_crashkernel_low() will not be
> invoked at (3). That's why I said (1ULL << 32) is inaccurate and enlarge the CRASH_ADDR_LOW
> upper limit.
> 
> If the memory of 'crash_base' is successfully allocated at (2), you see,
> CRASH_ADDR_HIGH_MAX = CRASH_ADDR_LOW_MAX = SZ_512M, the same as (1). In fact,
> "crashkernel=high," may not be recommended on X86_32.
> 
> Is it possible that (CRASH_ADDR_HIGH_MAX >= 4G) and (CRASH_ADDR_LOW_MAX < 4G)?
> In this case, the memory allocated at (2) maybe over 4G. But why shouldn't
> CRASH_ADDR_LOW_MAX be equal to 4G at this point?

We divide two memory areas: low memory area and high memory area. The doc told us:
at least 256MB memory should be reserved at low memory area. So that if
"crash_base >= CRASH_ADDR_LOW_MAX" is true at (3), that means we have not reserved
any memory at low memory area, so we should call reserve_crashkernel_low().
The low memory area is not equivalent to <=4G, I think. So replace (1ULL << 32) with
CRASH_ADDR_LOW_MAX is logically correct.

> 
> 
>>
>>> This is because when the memory is allocated from the low end, the
>>> address cannot exceed CRASH_ADDR_LOW_MAX, see "if (!high)" branch.
>>
>>> If
>>> the memory is allocated from the high end, 'crash_base' is greater than or
>>> equal to (1ULL << 32), and naturally, it is greater than CRASH_ADDR_LOW_MAX.
>>>
>>> I think I should update the description, thanks.
>>
>> I think you should explain why is (1ULL << 32) wrong.
>>
>> It came from:
>>
>>   eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")
>>
>> which simply frees the high memory portion when the low reservation
>> fails. And the test for that is, is crash base > 4G. So that makes
>> perfect sense to me.
>>
>> So your change is a NOP on 64-bit and it is a NOP on 32-bit by virtue of
>> the _low() variant always returning 0 on 32-bit.
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
