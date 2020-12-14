Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kor3O-0001ab-54
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 16:50:31 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC]: kexec: change to handle memory/cpu changes
Message-ID: <b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com>
Date: Mon, 14 Dec 2020 10:50:18 -0600
MIME-Version: 1.0
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
To: ebiederm@xmission.com, linux-kernel@vger.kernel.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


As the memory layout or the number of CPUs change, a loaded kdump
capture kernel must also be updated. By having an accurate
representation of the memory and CPU layout, the resulting kdump
capture in response to a kernel panic will be complete and accurate.

Currently, the memory and CPU layout is recorded only when the kdump
capture kernel is loaded via the kexec userspace utility. If the kexec
utility is passing a non-signed kernel, then kexec also passes in the
memory and CPU layout (which is obtained via sysfs). If the kernel is
signed, then the kernel constructs the memory and CPU layout during
the syscall (also from sysfs resources). In either case, the memory
and CPU layout is recorded in a vmcoreinfo structure at kdump capture
kernel load time; and the capture kernel, capture kernel initrd,
capture kernel cmdline and the vmcoreinfo struct are all located in
crash kernel memory (reserved via the crashkernel= parameter to the
current kernel), ready to go upon a panic.

When memory and/or CPU changes do occur, these changes cause kernel
and subsequently udev events. The handling of the udev events allows
for the onlining/offlining of the associated memory or CPUs. The udev
event handling is also utilized to update the kdump capture kernel, by
reloading it.

In the Red Hat distributions, for example, the udev rule
98-kexec.rules handles the memory and CPU udev events so that kdump
can be updated. In RHEL7, it looks like:

   SUBSYSTEM=="cpu", ACTION=="add", GOTO="kdump_reload"
   SUBSYSTEM=="cpu", ACTION=="remove", GOTO="kdump_reload"
   SUBSYSTEM=="memory", ACTION=="online", GOTO="kdump_reload"
   SUBSYSTEM=="memory", ACTION=="offline", GOTO="kdump_reload"

   GOTO="kdump_reload_end"

   LABEL="kdump_reload"

   # If kdump is not loaded, calling "kdumpctl reload" will end up
   # doing nothing, but it and systemd-run will always generate
   # extra logs for each call, so trigger the "kdumpctl reload"
   # only if kdump service is active to avoid unnecessary logs
   RUN+="/bin/sh -c '/usr/bin/systemctl is-active kdump.service || exit 0; /usr/bin/systemd-run 
--quiet /usr/bin/kdumpctl reload'"

   LABEL="kdump_reload_end"

On any change to memory or CPUs (ie. ACTION=="add" or
ACTION=="remove"), the "kdump_reload" label invokes kdumpctl to reload
the kdump kernel. This happens for each CPU and/or memory block added
or removed to/from the system.

When memory is added, for example, the memory subsystem breaks the
memory into smaller memblocks, typically 128MiB. Then for each of
memblock, a udev event is triggered, which in turns causes the current
kdump kernel to be unloaded, then reloaded again (this time with an
updated memory layout including the just onlined memblock). Thus, the
act of adding the 1GiB actually causes the kdump capture kernel to be
unloaded then reloaded 8 times.

The actual problem is that there is a window of time between when the
kdump capture kernel is unloaded and before it is reloaded again,
where kdump fails if a panic occurs. It fails simply because there
isn't a valid kdump kernel resident.

Now, as long as the number of events is small, for example going from
8 to 16 CPUs, or adding a single 1GiB, this unloading-then-reloading
behavior has been, for the most part, tolerable. But in cloud
environments, in particular, with guest memory being added and removed
by the tens or hundreds of gigabytes, this behavior easily exposes
the race window(s) which can cause kdump to fail.

As a more concrete example, on a guest with 32GiB memory, and sizing
up the guest to 512GiB memory, this results in 3840 128MiB memblocks,
and associated udev events!  It took the guest nearly 400 seconds to
process all the events. Clearly this is a waste of time and energy,
but more importantly it creates 3839 un-necessary race windows in
which kdump can fail.

The excessive kdump capture kernel unload-then-reload activity did not
go un-noticed and, in RHEL8, the 98-kexec.rules invokes a new script
named kdump-udev-throttle that looks like this:

   #!/bin/bash
   # This util helps to reduce the workload of kdump service restarting
   # on udev event. When hotplugging memory / CPU, multiple udev
   # events may be triggered concurrently, and obviously, we don't want
   # to restart kdump service for each event.

   # This script will be called by udev, and make sure kdump service is
   # restart after all events we are watching are settled.

   # On each call, this script will update try to aquire the $throttle_lock
   # The first instance acquired the file lock will keep waiting for events
   # to settle and then reload kdump. Other instances will just exit
   # In this way, we can make sure kdump service is restarted immediately
   # and for exactly once after udev events are settled.

   throttle_lock="/var/lock/kdump-udev-throttle"

   exec 9>$throttle_lock
   if [ $? -ne 0 ]; then
         echo "Failed to create the lock file! Fallback to non-throttled kdump service restart"
         /bin/kdumpctl reload
         exit 1
   fi

   flock -n 9
   if [ $? -ne 0 ]; then
         echo "Throttling kdump restart for concurrent udev event"
         exit 0
   fi

   # Wait for at least 1 second, at most 4 seconds for udev to settle
   # Idealy we will have a less than 1 second lag between udev events settle
   # and kdump reload
   sleep 1 && udevadm settle --timeout 3

   # Release the lock, /bin/kdumpctl will block and make the process
   # holding two locks at the same time and we might miss some events
   exec 9>&-

   /bin/kdumpctl reload

   exit 0

The purpose of kdump-udev-throttle is to absorb CPU and memory events
and only update the kdump capture kernel once in a roughly 4 second
window of the first event. This has the effect of coalescing events
and thereby reducing the number of times the kdump capture kernel is
reloaded.

This approach is an improvement as it reduces the number of kdump
unload-then-reloads for multiple changes to memory and/or CPU (that
occur within the 4 second window), but it still suffers from the fact
that the currently loaded capture kernel does not contain an accurate
reflection of the CPU and memory layout until the update occurs.

To relate the problem to time, here is some data. I show two scenarios
in which a guest goes from 32GiB to 512GiB, one scenario in which a
single 480GiB (QEMU virtual) DIMM is added, and the second scenario in
which 480 1GiB (QEMU virtual) DIMMs are added. These two scenarios
represent either end of the spectrum of the granularity of what cloud
providers offer in terms of resizing a guest's memory, in this
specific example.

The cell contents show the number of seconds it took for the system to
process all of the 3840 memblocks. The value in parenthesis is the
number of kdump unload-then-reload operations per second.

           1 480GB DIMM   480 1GB DIMMs
-------+-----------------+----------------+
  RHEL7 | 181s (21.2 ops) | 389s (9.8 ops) |
-------+-----------------+----------------+
  RHEL8 |  86s (44.7 ops) | 419s (9.2 ops) |
-------+-----------------+----------------+

The scenario of adding 480 1GiB virtual DIMMs takes more time given
the larger number of round trips of QEMU -> kernel -> udev -> kernel ->
QEMU, and are both roughly 400s.

The RHEL7 system process all 3840 memblocks individually and perform
3840 kdump unload-then-reload operations.

However, RHEL8 data in the best case scenario (1 480GiB DIMM) suggests
that approximately 86/4= 21 kdump unload-then-reload operations
happened, and in the worst case scenario (480 1GiB DIMMs), the data
suggests that approximately 419/4 = 105 kdump unload-then-reload
operations happened. For RHEL8, the final number of kdump
unload-then-reload operations are 0.5% (21 of 3840) and 2.7% (105 of
3840), respectively, compared to that of the RHEL7 system.

The throttle approach is quite effective in reducing the number of
kdump unload-then-reload operations. However, the kdump capture kernel
is still reloaded multiple times, and each kdump capture kernel reload
is a race window in which kdump can fail.

A quick peek at Ubuntu 20.04 LTS reveals it has 50-kdump-tools.rules
that looks like:

   SUBSYSTEM=="memory", ACTION=="online", PROGRAM="/usr/sbin/kdump-config try-reload"
   SUBSYSTEM=="memory", ACTION=="offline", PROGRAM="/usr/sbin/kdump-config try-reload"
   SUBSYSTEM=="cpu", ACTION=="add", PROGRAM="/usr/sbin/kdump-config try-reload"
   SUBSYSTEM=="cpu", ACTION=="remove", PROGRAM="/usr/sbin/kdump-config try-reload"
   SUBSYSTEM=="cpu", ACTION=="offline", PROGRAM="/usr/sbin/kdump-config try-reload"

which produces the equivalent behavior to RHEL7 whereby every event
results in a kdump capture kernel reload.

Fedora 33 and CentOS 8-stream behave the same as RHEL8.

Perhaps a better solution is to rewrite the vmcoreinfo structure that
contains the memory and CPU layout information, as those changes to
memory and CPUs occur. Rewriting vmcoreinfo is an in-kernel activity
and would certainly avoid the relatively large unload-then-reload
times of the kdump capture kernel. The pointer to the vmcoreinfo
structure is provided to the capture kernel via the elfcorehdr=
parameter to the capture kernel cmdline. Rewriting the vmcoreinfo
structure as well as rewriting the capture kernel cmdline parameter is
needed to utilize this approach.

Based upon some amount of examining code, I think the challenges
involved in updating the CPU and memory layout in-kernel are:

  - adding call-outs on the add_memory()/try_remove_memory() and
    cpu_up()/cpu_down() paths for notifying the kdump subsystem of
    memory and/or CPU changes.

  - updating the struct kimage with the memory or CPU changes

  - Rewriting the vmcoreinfo structure from the data contained
    in struct kimage, eg crash_prepare_elf64_headers()

  - Installing the updated vmcoreinfo struct via
    kimage_crash_copy_vmcoreinfo() and rewriting the kdump kernel
    cmdline in order to update parameter elfcorehdr= with the
    new address

As I am not overly familiar with all the code paths involved, yet, I'm
sure the devil is in the details. However, due the kexec_file_load
syscall, it appears most of the infrastructure is already in place,
and we essentially need to tap into it again for memory and cpu
changes.

It appears that this change could be applicable to both kexec_load and
kexec_file_load, it has the potential to (eventually) simplify the
userland kexec utility for kexec_load, and would eliminate the need
for 98-kexec.rules and the associated churn.

Comments please!
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
