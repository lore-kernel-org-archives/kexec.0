Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tango.0pointer.de ([85.214.72.216])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCTDt-0000W2-Ix
 for kexec@lists.infradead.org; Tue, 27 Mar 2012 10:01:54 +0000
Date: Tue, 27 Mar 2012 12:01:36 +0200
From: Lennart Poettering <lennart@poettering.net>
Subject: Re: Doing kexec reboot right in systemd
Message-ID: <20120327100132.GA15921@tango.0pointer.de>
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
 <20120322223646.GC26794@verge.net.au>
 <20120326180729.GB5398@tango.0pointer.de>
 <CABRT9RBa-x661VxvvinD6BPdFc0sharst-h9mgz0kht6aQr76Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABRT9RBa-x661VxvvinD6BPdFc0sharst-h9mgz0kht6aQr76Q@mail.gmail.com>
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
To: Marti Raudsepp <marti@juffo.org>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, Simon Horman <horms@verge.net.au>, kexec list <kexec@lists.infradead.org>

On Mon, 26.03.12 21:25, Marti Raudsepp (marti@juffo.org) wrote:

> 
> On Mon, Mar 26, 2012 at 21:07, Lennart Poettering
> <lennart@poettering.net> wrote:
> > Marti, sorry for changing my mind on this: would be great if you could
> > prep a patch for this for systemd itself.
> 
> D'oh, I already prepared a patch for kexec, although I haven't sent it
> out yet.

OK, I am fine with either.

> > Hmm, so since this would then belong in the shutdown path of systemd,
> > and only be added for the kexec shutdown path I actually think it would
> > make more sense to add this into systemd itself instead of kexec-tools,
> > to ensure the right ordering.
> 
> Um, why is including in systemd necessary for guaranteeing order?

It isn't, but it's easier to keep early boot and late shutdown stuff in
systemd.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
