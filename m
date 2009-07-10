Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MPAuZ-0002bw-7K
	for kexec@lists.infradead.org; Fri, 10 Jul 2009 07:52:58 +0000
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6A7qlbR024705 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Fri, 10 Jul 2009 16:52:47 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7552545DE4D
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 16:52:46 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5378945DE6E
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 16:52:46 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 370081DB8043
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 16:52:46 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BF80C1DB803B
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 16:52:45 +0900 (JST)
Message-ID: <4A56F343.7040907@jp.fujitsu.com>
Date: Fri, 10 Jul 2009 16:52:35 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: Enable kdump if 2nd-kernel is loaded.
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
	<4A56E069.5040907@jp.fujitsu.com>
	<4A56E83B.50600@mxs.nes.nec.co.jp>
In-Reply-To: <4A56E83B.50600@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

Hi Ohmichi-san,

Ken'ichi Ohmichi wrote:
> Hidetoshi Seto wrote:
>> I'd like to quote your comment:
>>
>>>> I tried to test a kdump on linux-2.6.31-rc1 *without* a kernel parameter
>>>> "oops=panic" by `echo c > /proc/sysrq-trigger`, but a kdump did not work
>>>> because a kdump, which is occurred by `echo c > /proc/sysrq-trigger`, has
>>>> been changed to a NULL pointer error instead of calling crash_kexec()
>>>> since linux-2.6.31-rc1.
>> So the real problem is that kdump is not triggered by the NULL pointer oops
>> if !panic_on_oops, isn't it?
>>
>> It seems that you should report this trouble of sysrq-c as a regression.
> 
> I don't think this problem is a regression of sysrq-c.
> This change of sysrq-c looks reasonable to me. Because sysrq-c is used
> for the test of kdump, and its code path has been changed to the same
> path as a kdump on oops (a real problem, not test).
> So we can test a kdump by a real oops, that is good to me.
> As a result, I could find this problem a kdump is not enabled without
> "oops=panic".

Still I believe this is a regression of sysrq-c.
If required function of sysrq-c were "cause a real oops", then it is not
regression.  But as described in Documentation/sysrq.txt, real usage of
sysrq-c is "perform a kexec reboot," i.e. kdump.
So I think sysrq-c should use panic instead of oops if it want to kick
the kdump unconditionally.

However, yes, I agree it is a problem on the kdump's policy that kdump on
oops is not enabled without the option.  I'm not sure how much people want
to enable kdump only on panic while not on oops, but I suppose it will be
negligible.  Or it would be better to introduce kdump_on_oops option or so.


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
