Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IkwZz-0005fN-1v
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 07:52:34 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9P6oPOE023489
	for <kexec@lists.infradead.org>; Thu, 25 Oct 2007 15:50:25 +0900 (JST)
Message-ID: <47203C21.2010505@ah.jp.nec.com>
Date: Thu, 25 Oct 2007 15:48:01 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add new notifier function ,take2
References: <471700F4.1080200@ah.jp.nec.com> <20071018080621.GB8779@in.ibm.com>
	<47171ED9.7010907@ah.jp.nec.com>
	<200710212200.04361.nickpiggin@yahoo.com.au>
In-Reply-To: <200710212200.04361.nickpiggin@yahoo.com.au>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Nick Piggin wrote:
>>> Is it possible to use a single bit of common code and a single
>>> notifier for these things? Or is it too difficult?
>> >
>> > I'm sorry, I can't understand your image well. I'd like to know details of
>> > your image.
> 
> Rather than have each of "RAS tools" have their own notifier, and have
> the user specify the priority of the notifiers, introduce some layer
> which _knows_ that, for example, only one of these subsystems will be
> called (it could arbitrate, perhaps distinguish between destructive and
> non-destructive ones). It would need only a single notifier, but would
> then have a specific way of calling into the ras modules.
> 
> Does this make sense? I guess it is a lot more work to do, so maybe your
> solution is the best one for now.

Hi Nick,

Thank you for your explanation. I understand. :-)

This is crash_stop (the common infrastructure for debug tools) by Keith Owens.
http://www.mail-archive.com/linux-arch@vger.kernel.org/msg01929.html

Is it same as your idea? I think it is very nice solution for debug tools
conflict problem.

By the way, on old notify_chain, if admin wants to change the list order, admin
have to recompile the kernel. My patches add new *generic* notify_chain which
admin can modify the list order. My patches are not only for RAS tools problem.

I'm happy if both patches are merged into mainline. :-)

Thanks,
  Takenori

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
