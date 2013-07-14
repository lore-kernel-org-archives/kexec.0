Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UyEpt-0007Mm-Fl
 for kexec@lists.infradead.org; Sun, 14 Jul 2013 05:27:06 +0000
Message-ID: <1373779584.19894.270.camel@pasglop>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 14 Jul 2013 15:26:24 +1000
In-Reply-To: <20130714043600.GA30717@concordia>
References: <51DF1BBB.5060904@mail.usask.ca>
 <51DF2229.5010604@mail.usask.ca> <20130712012142.GA24112@concordia>
 <51E07056.8040007@mail.usask.ca> <51E08A40.80900@mail.usask.ca>
 <51E0F41A.20904@mail.usask.ca> <20130714043600.GA30717@concordia>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Chris Friesen <cbf123@mail.usask.ca>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On Sun, 2013-07-14 at 14:36 +1000, Michael Ellerman wrote:
> > >Is this expected behaviour? It seems to be the same in current git
> > >versions of kexec-tools.
> > >
> > >On my system I see "/proc/device-tree/memory".
> > >
> > >If I modify add_usable_mem_property() to also accept "/memory" then
> my

This is a bug in your device-tree. The memory node should have a unit
address which corresponds to it's reg property. I know people tend to
skip it for "0" but it's bad practice.

So for memory starting at 0 it should be memory@0

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
