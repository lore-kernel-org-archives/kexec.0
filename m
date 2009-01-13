Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga10.intel.com ([192.55.52.92] helo=fmsmga102.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LMkmG-0006Ce-Hw
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 15:02:14 +0000
Date: Tue, 13 Jan 2009 06:49:47 -0800
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: newbie question: kexec linux-based bootstrap
Message-ID: <20090113144947.GA19417@nlxdcldnl2.cl.intel.com>
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
	<496B4127.1070201@anduras.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <496B4127.1070201@anduras.de>
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
To: Sven Anders <anders@anduras.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>

On Mon, Jan 12, 2009 at 05:09:59AM -0800, Sven Anders wrote:
> Bizhan Gholikhamseh (bgholikh) schrieb:
> >
> > HI all,
> >
> > =20
> >
> > I have been investigating how to boot Linux as bootstrap to boot
> > another Linux.
> >
> > =20
> >
> > From my understanding, Linux has a kexec system call which provides
> > overlay another Linux image on the current running Linux.
> >
> > =20
> >
> > Is my understanding correct?
> >
> Yes, it correct. We are using a similiar configuration without problems.

I too use kexec & kexec-tools, for a couple of years now.

On IA using kexec-tools 2.0.0, use a command like this to load the kernel:

    kexec -l bzImage --initrd=initrd.img --command-line="kernel-cmd-args"

where
	bzImage is the kernel's bzImage file
	initrd.img is the initrd image file
	kernel-cmd-args are the kernel's command line args

Then, boot the kernel with:

    kexec -e

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
