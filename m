Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QXUHo-0002kD-GF
	for kexec@lists.infradead.org; Fri, 17 Jun 2011 08:20:17 +0000
Date: Fri, 17 Jun 2011 10:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] generic-ipi: Initialize call_single_queue before
	enabling interrupt
Message-ID: <20110617081911.GB893@elte.hu>
References: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
	<ABCC2C38C9CAC4indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ABCC2C38C9CAC4indou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>


* Takao Indoh <indou.takao@jp.fujitsu.com> wrote:

> Just a reminder...
> 
> Thanks for acks, but I'm still waiting for inclusion.
> I tested 3.0.0-rc3 and kdump still failed due to pending IPI
> from 1st kernel. Need this patch to fix it.

For any future patch that has a review discussion (like this one) 
please collect Acks and resend the patch with the acks included once 
the discussion results in a final patch, otherwise maintainers might 
skip the patch as "still being reviewed".

I've collected the acks here and started testing your patch.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
