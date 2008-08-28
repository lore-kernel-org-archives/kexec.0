Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYoVc-0003x9-3j
	for kexec@lists.infradead.org; Thu, 28 Aug 2008 20:54:24 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <431757fd0808281103s414a0eaucf089a8b5da34b0@mail.gmail.com>
Date: Thu, 28 Aug 2008 13:51:38 -0700
In-Reply-To: <431757fd0808281103s414a0eaucf089a8b5da34b0@mail.gmail.com>
	(Manish Lachwani's message of "Thu, 28 Aug 2008 11:03:47 -0700")
Message-ID: <m1fxooc17p.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Kexec on ARM V6
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
To: Manish Lachwani <mlachwani@gmail.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

"Manish Lachwani" <mlachwani@gmail.com> writes:

> Hello Eric,
>
> I am trying to get kexec working on an ARM V6 board (1136) using the
> 2.0.0 version of the kexec-tools.
>
> Firstly, it appears that uname checks for "arm". The ARM V6 board that
> I have has "armv6l" in the uname. I have hacked this support for
> armv6l.
>
> const struct arch_map_entry arches[] = {
>        { "arm", KEXEC_ARCH_ARM },
>        { "armv6l", KEXEC_ARCH_ARM },
>        { 0 },
> };
>
> I can send you a patch as well.
>
> The loading seems to work ok. On "kexec -e", I see:
>
> Starting new kernel
> Uncompressing
> Linux...................................................................................................
>
> crc error
>
>  -- System halted
>
>
> Has kexec been tried on any ARM yet? unfortunately, I dont have
> another board to try on. Response is highly appreciated.

I'm fairly certain kexec has been tried on ARM.  I'm not
certain what the status of the port is.  arm as I recall is
fairly simple so it should not be hard to make kexec work.

Given that you get Uncompressing Linux and crc error it
looks like the kernel loaded on you arm platform but something
was corrupt.

It might be a problem as simple as you have some weird device
that has not shut down an ongoing DMA transaction at the time
kexec runs.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
