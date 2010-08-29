Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Opg0r-0001XP-DH
	for kexec@lists.infradead.org; Sun, 29 Aug 2010 11:25:26 +0000
Date: Sun, 29 Aug 2010 07:24:53 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <633505726.1479321283081093502.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4C7A20F6.5070802@kernel.org>
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

> On 08/29/2010 09:01 AM, caiqian@redhat.com wrote:
> > Further bisect indicated this bad commit from the merge. Given kdump
> > kernel was running with maxcpus=1, I guess this work caused fs/bio.c
> > hung in the workqueue on UP. Reverted the whole merge let kdump work
> > again.
> 
> Can you please pull from the following git tree and see whether it
> fixes the problem?  There was a bug in nr_active accounting.
It had the same problem.
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-linus
> 
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
