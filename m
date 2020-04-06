Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Apr 2020 11:25:40 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200406092540.GB31279@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200406091600.GF25745@shell.armlinux.org.uk>
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

On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > 
> > But kexec 2.0.18 fail to work:
> > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> 
> What happens if you omit the dtb argument?
> 

No change without dtb

I have also tried to add --mem-mim and --mem-max without any change.
I given mem according to what I saw in /proc/iomem
20000000-9fffffff : System RAM
  20008000-207fffff : Kernel code
  20900000-209a0c87 : Kernel data
So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
Anyway, the result is always the same.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
