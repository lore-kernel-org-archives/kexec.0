Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xtw-0001VY-1d
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:01:25 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 01/32] kdump: mmap() and munmap() only work on
 page-aligned quantites
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xrT-0003rV-HE@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:58:47 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

The man page for mmap() and munmap() says that mmap() and munmap()
only works for page-aligned addresses, sizes and offsets.  Arrange
to give these interfaces what they want.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 821ee7c..3247a54 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -25,22 +25,35 @@
 #define MAP_WINDOW_SIZE (64*1024*1024)
 #define DEV_MEM "/dev/mem"
 
+#define ALIGN_MASK(x,y) (((x) + (y)) & ~(y))
+#define ALIGN(x,y)	ALIGN_MASK(x, (y) - 1)
+
 static void *map_addr(int fd, unsigned long size, off_t offset)
 {
+	unsigned long page_size = getpagesize();
+	unsigned long map_offset = offset & (page_size - 1);
+	size_t len = ALIGN(size + map_offset, page_size);
 	void *result;
-	result = mmap(0, size, PROT_READ, MAP_SHARED, fd, offset);
+
+	result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
 	if (result == MAP_FAILED) {
 		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
 			(unsigned long long)offset, size, strerror(errno));
 		exit(5);
 	}
-	return result;
+	return result + map_offset;
 }
 
 static void unmap_addr(void *addr, unsigned long size)
 {
+	unsigned long page_size = getpagesize();
+	unsigned long map_offset = (uintptr_t)addr & (page_size - 1);
+	size_t len = ALIGN(size + map_offset, page_size);
 	int ret;
-	ret = munmap(addr, size);
+
+	addr -= map_offset;
+
+	ret = munmap(addr, len);
 	if (ret < 0) {
 		fprintf(stderr, "munmap failed: %s\n",
 			strerror(errno));
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
