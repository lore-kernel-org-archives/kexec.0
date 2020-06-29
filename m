Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH v9 0/5] support reserving crashkernel above 4G on arm64
 kdump
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20200628083458.40066-1-chenzhou10@huawei.com>
Date: Mon, 29 Jun 2020 09:44:06 -0500
Message-Id: <7DE7332B-1431-466A-A1DB-658A8D65F5CE@oracle.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
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
Cc: horms@verge.net.au, xiexiuqi@huawei.com, arnd@arndb.de, bhe@redhat.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, dyoung@redhat.com, guohanjun@huawei.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, prabhakar.pkin@gmail.com, Thomas Gleixner <tglx@linutronix.de>, will@kernel.org, kexec@lists.infradead.org, nsaenzjulienne@suse.de

Hi , 

> On Jun 28, 2020, at 3:34 AM, Chen Zhou <chenzhou10@huawei.com> wrote:
> 
> This patch series enable reserving crashkernel above 4G in arm64.
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> when there is no enough low memory.
> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> in this case, if swiotlb or DMA buffers are required, crash dump kernel
> will boot failure because there is no low memory available for allocation.
> 3. commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32") broken
> the arm64 kdump. If the memory reserved for crash dump kernel falled in
> ZONE_DMA32, the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
> 
> To solve these issues, introduce crashkernel=X,low to reserve specified
> size low memory.
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.
> 
> When crashkernel is reserved above 4G in memory and crashkernel=X,low
> is specified simultaneously, kernel should reserve specified size low memory
> for crash dump kernel devices. So there may be two crash kernel regions, one
> is below 4G, the other is above 4G.
> In order to distinct from the high region and make no effect to the use of
> kexec-tools, rename the low region as "Crash kernel (low)", and pass the
> low region by reusing DT property "linux,usable-memory-range". We made the low
> memory region as the last range of "linux,usable-memory-range" to keep
> compatibility with existing user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> The previous changes and discussions can be retrieved from:
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.

  
  Nice job Chen, 

  Does this need a Ack-by from the Raspberry maintainers on this ZONE_DMA fix  ?

  This activity has been going on for over a year now.  Can we please get this finalized and merged ?
 
 Thank you,
 John.



> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-June/020737.html__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw-1A43Ss$ 
> [2]: https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/19__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw9xTB8yT$  
> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw2EAOIhM$ 
> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwx3ILnLL$ 
> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw5YJeYoP$ 
> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwxbrySTW$ 
> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwzGOGcMs$ 
> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw70P0bKy$ 
> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw29m6Wrh$ 
> [v8]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw-jGzScF$ 
> 
> Chen Zhou (5):
>  x86: kdump: move reserve_crashkernel_low() into crash_core.c
>  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>  arm64: kdump: add memory for devices by DT property
>    linux,usable-memory-range
>  arm64: kdump: fix kdump broken with ZONE_DMA reintroduced
>  kdump: update Documentation about crashkernel on arm64
> 
> Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
> .../admin-guide/kernel-parameters.txt         | 17 +++-
> arch/arm64/kernel/setup.c                     |  8 +-
> arch/arm64/mm/init.c                          | 74 ++++++++++++---
> arch/x86/kernel/setup.c                       | 66 ++------------
> include/linux/crash_core.h                    |  3 +
> include/linux/kexec.h                         |  2 -
> kernel/crash_core.c                           | 90 +++++++++++++++++++
> kernel/kexec_core.c                           | 17 ----
> 9 files changed, 196 insertions(+), 94 deletions(-)
> 
> -- 
> 2.20.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
