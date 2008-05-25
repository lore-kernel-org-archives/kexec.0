Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0GFw-0002JT-33
	for kexec@lists.infradead.org; Sun, 25 May 2008 13:27:24 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9095F45DDC
	for <kexec@lists.infradead.org>; Sun, 25 May 2008 15:27:22 +0200 (CEST)
Date: Sun, 25 May 2008 15:27:20 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Freeze problem
Message-ID: <20080525152720.6b4f1ede@kopernikus.site>
In-Reply-To: <20080525170335.00ef0676.zoup@zoup.org>
References: <20080525151904.10392ec8.zoup@zoup.org>
	<20080525130732.32ddc731@kopernikus.site>
	<20080525170335.00ef0676.zoup@zoup.org>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

* Armin ranjbar <zoup@zoup.org> [2008-05-25 17:03]:
>
> Armin ranjbar , System Administrator
> i did tried vga=normal , still freezes , different is that the shell
> cursor is still blinking , very strange . 
> no panic like LED flashing , in fact no flashing at all .

That's a hardware cursor, it always blinks. That doesn't mean anything.

However, you might try serial console to get a bit more diagnostic.
Also, please try (if you still use VGA)

   kexec --console-vga --debug -p /boot/vmlinux ....

That gives a bit more diagnostics in purgatory code to see where the
system hangs. However, not sure if that also works when booting the
crashkernel. Can you try a normal kexec (with -l) first and see if that
works in your configuration?


	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
