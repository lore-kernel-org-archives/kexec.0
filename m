Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVgMn-0000Cx-DD
 for kexec@lists.infradead.org; Mon, 04 May 2020 19:03:04 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/3] mm/memory_hotplug: Interface to add driver-managed
 system ram
Date: Mon,  4 May 2020 21:02:24 +0200
Message-Id: <20200504190227.18269-1-david@redhat.com>
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

Third time is the charm? Let's see ... :)

This is the follow up of [1]:
 [PATCH v1 0/3] mm/memory_hotplug: Make virtio-mem play nicely with
 kexec-tools
and [2]:
 [PATCH v2 0/3] mm/memory_hotplug: Allow to not create firmware memmap
 entries

kexec (via kexec_load()) can currently not properly handle memory added via
dax/kmem, and will have similar issues with virtio-mem. kexec-tools will
currently add all memory to the fixed-up initial firmware memmap. In case
of dax/kmem, this means that - in contrast to a proper reboot - how that
persistent memory will be used can no longer be configured by the kexec'd
kernel. In case of virtio-mem it will be harmful, because that memory
might contain inaccessible pieces that require coordination with hypervisor
first.

In both cases, we want to let the driver in the kexec'd kernel handle
detecting and adding the memory, like during an ordinary reboot.
Introduce add_memory_driver_managed(). More on the samentics are in patch
#1.

In the future, we might want to make this behavior configurable for
dax/kmem- either by configuring it in the kernel (which would then also
allow to configure kexec_file_load()) or in kexec-tools by also adding
"System RAM (kmem)" memory from /proc/iomem to the fixed-up initial
firmware memmap.

More on the motivation can be found in [1] and [2].

v2 -> v3:
- Don't use flags for add_memory() and friends, provide
  add_memory_driver_managed() instead.
- Flag memory resources via IORESOURCE_MEM_DRIVER_MANAGED and handle them
  in kexec.
- Name memory resources "System RAM ($DRIVER)", visible via /proc/iomem
- Added more details to the patch descriptions, especially regarding the
  history of /sys/firmware/memmap
- Add a comment to the device-dax change. Dropped Dave's Ack as the

v1 -> v2:
- Don't change the resource name
- Rename the flag to MHP_NO_FIRMWARE_MEMMAP to reflect what it is doing
- Rephrase subjects/descriptions
- Use the flag for dax/kmem

[1] https://lkml.kernel.org/r/20200429160803.109056-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200430102908.10107-1-david@redhat.com

David Hildenbrand (3):
  mm/memory_hotplug: Introduce add_memory_device_managed()
  kexec_file: Don't place kexec images on IORESOURCE_MEM_DRIVER_MANAGED
  device-dax: Add memory via add_memory_driver_managed()

 drivers/dax/kmem.c             |  8 ++++-
 include/linux/ioport.h         |  1 +
 include/linux/memory_hotplug.h |  2 ++
 kernel/kexec_file.c            |  5 +++
 mm/memory_hotplug.c            | 62 +++++++++++++++++++++++++++++++---
 5 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.25.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
