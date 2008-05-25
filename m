Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 52.19.354a.static.theplanet.com ([74.53.25.82]
	helo=elimiz.elimizonline.net)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0GoG-0003AE-Pu
	for kexec@lists.infradead.org; Sun, 25 May 2008 14:02:53 +0000
Received: from [91.98.72.124] (helo=ArminLaptop)
	by elimiz.elimizonline.net with esmtpa (Exim 4.68)
	(envelope-from <zoup@zoup.org>) id 1K0Go6-00044T-7l
	for kexec@lists.infradead.org; Sun, 25 May 2008 19:02:43 +0500
Date: Sun, 25 May 2008 18:19:54 +0430
From: Armin ranjbar <zoup@zoup.org>
Subject: Re: Freeze problem
Message-Id: <20080525181954.4091b47e.zoup@zoup.org>
In-Reply-To: <20080525152720.6b4f1ede@kopernikus.site>
References: <20080525151904.10392ec8.zoup@zoup.org>
	<20080525130732.32ddc731@kopernikus.site>
	<20080525170335.00ef0676.zoup@zoup.org>
	<20080525152720.6b4f1ede@kopernikus.site>
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

On Sun, 25 May 2008 15:27:20 +0200
Bernhard Walle <bwalle@suse.de> wrote:
>    kexec --console-vga --debug -p /boot/vmlinux ....
> 
> That gives a bit more diagnostics in purgatory code to see where the
> system hangs. However, not sure if that also works when booting the
> crashkernel. Can you try a normal kexec (with -l) first and see if that
> works in your configuration?

Yes thats works perfectly ( with -l ), 
you want result of that debug command if it failed or not ?

-- 
Armin ranjbar , System Administrator

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
