Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gEV2j-0008To-H3
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 07:54:34 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82F143082125
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2018 07:54:18 +0000 (UTC)
Received: from mylaptop.nay.redhat.com (unknown [10.66.128.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E885D778
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2018 07:54:17 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] x86: fix BAD_FREE in get_efi_runtime_map()
Date: Mon, 22 Oct 2018 15:54:16 +0800
Message-Id: <1540194856-22759-1-git-send-email-piliu@redhat.com>
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

If the err_out label is reached, address of a stack variable is passed to
free(). Fix it.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 6c7d260..6cda12c 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -595,8 +595,8 @@ static int get_efi_runtime_map(struct efi_mem_descriptor **map)
 	closedir(dirp);
 	return nr_maps;
 err_out:
-	if (map)
-		free(map);
+	if (*map)
+		free(*map);
 	closedir(dirp);
 	return 0;
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
