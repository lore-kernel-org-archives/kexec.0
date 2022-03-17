From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
Date: Thu, 17 Mar 2022 11:23:13 +0800
Subject: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
In-Reply-To: <YjKfLo4YgSBG8v61@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <YjKfLo4YgSBG8v61@MiWiFi-R3L-srv>
Message-ID: <d5f61c51-9f5a-b39c-6e15-1a5e56701516@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2022/3/17 10:38, Baoquan He wrote:
> On 02/27/22 at 11:07am, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>               ~~ change it to "get boot failure" or "fail to boot"

OK. I'm going to use "fail to boot".

>> for allocation.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> .
> 

-- 
Regards,
  Zhen Lei

