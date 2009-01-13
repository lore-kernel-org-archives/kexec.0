Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMlPv-0001iP-6p
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 15:43:05 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: newbie question: kexec linux-based bootstrap
Date: Tue, 13 Jan 2009 07:42:57 -0800
Message-ID: <F795765B112E7344AF36AA911279641508F6B692@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <20090113144947.GA19417@nlxdcldnl2.cl.intel.com>
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
	<496B4127.1070201@anduras.de>
	<20090113144947.GA19417@nlxdcldnl2.cl.intel.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
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
To: "David N. Lombard" <dnlombar@ichips.intel.com>, Sven Anders <anders@anduras.de>
Cc: kexec@lists.infradead.org

> On IA using kexec-tools 2.0.0, use a command like this to load the
kernel:
> 
>     kexec -l bzImage --initrd=initrd.img
--command-line="kernel-cmd-args"
> 
> where
> 	bzImage is the kernel's bzImage file
> 	initrd.img is the initrd image file
> 	kernel-cmd-args are the kernel's command line args
> 
> Then, boot the kernel with:
> 
>     kexec -e

We are using ramdisk instead of initrd, do you know what arguments I
need to pass to point to the ramdisk install on a partition on SATA
disk: e.g /dev/sda2?

 Bizhan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
