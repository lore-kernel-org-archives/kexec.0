Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I8apD-0007Xd-2t
	for kexec@lists.infradead.org; Wed, 11 Jul 2007 07:57:45 -0400
Date: Wed, 11 Jul 2007 07:57:29 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070711115729.GA6685@hmsendeavour.rdu.redhat.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070709092154.GA19705@suse.de>
	<20070709114131.GA18750@localdomain>
	<20070710150037.GB10216@in.ibm.com>
	<20070710171740.GA11130@hmsendeavour.rdu.redhat.com>
	<20070710173541.GA21743@localdomain>
	<20070710190009.GB11130@hmsendeavour.rdu.redhat.com>
	<20070710203645.GB22675@localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710203645.GB22675@localdomain>
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
To: Dan Aloni <da-x@monatomic.org>
Cc: Neil Horman <nhorman@redhat.com>, Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Tue, Jul 10, 2007 at 11:36:45PM +0300, Dan Aloni wrote:
> On Tue, Jul 10, 2007 at 03:00:09PM -0400, Neil Horman wrote:
> > On Tue, Jul 10, 2007 at 08:35:41PM +0300, Dan Aloni wrote:
> >[...]
> > > 
> > > Isn't there some sort of a circular dependency going on here? As I 
> > > understand it the vmlinux binary already contains the initramfs as 
> > > built-in data (at least that's what I use here for initramfs). It 
> > You're misunderstood.  The vmlinux binary and the initramfs are stored in the
> > same protected memory area when you execute a kexec -l, but they are separate
> > and distinct files.
> > 
> > > makes more sense if you guys are creating an _initrd_ image (that's 
> > > what mkinitrd originally did AFAIK) and supply it to the boot-loader.
> > initrd is old, initramfs is the new way to go, but they effecitvley do the same
> > thing, and while the initramfs _can_ be built into the kernel, it can also be
> > separately managed (which is what most distros tend to do, AFAICS).
> > Neil
> 
> Yes, I was under the impression that the external initramfs was the 
> 'special case' and I seem to forget about it, I guess that's what most  
> kernel distribution still do (I haven't been using a distribution-supplied 
> kernel for quite a while...).
> 
> Anyway, the patches I contributed in one the previous mail (didn't reach 
> the kexec list due to moderation but available on LKML) can help with 
> what Bernhard is aiming for. I took quite a dive into makedumpfile's code 
> to figure out what's the best way to integrate it. What I was thinking 
> was something in the lines of:
> 
>  * early on, detect if /proc/vmcore has a LINUX elf note 
>    * if it has, then don't require '-x' or '-i' on the command line,
>      extract it to a temporary file and treat it as a CONFIGFILE for 
>      the rest of the code flow.
>    * otherwise, continue with the regular flow.
> 
This would make sense to me.

> For just extracting OSRELEASE, it is possible to write a simple program or 
> script that searches for it at the first few kilobytes of the file.
> 
Also seems reasonable.

Regards
Neil

> -- 
> Dan Aloni
> XIV LTD, http://www.xivstorage.com
> da-x (at) monatomic.org, dan (at) xiv.co.il

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
