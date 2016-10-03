Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1br6iI-0006Xa-8Z
 for kexec@lists.infradead.org; Mon, 03 Oct 2016 17:07:40 +0000
From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
Date: Mon,  3 Oct 2016 13:07:12 -0400
Message-Id: <1475514432-27682-1-git-send-email-prarit@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, dyoung@redhat.com, x86@kernel.org, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@redhat.com>

When kdump'ing on a system that has had a socket (package) physically
hotadded, the following panic is occasionally seen:

BUG: unable to handle kernel paging request at 0000000000841f1f
IP: [<ffffffff81014ec4>] uncore_change_context+0xd4/0x180
PGD 0
Oops: 0000 [#1] SMP
Modules linked in:
CPU: 0 PID: 12 Comm: cpuhp/0 Not tainted 4.8.0-rc8+ #3
Hardware name: FUJITSU PRIMEQUEST 2800E3/D3752, BIOS PRIMEQUEST 2000 Series BIOS Version 01.17 05/16/2016
task: ffff88002daf1680 task.stack: ffff88002dafc000
RIP: 0010:[<ffffffff81014ec4>]  [<ffffffff81014ec4>] uncore_change_context+0xd4/0x180
RSP: 0000:ffff88002daffdc8  EFLAGS: 00010286
RAX: ffff88002c069c00 RBX: 0000000000841f0f RCX: ffffffffffffffff
RDX: 000000000000a020 RSI: 00000000ffffffff RDI: ffffffff81c18fa0
RBP: ffff88002daffe10 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000007fff8 R11: 00000000a585a840 R12: ffff88002c0a4400
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff81c19a20
FS:  0000000000000000(0000) GS:ffff880032c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000841f1f CR3: 0000000031c06000 CR4: 00000000003406b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 000000000000a020 ffffffff81c18fa0 ffff88002daf28c0 ffff88002daffdf0
 0000000000000000 0000000000000000 000000000000004a ffffffff81015a60
 0000000000000000 ffff88002daffe30 ffffffff81015acc ffff880032c0dda0
Call Trace:
 [<ffffffff81015a60>] ? uncore_cpu_starting+0x130/0x130
 [<ffffffff81015acc>] uncore_event_cpu_online+0x6c/0x80
 [<ffffffff8108e819>] cpuhp_invoke_callback+0x49/0x100
 [<ffffffff8108ead1>] cpuhp_thread_fun+0x41/0x100
 [<ffffffff810b054f>] smpboot_thread_fn+0x10f/0x160
 [<ffffffff810b0440>] ? sort_range+0x30/0x30
 [<ffffffff810accd8>] kthread+0xd8/0xf0
 [<ffffffff816ff4bf>] ret_from_fork+0x1f/0x40
 [<ffffffff810acc00>] ? kthread_park+0x60/0x60
Code: c8 44 89 73 10 41 83 c5 01 49 81 c4 48 01 00 00 45 3b 6f 0c 7d 21 49 8b 84 24 40 01 00 00 4a 8b 1c 10 48 85 db 74 de 85 c9 79 96 <83> 7b 10 ff 75 63 44 89 73 10 eb ce 48 83 45 c0 08 48 8b 45 c0
RIP  [<ffffffff81014ec4>] uncore_change_context+0xd4/0x180
 RSP <ffff88002daffdc8>
CR2: 0000000000841f1f
---[ end trace 2ce4e89368333d22 ]---
Kernel panic - not syncing: Fatal exception
Rebooting in 10 seconds..
ACPI MEMORY or I/O RESET_REG.

The panic shows what the problem is:

arch/x86/events/intel/uncore.c:
1137 static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_     cpu,
1138                                    int new_cpu)
1139 {
1140         struct intel_uncore_pmu *pmu = type->pmus;
1141         struct intel_uncore_box *box;
1142         int i, pkg;
1143
1144         pkg = topology_logical_package_id(old_cpu < 0 ? new_cpu : old_cpu);
1145         for (i = 0; i < type->num_boxes; i++, pmu++) {
1146                 box = pmu->boxes[pkg];

pmu->boxes[pkg] is garbage because pkg was returned as 0xffff.
topology_logical_package_id() is defined as

|#define topology_logical_package_id(cpu)         (cpu_data(cpu).logical_proc_id

which means that logical_proc_id was not defined.  logical_proc_id is set in
arch/x86/kernel/smpboot.c:topology_update_package_map(), which is called in
arch/x86/kernel/smpboot.c:smp_init_package_map.

smp_init_package_map() was introduced in 1f12e32f4cd5 ("x86/topology:
Create logical package id"), and does

arch/x86/kernel/smpboot.c:
358         for_each_present_cpu(cpu) {
359                 unsigned int apicid = apic->cpu_present_to_apicid(cpu);
360
361                 if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
362                         continue;
363                 if (!topology_update_package_map(apicid, cpu))
364                         continue;

which means that apic->cpu_present_to_apicid(cpu) is returning BAD_APICID
(experimentally verified that it is not the acpi_id_valid() that is the
problem) so that topology_update_package_map() is not called for the cpu,
and the cpu's pkg value will remain the default value of 0xffff.

Following through function pointers, cpu_present_to_apicid() resolves as
default_cpu_present_to_apicid() which is __default_cpu_present_to_apicid()
for x86_64.

arch/x86/include/asm/apic.h:
605 static inline int __default_cpu_present_to_apicid(int mps_cpu)
606 {
607         if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
608                 return (int)per_cpu(x86_bios_cpu_apicid, mps_cpu);
609         else
610                 return BAD_APICID;
611 }

The per_cpu field x86_bios_cpu_apicid is set in generic_processor_info().
After verifying that the mps_cpu was 0 and the cpu was in the present
map, the only way that x86_bios_cpu_apicid is BAD_APICID for a valid
cpu is if the cpu initialization function generic_processor_info() was not
called on the cpu.

As part of acpi_boot_init(), the acpi_register_lapic() calls
generic_processor_info() and is called for all APIC entries in the MADT
table. The ACPI 6.0 Specification states that the ACPI X2APIC tables does
not have to update on a cpu hotplug event:

"5.2.12.12 Processor Local x2APIC Structure

OSPM does not expect the information provided in this table to be updated if
the processor information changes during the lifespan of an OS boot."

and that explains why generic_processor_info() was not called on a
hotplugged cpu during the kdump kernel boot.

Hot adding a cpu to a system and testing kdump [1] with

taskset -c {hotadded thread id} echo c > /proc/sysrq-trigger

makes the panic occur 100% of the time.  Targetting a cpu that is present in
the MADT results in a valid kdump 100% of time.  These two combined explain the
occasional nature of the panic.

The boot log also contains evidence that generic_processor_info() wasn't
called on the boot cpu, and that was the problem:

smpboot: weird, boot CPU (#507) not listed by the BIOS

and

APIC: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 1/0x2 ignored.

entries are listed for each cpu but there is no indication that the boot
cpu was enumerated in ACPI.  Adding a debug printk shows num_processors is
0 after the ACPI enumeration is complete.

After the ACPI enumeration is complete, prefill_possible_map() [2] checks
if num_processors is 0 and sets it to 1 to account for a boot cpu that
wasn't enumerated.  However, prefill_possible_map() does not call
generic_processor_info() on the boot cpu which leaves the boot cpu with
partially uninitialized data.

This patch adds the missing generic_processor_info() to
prefill_possible_map() to ensure the initialization of the boot cpu is
correct.  This results in smp_init_package_map() having correct data and
properly setting the package map for the hotplugged boot cpu, which in
turn resolves the kdump kernel panic on physically hotplugged cpus.

[1] This can be simulated in a KVM environment by hot adding a CPU and
using taskset to force the dump on the newly added CPU.
[2] prefill_possible_map() is called before smp_store_boot_cpu_info().
The comment beside the call to smp_store_boot_cpu_info() states that the
completed call results in "Final full version of the data".

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Fixes: 1f12e32f4cd5 ("x86/topology: Create logical package id")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: dyoung@redhat.com
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/smpboot.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4296beb8fdd3..d1272febc13b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1406,9 +1406,18 @@ __init void prefill_possible_map(void)
 {
 	int i, possible;
 
-	/* no processor from mptable or madt */
-	if (!num_processors)
-		num_processors = 1;
+	/* No boot processor was found in mptable or ACPI MADT */
+	if (!num_processors) {
+		/* Make sure boot cpu is enumerated */
+		if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
+		    apic->apic_id_valid(boot_cpu_physical_apicid))
+			generic_processor_info(boot_cpu_physical_apicid,
+					apic_version[boot_cpu_physical_apicid]);
+		if (!num_processors) {
+			pr_warn("CPU 0 not enumerated in mptable or ACPI MADT\n");
+			num_processors = 1;
+		}
+	}
 
 	i = setup_max_cpus ?: 1;
 	if (setup_possible_cpus == -1) {
-- 
1.7.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
