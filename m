Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MQXOL-0003jl-V0
	for kexec@lists.infradead.org; Tue, 14 Jul 2009 02:05:21 +0000
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6E259DH020020 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Tue, 14 Jul 2009 11:05:10 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 704F345DE4F
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 11:05:09 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F1A145DE62
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 11:05:09 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 141D3E3800D
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 11:05:09 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AE63CE38008
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 11:05:08 +0900 (JST)
Message-ID: <4A5BE7B5.7080500@jp.fujitsu.com>
Date: Tue, 14 Jul 2009 11:04:37 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH-v2] kdump: Enable kdump if 2nd-kernel is loaded.
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>	<4A56E069.5040907@jp.fujitsu.com>
	<4A5AB903.6090204@mxs.nes.nec.co.jp>
	<m14otga4xa.fsf@fess.ebiederm.org>
In-Reply-To: <m14otga4xa.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Simon Horman <horms@verge.net.au>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

Eric W. Biederman wrote:
> The Documentation for sysrq-c certainly needs to be updated.

No doubt about it.

> If I am doing development on a system I like oops's.  All of the
> information and nothing goes down.  I can get at /proc/kcore etc.
> 
> In a setting where I can't be Johnny on the spot and look at
> things a core dump is probably the best I can get.  In that scenario
> panic_on_oops sounds good.
> 
> As I read the current check it reads:
> If we are going to panic and not oops || panic_on_oops
> 	kexec_should_crash = true;
> 
> Which seems a very reasonable implementation of policy.

If I understand it,

a) panic
b) oops
c) SysRq (from keyboard interrupt)
d) echo c > /proc/sysrq-trigger

   a      b      c      d
common, w/o CONFIG_KEXEC:
 panic  oops   panic   oops  :
 panic  panic  panic   panic : w/ panic_on_oops

A) 2.6.30 + CONFIG_KEXEC:
 panic  oops   -       -     : w/o kdump-image
 panic  panic  -       -     : w/o kdump-image w/ panic_on_oops
 kdump  oops   kdump   kdump : w/ kdump-image
 kdump  kdump  kdump   kdump : w/ kdump-image w/ panic_on_oops

B) 2.6.31-rc1 + CONFIG_KEXEC:
 panic  oops   panic   oops  : w/o kdump-image
 panic  panic  panic   panic : w/o kdump-image w/ panic_on_oops
 kdump  oops   kdump   oops  : w/ kdump-image
 kdump  kdump  kdump   kdump : w/ kdump-image w/ panic_on_oops

C) After this patch + CONFIG_KEXEC:
 panic  oops   panic   oops  : w/o kdump-image
 panic  panic  panic   panic : w/o kdump-image w/ panic_on_oops
 kdump  kdump  kdump   kdump : w/ kdump-image
 kdump  kdump  kdump   kdump : w/ kdump-image w/ panic_on_oops

Ohmichi-san pointed "oops on d) with kdump-image" in B) and suggested
it should be "kdump."
And Eric pointed "kdump on b) without panic_on_oops" in C) and requested
it should be "oops."
(Plus, IMHO, "oops on d) without panic_on_oops" should be "panic.") 

... Right?

Then as I mentioned, use panic in sysrq would be one of solutions.
Are there any better fix?


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
