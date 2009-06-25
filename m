Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MJeVe-0001XP-UR
	for kexec@lists.infradead.org; Thu, 25 Jun 2009 02:16:26 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5P2GBAE009913 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 25 Jun 2009 11:16:13 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 673D845DE53
	for <kexec@lists.infradead.org>; Thu, 25 Jun 2009 11:16:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 39CA945DE51
	for <kexec@lists.infradead.org>; Thu, 25 Jun 2009 11:16:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E9A1E08005
	for <kexec@lists.infradead.org>; Thu, 25 Jun 2009 11:16:11 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id BB72B1DB8042
	for <kexec@lists.infradead.org>; Thu, 25 Jun 2009 11:16:10 +0900 (JST)
Message-ID: <4A42DDDF.2000403@jp.fujitsu.com>
Date: Thu, 25 Jun 2009 11:15:59 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com> <4A4022EA.1020506@jp.fujitsu.com>
	<20090623055536.GE6865@sgi.com> <4A408D32.9010500@jp.fujitsu.com>
	<20090624111415.GA6878@sgi.com>
In-Reply-To: <20090624111415.GA6878@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Robin Holt <holt@sgi.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Robin Holt wrote:
> The concern is that any time we prevent SAL from receiving control during
> an MCA/INIT, we reduce the maintainability of the machine.  Having them
> masked at any time results in the NMI/INIT not recording the PROM record
> which we use to diagnose where the hang is.

Think about servers which have no such PROM record features... Please?

The original problem here, which I wrote these patches for, is that the
INIT can block retrieving crashdump via kdump.  The crashdump is the only
record which we can use to diagnose where the hang is, if the PROM record
like SGI servers have is not supported.
(I guess the even the PROM record is supported, the crashdump is better,
 more important resource for the trouble shooting.)

My patches will mask MCA/INIT on all CPUs once kdump is invoked (via
panic or INIT), and soon unmask one of them who is going to jump in 2nd
kernel (=kdump kernel) after registering a do-nothing handler.

If there was a pending INIT, it will be received on the cpu as soon as
it is unmasked.  Then the PROM will make a record on it, pass the control
to OS_INIT which does nothing, and return to interrupted context to
continue processing the kdump.

What time point are you concerning?


> In other patches, you implemented a do-nothing handler.  Could that
> be used?

... How?  Maybe I could not catch your point.

It would be useful, but it is only available from the beginning of 2nd
kernel (to be exact, from the end of 1st kernel), until new INIT handlers
for 2nd kernel is registered.


> Alternatively, when the machine is first booted, the handler is defined
> by SAL as a SAL routine.  Could you record that during kernel boot and
> then just set the handler back to the SAL provided one prior to starting
> the kexec kernel boot?  At that point, the machine is more like the
> first boot.  Now that I think about this, this alternative seems fairly
> attractive.

I think it is definitely wrong thing if SAL provides the initial handler
as OS_INIT which can be removed/replaced by OS.

Since INIT event processes PAL_INIT -> SAL_INIT -> OS_INIT(if available),
SAL should keep the entry point of its initial handler and should use it
from SAL_INIT when OS_INIT is not registered.  Ditto to OS_MCA.


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
