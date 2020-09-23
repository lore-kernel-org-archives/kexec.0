Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <05b1fdbb-5bb3-1345-14ac-9bf91df16aa4@huawei.com>
Date: Wed, 23 Sep 2020 12:47:10 -0500
Message-Id: <1FEE65CB-702C-4C79-947B-21EA8D0DEFFD@oracle.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <05b1fdbb-5bb3-1345-14ac-9bf91df16aa4@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de



> On Sep 15, 2020, at 2:16 AM, chenzhou <chenzhou10@huawei.com> wrote:
> 
> 
> 
> On 2020/9/7 21:47, Chen Zhou wrote:
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>> fail.
>> 
>> To solve these issues, change the behavior of crashkernel=X.
>> crashkernel=X tries low allocation in DMA zone, and fall back to
>> high allocation if it fails.
>> If requized size X is too large and leads to very little low memory
>> in DMA zone after low allocation, the system may not work normally.
>> So add a threshold and go for high allocation directly if the required
>> size is too large. The value of threshold is set as the half of
>> the low memory.
>> 
>> We can also use "crashkernel=X,high" to select a high region above
>> DMA zone, which also tries to allocate at least 256M low memory in
>> DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>> For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
>> 
>> When reserving crashkernel in high memory, some low memory is reserved
>> for crash dump kernel devices. So there may be two regions reserved for
>> crash dump kernel.
>> In order to distinct from the high region and make no effect to the use
>> of existing kexec-tools, rename the low region as "Crash kernel (low)",
>> and pass the low region by reusing DT property
>> "linux,usable-memory-range". We made the low memory region as the last
>> range of "linux,usable-memory-range" to keep compatibility with existing
>> user-space and older kdump kernels.
>> 
>> Besides, we need to modify kexec-tools:
>> arm64: support more than one crash kernel regions(see [1])
>> 
>> Another update is document about DT property 'linux,usable-memory-range':
>> schemas: update 'linux,usable-memory-range' node schema(see [2])
>> 
>> This patchset contains the following nine patches:
>> 0001-x86-kdump-move-CRASH_ALIGN-to-2M.patch
>> 0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
>> 0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
>> 0004-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
>> 0005-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
>> 0006-arm64-kdump-reimplement-crashkernel-X.patch
>> 0007-kdump-add-threshold-for-the-required-memory.patch
>> 0008-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
>> 0009-kdump-update-Documentation-about-crashkernel.patch
>> 
>> 0001-0003 are some x86 cleanups which prepares for making
>> functionsreserve_crashkernel[_low]() generic.
>> 
>> 0004 makes functions reserve_crashkernel[_low]() generic.
>> 0005-0006 reimplements crashkernel=X.
>> 0007 adds threshold for the required memory.
>> 0008 adds memory for devices by DT property linux,usable-memory-range.
>> 0009 updates the doc.
> Hi Catalin and Dave,

  Hi,

   This patch set  has been going on since May, 2019.  When will this be accepted and integrated into a rc build ?

  



> 
> Any other suggestions about this patchset? Let me know if you have any questions.
> 
> Thanks,
> Chen Zhou
>> 
>> Changes since [v11]
>> - Rebased on top of 5.9-rc4.
>> - Make the function reserve_crashkernel() of x86 generic.
>> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
>> and arm64 use the generic version to reimplement crashkernel=X.
>> 
>> Changes since [v10]
>> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
>> 
>> Changes since [v9]
>> - Patch 1 add Acked-by from Dave.
>> - Update patch 5 according to Dave's comments.
>> - Update chosen schema.
>> 
>> Changes since [v8]
>> - Reuse DT property "linux,usable-memory-range".
>> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
>> memory region.
>> - Fix kdump broken with ZONE_DMA reintroduced.
>> - Update chosen schema.
>> 
>> Changes since [v7]
>> - Move x86 CRASH_ALIGN to 2M
>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
>> - Update Documentation/devicetree/bindings/chosen.txt.
>> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
>> suggested by Arnd.
>> - Add Tested-by from Jhon and pk.
>> 
>> Changes since [v6]
>> - Fix build errors reported by kbuild test robot.
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
>> [1]: https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-June/020737.html__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_zMCI6U-$ 
>> [2]: https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/19__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_5c9NEUf$  
>> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_1bFn-eN$ 
>> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_wVqWygD$ 
>> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_8fQ7uBl$ 
>> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_ztbOBKM$ 
>> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_9TAk7Oj$ 
>> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_9IFx5Hx$ 
>> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_0x8im8q$ 
>> [v8]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_yVVP42e$ 
>> [v9]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/28/73__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_y2-BLN1$ 
>> [v10]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/2/1443__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_0qJHLGR$ 
>> [v11]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/8/1/150__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_3QitPUY$ 
>> 
>> Chen Zhou (9):
>>  x86: kdump: move CRASH_ALIGN to 2M
>>  x86: kdump: make the lower bound of crash kernel reservation
>>    consistent
>>  x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>>    reserve_crashkernel[_low]()
>>  x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>>  arm64: kdump: introduce some macroes for crash kernel reservation
>>  arm64: kdump: reimplement crashkernel=X
>>  kdump: add threshold for the required memory
>>  arm64: kdump: add memory for devices by DT property
>>    linux,usable-memory-range
>>  kdump: update Documentation about crashkernel
>> 
>> Documentation/admin-guide/kdump/kdump.rst     |  25 ++-
>> .../admin-guide/kernel-parameters.txt         |  13 +-
>> arch/arm64/include/asm/kexec.h                |  15 ++
>> arch/arm64/include/asm/processor.h            |   1 +
>> arch/arm64/kernel/setup.c                     |  13 +-
>> arch/arm64/mm/init.c                          | 105 ++++------
>> arch/arm64/mm/mmu.c                           |   4 +
>> arch/x86/include/asm/kexec.h                  |  28 +++
>> arch/x86/kernel/setup.c                       | 165 +--------------
>> include/linux/crash_core.h                    |   4 +
>> include/linux/kexec.h                         |   2 -
>> kernel/crash_core.c                           | 192 ++++++++++++++++++
>> kernel/kexec_core.c                           |  17 --
>> 13 files changed, 328 insertions(+), 256 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
