Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OpvH9-0002xT-3R
	for kexec@lists.infradead.org; Mon, 30 Aug 2010 03:43:15 +0000
Date: Sun, 29 Aug 2010 23:42:53 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1888320510.1487031283139773505.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4C7A5455.7060905@kernel.org>
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
Cc: torvalds@linux-foundation.org, linux-next@vger.kernel.org, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>


----- "Tejun Heo" <tj@kernel.org> wrote:

> Hello,
> 
> On 08/29/2010 02:03 PM, CAI Qian wrote:
> > 
> > ----- "Tejun Heo" <tj@kernel.org> wrote:
> > 
> >> On 08/29/2010 01:56 PM, CAI Qian wrote:
> >>> It is easy to reproduce by passing maxcpus=1 to the first kernel.
> >>
> >> Do you mean booting w/ maxcpus=1 hangs the first kernel even w/o
> >> kdump?
> > Yes, here was the log,
> 
> Hmmm... I can't reproduce it here.  I wonder what the difference is.
> Can you please trigger sysrq-t after the boot is hung and post the
> result?
Sysrq keys did not work at this early stage of booting for me even adding sysrq_always_enabled.
> Thanks.
> 
> -- 
> tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
