Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEAyB-00AHIR-0P
 for kexec@lists.infradead.org; Thu, 12 Aug 2021 13:42:04 +0000
From: Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 2/2] makedumpfile: Fix --dry-run for incomplete dumps
Date: Thu, 12 Aug 2021 15:39:40 +0200
Message-Id: <20210812133940.5370-3-prudo@redhat.com>
In-Reply-To: <20210812133940.5370-1-prudo@redhat.com>
References: <20210812133940.5370-1-prudo@redhat.com>
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com

When running out of space during a dry run, e.g. by limiting the output
size using the -L option, makedumpfile fails with

	[...]
	Can't write the dump file(vmcore). Size limit(104857600) reached.
	get_nr_pages: Can't seek end of the dump file(vmcore).
	__read_disk_dump_header: Can't open a file(vmcore). No such file or directory
	[...]

This is because for --dry-run no dump file is created and a dummy file
descriptor of -1 is used. Thus the file operations in get_nr_pages and
check_and_modify_*_headers fail. Fix the first error by using
write_bytes as file size for the output file and the second one by
always returning TRUE for check_and_modify_headers.

Fixes: 3422e1d ("[PATCH 1/2] Add --dry-run option to prevent writing the dumpfile")
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 30f9725..c063267 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5113,6 +5113,9 @@ check_and_modify_multiple_kdump_headers() {
 int
 check_and_modify_headers()
 {
+	if (info->flag_dry_run)
+		return TRUE;
+
 	if (info->flag_elf_dumpfile)
 		return check_and_modify_elf_headers(info->name_dumpfile);
 	else
@@ -7996,7 +7999,11 @@ get_nr_pages(void *buf, struct cache_data *cd_page){
 	int size, file_end, nr_pages;
 	page_desc_t *pd = buf;
 
-	file_end = lseek(cd_page->fd, 0, SEEK_END);
+	if (info->flag_dry_run)
+		file_end = write_bytes;
+	else
+		file_end = lseek(cd_page->fd, 0, SEEK_END);
+
 	if (file_end < 0) {
 		ERRMSG("Can't seek end of the dump file(%s).\n", cd_page->file_name);
 		return -1;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
