Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail2.vodafone.ie ([213.233.128.44])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJXlD-0007ES-H4
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 21:45:16 +0000
Message-ID: <4EA9D09E.800@draigBrady.com>
Date: Thu, 27 Oct 2011 22:43:58 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
Subject: Re: watchdogs and kdump
References: <20111027203029.GR3452@redhat.com>
In-Reply-To: <20111027203029.GR3452@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>
Cc: kexec@lists.infradead.org, linux-watchdog@vger.kernel.org, vgoyal@redhat.com, amwang@redhat.com

On 10/27/2011 09:30 PM, Don Zickus wrote:
> Hi,
> =

> I was assisting a customer the other day debugging a kdump[1] problem, wh=
en we
> noticed the real problem was the hardware watchdog was firing and
> rebooting the box.
> =

> Of course, this can be inconvienant if the panic happens right before the
> watchdog is supposed to be kicked, leading to a spontaneous reboot before
> the second kernel finishes booting and loading the watchdog module.
> =

> I was trying to think of a way to solve this and thought, one way to
> minimize the problem is to kick the watchdog before we jump into the kdump
> kernel.  Another way is to disable the watchdog entirely, but that doesn't
> work on all hardware I believe.
> =

> Anyway, I was posting on the watchdog mailing list to see if anyone had a=
ny
> ideas that might help.  And if my above idea to kick the watchdog before
> jumping into the kdump kernel seems ok, then an api would need to be
> developed.
> =

> I am willing to do any coding and testing necessary, but before I did, I
> wanted help to get a direction to go in first.
> =

> Thoughts?

Seems like the appropriate thing to do is to call all the
reboot notifiers that each watchdog registers.
Since one is not doingn a full SYS_RESTART (SYS_DOWN) though,
i.e. not running through the BIOS code again,
it might be worth having a different SYS_JUMP code in notifier.h
that would allow you to kick rather than stop the watchdogs
as the reboot notifiers generally do at the moment.
I think it would be important not to stop the watchdog if possible,
given the large amount of logic that's going to be executed
after the jump.

cheers,
P=E1draig.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
