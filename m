Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga10.intel.com ([192.55.52.92] helo=fmsmga102.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NF7Zu-0007k7-6v
	for kexec@lists.infradead.org; Mon, 30 Nov 2009 14:50:18 +0000
Date: Mon, 30 Nov 2009 06:50:10 -0800
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: Kexec not working as expected from inside X
Message-ID: <20091130145010.GA25242@nlxdcldnl2.cl.intel.com>
References: <20091130085740.210870a0vkwm8t0c@webmail.df.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091130085740.210870a0vkwm8t0c@webmail.df.eu>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Mayank Kaushik <mayank.utexas@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Nov 30, 2009 at 12:57:40AM -0700, Bernhard Walle wrote:
> 
> Mayank Kaushik schrieb:
> >
> > Is it something in the nvidia driver that's causing this to not work?
> > Any clues on what's going wrong, or how I can debug this further?
> 
> You should attach a serial console to debug that. Is that possible on
> your system. It's also possible to use a USB-to-RS232 converter on the
> machine that should be debugged. However, that only works after the USB
> drivers have been loaded, so much later than a real serial console.

A normal serial console will do for this particular task, but when you need
very early debugging, there's also a "USB debug" cable.  AFAICT, this is a
sole-source item from Ajays Technology and only sold at
<http://www.semiconductorstore.com/cart/pc/viewprd.asp?idProduct=12083>

See Documentation/x86/earlyprintk.txt on using the device...

It's on my XMAS wish list ;)

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
