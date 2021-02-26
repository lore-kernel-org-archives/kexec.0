Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com> <20210225072426.GH3553@MiWiFi-R3L-srv>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
Date: Fri, 26 Feb 2021 14:45:25 +0800
MIME-Version: 1.0
In-Reply-To: <20210225072426.GH3553@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, ebiederm@xmission.com
Cc: linux-arm-kernel@lists.infradead.org, John.P.donnelly@oracle.com, wangkefeng.wang@huawei.com, arnd@arndb.de, horms@verge.net.au, corbet@lwn.net, dyoung@redhat.com, xiexiuqi@huawei.com, guohanjun@huawei.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, rppt@kernel.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, tglx@linutronix.de, will@kernel.org, kexec@lists.infradead.org, nsaenzjulienne@suse.de



On 2021/2/25 15:25, Baoquan He wrote:
> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
>>> function reserve_crashkernel() also used 1M alignment. So just
>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
>> [...]
>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>>>  	} else {
>>>  		unsigned long long start;
>>>  
>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>>  						  crash_base + crash_size);
>>>  		if (start != crash_base) {
>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>> There is a small functional change here for x86. Prior to this patch,
>> crash_base passed by the user on the command line is allowed to be 1MB
>> aligned. With this patch, such reservation will fail.
>>
>> Is the current behaviour a bug in the current x86 code or it does allow
>> 1MB-aligned reservations?
> Hmm, you are right. Here we should keep 1MB alignment as is because
> users specify the address and size, their intention should be respected.
> The 1MB alignment for fixed memory region reservation was introduced in
> below commit, but it doesn't tell what is Eric's request at that time, I
> guess it meant respecting users' specifying.
I think we could make the alignment unified. Why is the alignment system reserved and
user specified different? Besides, there is no document about the 1MB alignment.
How about adding the alignment size(16MB) in doc  if user specified  start address as arm64 does.

Thanks,
Chen Zhou
>
> commit 44280733e71ad15377735b42d8538c109c94d7e3
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Sun Nov 22 17:18:49 2009 -0800
>
>     x86: Change crash kernel to reserve via reserve_early()
>     
>     use find_e820_area()/reserve_early() instead.
>     
>     -v2: address Eric's request, to restore original semantics.
>          will fail, if the provided address can not be used.
>
> .
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
