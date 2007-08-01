Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGATl-0002U7-02
	for kexec@lists.infradead.org; Wed, 01 Aug 2007 05:26:56 -0400
Message-ID: <46B051B5.6020207@ah.jp.nec.com>
Date: Wed, 01 Aug 2007 18:26:13 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [patch] add kdump_after_notifier
References: <469F55D0.4050203@ah.jp.nec.com>
	<20070726140702.GA8949@suse.de>	<20070726153240.GA15969@in.ibm.com>
	<20070726153440.GA19095@suse.de>	<20070726154415.GB15969@in.ibm.com>
	<20070726154718.GA25561@suse.de>	<20070726155444.GC15969@in.ibm.com>
	<46A92E30.8070703@ah.jp.nec.com>	<20070730091624.GB6071@in.ibm.com>	<m16442vwgs.fsf@ebiederm.dsl.xmission.com>	<46AECEE0.3000307@ah.jp.nec.com>
	<m1fy35t665.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fy35t665.fsf@ebiederm.dsl.xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>

Eric W. Biederman wrote:
> Takenori Nagano <t-nagano@ah.jp.nec.com> writes:
>> Hi all,
>>
>> IMHO, most users don't use kdump, kdump users are only kernel developers and
>> enterprise users. 
> 
> Not at all.  So far the only kdump related bug report I have seen has
> been from fedora Core.

Sorry, I thought general users push reset button when the machine is
panicked. :-(

> No.  The problem with your patch is that it doesn't have a code
> impact.  We need to see who is using this and why.

My motivation is very simple. I want to use both kdb and kdump, but I think it
is too weak to satisfy kexec guys. Then I brought up the example enterprise
software. But it isn't a lie. I know some drivers which use panic_notifier.
IMHO, they use only major distribution, and they has the workaround or they
don't notice this problem yet. I think they will be in trouble if all
distributions choose only kdump.

BTW, I use kdb and lkcd now, but I want to use kdb and kdump. I sent a patch to
kdb community but it was rejected. kdb maintainer Keith Owens said,

> Both KDB and crash_kexec should be using the panic_notifier_chain, with
> KDB having a higher priority than crash_exec.  The whole point of
> notifier chains is to handle cases like this, so we should not be
> adding more code to the panic routine.
> 
> The real problem here is the way that the crash_exec code is hard coded
> into various places instead of using notifier chains.  The same issue
> exists in arch/ia64/kernel/mca.c because of bad coding practices from
> kexec.

Then I gave up to merge my patch to kdb, and I tried to send another patch to
kexec community. I can understand his opinion, but it is very difficult to
modify that kdump is called from panic_notifier. Because it has a reason why
kdump don't use panic_notifier. So, I made this patch.

Please do something about this problem.

Thanks,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
