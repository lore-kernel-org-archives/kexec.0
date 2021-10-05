Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXjPM-00ALRx-Bo
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 12:18:57 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 8/9] virtio-mem: factor out hotplug specifics from
 virtio_mem_remove() into virtio_mem_deinit_hotplug()
Date: Tue,  5 Oct 2021 14:14:29 +0200
Message-Id: <20211005121430.30136-9-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
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
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org

Let's prepare for a new virtio-mem kdump mode in which we don't actually
hot(un)plug any memory but only observe the state of device blocks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1be3ee7f684d..76d8aef3cfd2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2667,9 +2667,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	return rc;
 }
 
-static void virtio_mem_remove(struct virtio_device *vdev)
+static void virtio_mem_deinit_hotplug(struct virtio_mem *vm)
 {
-	struct virtio_mem *vm = vdev->priv;
 	unsigned long mb_id;
 	int rc;
 
@@ -2716,7 +2715,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	 * away. Warn at least.
 	 */
 	if (virtio_mem_has_memory_added(vm)) {
-		dev_warn(&vdev->dev, "device still has system memory added\n");
+		dev_warn(&vm->vdev->dev,
+			 "device still has system memory added\n");
 	} else {
 		virtio_mem_delete_resource(vm);
 		kfree_const(vm->resource_name);
@@ -2730,6 +2730,13 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	} else {
 		vfree(vm->bbm.bb_states);
 	}
+}
+
+static void virtio_mem_remove(struct virtio_device *vdev)
+{
+	struct virtio_mem *vm = vdev->priv;
+
+	virtio_mem_deinit_hotplug(vm);
 
 	/* reset the device and cleanup the queues */
 	vdev->config->reset(vdev);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
