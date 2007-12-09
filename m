Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J1Adr-00055j-NI
	for kexec@lists.infradead.org; Sun, 09 Dec 2007 01:07:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec jump
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
	<20071208235344.GA17005@elf.ucw.cz> <200712090119.57826.rjw@sisk.pl>
Date: Sat, 08 Dec 2007 18:06:02 -0700
In-Reply-To: <200712090119.57826.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 9 Dec 2007 01:19:56 +0100")
Message-ID: <m1prxgoex1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> I'm not kexec hacker... but maybe this is in good enough state to be
>> merged? It is useful on its own: kexec jump and back means we can dump
>> system then continue running, for example...
>
> As far as I'm concerned, patches [1/4] and [2/4] can go.
>
> The other two are not in that shape yet (especially the [3/4] patch).

Ok.  Then I will see if I can review these in the next couple days
and give some feedback.

At a quick skim through the code it appears there is some more infrastructure
then we need and things can still be simplified.

Since this applies in particular to the user space interface I'm not comfortable
with these patches going in just yet.

The unused KEXEC_PRESERVE_ flags especially give me pause.  Having something
like that, that isn't currently wired up sounds like a bad place to start.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
