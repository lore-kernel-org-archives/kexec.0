Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hawking.rebel.net.au ([203.20.69.83])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O6pfi-0001mn-LB
	for kexec@lists.infradead.org; Tue, 27 Apr 2010 18:38:15 +0000
Message-ID: <4BD72F0D.5010708@davidnewall.com>
Date: Wed, 28 Apr 2010 04:08:05 +0930
From: David Newall <kexec@davidnewall.com>
MIME-Version: 1.0
Subject: general protection error:0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I'm running Ubuntu Hardy with a 2.6.28 kernel on VirtualBox, and want to 
simply restart the current kernel (because I'm a kexec noob and that 
seems a sensible first step.)  I've put "break=init" on the command line 
so it gives me a shell just before pivoting root from the initrd to the 
hard-disk.  I do the kexec -l and kexec -e, the kernel (re)starts, does 
all of the usual startup things, and drops me back in a shell when it's 
about to start init (break=init, remember?)  At this point, when I try 
to run almost any command, for example "chroot /root bash", I get 
"Segmentation fault" with general protection logged in dmesg, for 
example: "bash[1058] general protection ip:b7f0c425 sb:bfb282f4 
error:0"  No doubt I'm making a basic mistake, but Google failed to show 
me what, hence I'm asking here for suggestions.

Has anyone any suggestion?

Thanks,

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
