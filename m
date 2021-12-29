Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com> <Ycs3kpZD/vpoo1AX@zn.tnic>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
Date: Wed, 29 Dec 2021 10:27:36 +0800
MIME-Version: 1.0
In-Reply-To: <Ycs3kpZD/vpoo1AX@zn.tnic>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>



On 2021/12/29 0:13, Borislav Petkov wrote:
> On Tue, Dec 28, 2021 at 09:26:01PM +0800, Zhen Lei wrote:
>> Use parse_crashkernel_high_low() to bring the parsing of
>> "crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
>> are strongly dependent, make code logic clear and more readable.
>>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
> 
> Yeah, doesn't look like something I suggested...
> 
>> @@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
>>  	/* crashkernel=XM */
>>  	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>>  	if (ret != 0 || crash_size <= 0) {
>> -		/* crashkernel=X,high */
>> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
>> -					     &crash_size, &crash_base);
>> -		if (ret != 0 || crash_size <= 0)
>> +		/* crashkernel=X,high and possible crashkernel=Y,low */
>> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> 
> So this calls parse_crashkernel() and when that one fails, it calls this
> new weird parse high/low helper you added.
> 
> But then all three end up in the same __parse_crashkernel() worker
> function which seems to do the actual parsing.
> 
> What I suggested and what would be real clean is if the arches would
> simply call a *single* 
> 
> 	parse_crashkernel()
> 
> function and when that one returns, *all* crashkernel= options would
> have been parsed properly, low, high, middle crashkernel, whatever...
> and the caller would know what crash kernel needs to be allocated.
> 
> Then each arch can do its memory allocations and checks based on that
> parsed data and decide to allocate or bail.

However, only x86 currently supports "crashkernel=X,high" and "crashkernel=Y,low", and arm64
will also support it. It is not supported on other architectures. So changing parse_crashkernel()
is not appropriate unless a new function is introduced. But naming this new function isn't easy,
and the name parse_crashkernel_in_order() that I've named before doesn't seem to be good.
Of course, we can also consider changing parse_crashkernel() to another name, then use
parse_crashkernel() to parse all possible "crashkernel=" options in order, but this will cause
other architectures to change as well.

> 
> So it is getting there but it needs more surgery...
> 
> Thx.
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
