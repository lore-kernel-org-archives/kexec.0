Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
 <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
From: James Morse <james.morse@arm.com>
Message-ID: <72a9c52b-1b24-57e8-e29f-b5a53524744b@arm.com>
Date: Thu, 13 Jun 2019 13:43:16 +0100
MIME-Version: 1.0
In-Reply-To: <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
Content-Language: en-GB
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, akpm@linux-foundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

Hi Chen Zhou,

On 13/06/2019 12:27, Chen Zhou wrote:
> On 2019/6/6 0:32, James Morse wrote:
>> On 07/05/2019 04:50, Chen Zhou wrote:
>>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>>> are requierd, capture kernel will boot failure because of no low memory.
>>
>>> When crashkernel is reserved above 4G in memory, kernel should reserve
>>> some amount of low memory for swiotlb and some DMA buffers. So there may
>>> be two crash kernel regions, one is below 4G, the other is above 4G.
>>
>> This is a good argument for supporting the 'crashkernel=...,low' version.
>> What is the 'crashkernel=...,high' version for?
>>
>> Wouldn't it be simpler to relax the ARCH_LOW_ADDRESS_LIMIT if we see 'crashkernel=...,low'
>> in the kernel cmdline?
>>
>> I don't see what the 'crashkernel=...,high' variant is giving us, it just complicates the
>> flow of reserve_crashkernel().
>>
>> If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel() we could
>> use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
>> memblock_end_of_DRAM().
>> I think this is a simpler change that gives you what you want.
> 
> According to your suggestions, we should do like this:
> 1. call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
> 2. mark the low region as 'nomap'
> 3. use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
> memblock_end_of_DRAM()
> 4. rename crashk_low_res as "Crash kernel (low)" for arm64

> 5. add an 'linux,low-memory-range' node in DT

(This bit would happen in kexec-tools)


> Do i understand correctly?

Yes, I think this is simpler and still gives you what you want.
It also leaves the existing behaviour unchanged, which helps with keeping compatibility
with existing user-space and older kdump kernels.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
