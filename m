Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJWav-0006rk-5A
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 20:30:33 +0000
Date: Thu, 27 Oct 2011 16:30:29 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: watchdogs and kdump
Message-ID: <20111027203029.GR3452@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-watchdog@vger.kernel.org
Cc: kexec@lists.infradead.org, amwang@redhat.com, vgoyal@redhat.com

Hi,

I was assisting a customer the other day debugging a kdump[1] problem, when we
noticed the real problem was the hardware watchdog was firing and
rebooting the box.

Of course, this can be inconvienant if the panic happens right before the
watchdog is supposed to be kicked, leading to a spontaneous reboot before
the second kernel finishes booting and loading the watchdog module.

I was trying to think of a way to solve this and thought, one way to
minimize the problem is to kick the watchdog before we jump into the kdump
kernel.  Another way is to disable the watchdog entirely, but that doesn't
work on all hardware I believe.

Anyway, I was posting on the watchdog mailing list to see if anyone had any
ideas that might help.  And if my above idea to kick the watchdog before
jumping into the kdump kernel seems ok, then an api would need to be
developed.

I am willing to do any coding and testing necessary, but before I did, I
wanted help to get a direction to go in first.

Thoughts?

Cheers,
Don

[1] - I am ignorantly assuming everyone knows what kdump is.  Kdumping is
the ability to jump into a previously loaded kernel in the case of a
panic.  This kdump (second) kernel would run in reserved memory, copy the
first kernel's memory to a file and save it to a pre-determined location.
There is no system reboot in between the first and second kernel, so no
chance for the watchdog to disarm itself.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
