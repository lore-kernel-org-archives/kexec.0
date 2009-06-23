Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MJ12a-0001Os-LE
	for kexec@lists.infradead.org; Tue, 23 Jun 2009 08:07:47 +0000
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5N87W59009161 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Tue, 23 Jun 2009 17:07:32 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C808945DE88
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 17:07:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9763545DE81
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 17:07:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0509A1DB803F
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 17:07:24 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 749E5E08015
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 17:07:22 +0900 (JST)
Message-ID: <4A408D32.9010500@jp.fujitsu.com>
Date: Tue, 23 Jun 2009 17:07:14 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com> <4A4022EA.1020506@jp.fujitsu.com>
	<20090623055536.GE6865@sgi.com>
In-Reply-To: <20090623055536.GE6865@sgi.com>
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
To: Robin Holt <holt@sgi.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Robin Holt wrote:
> On Tue, Jun 23, 2009 at 09:33:46AM +0900, Hidetoshi Seto wrote:
>> Robin Holt wrote:
> ...
>> Do you mean that the 2nd kernel should be able to handle MCA/INIT from its
>> boot up?  I guess the word PROM is nearly equal to PAL/SAL firmware, if so
>> then I don't think there are good generic interface/procedure could be
>> useful here.  Do you have any concrete idea?
> 
> No concrete ideas.  Just a really uneasy feeling whenever the INIT
> is disabled.

Don't worry, don't be afraid.
Again, my patches don't disable INIT until kdump is invoked.
(And if kdump is invoked via INIT, it have already masked at the begging
 of INIT handlers.)

> If you could give this some consideration, I would appreciate it.
> I really don't have the time to dedicate to thinking all the way through
> and therefore will not stand in the way of any patch you propose.
> If I can be of help in any way, please let me know.

I know you guys are busy with this and that...

It would be the best if you could test my patches soon on SGI servers,
but I would appreciate it too if you could let me know if you have any
trouble on the patches later.


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
