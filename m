Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NF18j-0008Fe-SE
	for kexec@lists.infradead.org; Mon, 30 Nov 2009 07:57:50 +0000
Message-ID: <20091130085740.210870a0vkwm8t0c@webmail.df.eu>
Date: Mon, 30 Nov 2009 08:57:40 +0100
From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: Kexec not working as expected from inside X
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mayank Kaushik <mayank.utexas@gmail.com>
Cc: kexec@lists.infradead.org


Mayank Kaushik schrieb:
>
> Is it something in the nvidia driver that's causing this to not work?
> Any clues on what's going wrong, or how I can debug this further?

You should attach a serial console to debug that. Is that possible on
your system. It's also possible to use a USB-to-RS232 converter on the
machine that should be debugged. However, that only works after the USB
drivers have been loaded, so much later than a real serial console.

Of course it would make sense to try without the "nvidia" driver. Just
edit your xorg.conf and replace "nvidia" with "nv". You don't have any
3D graphics then, but it's only for a test. :-)


Regards,
Bernhard






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
