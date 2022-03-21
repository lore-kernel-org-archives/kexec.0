From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 21 Mar 2022 09:09:19 -0500
Subject: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
Message-ID: <d938a7e8-6b4f-f24d-41d3-8058ca2b2ac8@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 3/21/22 8:29AM, John Donnelly wrote:
> On 2/26/22 9:07 PM, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
> 
>  ??????????????????????? " Not enough "
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
> 
>  ?We can't have a "boot failure". If the requested reservation
>  ?can not be met,? the kdump? configuration is not setup.

I think you misread this. Without these patches, if only high memory is 
reserved for the crash kernel, then the crash kernel will fail to boot.

>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Is there going to be documentation on what values certain Arm platforms 
> are going to use this on ?
> 
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

