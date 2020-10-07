Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ3Nn-000176-AC
 for kexec@lists.infradead.org; Wed, 07 Oct 2020 06:57:04 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/3] Cleanup: Remove a superfluous seek to physical address 0
Date: Wed,  7 Oct 2020 08:56:50 +0200
Message-Id: <20201007065652.28160-2-ptesarik@suse.com>
In-Reply-To: <20201007065652.28160-1-ptesarik@suse.com>
References: <20201007065652.28160-1-ptesarik@suse.com>
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
To: Kazuhito Hagio <k-hagio-ab@nec.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

The file position is updated for each page in readmem() via a
read_pfn(). There is no point in seeking to PFN 0 data first.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 makedumpfile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4c4251e..cdde040 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8385,7 +8385,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
 	struct timespec ts_start;
-	const off_t failed = (off_t)-1;
 	int ret = FALSE;
 	z_stream z_stream, *stream = NULL;
 #ifdef USELZO
@@ -8422,16 +8421,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	per = info->num_dumpable / 10000;
 	per = per ? per : 1;
 
-	/*
-	 * Set a fileoffset of Physical Address 0x0.
-	 */
-	if (lseek(info->fd_memory, get_offset_pt_load_memory(), SEEK_SET)
-	    == failed) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		       info->name_memory, strerror(errno));
-		goto out;
-	}
-
 	start_pfn = cycle->start_pfn;
 	end_pfn   = cycle->end_pfn;
 
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
