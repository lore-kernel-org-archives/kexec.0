From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
Date: Fri, 7 Jan 2022 16:13:00 +0800
Subject: [PATCH v18 02/17] x86/setup: Move xen_pv_domain() check and
 insert_resource() to setup_arch()
In-Reply-To: <5d8aed79-b20f-2575-3c3f-8945d8cbac3f@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-3-thunder.leizhen@huawei.com> <YcSxLodOnxXHx0sV@zn.tnic>
 <d6226aa2-f1f2-24cc-c9d2-9762bd615686@huawei.com>
 <5d8aed79-b20f-2575-3c3f-8945d8cbac3f@huawei.com>
Message-ID: <7e7c8d93-e745-2bfd-b93d-aecb3b70bf33@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2021/12/25 9:53, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/24 14:36, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/12/24 1:26, Borislav Petkov wrote:
>>> On Wed, Dec 22, 2021 at 09:08:05PM +0800, Zhen Lei wrote:
>>>> From: Chen Zhou <chenzhou10@huawei.com>
>>>>
>>>> We will make the functions reserve_crashkernel() as generic, the
>>>> xen_pv_domain() check in reserve_crashkernel() is relevant only to
>>>> x86,
>>>
>>> Why is that so? Is Xen-PV x86-only?
>>>
>>>> the same as insert_resource() in reserve_crashkernel[_low]().
>>>
>>> Why?
>>>
>>> Looking at
>>>
>>>   0212f9159694 ("x86: Add Crash kernel low reservation")
>>>
>>> it *surprisingly* explains why that resources thing is being added:
>>>
>>>     We need to add another range in /proc/iomem like "Crash kernel low",
>>>     so kexec-tools could find that info and append to kdump kernel
>>>     command line.
>>>
>>> Then,
>>>
>>>   157752d84f5d ("kexec: use Crash kernel for Crash kernel low")
>>>
>>> renamed it because, as it states, kexec-tools was taught to handle
>>> multiple resources of the same name.
>>>
>>> So why does kexec-tools on arm *not* need those iomem resources? How
>>> does it parse the ranges there? Questions over questions...

Hi Borislav:
  The reason why insert_resource() cannot be used in reserve_crashkernel[_low]()
on arm64 is clear. The parent resource node of crashk[_low]_res is added by
request_resource() in request_standard_resources(), so that it will be conflicted.
All request_resource() in request_standard_resources() should be changed to
insert_resource(), to make insert_resource() can be used in reserve_crashkernel[_low]().

  I found commit e25e6e7593ca ("kdump, x86: Process multiple Crash kernel in /proc/iomem")
in kexec-tools. I'm trying to port it to arm64, or make it generic.

  Thanks.

> 
> It's a good question worth figuring out. I'm going to dig into this.
> I admire your rigorous style and sharp vision.
> 


-- 
Regards,
  Zhen Lei

