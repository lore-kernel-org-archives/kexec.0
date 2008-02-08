Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rgminet01.oracle.com ([148.87.113.118])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JNWej-0000yP-M2
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 17:05:00 +0000
Date: Fri, 8 Feb 2008 09:04:07 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: why kexec insists on syncing with recent kernels?
Message-Id: <20080208090407.4ab240f1.randy.dunlap@oracle.com>
In-Reply-To: <20080208160408.GB18782@redhat.com>
References: <47AB120A.1000600@wpkg.org> <20080207163752.GD11969@redhat.com>
	<47AB38E2.9050509@wpkg.org> <20080208160408.GB18782@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>

On Fri, 8 Feb 2008 11:04:08 -0500 Vivek Goyal wrote:

> On Thu, Feb 07, 2008 at 05:59:14PM +0100, Tomasz Chmielewski wrote:
> > Vivek Goyal schrieb:
> >> On Thu, Feb 07, 2008 at 03:13:30PM +0100, Tomasz Chmielewski wrote:
> >>> According to kernel/kexec.c:
> >>>
> >>>  * kexec does not sync, or unmount filesystems so if you need
> >>>  * that to happen you need to do that yourself.
> >>>
> >>>
> >>
> >> In latest kexec code I do see it syncing. But it does not unmount the
> >> filesystems. So this comment looks like partially wrong.
> >>
> >>> I saw this was true with 2.6.18 kernel (i.e., it didn't sync), but kexec 
> >>> syncs with recent kernels (I checked 2.6.23.14 and 2.6.24):
> >>>
> >>> # kexec -e
> >>> md: stopping all md devices
> >>> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> >>
> >> Which kexec-tools you are using? 
> >
> > # kexec -v
> > kexec 1.101 released 15 February 2005
> >
> >
> >> syncing is initiated by user space so changing kernel will not have
> >> any effect (as long as user space is same). I think just that message
> >> are spitted by kernel, so probably 2.6.18 did not spit any message and
> >> 2.6.24 does.
> >
> > Yes and no.
> > I just booted 2.6.24 on a diskless system (Mandriva) I normally use with 
> > 2.6.18 kernel, did kexec -e... And it executed the kernel immediately, 
> > without any syncing.
> > On Debian, with the same 2.6.24 kernel, it does sync.
> >
> > So what user space part does the syncing (and how to prevent it)?
> 
> Syncing is initiated by kexec-tools. Following is the code in
> kexec/kexec.c in kexec-tools-testing.tar.gz
> 
> 
>         if ((result == 0) && do_sync) {
>                 sync();
> 
> I think this problem has nothing to do with syncing. There seems to be
> some dependency on not shutting down network here. You might want to 
> debug, exactly where does it get stuck.
> 
> - Specify earlyprintk= parameter for second kernel and see if control
>   is reaching to second kernel.
> 
> - Otherwise specify --console-serial parameter on "kexec -l" commandline
>   and it should display a message "I am in purgatory" on serial console.
>   This will just mean that control has reached at least till purgatory.
> 
> Right now  there does not seem to be any option to prevent syncing and 
> I don't know why would one like to have one.
> 
> > (...)
> >
> >
> >>> The way kexec works now makes rebooting unreliable again:
> >>> - network interfaces are brought down,
> >>> - kernel tries to sync - it never will, as we're booted off network, 
> >>> which is down
> >>>
> >>
> >> Kexec has got an option -x --no-ifdown, which will not bring the network
> >> down. Try that. "kexec- -e -x"
> >
> > It does seem to help, thanks.
> >
> > Why it has to be the last option specified?
> >
> 
> I have no idea. This might be an stale comment. Try putting -x before -e.
> 
> > I tried -f option before (don't call shutdown), but it didn't help.
> >
> 
> Even if you did -f, it must have shutdown the network. I think somehow
> in latest kernels there is some dependency on network and that's why
> not shutting down network in this case is helping you.

I'm seeing NFS mounts take forever to unmount (at shutdown/reboot).
(forever => 1 hour ... or never completes)

Is this similar to the problem that the OP is asking about?


---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
