Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 6 Jun 2018 10:00:24 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: panic kexec broken on ARM64?
Message-ID: <20180606100024.50be6b75@ezekiel.suse.cz>
In-Reply-To: <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Marc Zyngier <Marc.Zyngier@arm.com>, kexec mailing list <kexec@lists.infradead.org>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

On Wed, 6 Jun 2018 09:02:04 +0200
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Petr,
> 
> Am 05.06.2018 um 19:46 schrieb James Morse:
> > Hi Petr,
> >
> > (CC: +Akashi, Marc)
> >
> > On 05/06/18 09:01, Petr Tesarik wrote:  
> >> I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
> >> when a panic kernel is loaded.  
> > kdump is a best-effort thing, it looks like this is a case where the
> > crashed-kernel can't tear itself down.
> >
> > Do you have the rest of the stack trace? Was it handling an irq when it decided
> > to panic?:
> > https://lkml.org/lkml/2018/3/13/1134  
> 
> the Raspberry Pi 3 B+ support is very fresh (linux-next). Since i didn't 
> see a version, i need to doublecheck.
> 
> You are actually using linux-next and not the downstream kernel?

Very good point. I'll try again with linux-next.

Stay tuned,
Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
