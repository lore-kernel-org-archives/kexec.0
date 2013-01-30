Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U0bCS-0005AY-4O
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 17:11:52 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0UHBoaE000330
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 12:11:50 -0500
Date: Wed, 30 Jan 2013 12:11:50 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <184157494.18614364.1359565910010.JavaMail.root@redhat.com>
In-Reply-To: <mailman.13964.1359561994.1038.kexec@lists.infradead.org>
Subject: Re: makedumpfile --dump-dmesg option broken on 3.5 kernels and later
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----
>  Bouchard Louis <louis.bouchard@canonical.com> wrote:
> 
> I now have what looks like a working patch for this issue. Thank to Dave
> Anderson (crash) and Eric Biederman (vmcore-dmesg) for having chewed
> most of the work for me.
> 
> My only remaining problem is to be able to print the syslog level as is
> provided in the previous version.  Currently, the kernel doesn't export
> the 'level:3' offset of the log structure in the vmcoreinfo information
> provided in the vmcore.
> 
> Vivek who authored the original kernel/printk.c patch might be able to
> suggest a better way to expose log.level:3 (I did try to patch the
> kernel but got thrown away because of the nature of .level:3 that didn't
> fit the VMCOREINFO_OFFSET macro)
> 
> In the meantime, I only found this kinda ugly hack to work around the
> absence of the structure element :
> 
> >                 /*
> >                  * Ugly hack around absence of log.level:3
> >                  * Hard code log.level offset = log.dict_len + 3
> >                  */
> >                 level = (UCHAR(logptr + OFFSET(log.dict_len)+3)&level_mask);
> >
> >         sprintf(buf,"<%d>[%5lld.%06ld] ",level,nanos,rem/1000);
> 
> Aside from that, I get an identical dmesg output on kernel 3.5 and after.
> 
> I would appreciate comments on the following before I send the patch to
> the list.

IMHO, just drop it.

As I mentioned on the crash-utility list, it's a PITA keeping up with 
the log structure changes, especially when it involves bit-fields.
The vmcore-dmesg facility just ignores displaying the message evel. 
And for the next crash release, I'm putting the finishing touches on 
a new "crash --log vmcore" option (i.e., without requiring the vmlinux
file), and I'm also going to ignore the log-level.

I understand that "makedumpfile --dump-dmesg" and vmcore-dmesg show
the log level for the legacy log buffer dumps, but that's because
they're embedded in the messages themselves. 

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
