Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihc5K-00066J-GB
 for kexec@lists.infradead.org; Wed, 18 Dec 2019 16:22:05 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIGAVdQ143104
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 16:21:54 GMT
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2wvqpqenqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 16:21:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIGARH5183372
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 16:21:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2wyp4x4bff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 16:21:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBIGLq40006597
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 16:21:52 GMT
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
From: John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <8ec4943b-5a6d-2291-3adf-099d7a9c943d@Oracle.com>
Date: Wed, 18 Dec 2019 10:21:50 -0600
MIME-Version: 1.0
In-Reply-To: <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: John Donnelly <john.p.donnelly@Oracle.com>

On 12/17/19 8:07 PM, Chen Zhou wrote:

Hi
  See inline below

> Hi all,
> 
> Friendly ping...
> 
> On 2019/8/30 15:11, Chen Zhou wrote:
>> I am busy with other things, so it was a long time before this version was
>> released.
>>
>> This patch series enable reserving crashkernel above 4G in arm64.
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
>> when there is no enough low memory.
>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
>> in this case, if swiotlb or DMA buffers are requierd, crash dump kernel
>> will boot failure because there is no low memory available for allocation.
>>
>> To solve these issues, introduce crashkernel=X,low to reserve specified
>> size low memory.
>> Crashkernel=X tries to reserve memory for the crash dump kernel under
>> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
>> size low memory for crash kdump kernel devices firstly and then reserve
>> memory above 4G.
>>
>> When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
>> is specified simultaneously, kernel should reserve specified size low memory
>> for crash dump kernel devices. So there may be two crash kernel regions, one
>> is below 4G, the other is above 4G.
>> In order to distinct from the high region and make no effect to the use of
>> kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low region.




Hi ,

I have  found that 5.4 Arm kernels can safely use 768M crashkernel size 
for " standard" crash dumps that write a minimal vmcore to local 
storage. While "standard"  may vary,  I say that is default out of box 
delivery.

If you a introduce more elaborate setup that use networking and NFS, a 
larger crashkernel is needed, and since 1024MB size is not available,  I 
found using the 1st available range  above 4GB on node-0 works:



  Set the crash dump to be in the   1st 35G region on node-0  after 4G :
  .
  [    0.000000] Movable zone start for each node
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
  [    0.000000]   node   0: [mem 0x0000000092000000-0x00000000928bffff]
  [    0.000000]   node   0: [mem 0x00000000928c0000-0x00000000fff9ffff]
  [    0.000000]   node   0: [mem 0x00000000fffa0000-0x00000000ffffffff]
  [    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
  [    0.000000]   node   0: [mem 0x0000008800000000-0x000000bff702ffff].

  0x0000008800000000 is the  1st  region @35G


crashkernel=2048M@35G


yields :



  [    0.000000] crashkernel reserved: 0x00000008c0000000- 
0x0000000940000000  @ (2048 MB)

Now we have very large Arm server class systems with GB of memory so 2GB 
crashkernel is not much of an impact

No modifications are needed.

I submitted a RFC awhile back to add crashkernel=auto upstream that 
hasn't been reviewed yet that could be used to set various Arm crash 
sizes like x86 does.



>>
>> Besides, we need to modify kexec-tools:
>> arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])
>>
>> The previous changes and discussions can be retrieved from:
>>
>> Changes since [v5]
>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>> - Delete crashkernel=X,high.
>> - Modify crashkernel=X,low.
>> If crashkernel=X,low is specified simultaneously, reserve spcified size low
>> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
>> pass to crash dump kernel by DT property "linux,low-memory-range".
>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>
>> Changes since [v4]
>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>
>> Changes since [v3]
>> - Add memblock_cap_memory_ranges back for multiple ranges.
>> - Fix some compiling warnings.
>>
>> Changes since [v2]
>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>> patch.
>>
>> Changes since [v1]:
>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>> in fdt_enforce_memory_region().
>> There are at most two crash kernel regions, for two crash kernel regions
>> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>> and then remove the memory range in the middle.
>>
>> [1]: https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_kexec_2019-2DAugust_023569.html&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=9tn9kUBabiuYhVtXauANSDGaISnCnHLYcAUQgsPBFxs&e=
>> [v1]: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_4_2_1174&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=F-lM7II2cuMF_sK3b6-QhSbWM3X-pI_WZEs0sZitS7A&e=
>> [v2]: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_4_9_86&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=5Y-S6sqMTklHkOQsNtjTX3C7pV05BjKLGhJVfMHEvDs&e=
>> [v3]: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_4_9_306&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=cWn4zSRQupaZ3jjz4eDvD-pNkoLyL_hsZoRx4yJoD0c&e=
>> [v4]: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_4_15_273&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=Nslk4RJKIyIuT0IoQoolXNjupEDXplPhQQwnTSoXNWE&e=
>> [v5]: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_5_6_1360&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=HJVAM6sCxV2DnNg5d4pw8WPqtkmQnKvztEmkSIgtQ5M&e=
>>
>> Chen Zhou (4):
>>    x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>    arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>    arm64: kdump: add memory for devices by DT property, low-memory-range
>>    kdump: update Documentation about crashkernel on arm64
>>
>>   Documentation/admin-guide/kdump/kdump.rst       | 13 ++++-
>>   Documentation/admin-guide/kernel-parameters.txt | 12 ++++-
>>   arch/arm64/include/asm/kexec.h                  |  3 ++
>>   arch/arm64/kernel/setup.c                       |  8 ++-
>>   arch/arm64/mm/init.c                            | 61 +++++++++++++++++++++--
>>   arch/x86/include/asm/kexec.h                    |  3 ++
>>   arch/x86/kernel/setup.c                         | 65 +++----------------------
>>   include/linux/crash_core.h                      |  4 ++
>>   include/linux/kexec.h                           |  1 -
>>   kernel/crash_core.c                             | 65 +++++++++++++++++++++++++
>>   10 files changed, 168 insertions(+), 67 deletions(-)
>>
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_kexec&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=ZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=XMcFx61B_QPg-FUfG_-t88DKCnGm4grqu6zRguiHYrU&e=
> 


-- 
Thank You,
John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
