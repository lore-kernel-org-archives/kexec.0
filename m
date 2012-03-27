Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SCffv-0000Hp-Nf
 for kexec@lists.infradead.org; Tue, 27 Mar 2012 23:19:41 +0000
Date: Wed, 28 Mar 2012 08:19:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Doing kexec reboot right in systemd
Message-ID: <20120327231929.GA2697@verge.net.au>
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
 <20120322223646.GC26794@verge.net.au>
 <20120326180729.GB5398@tango.0pointer.de>
 <CABRT9RBa-x661VxvvinD6BPdFc0sharst-h9mgz0kht6aQr76Q@mail.gmail.com>
 <20120327100132.GA15921@tango.0pointer.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120327100132.GA15921@tango.0pointer.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lennart Poettering <lennart@poettering.net>
Cc: kexec list <kexec@lists.infradead.org>, Marti Raudsepp <marti@juffo.org>, systemd-devel <systemd-devel@lists.freedesktop.org>

On Tue, Mar 27, 2012 at 12:01:36PM +0200, Lennart Poettering wrote:
> On Mon, 26.03.12 21:25, Marti Raudsepp (marti@juffo.org) wrote:
> 
> > 
> > On Mon, Mar 26, 2012 at 21:07, Lennart Poettering
> > <lennart@poettering.net> wrote:
> > > Marti, sorry for changing my mind on this: would be great if you could
> > > prep a patch for this for systemd itself.
> > 
> > D'oh, I already prepared a patch for kexec, although I haven't sent it
> > out yet.
> 
> OK, I am fine with either.

FWIW, I think systemd is a better place for this change.

> > > Hmm, so since this would then belong in the shutdown path of systemd,
> > > and only be added for the kexec shutdown path I actually think it would
> > > make more sense to add this into systemd itself instead of kexec-tools,
> > > to ensure the right ordering.
> > 
> > Um, why is including in systemd necessary for guaranteeing order?
> 
> It isn't, but it's easier to keep early boot and late shutdown stuff in
> systemd.
> 
> Lennart
> 
> -- 
> Lennart Poettering - Red Hat, Inc.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
