Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from noname.neutralserver.com ([70.84.186.210])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8Jd1-0005Ej-4T
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 13:36:02 -0400
Date: Tue, 10 Jul 2007 20:35:41 +0300
From: Dan Aloni <da-x@monatomic.org>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710173541.GA21743@localdomain>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070709092154.GA19705@suse.de>
	<20070709114131.GA18750@localdomain>
	<20070710150037.GB10216@in.ibm.com>
	<20070710171740.GA11130@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710171740.GA11130@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Jul 10, 2007 at 01:17:40PM -0400, Neil Horman wrote:
> On Tue, Jul 10, 2007 at 08:30:37PM +0530, Vivek Goyal wrote:
> > I am still thinking that why can't we change initrd building process
> > (Be it mkinitrd or mkdumprd depending on distriution). Whole idea is
> > that while building an initrd/initramfs for the first kernel, one will
> > ask user for kdump kernel (if user wishes to load kdump kenrel through
> > initrd) and then it will generate kdump kenrel's initrd and pack into
> > first kernel's initrd.
> > 
> > So steps would look something like this.
> > 
> > - mkinitrd takes second kernel's vmlinux as argument
> > - mkinitrd runs "makedumpfile -g" on debug version of first kernel's vmlinux.
> > - mkinitrd generates the initramfs for kdump kernel and packs output
> >   of "makedumpfile -g" into that.
> > - mkinitrd packs statically linked kexec, kdump kernel vmlinux/bzImage,
> >   and kdump kernel initramfs into first kernel's initramfs.
> > 
> Agreed, this is exactly what happens right now.

Isn't there some sort of a circular dependency going on here? As I 
understand it the vmlinux binary already contains the initramfs as 
built-in data (at least that's what I use here for initramfs). It 
makes more sense if you guys are creating an _initrd_ image (that's 
what mkinitrd originally did AFAIK) and supply it to the boot-loader.

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
