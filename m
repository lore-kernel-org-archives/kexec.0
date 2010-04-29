Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O7bqo-0000Xr-2n
	for kexec@lists.infradead.org; Thu, 29 Apr 2010 22:04:56 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: general protection error:0
In-reply-to: <4BD72F0D.5010708@davidnewall.com>
References: <4BD72F0D.5010708@davidnewall.com>
Date: Fri, 30 Apr 2010 08:04:03 +1000
Message-ID: <27864.1272578643@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Newall <kexec@davidnewall.com>
Cc: kexec@lists.infradead.org

David.  

> I'm running Ubuntu Hardy with a 2.6.28 kernel on VirtualBox, and want to 
> simply restart the current kernel (because I'm a kexec noob and that 
> seems a sensible first step.)  I've put "break=init" on the command line 
> so it gives me a shell just before pivoting root from the initrd to the 
> hard-disk.  I do the kexec -l and kexec -e, the kernel (re)starts, does 
> all of the usual startup things, and drops me back in a shell when it's 
> about to start init (break=init, remember?)  At this point, when I try 
> to run almost any command, for example "chroot /root bash", I get 
> "Segmentation fault" with general protection logged in dmesg, for 
> example: "bash[1058] general protection ip:b7f0c425 sb:bfb282f4 
> error:0"  No doubt I'm making a basic mistake, but Google failed to show 
> me what, hence I'm asking here for suggestions.
> 
> Has anyone any suggestion?

2.6.28 is pretty old these days.  It's unlikely someone here is going to
help you debug a kernel that ancient.

Can you retry with current mainline and kexec-tools user space?  Also
post your full boot log and kexec -l and -e outputs when you hit this
problem.

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
