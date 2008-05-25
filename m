Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0E4e-00017z-Ot
	for kexec@lists.infradead.org; Sun, 25 May 2008 11:07:37 +0000
Date: Sun, 25 May 2008 13:07:32 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Freeze problem
Message-ID: <20080525130732.32ddc731@kopernikus.site>
In-Reply-To: <20080525151904.10392ec8.zoup@zoup.org>
References: <20080525151904.10392ec8.zoup@zoup.org>
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
To: Armin ranjbar <zoup@zoup.org>
Cc: kexec@lists.infradead.org

Hi,

* Armin ranjbar <zoup@zoup.org> [2008-05-25 15:19]:
> 
> i have a problem with kexec , when i load a panic kernel with kexec -p
> which goes successful and panic the kernel using alt+sysrc+c , well ,
> nothing happens , system says that triggering a panic and it freezes . 
> note that the main kernel and crash kernel are the same and are
> relocate able . 
> .config of kernel http://pastebin.ca/1028714

Did you also try via serial console? Or vga=normal? Does the keyboard
LED work (i.e. toggle CapsLock and see if the LED is still
repsonding). VGA is a known problem when dumping, and often the panic
kernel just boots fine, only the user doesn't recognise.



	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
