Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NcmAt-00045o-4d
	for kexec@lists.infradead.org; Wed, 03 Feb 2010 20:50:15 +0000
Date: Wed, 3 Feb 2010 15:50:08 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: problems in loading capture kernel
Message-ID: <20100203205008.GD17059@redhat.com>
References: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09A5@lion.reldatainc.local>
	<20100203202510.GC17059@redhat.com>
	<32AB6BC050DF9E4E91868C4C3B7B6ABBAE09B6@lion.reldatainc.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09B6@lion.reldatainc.local>
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
To: Soumendu Satapathy <soumendu.satapathy@reldata.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Wed, Feb 03, 2010 at 03:41:25PM -0500, Soumendu Satapathy wrote:

> Oh! I am sorry. That's not an issue, I just did some trace to check the
> errno. The errno = 99 which is invalid address.
> 
> 
> - Have you reserved the space for second kernel?
> 
> Yes, I have reserved with the boot parameters. crashkernel=64M@16M
> 
> 
> - Have you compiled kernel as relocatable one or built a second kernel
>   and trying to load vmlinux.
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> 

Please do not exclude kexec mailing list from CC. Adding it again.

Can you paste your `cat /proc/iomem` output and make sure space for crash
kernel has been reserved.

Thanks
Vivek

> I have used the above config option for the capture kernel . Compiled
> and build it. And was trying to pre-load it using the following command.
> kexec -p  /boot/vmlinuz-2.6.27_capturekernel03feb
> --initrd=/boot/initrd-2.6.27.img  --append="root=/dev/nfs
> nfsroot=192.168.101.3:/FILESYSTEMS/nfs-roots/root-55 ip=dhcp selinux=0
> 1  irqpoll  maxcpus=1  reset_devices"
> 
> 
> - What was the last working version or setup of kdump in your
> environment.
> 
> Kdump worked well in my environment with a vanilla kernel (2.6.18). The
> one that I am using now is a Fedora core 2.6.27 and it is somehow
> failing with it.
> 
> 
> Thanks
> Soumendu
> 
> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@redhat.com] 
> Sent: Wednesday, February 03, 2010 3:25 PM
> To: Soumendu Satapathy
> Cc: Kexec Mailing List
> Subject: Re: problems in loading capture kernel
> 
> On Wed, Feb 03, 2010 at 02:46:53PM -0500, Soumendu Satapathy wrote:
> > Hi Vivek ,
> > 
> >  
> > 
> > I am having some problems to load the capture kernel.
> > 
> >  
> > 
> > The following is the error. I am using a x86_64 box. I am using 2.6.27
> > linux kernel for both the first kernel and the capture kernel. The
> > capture kenel I have configured with CONFIG_SMP=n.
> > 
> > maxcpus=1.
> > 
> >  
> > 
> > kexec_load failed: Cannot assign requested address  99
> > 
> 
> This looks little odd. Where is this address "99" coming from?
> 
> Few things.
> 
> - Have you reserved the space for second kernel?
> - Have you compiled kernel as relocatable one or built a second kernel
>   and trying to load vmlinux.
> - What was the last working version or setup of kdump in your
> environment.
> 
> I would begin at running gdb at kexec to figure out where this seemingly
> bad address "99" coming from.
> 
> CCing kexec mailing list, in case somebody has seen similar message.
> 
> Thanks
> Vivek
> 
> > entry       = 0x92550 flags = 1
> > 
> > nr_segments = 4
> > 
> > segment[0].buf   = 0xb75b40
> > 
> > segment[0].bufsz = 2e77
> > 
> > segment[0].mem   = 0x8f000
> > 
> > segment[0].memsz = 3000
> > 
> > segment[1].buf   = 0xb6e8d0
> > 
> > segment[1].bufsz = 7100
> > 
> > segment[1].mem   = 0x92000
> > 
> > segment[1].memsz = 9000
> > 
> > segment[2].buf   = 0x7f5aab6c4e10
> > 
> > segment[2].bufsz = 3159d0
> > 
> > segment[2].mem   = 0x100000
> > 
> > segment[2].memsz = 316000
> > 
> > segment[3].buf   = 0x7f5aabd6c010
> > 
> > segment[3].bufsz = 13b153
> > 
> > segment[3].mem   = 0x7fec4000
> > 
> > segment[3].memsz = 13c000
> > 
> >  
> > 
> >  
> > 
> > Can you please provide some inputs ?
> > 
> >  
> > 
> > thanks
> > 
> > Soumendu S Satapathy
> > 
> > Senior Software Developer
> > 
> > RELDATA Inc.
> > 
> > 1719 Route 10, Suite 209
> > 
> > Parsippany, NJ 07054
> > 
> > (973) 644-2770  ext. 139  office
> > 
> > 732-692-7230 mobile
> > 
> > (973) 644-3385 fax
> > 
> > soumendu.satapathy@reldata.com
> > 
> > www.reldata.com <http://www.reldata.com/> 
> > 
> >  
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
