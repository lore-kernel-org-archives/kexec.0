Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c4hLV-0006wA-O2
 for kexec@lists.infradead.org; Thu, 10 Nov 2016 04:52:18 +0000
Date: Thu, 10 Nov 2016 12:51:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2] makedumpfile: Adapt code to get value of phys_base
Message-ID: <20161110045153.GD22737@x1>
References: <1478595319-9299-1-git-send-email-bhe@redhat.com>
 <1478595319-9299-2-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7E412@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E7E412@BPXM01GP.gisp.nec.co.jp>
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
Cc: "panand@redhat.com" <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 11/10/16 at 03:57am, Atsushi Kumagai wrote:
> >Kernel code only exports virtual address of phys_base now and it's helpless
> >for Crash and Makedumpfile. Below patch which changes code to export value
> >of phys_base has been posted to upstream. So adapt code to get it.
> >
> >kexec: Change to export the value of phys_base instead of symbol address
> >marc.info/?l=linux-kernel&m=147856863629624&w=2
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> I suspect that this patch will break backward compatibility.
> 
> >---
> > arch/x86_64.c  | 7 +++++--
> > makedumpfile.c | 5 ++---
> > makedumpfile.h | 2 +-
> > 3 files changed, 8 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/x86_64.c b/arch/x86_64.c
> >index 3ef33ae..8593c1a 100644
> >--- a/arch/x86_64.c
> >+++ b/arch/x86_64.c
> >@@ -61,7 +61,10 @@ get_phys_base_x86_64(void)
> > 	/*
> > 	 * Get the relocatable offset
> > 	 */
> >-	info->phys_base = 0; /* default/traditional */
> >+	if (NUMBER(phys_base) != NOT_FOUND_NUMBER) {
> >+		info->phys_base = NUMBER(phys_base);
> >+		return TRUE;
> >+	}
> >
> > 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
> > 		if (virt_start >= __START_KERNEL_map) {
> >@@ -189,7 +192,7 @@ vtop4_x86_64(unsigned long vaddr)
> > 	unsigned long pte_paddr, pte;
> > 	unsigned long phys_base;
> >
> >-	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
> >+	if (NUMBER(phys_base) != NOT_FOUND_NUMBER)
> > 		phys_base = info->phys_base;
> > 	else
> > 		phys_base = 0;
> 
> In older kernel, even if get_phys_base_x86_64() calculates info->phys_base
> from PT_LOAD, it will not be used since the kernels export *SYMBOL*(phys_base)
> and phys_base will be always set to 0 here.
> Is this check really needed ? Why don't you just set info->phys_base
> to phys_base ? (Of course, info->phys_base should be initialized with 0
> in get_phys_base_x86_64() in that case.)

You are right. Will change as you suggested and repost.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
