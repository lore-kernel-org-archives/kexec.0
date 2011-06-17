Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QXai9-00071x-7F
	for kexec@lists.infradead.org; Fri, 17 Jun 2011 15:11:55 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [PATCH v2] generic-ipi: Initialize call_single_queue before
	enabling interrupt
Date: Fri, 17 Jun 2011 11:11:01 -0400
MIME-Version: 1.0
In-Reply-To: <20110617081911.GB893@elte.hu>
References: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
	<ABCC2C38C9CAC4indou.takao@jp.fujitsu.com>
	<20110617081911.GB893@elte.hu>
Message-Id: <ACCC2D00C516DAindou.takao@jp.fujitsu.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, 17 Jun 2011 10:19:11 +0200, Ingo Molnar wrote:

>
>* Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>
>> Just a reminder...
>> 
>> Thanks for acks, but I'm still waiting for inclusion.
>> I tested 3.0.0-rc3 and kdump still failed due to pending IPI
>> from 1st kernel. Need this patch to fix it.
>
>For any future patch that has a review discussion (like this one) 
>please collect Acks and resend the patch with the acks included once 
>the discussion results in a final patch, otherwise maintainers might 
>skip the patch as "still being reviewed".
>
>I've collected the acks here and started testing your patch.

Ok, understood. Thanks for your advice.

Thanks,
Takao Indoh


>
>Thanks,
>
>	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
