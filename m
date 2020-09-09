Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFute-0000ac-Jw
 for kexec@lists.infradead.org; Wed, 09 Sep 2020 07:52:08 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
Date: Wed,  9 Sep 2020 15:50:13 +0800
Message-Id: <20200909075016.104407-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

Currently vmcore only supports reading, this patch series is an RFC
to add writing support to vmcore. It's x86_64 only yet, I'll add other
architecture later if there is no problem with this idea.

My purpose of adding writing support is to reuse the crashed kernel's
old memory in kdump kernel, reduce kdump memory pressure, and
allow kdump to run with a smaller crashkernel reservation.

This is doable because in most cases, after kernel panic, user only
interested in the crashed kernel itself, and userspace/cache/free
memory pages are not dumped. `makedumpfile` is widely used to skip
these pages. Kernel pages usually only take a small part of
the whole old memory. So there will be many reusable pages.

By adding writing support, userspace then can use these pages as a fast
and temporary storage. This helps reduce memory pressure in many ways.

For example, I've written a POC program based on this, it will find
the reusable pages, and creates an NBD device which maps to these pages.
The NBD device can then be used as swap, or to hold some temp files
which previouly live in RAM.

The link of the POC tool: https://github.com/ryncsn/kdumpd

I tested it on x86_64 on latest Fedora by using it as swap with
following step in kdump kernel:

  1. Install this tool in kdump initramfs
  2. Execute following command in kdump:
     /sbin/modprobe nbd nbds_max=1
     /bin/kdumpd &
     /sbin/mkswap /dev/nbd0
     /sbin/swapon /dev/nbd0
  3. Observe the swap is being used:
     SwapTotal:        131068 kB
     SwapFree:         121852 kB

It helped to reduce the crashkernel from 168M to 110M for a successful
kdump run over NFSv3. There are still many workitems that could be done
based on this idea, eg. move the initramfs content to the old memory,
which may help reduce another ~10-20M of memory.

It's have been a long time issue that kdump suffers from OOM issue
with limited crashkernel memory. So reusing old memory could be very
helpful.

This method have it's limitation:
- Swap only works for userspace. But kdump userspace is a major memory
  consumer, so in general this should be helpful enough.
- For users who want to dump the whole memory area, this won't help as
  there is no reusable page.

I've tried other ways to improve the crashkernel value, eg.
- Reserve some smaller memory segments in first kernel for crashkernel: It's
  only a suppliment of the default crashkernel reservation and only make
  crashkernel value more adjustable, still not solving the real problem.

- Reuse old memory, but hotplug chunk of reusable old memory into
  kdump kernel's memory:
  It's hard to find large chunk of continuous memory, especially on
  systems with heavy workload, the reusable regions could be very
  fragmental. So it can only hotplug small fragments of memories,
  which looks hackish, and may have a high page table overhead.

- Implement the old memory based based block device as a kernel
  module. It doesn't looks good to have a module for this sole
  usage and it don't have much performance/implementation advantage
  compared to this RFC.

Besides, keeping all the complex logic of parsing reusing old memory
logic in userspace seems a better idea.

And as a plus, this could make it more doable and reasonable to
have n crashkernel=auto param. If there is a swap, then userspace
will have less memory pressure. crashkernel=auto can focus on the
kernel usage.

Kairui Song (3):
  vmcore: simplify read_from_olemem
  vmcore: Add interface to write to old mem
  x86_64: implement copy_to_oldmem_page

 arch/x86/kernel/crash_dump_64.c |  49 ++++++++--
 fs/proc/vmcore.c                | 154 ++++++++++++++++++++++++++------
 include/linux/crash_dump.h      |  18 +++-
 3 files changed, 180 insertions(+), 41 deletions(-)

-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
