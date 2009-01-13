Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LMmXz-00042V-Oa
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 16:55:26 +0000
Date: Tue, 13 Jan 2009 08:43:11 -0800
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: newbie question: kexec linux-based bootstrap
Message-ID: <20090113164311.GB19417@nlxdcldnl2.cl.intel.com>
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
	<496B4127.1070201@anduras.de>
	<20090113144947.GA19417@nlxdcldnl2.cl.intel.com>
	<F795765B112E7344AF36AA911279641508F6B692@xmb-sjc-212.amer.cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F795765B112E7344AF36AA911279641508F6B692@xmb-sjc-212.amer.cisco.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: "David N. Lombard" <dnlombar@plxs0284.pdx.intel.com>, Sven Anders <anders@anduras.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Jan 13, 2009 at 07:42:57AM -0800, Bizhan Gholikhamseh (bgholikh) wrote:
> > On IA using kexec-tools 2.0.0, use a command like this to load the
> kernel:
> > 
> >     kexec -l bzImage --initrd=initrd.img
> --command-line="kernel-cmd-args"
> > 
> > where
> > 	bzImage is the kernel's bzImage file
> > 	initrd.img is the initrd image file
> > 	kernel-cmd-args are the kernel's command line args
> > 
> > Then, boot the kernel with:
> > 
> >     kexec -e
> 
> We are using ramdisk instead of initrd, do you know what arguments I
> need to pass to point to the ramdisk install on a partition on SATA
> disk: e.g /dev/sda2?

I'm not sure what you mean by "ramdisk install on ... SATA disk".

If you want to just try kexec, take look at your current boot
configuration file, e.g., /boot/grub/grub.conf.  For example, on my F7
system, I have the following stanza:

  title Fedora (2.6.23.15-80.fc7)
    root (hd0,0)
    kernel /vmlinuz-2.6.23.15-80.fc7 ro root=/dev/VolGroup00/LogVol00 rhgb quiet
    initrd /initrd-2.6.23.15-80.fc7.img

I could boot that as follows:

  kexec -l /boot/vmlinuz-2.6.23.15-80.fc7 \
    --initrd=/boot/initrd-2.6.23.15-80.fc7.img \
    --command-line="ro root=/dev/VolGroup00/LogVol00 rhgb quiet"
  kexec -e

Alternatively, to boot a diskless kernel/initrd, I might use

  kexec -l vmlinuz --initrd=initrd.img --command-line="root=/dev/ram rw"
  kexec -e

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
