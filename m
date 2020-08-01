Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v11 0/5] support reserving crashkernel above 4G on arm64 kdump
Date: Sat, 1 Aug 2020 21:08:51 +0800
Message-ID: <20200801130856.86625-1-chenzhou10@huawei.com>
MIME-Version: 1.0
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
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.
3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
if the memory reserved for crash dump kernel falled in ZONE_DMA32,
the devices in crash dump kernel need to use ZONE_DMA will alloc
fail.

To solve these issues, change the behavior of crashkernel=X.
crashkernel=X tries low allocation in ZONE_DMA, and fall back to
high allocation if it fails.

If requized size X is too large and leads to very little free memory
in ZONE_DMA after low allocation, the system may not work normally.
So add a threshold and go for high allocation directly if the required
size is too large. The value of threshold is set as the half of
the low memory.

If crash_base is outside ZONE_DMA, try to allocate at least 256M in
ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
specified size low memory.
For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices. So there may be two regions reserved for
crash dump kernel, one is below 4G, the other is above 4G.
In order to distinct from the high region and make no effect to the use
of existing kexec-tools, rename the low region as "Crash kernel (low)",
and pass the low region by reusing DT property
"linux,usable-memory-range". We made the low memory region as the last
range of "linux,usable-memory-range" to keep compatibility with existing
user-space and older kdump kernels.

Besides, we need to modify kexec-tools:
arm64: support more than one crash kernel regions(see [1])

Another update is document about DT property 'linux,usable-memory-range':
schemas: update 'linux,usable-memory-range' node schema(see [2])

Changes since [v10]
- Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.

Changes since [v9]
- Patch 1 add Acked-by from Dave.
- Update patch 5 according to Dave's comments.
- Update chosen schema.

Changes since [v8]
- Reuse DT property "linux,usable-memory-range".
Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
memory region.
- Fix kdump broken with ZONE_DMA reintroduced.
- Update chosen schema.

Changes since [v7]
- Move x86 CRASH_ALIGN to 2M
Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
- Update Documentation/devicetree/bindings/chosen.txt.
Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
suggested by Arnd.
- Add Tested-by from Jhon and pk.

Changes since [v6]
- Fix build errors reported by kbuild test robot.

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
[2]: https://github.com/robherring/dt-schema/pull/19 
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360
[v6]: https://lkml.org/lkml/2019/8/30/142
[v7]: https://lkml.org/lkml/2019/12/23/411
[v8]: https://lkml.org/lkml/2020/5/21/213
[v9]: https://lkml.org/lkml/2020/6/28/73
[v10]: https://lkml.org/lkml/2020/7/2/1443

Chen Zhou (5):
  arm64: kdump: add macro CRASH_ALIGN and CRASH_ADDR_LOW_MAX
  x86: kdump: move reserve_crashkernel_low() into crash_core.c
  arm64: kdump: reimplement crashkernel=X
  arm64: kdump: add memory for devices by DT property
    linux,usable-memory-range
  kdump: update Documentation about crashkernel

 Documentation/admin-guide/kdump/kdump.rst     | 21 +++-
 .../admin-guide/kernel-parameters.txt         | 11 ++-
 arch/arm64/include/asm/kexec.h                |  9 ++
 arch/arm64/include/asm/processor.h            |  1 +
 arch/arm64/kernel/setup.c                     |  8 +-
 arch/arm64/mm/init.c                          | 99 +++++++++++++++----
 arch/x86/include/asm/kexec.h                  | 24 +++++
 arch/x86/kernel/setup.c                       | 86 ++--------------
 include/linux/crash_core.h                    |  3 +
 include/linux/kexec.h                         |  2 -
 kernel/crash_core.c                           | 74 ++++++++++++++
 kernel/kexec_core.c                           | 17 ----
 12 files changed, 233 insertions(+), 122 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
