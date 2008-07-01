Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bobafett.staff.proxad.net ([213.228.1.121])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDg8A-00057U-UR
	for kexec@lists.infradead.org; Tue, 01 Jul 2008 13:42:51 +0000
From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: kexec on mips - anyone has it working?
Date: Tue, 1 Jul 2008 15:42:28 +0200
References: <483BCB75.4050901@wpkg.org>
	<200805301327.11925.nschichan@freebox.fr>
	<483FE764.1090901@wpkg.org>
In-Reply-To: <483FE764.1090901@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807011542.29274.nschichan@freebox.fr>
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
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org, Kexec Mailing List <kexec@lists.infradead.org>

On Friday 30 May 2008 13:39:16 Tomasz Chmielewski wrote:

Hello,

> Nicolas Schichan schrieb:
> > On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
> >> Will call new kernel at 00305000
> >
> > The calling address of the kernel looks quite wrong, it should clearly
> > be inside the KSEG0 zone. could  you please indicate the output of the
> > command "mips-linux-readelf -l vmlinux" ?
>
> # uname -m
> mips
> # readelf -l vmlinux
>
> Elf file type is EXEC (Executable file)
> Entry point 0x80251b50

This is  quite surprising.   The jump address  that kexec will  use is
cleary not what  I expected. I would have expected it  to be the Entry
point address given by readelf.

could  you try  the  following patch  to  make sure  that the  kimage*
structure is not corrupted by the code in machine_kexec() ?

Index: linux/arch/mips/kernel/machine_kexec.c
===================================================================
--- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
+++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
@@ -49,6 +49,8 @@
 	unsigned long entry;
 	unsigned long *ptr;
 
+	printk("image->start = %p", image->start);
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
