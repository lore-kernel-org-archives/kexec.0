Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OC0J2-0006wM-7K
	for kexec@lists.infradead.org; Wed, 12 May 2010 01:00:13 +0000
Date: Wed, 12 May 2010 11:00:03 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
Message-ID: <20100512010003.GB3548@drongo>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia>
	<30983.1273620594@neuling.org> <1273624565.5738.8.camel@concordia>
	<7247.1273624988@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7247.1273624988@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>

On Wed, May 12, 2010 at 10:43:08AM +1000, Michael Neuling wrote:

> We probably only do the remove on < 1% of the hptes now.  So I doubt we
> would get a speedup since most of the time we aren't do the remove
> anymore.

It would be nice to have some actual numbers.  Could you add some
counters and print the results at the end?  (Or don't you have any
way to print things at that stage?)

Paul.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
