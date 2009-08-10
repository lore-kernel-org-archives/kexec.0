Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MaLGu-0008IT-MJ
	for kexec@lists.infradead.org; Mon, 10 Aug 2009 03:10:09 +0000
Message-ID: <4A7F8FE6.9030709@redhat.com>
Date: Mon, 10 Aug 2009 11:11:34 +0800
From: Amerigo Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [Patch 0/7] Implement crashkernel=auto
References: <20090805112123.6552.73574.sendpatchset@localhost.localdomain>	<m1eirqtmey.fsf@fess.ebiederm.org>	<20090805140408.GJ7259@hmsreliant.think-freely.org>	<m1skg5vpgg.fsf@fess.ebiederm.org>
	<4A7A3A78.7080200@redhat.com>	<m1y6pxr737.fsf@fess.ebiederm.org>
	<4A7A506B.2060008@redhat.com>	<m1ljlxsiox.fsf@fess.ebiederm.org>
	<4A7A70E5.2010204@redhat.com>	<m1bpmtqxjh.fsf@fess.ebiederm.org>
	<4A7A7A0F.6070906@redhat.com>	<m1iqh1nxv3.fsf@fess.ebiederm.org>
	<4A7A9E54.60705@redhat.com> <m1iqgze740.fsf@fess.ebiederm.org>
In-Reply-To: <m1iqgze740.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@redhat.com>, tony.luck@intel.com, linux-ia64@vger.kernel.org, Bernhard Walle <bernhard.walle@gmx.de>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Anton Vorontsov <avorontsov@ru.mvista.com>, akpm@linux-foundation.org

Eric W. Biederman wrote:
> Let me put this concrete proposal on the table.
>
> The problem:
>
> With the current set of crashkernel= options we are asking the
> distribution installer to perform magic.  Moving as much of this logic
> into a normal init script for better maintenance is desirable.
>
> My proposal:
>
> Implement crashkernel=max which reserves as much memory as is
> reasonable for a crash kernel, without seriously affecting stability,
> performance, and reliability.
>   

This is almost exactly what I want with crashkernel=auto....
So there's no big difference, except the name.

> As an initial approximation I would use a 32nd of low memory.
>   

Hmm, I think Bernhard's proposal is fine for this case, i.e. we can 
introduce a new syntax, "crashkernel=>>X" which means we reserve 1/2^X 
of system memory.

What do you think?

> In addition implement:
>
> /sys/kernel/crash_size
>
> That can be written to (with enough privileges when no crash kernel is
> loaded) reduce the amount of memory reserved by the crash kernel.
>   

Yeah, this is nice!

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
