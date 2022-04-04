From: Philipp Rudo <prudo@redhat.com>
Date: Mon,  4 Apr 2022 17:50:50 +0200
Subject: [PATCH 2/2] makedumpfile: break loop after last dumpable page
In-Reply-To: <20220404155050.6898-1-prudo@redhat.com>
References: <20220404155050.6898-1-prudo@redhat.com>
Message-ID: <20220404155050.6898-3-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Once the last dumpable page was processed there is no need to finish the
loop to the last page. Thus exit early to improve performance.

Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2ef3458..c944d0e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8884,6 +8884,12 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
+		/*
+		 * All dumpable pages have been processed. No need to continue.
+		 */
+		if (num_dumped == info->num_dumpable)
+			break;
+
 		/*
 		 * Check the excluded page.
 		 */
-- 
2.35.1


