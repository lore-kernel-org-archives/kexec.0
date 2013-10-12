Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VV5sH-00018x-Bd
 for kexec@lists.infradead.org; Sat, 12 Oct 2013 20:33:22 +0000
Received: by mail-ea0-f176.google.com with SMTP id q16so2527767ead.7
 for <kexec@lists.infradead.org>; Sat, 12 Oct 2013 13:32:53 -0700 (PDT)
Date: Sat, 12 Oct 2013 23:32:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
Message-ID: <20131012203250.GA3458@p183.telecom.by>
References: <20131002140356.63706540@holzheu> <524D0ADF.2010507@jp.fujitsu.com>
 <52521FA5.3040101@jp.fujitsu.com>
 <CACVxJT8S7kA92=80DWVmVJJvbnaQ6WkyvsiFq4wP37WHV=tfuA@mail.gmail.com>
 <52552C9F.2030404@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52552C9F.2030404@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jan Willeke <willeke@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Oct 09, 2013 at 07:14:55PM +0900, HATAYAMA Daisuke wrote:
> Hello,
> 
> (2013/10/08 21:49), Alexey Dobriyan wrote:
> > On Mon, Oct 7, 2013 at 5:42 AM, HATAYAMA Daisuke
> > <d.hatayama@jp.fujitsu.com> wrote:
> >
> >> +static unsigned long
> >> +get_unmapped_area_vmcore(struct file *filp, unsigned long addr,
> >> +                        unsigned long len, unsigned long pgoff,
> >> +                        unsigned long flags)
> >> +{
> >> +#ifdef CONFIG_MMU
> >> +       return current->mm->get_unmapped_area(filp, addr, len, pgoff,
> >> flags);
> >> +#else
> >> +       return -EIO;
> >> +#endif
> >> +}
> >> +
> >>   static const struct file_operations proc_vmcore_operations = {
> >>          .read           = read_vmcore,
> >>          .llseek         = default_llseek,
> >>          .mmap           = mmap_vmcore,
> >> +       .get_unmapped_area = get_unmapped_area_vmcore,
> >
> > I think current->mm->get_unmapped_area should be used by core proc code.
> 
> What do you actually suggest here? You mean moving this code in proc code?
> I don't think you suggest so.

Please, try this patch, I don't have kexec setup handy.

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -291,7 +291,11 @@ static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long
 	int rv = -EIO;
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 	if (use_pde(pde)) {
-		get_unmapped_area = pde->proc_fops->get_unmapped_area;
+		get_unmapped_area = current->mm->get_unmapped_area;
+#ifdef CONFIG_MMU
+		if (pde->proc_fops->get_unmapped_area)
+			get_unmapped_area = pde->proc_fops->get_unmapped_area;
+#endif
 		if (get_unmapped_area)
 			rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
 		unuse_pde(pde);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
