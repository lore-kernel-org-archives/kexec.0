Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1agRqn-0000k0-9S
 for kexec@lists.infradead.org; Thu, 17 Mar 2016 06:56:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makdumpfile: clean up the in-accurate message printing
 about mmap
Date: Thu, 17 Mar 2016 06:46:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E32706@BPXM01GP.gisp.nec.co.jp>
References: <1458112379-10969-1-git-send-email-bhe@redhat.com>
In-Reply-To: <1458112379-10969-1-git-send-email-bhe@redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Baoquan,

>mmap() is not used either caused by failure of mmap() in initialize_mmap(),
>or because user explictly specify '--non-mmap'. So the message need be changed
>according these different cases.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Sounds reasonable, thanks.

Acked-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

>---
> makedumpfile.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index fa0b779..5703369 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -3949,14 +3949,17 @@ out:
> 	if (info->dump_level & DL_EXCLUDE_FREE)
> 		setup_page_is_buddy();
>
>-	if (info->flag_usemmap == MMAP_TRY && initialize_mmap()) {
>-		DEBUG_MSG("mmap() is available on the kernel.\n");
>-		info->flag_usemmap = MMAP_ENABLE;
>-	} else {
>-		DEBUG_MSG("The kernel doesn't support mmap(),");
>-		DEBUG_MSG("read() will be used instead.\n");
>-		info->flag_usemmap = MMAP_DISABLE;
>-        }
>+	if (info->flag_usemmap == MMAP_TRY ) {
>+		if (initialize_mmap()) {
>+			DEBUG_MSG("mmap() is available on the kernel.\n");
>+			info->flag_usemmap = MMAP_ENABLE;
>+		} else {
>+			DEBUG_MSG("The kernel doesn't support mmap(),");
>+			DEBUG_MSG("read() will be used instead.\n");
>+			info->flag_usemmap = MMAP_DISABLE;
>+		}
>+        } else if (info->flag_usemmap == MMAP_DISABLE)
>+		DEBUG_MSG("mmap() is disabled by specified option '--non-mmap'.\n");
>
> 	return TRUE;
> }
>--
>2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
