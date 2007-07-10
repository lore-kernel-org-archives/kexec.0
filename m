Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I8Ea3-0000Wc-9y
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 08:12:37 -0400
Date: Tue, 10 Jul 2007 08:12:25 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710121225.GC10121@hmsendeavour.rdu.redhat.com>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070710064817.GC5471@in.ibm.com>
	<20070710081413.GA29034@localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710081413.GA29034@localdomain>
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
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Jul 10, 2007 at 11:14:14AM +0300, Dan Aloni wrote:
> On Tue, Jul 10, 2007 at 12:18:17PM +0530, Vivek Goyal wrote:
> > On Fri, Jul 06, 2007 at 05:58:04PM +0300, Dan Aloni wrote:
> > > 
> >[..]
> > > It contains enough information in order to make a compact kernel
> > > dump (makedumpinfo needs to go over the struct page arrays). As
> > > you see, it also contains the kernel version.
> > > 
> > 
> > But this will not solve Bernhard's problem where looking at a vmcore
> > he wants to know which vmlinux (kernel version with time stamp) has
> > generated this vmcore. So adding a ELF NOTE should help.
> 
> That, or pass it in *runtime* by other means.
Wait a second,  I may have been confused before.  Do you want to know the
version of the crashing kernel when you look at a core in the crash utilty, or
do you want to know it when you are capturing the crash?  If you want the
former, then an ELF NOTE would be perfect.  If you want to know the latter, my
suggestion would be to simply modify mkdumprd to place the name of the crashing
kernel, along with its version directly into the kdump initramfs init script.
We can use makedumpfile or readelf to fish out the utsname and just embed it.
Either approach is rather easy to do I think, the former would require a kernel
modification, while the latter would require some extra scripting.

>  
> > > However, this file needs to be passed somehow to the rootfs
> > > of the kdump kernel. This poses a chicken-and-egg problem on 
> > > my setup where the initramfs of the first kernel contains 
> > > a staticlu linked version of the kexec executable along with a
> > > kdump kernel to be loaded before mount rootfs and running 
> > > init. 
> > > 
> > 
> > Why are you loading kdump kernel from first kernel's initramfs?
> > I guess to enable the dump capture as soon as possible so if some
> > driver panics() you can capture the dump?
> 
> Yes, that's one of the reasons.
>  
> > Can't we modify the initramfs generation process (mkinitrd) to take
> > care of this situation?. By the way, how is second kernel's initramfs
> > is generated currently? The moment we start packing a file which contains
> > the debuginfo for first kernel, initramfs of second kernel becomes dependent
> > on first kernel and to me its not a good approach.
> 
> That's not what I'm aiming for, they are actually independent (my 
> initramfs is a build-time constant). I have described it in another
> mail.
>  
> > A dump kernel and its initrd should be independent of the crashing kernel.
> 
> I agree.
> 
And they are.

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
