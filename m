Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVHli-008Ofd-9u
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 18:23:55 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/8] proc/vmcore: let pfn_is_ram() return a bool
Date: Tue, 28 Sep 2021 20:22:53 +0200
Message-Id: <20210928182258.12451-4-david@redhat.com>
In-Reply-To: <20210928182258.12451-1-david@redhat.com>
References: <20210928182258.12451-1-david@redhat.com>
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

The callback should deal with errors internally, it doesn't make sense to
expose these via pfn_is_ram(). We'll rework the callbacks next. Right now
we consider errors as if "it's RAM"; no functional change.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..a9bd80ab670e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -84,11 +84,11 @@ void unregister_oldmem_pfn_is_ram(void)
 }
 EXPORT_SYMBOL_GPL(unregister_oldmem_pfn_is_ram);
 
-static int pfn_is_ram(unsigned long pfn)
+static bool pfn_is_ram(unsigned long pfn)
 {
 	int (*fn)(unsigned long pfn);
 	/* pfn is ram unless fn() checks pagetype */
-	int ret = 1;
+	bool ret = true;
 
 	/*
 	 * Ask hypervisor if the pfn is really ram.
@@ -97,7 +97,7 @@ static int pfn_is_ram(unsigned long pfn)
 	 */
 	fn = oldmem_pfn_is_ram;
 	if (fn)
-		ret = fn(pfn);
+		ret = !!fn(pfn);
 
 	return ret;
 }
@@ -124,7 +124,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (pfn_is_ram(pfn) == 0)
+		if (!pfn_is_ram(pfn))
 			memset(buf, 0, nr_bytes);
 		else {
 			if (encrypted)
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
