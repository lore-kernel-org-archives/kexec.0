Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Apr 2020 10:01:44 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407080144.GA20773@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200407073117.GH25745@shell.armlinux.org.uk>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org

On Tue, Apr 07, 2020 at 08:31:17AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Apr 06, 2020 at 10:10:53PM +0200, Corentin Labbe wrote:
> > On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > > > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > > > Hello
> > > > > > 
> > > > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > > > 
> > > > > > But kexec 2.0.18 fail to work:
> > > > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > > > 
> > > > > What happens if you omit the dtb argument?
> > > > > 
> > > > 
> > > > No change without dtb
> > > > 
> > > > I have also tried to add --mem-mim and --mem-max without any change.
> > > > I given mem according to what I saw in /proc/iomem
> > > > 20000000-9fffffff : System RAM
> > > >   20008000-207fffff : Kernel code
> > > >   20900000-209a0c87 : Kernel data
> > > > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > > > Anyway, the result is always the same.
> > > 
> > > The next step is to enable the early debugging - first in the
> > > decompressor - add #define DEBUG to the top of
> > > arch/arm/boot/compressed/head.S
> > > 
> > > Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> > > get anything from the new kernel.
> > > 
> > 
> > I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
> > Furthermore, I have added crashkernel=128M to the cmdlist
> > I have verified that the reservation is working:
> > 20000000-9fffffff : System RAM
> >   20008000-207fffff : Kernel code
> >   20900000-209a0c87 : Kernel data
> >   40000000-47ffffff : Crash kernel
> > But even with this reservation, no change.
> 
> crashkernel is only necessary if you're loading a kenrel image to be
> booted when the existing one has crashed. For the problem you're
> seeing, it's an unnecessary additional change; please drop that.
> 
> You could try running kexec with debug enabled to see more information.
> 

I am already running with --debug

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
