Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OpgVL-0008WB-Tg
	for kexec@lists.infradead.org; Sun, 29 Aug 2010 11:56:57 +0000
Date: Sun, 29 Aug 2010 07:56:45 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1236896997.1479691283083005518.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <171172387.1479581283082093912.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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


----- caiqian@redhat.com wrote:

> ----- "Tejun Heo" <tj@kernel.org> wrote:
> 
> > Hello,
> >
> > On 08/29/2010 01:24 PM, CAI Qian wrote:
> > >> On 08/29/2010 09:01 AM, caiqian@redhat.com wrote:
> > >>> Further bisect indicated this bad commit from the merge. Given
> kdump
> > >>> kernel was running with maxcpus=1, I guess this work caused
> > fs/bio.c
> > >>> hung in the workqueue on UP. Reverted the whole merge let kdump
> > work
> > >>> again.
> > >>
> > >> Can you please pull from the following git tree and see whether
> it
> > >> fixes the problem?  There was a bug in nr_active accounting.
> > >
> > > It had the same problem.
> >
> > I see.  Hmm... a different issue then.  Can you please tell me how
> to
> > reproduce the problem?
It is easy to reproduce by passing maxcpus=1 to the first kernel.
> First, to configure kdump - see Documentation/kdump/kdump.txt. It
> might be easier if you are using a distro that provide advanced kdump
> tools. Then, to trigger the kdump - echo c >/proc/sysrq-trigger. In
> case needed, here is the system information,
> # lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> CPU(s):                64
> Thread(s) per core:    2
> Core(s) per socket:    8
> CPU socket(s):         4
> NUMA node(s):          4
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 46
> Stepping:              6
> CPU MHz:               1064.000
> Virtualization:        VT-x
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              256K
> L3 cache:              18432K
> NUMA node0 CPU(s):     0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60
> NUMA node1 CPU(s):     1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61
> NUMA node2 CPU(s):     2,6,10,14,18,22,26,30,34,38,42,46,50,54,58,62
> NUMA node3 CPU(s):     3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63
> 
> > Thanks.
> >
> > --
> > tejun
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
