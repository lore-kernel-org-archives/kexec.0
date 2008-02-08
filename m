Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from blaine.gmane.org ([80.91.229.8] helo=hugh.gmane.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JNWVW-0004I9-26
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 16:55:29 +0000
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <public@hugh.gmane.org>) id 1JNWVD-0008Pm-6b
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 17:55:03 +0100
Subject: Re: [PATCH],
	issue EOI to APIC prior to calling crash_kexec in die_nmi path
From: Andi Kleen <andi@firstfloor.org>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu> <20080206224805.GD11886@redhat.com>
	<47AA3B16.7000507@zytor.com> <20080206233657.GB12393@elte.hu>
	<m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
	<20080207121719.GA29279@hmsreliant.think-freely.org>
	<20080207122404.GA8195@elte.hu>
Date: Fri, 08 Feb 2008 17:54:29 +0100
In-Reply-To: <20080207122404.GA8195@elte.hu> (Ingo Molnar's message of "Thu\,
	7 Feb 2008 13\:24\:04 +0100")
Message-ID: <p73ir0z2xtm.fsf@bingen.suse.de>
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
To: Ingo Molnar <public-mingo-X9Un+BFzKDI@hugh.gmane.org>
Cc: public-kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@hugh.gmane.org, Neil Horman <public-nhorman-2XuSBdqkA4R54TAoqtyWWQ@hugh.gmane.org>, "Eric W. Biederman" <public-ebiederm-aS9lmoZGLiVWk0Htik3J/w@hugh.gmane.org>, public-linux-kernel-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org, public-mingo-H+wXaHxf7aLQT0dZR+AlfA@hugh.gmane.org, Vivek Goyal <public-vgoyal-H+wXaHxf7aLQT0dZR+AlfA@hugh.gmane.org>, public-tglx-hfZtesqFncYOwBW4kG4KsQ@hugh.gmane.org, "H. Peter Anvin" <public-hpa-YMNOUZJC4hwAvxtiuMwx3w@hugh.gmane.org>



Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org> writes:
>
> try a dummy iret, something like:
>
>   asm volatile ("pushf; push $1f; iret; 1: \n");
>
> to get the CPU out of its 'nested NMI' state. (totally untested)

Just if you do this while running on the NMI stack (and I think
you do if you insert it at the same place as Neil's original patch)
and another NMI happens for some reason you will be dead
because your stack will corrupt.

If you really want nested NMIs you would need to fix up the NMI
stacks first by pointing them below your own stack.

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
