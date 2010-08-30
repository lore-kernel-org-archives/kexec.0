Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oq1Y8-0002IL-VY
	for kexec@lists.infradead.org; Mon, 30 Aug 2010 10:25:14 +0000
Date: Mon, 30 Aug 2010 06:24:28 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1633441528.1498131283163868227.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4C7B6C07.6010800@kernel.org>
Subject: Re: kdump regression compared to v2.6.35
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: kexec <kexec@lists.infradead.org>, linux-next@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>


----- "Tejun Heo" <tj@kernel.org> wrote:

> Hello,
> 
> On 08/30/2010 05:42 AM, CAI Qian wrote:
> >> Hmmm... I can't reproduce it here.  I wonder what the difference
> is.
> >> Can you please trigger sysrq-t after the boot is hung and post the
> >> result?
> > Sysrq keys did not work at this early stage of booting for me even
> > adding sysrq_always_enabled.
> 
> I see.  I'll prepare a debug patch which tries to catch long
> execution
> delays in workqueue but in the meantime can you please turn on
> hangcheck timer and see whether it triggers after the kernel hangs
> during boot?
Can't see any difference with hangcheck timer enabled.
> Thanks.
> 
> -- 
> tejun
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
