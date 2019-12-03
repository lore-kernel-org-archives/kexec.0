Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic2kH-0001RU-Ko
 for kexec@lists.infradead.org; Tue, 03 Dec 2019 07:37:19 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] makedumpfile: assign bitmap2 fd for sub process during
 refiltering
Date: Tue,  3 Dec 2019 15:37:07 +0800
Message-Id: <1575358627-17152-1-git-send-email-piliu@redhat.com>
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
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

In refiltering mode, each sub process inherits bitmap2->fd from parent.
Then they lseek()/read() on the same fd, which means that they interference
with each other.

This breaks the purpose of SPLITTING_FD_BITMAP(i) for each sub process.
Fix it by assigning a sub process dedicated fd to bitmap2->fd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 makedumpfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d76a435..1dc8640 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8857,7 +8857,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	if (info->flag_cyclic) {
 		if (!prepare_bitmap2_buffer())
 			return FALSE;
-	}
+	} else if (info->flag_refiltering)
+		info->bitmap2->fd = info->fd_bitmap;
 
 	/*
 	 * Write pages and bitmap cyclically.
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
