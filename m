Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 52.19.354a.static.theplanet.com ([74.53.25.82]
	helo=elimiz.elimizonline.net)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0FQ0-0006sH-UR
	for kexec@lists.infradead.org; Sun, 25 May 2008 12:33:45 +0000
Date: Sun, 25 May 2008 17:03:35 +0430
From: Armin ranjbar <zoup@zoup.org>
Subject: Re: Freeze problem
Message-Id: <20080525170335.00ef0676.zoup@zoup.org>
In-Reply-To: <20080525130732.32ddc731@kopernikus.site>
References: <20080525151904.10392ec8.zoup@zoup.org>
	<20080525130732.32ddc731@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Sun, 25 May 2008 13:07:32 +0200
Bernhard Walle <bwalle@suse.de> wrote:

> Hi,
> 
> * Armin ranjbar <zoup@zoup.org> [2008-05-25 15:19]:
> > 
> > i have a problem with kexec , when i load a panic kernel with kexec -p
> > which goes successful and panic the kernel using alt+sysrc+c , well ,
> > nothing happens , system says that triggering a panic and it freezes . 
> > note that the main kernel and crash kernel are the same and are
> > relocate able . 
> > .config of kernel http://pastebin.ca/1028714
> 
> Did you also try via serial console? Or vga=normal? Does the keyboard
> LED work (i.e. toggle CapsLock and see if the LED is still
> repsonding). VGA is a known problem when dumping, and often the panic
> kernel just boots fine, only the user doesn't recognise.
> 
> 
> 
> 	Bernhard
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Dear Bernhard

-- 
Armin ranjbar , System Administrator
i did tried vga=normal , still freezes , different is that the shell
cursor is still blinking , very strange . 
no panic like LED flashing , in fact no flashing at all .

its 2.6.25 , debian testing :) 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
