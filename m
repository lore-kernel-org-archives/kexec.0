Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luBmC-00Djcj-86
 for kexec@lists.infradead.org; Fri, 18 Jun 2021 10:31:06 +0000
Received: by mail-pf1-f200.google.com with SMTP id
 e19-20020aa78c530000b02902e9ca53899dso5451766pfd.22
 for <kexec@lists.infradead.org>; Fri, 18 Jun 2021 03:28:54 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [makedumpfile PATCH] check for invalid physical address of
 /proc/kcore when make ELF format dumpfile
Date: Fri, 18 Jun 2021 18:28:04 +0800
Message-Id: <20210618102803.1042547-1-ltao@redhat.com>
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
Cc: Tao Liu <ltao@redhat.com>

Previously when executing makedumpfile with -E option against /proc/kcore,
makedumpfile will fail:

    $ sudo makedumpfile -E -d 31 /proc/kcore vmcore
    ...
    write_elf_load_segment: Can't convert physaddr(ffffffffffffffff) to an
    offset.

    makedumpfile Failed.

It's because /proc/kcore contains PT_LOAD program headers which have
physaddr(ffffffffffffffff). With -E option, makedumpfile will try to convert
the physaddr to an offset and fails.

In this patch, let's skip the PT_LOAD program headers which have such physaddr.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 makedumpfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 894c88e..8c93c54 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7767,6 +7767,9 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		if (load.p_type != PT_LOAD)
 			continue;
 
+		if (load.p_paddr == -1)
+			continue;
+
 		off_memory= load.p_offset;
 		paddr = load.p_paddr;
 		pfn_start = paddr_to_pfn(load.p_paddr);
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
