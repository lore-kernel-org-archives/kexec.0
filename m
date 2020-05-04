Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVgMq-0000FN-AZ
 for kexec@lists.infradead.org; Mon, 04 May 2020 19:03:06 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 3/3] device-dax: Add memory via add_memory_driver_managed()
Date: Mon,  4 May 2020 21:02:27 +0200
Message-Id: <20200504190227.18269-4-david@redhat.com>
In-Reply-To: <20200504190227.18269-1-david@redhat.com>
References: <20200504190227.18269-1-david@redhat.com>
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

Currently, when adding memory, we create entries in /sys/firmware/memmap/
as "System RAM". This will lead to kexec-tools to add that memory to the
fixed-up initial memmap for a kexec kernel (loaded via kexec_load()). The
memory will be considered initial System RAM by the kexec'd kernel and
can no longer be reconfigured. This is not what happens during a real
reboot.

Let's add our memory via add_memory_driver_managed() now, so we won't
create entries in /sys/firmware/memmap/ and indicate the memory as
"System RAM (kmem)" in /proc/iomem. This allows everybody (especially
kexec-tools) to identify that this memory is special and has to be treated
differently than ordinary (hotplugged) System RAM.

Before configuring the namespace:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-33fffffff : namespace0.0
	3280000000-32ffffffff : PCI Bus 0000:00

After configuring the namespace:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

After loading kmem before this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : dax0.0
	    150000000-33fffffff : System RAM
	3280000000-32ffffffff : PCI Bus 0000:00

After loading kmem after this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : dax0.0
	    150000000-33fffffff : System RAM (kmem)
	3280000000-32ffffffff : PCI Bus 0000:00

After a proper reboot:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel before this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : System RAM
	3280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel after this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

/sys/firmware/memmap/ before this change:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)
	0000000150000000-0000000340000000 (System RAM)

/sys/firmware/memmap/ after a proper reboot:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)

/sys/firmware/memmap/ after this change:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)

kexec-tools already seem to basically ignore any System RAM that's not
on top level when searching for areas to place kexec images - but also
for determining crash areas to dump via kdump. Changing the resource name
won't have an impact.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/dax/kmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3d0a7e702c94..5a645a24e359 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -65,7 +65,13 @@ int dev_dax_kmem_probe(struct device *dev)
 	new_res->flags = IORESOURCE_SYSTEM_RAM;
 	new_res->name = dev_name(dev);
 
-	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
+	/*
+	 * Ensure that future kexec'd kernels will not treat this as RAM
+	 * automatically.
+	 */
+	rc = add_memory_driver_managed(numa_node, new_res->start,
+				       resource_size(new_res),
+				       "System RAM (kmem)");
 	if (rc) {
 		release_resource(new_res);
 		kfree(new_res);
-- 
2.25.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
