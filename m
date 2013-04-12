Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQXlJ-00051M-SF
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 06:47:06 +0000
Date: Fri, 12 Apr 2013 15:17:56 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 1/2] Move scrubbing process from reader to writer.
Message-Id: <20130412151756.afe14ce0df4cdd8bf96be9e6@mxc.nes.nec.co.jp>
In-Reply-To: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
References: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: ptesarik@suse.cz

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 11 Apr 2013 09:36:36 +0900
Subject: [PATCH 1/2] Move scrubbing process from reader to writer.

When create a dumpfile in the kdump-compressed format, scrubbing
process is done in reading process via read_pfn(). But it would be
better to do it just before actually writing the data like the
case of ELF.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 9cf907c..725100b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5337,7 +5337,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 			ERRMSG("Can't get the page data.\n");
 			return FALSE;
 		}
-		filter_data_buffer(buf, paddr, info->page_size);
 		return TRUE;
 	}
 
@@ -5360,7 +5359,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 		ERRMSG("Can't get the page data.\n");
 		return FALSE;
 	}
-	filter_data_buffer(buf, paddr, size1);
 	if (size1 != info->page_size) {
 		size2 = info->page_size - size1;
 		if (!offset2) {
@@ -5370,7 +5368,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 				ERRMSG("Can't get the page data.\n");
 				return FALSE;
 			}
-			filter_data_buffer(buf + size1, paddr + size1, size2);
 		}
 	}
 	return TRUE;
@@ -5805,6 +5802,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 		if (!read_pfn(pfn, buf))
 			goto out;
+		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
 
 		/*
 		 * Exclude the page filled with zeros.
@@ -5983,6 +5981,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 
 		if (!read_pfn(pfn, buf))
 			goto out;
+		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
 
 		/*
 		 * Exclude the page filled with zeros.
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
