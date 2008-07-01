Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bobafett.staff.proxad.net ([213.228.1.121])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDk9i-00061O-GC
	for kexec@lists.infradead.org; Tue, 01 Jul 2008 18:00:43 +0000
From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: kexec on mips - anyone has it working?
Date: Tue, 1 Jul 2008 20:00:40 +0200
References: <483BCB75.4050901@wpkg.org>
	<200807011542.29274.nschichan@freebox.fr>
	<486A6F0D.4070802@wpkg.org>
In-Reply-To: <486A6F0D.4070802@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807012000.40421.nschichan@freebox.fr>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-mips@linux-mips.org, Tomasz Chmielewski <mangoo@wpkg.org>

On Tuesday 01 July 2008 19:53:17 Tomasz Chmielewski wrote:
> > Index: linux/arch/mips/kernel/machine_kexec.c
> > ===================================================================
> > --- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
> > +++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
> > @@ -49,6 +49,8 @@
> >  	unsigned long entry;
> >  	unsigned long *ptr;
> >
> > +	printk("image->start = %p", image->start);
> > +
> >  	reboot_code_buffer =
> >  	  (unsigned long)page_address(image->control_code_page);
>
> Umm?
>
>    CC      arch/mips/kernel/machine_kexec.o
> cc1: warnings being treated as errors
> arch/mips/kernel/machine_kexec.c: In function 'machine_kexec':
> arch/mips/kernel/machine_kexec.c:52: warning: format '%p' expects type
> 'void *', but argument 2 has type 'long unsigned int'
> make[6]: *** [arch/mips/kernel/machine_kexec.o] Error 1
> make[5]: *** [arch/mips/kernel] Error 2
> make[5]: Leaving directory
> `/home/tch-data/openwrt/11612/build_dir/linux-brcm47xx/linux-2.6.25.9'

-Werror is missing from my kernel cflags.

Try this one, %lx will accept unsigned long parameters without warnings:

Index: linux/arch/mips/kernel/machine_kexec.c
===================================================================
--- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
+++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
@@ -49,6 +49,8 @@
 	unsigned long entry;
 	unsigned long *ptr;
 
+	printk("image->start = %lx", image->start);
+
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 

Regards,


-- 
Nicolas Schichan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
