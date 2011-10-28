Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJmfA-0006NG-FN
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 13:40:01 +0000
Date: Fri, 28 Oct 2011 09:39:54 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: watchdogs and kdump
Message-ID: <20111028133954.GS3452@redhat.com>
References: <20111027203029.GR3452@redhat.com>
 <4EA9D09E.800@draigBrady.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EA9D09E.800@draigBrady.com>
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
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: kexec@lists.infradead.org, linux-watchdog@vger.kernel.org, vgoyal@redhat.com, amwang@redhat.com

On Thu, Oct 27, 2011 at 10:43:58PM +0100, P=E1draig Brady wrote:
> On 10/27/2011 09:30 PM, Don Zickus wrote:
> > Hi,
> > =

> > I was assisting a customer the other day debugging a kdump[1] problem, =
when we
> > noticed the real problem was the hardware watchdog was firing and
> > rebooting the box.
> > =

> > Of course, this can be inconvienant if the panic happens right before t=
he
> > watchdog is supposed to be kicked, leading to a spontaneous reboot befo=
re
> > the second kernel finishes booting and loading the watchdog module.
> > =

> > I was trying to think of a way to solve this and thought, one way to
> > minimize the problem is to kick the watchdog before we jump into the kd=
ump
> > kernel.  Another way is to disable the watchdog entirely, but that does=
n't
> > work on all hardware I believe.
> > =

> > Anyway, I was posting on the watchdog mailing list to see if anyone had=
 any
> > ideas that might help.  And if my above idea to kick the watchdog before
> > jumping into the kdump kernel seems ok, then an api would need to be
> > developed.
> > =

> > I am willing to do any coding and testing necessary, but before I did, I
> > wanted help to get a direction to go in first.
> > =

> > Thoughts?
> =

> Seems like the appropriate thing to do is to call all the
> reboot notifiers that each watchdog registers.
> Since one is not doingn a full SYS_RESTART (SYS_DOWN) though,
> i.e. not running through the BIOS code again,
> it might be worth having a different SYS_JUMP code in notifier.h
> that would allow you to kick rather than stop the watchdogs
> as the reboot notifiers generally do at the moment.

That is an interesting idea.  Not sure if calling a blocking notifier in
the kdump path would be acceptable to the kexec folks.  Then again using
the reboot notifier in the panic path may not be a good idea either, it
might lead to false expectations. :-/

> I think it would be important not to stop the watchdog if possible,
> given the large amount of logic that's going to be executed
> after the jump.

I agree.  Especially since kdump is still not 100% reliable.

Thanks for the feedback!

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
