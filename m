Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout-xforward.kundenserver.de ([212.227.17.5])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L3XBM-0002w9-8m
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 14:40:28 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC on
	boot
Date: Fri, 21 Nov 2008 15:40:02 +0100
References: <200811191450.59361.arnd@arndb.de>
	<200811201823.25263.arnd@arndb.de>
	<1227235450.7185.214.camel@pasglop>
In-Reply-To: <1227235450.7185.214.camel@pasglop>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200811211540.03281.arnd@arndb.de>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org, cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>

On Friday 21 November 2008, Benjamin Herrenschmidt wrote:
> Oh just that for powermac for example, I know I'm resetting the thing,
> so can't rely on init values, and on some BML embedded boxes too, while
> on things like cell I don't off hand know what the right CPU number is
> to hit the right C3PO interrupt, so I'm better off reading what SLOF
> did :-)

The current code will always use destination 0 for any MPIC, because
mpic_init is run befew smp_init and it currently uses the local CPU.

If an SMP powermac requires a specific destination setting in the
secondary MPIC, either the current mpic_init code is broken there
in the same way as on cell, or more broken if it requires something
other than destination 0.

> But if you think on Cell we can just hard wire in the platform code,
> then I'm ok.

On cell, I know that destination 0 is always correct because of the wiring
inside of Axon.

	Arnd <><

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
