Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/7] uImage: fix realloc() pointer confusion
Date: Wed,  8 Mar 2017 22:41:08 +0000
Message-Id: <20170308224114.49729-1-dwmw2@infradead.org>
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
To: kexec@lists.infradead.org
Cc: David Woodhouse <dwmw@amazon.co.uk>

From: David Woodhouse <dwmw@amazon.co.uk>

We carefully avoid the realloc() API trap by *not* using the
'ptr = realloc(ptr, new_size)' idiom which can lead to leaks on
failure. Very commendable, even though all we're going to do is
exit() on failure so it wouldn't have mattered.

What *does* matter is that we then ask zlib to continue
decompression... just past the end of the *old* buffer that just
got freed. Oops.

Apparently nobody has *ever* tested this code by booting a uImage
with a compressed payload larger than 10MiB.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kexec/kexec-uImage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 5e24629..667cd93 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -210,9 +210,9 @@ static int uImage_gz_load(const unsigned char *buf, off_t len,
 				return -1;
 			}
 
+			uncomp_buf = new_buf;
 			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
 			strm.avail_out = inc_buf;
-			uncomp_buf = new_buf;
 		} else {
 			printf("Error during decompression %d\n", ret);
 			return -1;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
