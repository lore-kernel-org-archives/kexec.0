Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OrKfk-0003ub-Ns
	for kexec@lists.infradead.org; Fri, 03 Sep 2010 01:02:30 +0000
Date: Fri, 3 Sep 2010 10:00:50 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: fix /proc/vmcore seek
Message-Id: <20100903100050.1943c4c3.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <2091492614.1926861283437436205.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <201009021420.19914.arnd@arndb.de>
	<2091492614.1926861283437436205.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, fweisbec@gmail.com, mingo@elte.hu, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de, kamezawa hiroyu <kamezawa.hiroyu@jp.fujitsu.com>


Hi CAI, Arnd,

On Thu, 2 Sep 2010 10:23:56 -0400 (EDT)
CAI Qian <caiqian@redhat.com> wrote:
> 
> ----- "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > Commit 73296bc611 "procfs: Use generic_file_llseek in /proc/vmcore"
> > broke
> > seeking on /proc/vmcore. This changes it back to use default_llseek
> > in order to restore the original behaviour.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: stable@kernel.org
> > 
> > ---
> > On Thursday 02 September 2010, CAI Qian wrote:
> > > 
> > > Ken'ichi, it turned out this kernel patch caused makedumpfile
> > failure below.
> > > I am not sure if this is a kernel bug or makedumpfile needs to catch
> > up with
> > > the change.
> > 
> > It doesn't matter who is correct here. A user program regressed
> > because of a
> > kernel change, so we need to fix the kernel. Thanks for the report!
> > 
> > Please try this patch.
>
> Confirmed makedumpfile is working again after applied this patch.

Thank you for investigating.
IIUC, this problem may happen if using "cp" command instead of
makedumpfile.

Does the following method in generic_file_llseek_unlocked() fail ?
Is inode->i_sb->s_maxbytes too small ?

     65         if (offset < 0 || offset > inode->i_sb->s_maxbytes)
     66                 return -EINVAL;


Thanks
Ken'ichi Ohmichi

> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -163,7 +163,7 @@ static ssize_t read_vmcore(struct file *file, char
> > __user *buffer,
> >  
> >  static const struct file_operations proc_vmcore_operations = {
> >  	.read		= read_vmcore,
> > -	.llseek		= generic_file_llseek,
> > +	.llseek		= default_llseek,
> >  };
> >  
> >  static struct vmcore* __init get_new_element(void)
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
