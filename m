Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dE4VI-0008GI-9Q
 for kexec@lists.infradead.org; Fri, 26 May 2017 01:57:26 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile Patch] Fix get_kcore_dump_loads() error case
Date: Fri, 26 May 2017 01:48:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDB29C@BPXM01GP.gisp.nec.co.jp>
References: <15e94cae34dbec7ebd029f0048cf9e471915c880.1495697583.git.panand@redhat.com>
In-Reply-To: <15e94cae34dbec7ebd029f0048cf9e471915c880.1495697583.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "piliu@redhat.com" <piliu@redhat.com>

>commit f10d1e2e94c50 introduced another bug while fixing memory leak.
>Use the braces with if condition.

Thanks, I'll merge this into v1.6.2

Atsushi Kumagai

>Signed-off-by: Pratyush Anand <panand@redhat.com>
>---
> elf_info.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/elf_info.c b/elf_info.c
>index 601d66e3f176..69b1719b020f 100644
>--- a/elf_info.c
>+++ b/elf_info.c
>@@ -893,9 +893,10 @@ int get_kcore_dump_loads(void)
> 		if (p->phys_start == NOT_PADDR
> 				|| !is_phys_addr(p->virt_start))
> 			continue;
>-		if (j >= loads)
>+		if (j >= loads) {
> 			free(pls);
> 			return FALSE;
>+		}
>
> 		if (j == 0) {
> 			offset_pt_load_memory = p->file_offset;
>--
>2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
