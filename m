Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WahEG-0000nH-SK
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 07:59:29 +0000
Subject: [PATCH v2] makedumpfile: fix a segmentation fault when physical
 address exceeds 8TB boundary
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 17 Apr 2014 15:59:02 +0800
Message-ID: <20140417075902.14515.26225.stgit@k.asiapacific.hpqcorp.net>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, lisa.mitchell@hp.com

This patch intends to fix a segmentation fault when physical address exceeds
8TB boundary.

Changelog:
v2:
- Add more comments from Daisuke HATAYAMA.


In function is_on(), if the physical address higher than 8T, pfn (i) will
greater than 2G, it will be a negative value and will cause a segmentation
fault.
is_on(char *bitmap, int i)
{
        return bitmap[i>>3] & (1 << (i & 7));
}

Daisuke's detailed analysis:
static inline int
is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
{
        off_t offset;
        if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
                offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
                lseek(bitmap->fd, offset, SEEK_SET);
                read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
                if (pfn == 0)
                        bitmap->no_block = 0;
                else
                        bitmap->no_block = pfn/PFN_BUFBITMAP;
        }
        return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
}

PFN_BUFBTIMAP is constant 32 K. So, it seems that the 4 byte byte
length came here.

But right shift to signed integer is implementation defined. We should
not use right shift to signed integer. it looks gcc performs
arithmetic shift and this bahaviour is buggy in case of is_on().

static inline int
is_dumpable_cyclic(char *bitmap, unsigned long long pfn, struct cycle *cycle)
{
        if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
                return FALSE;
        else
                return is_on(bitmap, pfn - cycle->start_pfn);
}

Simply, (pfn - cycle->start_pfn) could be (info->max_mapnr - 0). It's
possible to pass more than 2 Gi by using system with more than 8 TiB
physical memory space.

So, in function is_on()

- i must be unsigned in order to make right shift operation
  meaningful, and

- i must have 8 byte for systems with more than 8 TiB physical memory
  space.


Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 3d270c6..03d35a8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1591,7 +1591,7 @@ int get_xen_info_ia64(void);
 #endif	/* s390x */
 
 static inline int
-is_on(char *bitmap, int i)
+is_on(char *bitmap, unsigned long long i)
 {
 	return bitmap[i>>3] & (1 << (i & 7));
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
