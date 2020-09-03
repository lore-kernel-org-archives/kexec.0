Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-4-chenzhou10@huawei.com> <20200902170910.GB16673@gaia>
 <f33a0ce6-552e-2f1a-e720-4f7124f15d1e@huawei.com>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <779fd86d-4d1a-c2ac-ffc8-79f05526a00c@huawei.com>
Date: Thu, 3 Sep 2020 21:18:51 +0800
MIME-Version: 1.0
In-Reply-To: <f33a0ce6-552e-2f1a-e720-4f7124f15d1e@huawei.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de



On 2020/9/3 19:26, chenzhou wrote:
> Hi Catalin,
>
>
> On 2020/9/3 1:09, Catalin Marinas wrote:
>> On Sat, Aug 01, 2020 at 09:08:54PM +0800, Chen Zhou wrote:
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>>> will fail when there is no enough low memory.
>>> 2. If reserving crashkernel above 4G, in this case, crash dump
>>> kernel will boot failure because there is no low memory available
>>> for allocation.
>>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
>>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>>> fail.
>>>
>>> To solve these issues, change the behavior of crashkernel=X.
>>> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
>>> high allocation if it fails.
>>>
>>> If requized size X is too large and leads to very little free memory
>>> in ZONE_DMA after low allocation, the system may not work normally.
>>> So add a threshold and go for high allocation directly if the required
>>> size is too large. The value of threshold is set as the half of
>>> the low memory.
>>>
>>> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
>>> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
>>> specified size low memory.
>> Except for the threshold to keep zone ZONE_DMA memory,
>> reserve_crashkernel() looks very close to the x86 version. Shall we try
>> to make this generic as well? In the first instance, you could avoid the
>> threshold check if it takes an explicit ",high" option.
> Ok, i will try to do this.
>
> I look into the function reserve_crashkernel() of x86 and found the start address is
> CRASH_ALIGN in function memblock_find_in_range(), which is different with arm64.
>
> I don't figure out why is CRASH_ALIGN in x86, is there any specific reason?
Besides, in function reserve_crashkernel_low() of x86, the start address is 0.

>
> Thanks,
> Chen Zhou
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
