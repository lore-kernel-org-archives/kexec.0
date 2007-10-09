Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1If9lb-0003EH-4B
	for kexec@lists.infradead.org; Tue, 09 Oct 2007 08:44:39 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l997gRMo017196
	for <kexec@lists.infradead.org>; Tue, 9 Oct 2007 16:42:27 +0900 (JST)
Message-ID: <470B3008.9040003@ah.jp.nec.com>
Date: Tue, 09 Oct 2007 16:38:48 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add new notifier function
References: <4704D09D.6080503@ah.jp.nec.com>
	<m1641llnqa.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1641llnqa.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Eric W. Biederman wrote:
> Takenori Nagano <t-nagano@ah.jp.nec.com> writes:
> 
>> Hi,
>>
>> These patches add new notifier function and implement it to panic_notifier_list.
>> We used the hardcoded notifier chain so far, but it was not flexible. New
>> notifier is very flexible, because user can change a list of order by debugfs.
> 
> How is the lack of flexibility a problem?
> Specifics please.

Please read this again.
http://www.gossamer-threads.com/lists/linux/kernel/797220?do=post_view_threaded#797220

Keith Owen said,

> My stance is that _all_ the RAS tools (kdb, kgdb, nlkd, netdump, lkcd,
> crash, kdump etc.) should be using a common interface that safely puts
> the entire system in a stopped state and saves the state of each cpu.
> Then each tool can do what it likes, instead of every RAS tool doing
> its own thing and they all conflict with each other, which is why this
> thread started.
> 
> It is not the kernel's job to decide which RAS tool runs first, second
> etc., it is the user's decision to set that policy. Different sites
> will want different orders, some will say "go straight to kdump", other
> sites will want to invoke a debugger first. Sites must be able to
> define that policy, but we hard code the policy into the kernel. 

I agreed with him and I made new notifier function.

> 
> My impression is that the purpose of this patchset is to build
> infrastructure to sort out a conflict between kdb and the kexec code,
> which it does not do, and it can not do if it does not own up to
> it's real purpose.

My motivation does not change. But I don't think kdump have to use notifer.
I want to resolve this adopting the way which satisfy all users.

Thanks,

Takenori Nagano <t-nagano@ah.jp.nec.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
