Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqaXO-0001lh-9W
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 07:18:32 +0000
Date: Wed, 22 Mar 2017 03:18:09 -0400 (EDT)
From: Pingfan Liu <piliu@redhat.com>
Message-ID: <1770021705.4797769.1490167089259.JavaMail.zimbra@redhat.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EBA7FF@BPXM01GP.gisp.nec.co.jp>
References: <1490066899-29298-1-git-send-email-piliu@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EBA7FF@BPXM01GP.gisp.nec.co.jp>
Subject: Re: [PATCH] elf_info.c: fix memory leak in get_kcore_dump_loads()
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec@lists.infradead.org





----- Original Message -----
> From: "Atsushi Kumagai" <ats-kumagai@wm.jp.nec.com>
> To: "Pingfan Liu" <piliu@redhat.com>
> Cc: kexec@lists.infradead.org
> Sent: Wednesday, March 22, 2017 2:59:29 PM
> Subject: RE: [PATCH] elf_info.c: fix memory leak in get_kcore_dump_loads()
> 
> Hello Pingfan,
> 
> It would be helpful if you could mention that the patch is for
> makedumpfile when you post that, otherwise I could overlook that.
> 
Sorry, and I will add such info.

Regards,
Pingfan

> Anyway, I'll merge this patch into v1.6.2 after adding semicolon
> to the back of "free(pls)".
> 
> Thanks,
> Atsushi Kumagai
> 
> >Signed-off-by: Pingfan Liu <piliu@redhat.com>
> >---
> > elf_info.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/elf_info.c b/elf_info.c
> >index d84553a..35e754b 100644
> >--- a/elf_info.c
> >+++ b/elf_info.c
> >@@ -893,12 +893,14 @@ int get_kcore_dump_loads(void)
> > 				|| !is_phys_addr(p->virt_start))
> > 			continue;
> > 		if (j >= loads)
> >+			free(pls)
> > 			return FALSE;
> >
> > 		if (j == 0) {
> > 			offset_pt_load_memory = p->file_offset;
> > 			if (offset_pt_load_memory == 0) {
> > 				ERRMSG("Can't get the offset of page data.\n");
> >+				free(pls)
> > 				return FALSE;
> > 			}
> > 		}
> >--
> >2.7.4
> >
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
