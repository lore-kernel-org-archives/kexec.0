Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
 <11E080AF-28F1-481A-BF16-9C062091D900@oracle.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <94c4540b-6467-002f-6cfc-bacc4ac45d24@huawei.com>
Date: Thu, 19 Dec 2019 10:56:25 +0800
MIME-Version: 1.0
In-Reply-To: <11E080AF-28F1-481A-BF16-9C062091D900@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: horms@verge.net.au, will@kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, guohanjun@huawei.com, tglx@linutronix.de, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Hi John,

On 2019/12/19 1:18, John Donnelly wrote:
> HI =

> =

> SEE INLINE ON A QUESTION :
> =

>> On Dec 17, 2019, at 8:07 PM, Chen Zhou <chenzhou10@huawei.com> wrote:
>>
>> Hi all,
>>
>> Friendly ping...
>>
>> On 2019/8/30 15:11, Chen Zhou wrote:
>>> I am busy with other things, so it was a long time before this version =
was
>>> released.
>>>
>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which will f=
ail
>>> when there is no enough low memory.
>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel abov=
e 4G,
>>> in this case, if swiotlb or DMA buffers are requierd, crash dump kernel
>>> will boot failure because there is no low memory available for allocati=
on.
> =

>   =

>       Can you elaborate when the boot failures may fail due to lacking  s=
wiotlb or DMA buffers ? Are these related to certain adapters or specific  =
platforms  ? =

> =

>      I have not seen this when using   crashkernel=3D2024M@35GB . =

> =


For example, in my environment "Huawei TaiShan 2280",
we need to use mpt3sas driver in crash dump kernel for dumping vmcore.

mpt3sas driver needs to call dma_pool_alloc to allocate some pages,
if there is no DMA buffer, page allocation will fail, which leads to crash =
dump kernel boot failure,
like this:

[2019/12/19 9:12:41] [   12.403501] mpt3sas_cm0: diag reset: SUCCESS
[2019/12/19 9:12:41] [   12.456076] mpt3sas_cm0: reply_post_free pool: dma_=
pool_alloc failed
[2019/12/19 9:12:41] [   12.462515] pci 0004:48:00.0: can't derive routing =
for PCI INT A
[2019/12/19 9:12:41] [   12.468761] mpt3sas 0004:49:00.0: PCI INT A: no GSI
[2019/12/19 9:12:41] [   12.476348] mpt3sas_cm0: failure at drivers/scsi/mp=
t3sas/mpt3sas_scsih.c:10626/_scsih_probe()!
[2019/12/19 9:14:38] [ TIME ] Timed out waiting for device dev-di=85b3\x2d8=
90a\x2d2ead7df26f48.device.
[2019/12/19 9:14:38] [DEPEND] Dependency failed for Initrd Root Device.
[2019/12/19 9:14:38] [DEPEND] Dependency failed for /sysroot.
[2019/12/19 9:14:38] [DEPEND] Dependency failed for Initrd Root File System.
[2019/12/19 9:14:38] [DEPEND] Dependency failed for Reload Configuration fr=
om the Real Root.
[2019/12/19 9:14:38] [DEPEND] Dependency failed for File System C=8540bae-9=
eb8-46b3-890a-2ead7df26f48.

Thanks,
Chen Zhou

> =

>>>
>>> To solve these issues, introduce crashkernel=3DX,low to reserve specifi=
ed
>>> size low memory.
>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel under
>>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve spcified
>>> size low memory for crash kdump kernel devices firstly and then reserve
>>> memory above 4G.
>>>
>>> When crashkernel is reserved above 4G in memory, that is, crashkernel=
=3DX,low
>>> is specified simultaneously, kernel should reserve specified size low m=
emory
>>> for crash dump kernel devices. So there may be two crash kernel regions=
, one
>>> is below 4G, the other is above 4G.
>>> In order to distinct from the high region and make no effect to the use=
 of
>>> kexec-tools, rename the low region as "Crash kernel (low)", and add DT =
property
>>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low reg=
ion.
>>>
>>> Besides, we need to modify kexec-tools:
>>> arm64: kdump: add another DT property to crash dump kernel's dtb(see [1=
])
>>>
>>> The previous changes and discussions can be retrieved from:
>>>
>>> Changes since [v5]
>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>>> - Delete crashkernel=3DX,high.
>>> - Modify crashkernel=3DX,low.
>>> If crashkernel=3DX,low is specified simultaneously, reserve spcified si=
ze low
>>> memory for crash kdump kernel devices firstly and then reserve memory a=
bove 4G.
>>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, a=
nd then
>>> pass to crash dump kernel by DT property "linux,low-memory-range".
>>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>>
>>> Changes since [v4]
>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>>
>>> Changes since [v3]
>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>> - Fix some compiling warnings.
>>>
>>> Changes since [v2]
>>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separa=
te
>>> patch.
>>>
>>> Changes since [v1]:
>>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>>> in fdt_enforce_memory_region().
>>> There are at most two crash kernel regions, for two crash kernel regions
>>> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>>> and then remove the memory range in the middle.
>>>
>>> [1]: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infrad=
ead.org_pipermail_kexec_2019-2DAugust_023569.html&d=3DDwICAg&c=3DRoP1YumCXC=
gaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw=
4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=3D9tn9kUBabiuYhVtX=
auANSDGaISnCnHLYcAUQgsPBFxs&e=3D =

>>> [v1]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2019_4_2_1174&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_Jn=
E&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09=
m6neWWzGWSphuvXXlXow68&s=3DF-lM7II2cuMF_sK3b6-QhSbWM3X-pI_WZEs0sZitS7A&e=3D =

>>> [v2]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2019_4_9_86&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&=
r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6=
neWWzGWSphuvXXlXow68&s=3D5Y-S6sqMTklHkOQsNtjTX3C7pV05BjKLGhJVfMHEvDs&e=3D =

>>> [v3]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2019_4_9_306&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE=
&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m=
6neWWzGWSphuvXXlXow68&s=3DcWn4zSRQupaZ3jjz4eDvD-pNkoLyL_hsZoRx4yJoD0c&e=3D =

>>> [v4]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2019_4_15_273&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_Jn=
E&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09=
m6neWWzGWSphuvXXlXow68&s=3DNslk4RJKIyIuT0IoQoolXNjupEDXplPhQQwnTSoXNWE&e=3D =

>>> [v5]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2019_5_6_1360&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_Jn=
E&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09=
m6neWWzGWSphuvXXlXow68&s=3DHJVAM6sCxV2DnNg5d4pw8WPqtkmQnKvztEmkSIgtQ5M&e=3D =

>>>
>>> Chen Zhou (4):
>>>  x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>>  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>>  arm64: kdump: add memory for devices by DT property, low-memory-range
>>>  kdump: update Documentation about crashkernel on arm64
>>>
>>> Documentation/admin-guide/kdump/kdump.rst       | 13 ++++-
>>> Documentation/admin-guide/kernel-parameters.txt | 12 ++++-
>>> arch/arm64/include/asm/kexec.h                  |  3 ++
>>> arch/arm64/kernel/setup.c                       |  8 ++-
>>> arch/arm64/mm/init.c                            | 61 ++++++++++++++++++=
+++--
>>> arch/x86/include/asm/kexec.h                    |  3 ++
>>> arch/x86/kernel/setup.c                         | 65 +++---------------=
-------
>>> include/linux/crash_core.h                      |  4 ++
>>> include/linux/kexec.h                           |  1 -
>>> kernel/crash_core.c                             | 65 ++++++++++++++++++=
+++++++
>>> 10 files changed, 168 insertions(+), 67 deletions(-)
>>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.or=
g_mailman_listinfo_kexec&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65=
eapI_JnE&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3=
Dvevd09m6neWWzGWSphuvXXlXow68&s=3DXMcFx61B_QPg-FUfG_-t88DKCnGm4grqu6zRguiHY=
rU&e=3D =

> =

> =

> .
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
