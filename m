Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXV0-0002iS-TO
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:24:15 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 06/32] kdump: print mmap() offset in hex
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXSQ-0004hT-54@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:21:34 +0100
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
Cc: Pratyush Anand <panand@redhat.com>

When mmap() fails, printing a large decimal number is mostly
meaningless - it's not obvious what it means.  Printing a hex number
is more obvious, because we can see whether it's over 32-bit, or not
page aligned.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 34d2149..f34727f 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -37,7 +37,7 @@ static void *map_addr(int fd, unsigned long size, off_t offset)
 
 	result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
 	if (result == MAP_FAILED) {
-		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
+		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %#llx size: %lu: %s\n",
 			(unsigned long long)offset, size, strerror(errno));
 		exit(5);
 	}
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
