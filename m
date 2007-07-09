Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from noname.neutralserver.com ([70.84.186.210])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I7rch-0002OE-Qh
	for kexec@lists.infradead.org; Mon, 09 Jul 2007 12:41:49 +0100
Date: Mon, 9 Jul 2007 14:41:31 +0300
From: Dan Aloni <da-x@monatomic.org>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070709114131.GA18750@localdomain>
References: <20070706132814.GA7079@suse.de>
	<20070706145804.GA31409@localdomain>
	<20070709092154.GA19705@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070709092154.GA19705@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Jul 09, 2007 at 11:21:54AM +0200, Bernhard Walle wrote:
> Hello,
> 
> * Dan Aloni <da-x@monatomic.org> [2007-07-06 16:58]:
> > 
> > Redhat has a makedumpinfo util which they intend to use as slim
> > kernel-version-independent utility on kdump rootfs in order to
> > save /proc/vmcore in a compact manner.
> 
> I think you mean makedumpfile, don't you?

Yes, a typo, sorry.

> > A patch that I am working on will make it possible to integrate
> > the output of 'makedumpinfo -g' into vmlinux as the final build
> > stage of the kernel. This information will be presented itself
> > as /proc/kcore.info for the first kernel throughout its entire
> > execution.
> 
> That sounds good. But I doubt that kernel developers like the idea of
> needing another utility in the build process ...

I don't think it would add much complexity to build process as it 
is now, just like the other tools that transparently do post-linking 
modifications. As far as the developer is concerned, there's just
the vmlinux and/or bzImage files that get emitted at the end.

> > Then inside initramfs of the first kernel, a small 
> > util will modify the vmlinux file of the kdump kernel before it
> > gets loaded so that another special file appearing as 
> > /proc/vmcore.info under the kdump kernel will present the same
> > info. 
> 
> Where do you get the info from? If you're in the kdump initrd,
> then the kdump kernel is already loaded. Do you want to attach the
> info from the crashed kernel to the initrd of the kdump kernel?

Not exactly. Let me describe the procedure in greater detail.
Basically, it would go like this:

1. <normal bootloader boot>
2. <normal initramfs>
3. embed_configfile /proc/kcore.info /vmlinux-kdump
4. kexec -l vmlinux-kdump <....>
5. <boot continues>
6. <crash>
7. <kdump kernel boot>
8. <kdump initramfs runs>
9. makedumpfile -i /proc/vmcore.info <....>

NOTES:
** in step 3 embed_configfile modifies vmlinux-kdump in place, 
   copying /proc/kcore.info into the data section of the vmlinux-kdump 
   at certain symbol (e.g. 'char core_info[0x1000]').
** in step 9 that data section variable (e.g. core_info) which was 
   originally holds the content of /proc/kcore.info is being presented 
   as /proc/vmcore.info for the util to use.

To complete the picture, at the final build stage of vmlinux we 
would have this:

makedumpfile -g vmlinux.configfile -x vmlinuxx
embed_configfile vmlinux.configfile vmlinux
rm vmlinux.configfile

BTW I think there could be a confusion between makedumpfile's 
CONFIGFILE and the .config file, so we should pick a different 
name for it...

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
