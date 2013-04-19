Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UT6x3-0008Tt-EE
 for kexec@lists.infradead.org; Fri, 19 Apr 2013 08:45:50 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 35EDA3EE0BB
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 17:45:42 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C00145DEC5
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 17:45:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E76A245DEBC
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 17:45:41 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D7E7CE08004
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 17:45:41 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 76D9C1DB8041
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 17:45:41 +0900 (JST)
Message-ID: <51710422.60704@jp.fujitsu.com>
Date: Fri, 19 Apr 2013 17:45:22 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kdump: Enter 2nd kernel with BSP for enabling multiple
 CPUs
References: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
 <20130418134148.53704982@azariah.suse.cz>
In-Reply-To: <20130418134148.53704982@azariah.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Fenghua Yu <fenghua.yu@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, vgoyal@redhat.com

(2013/04/18 20:41), Petr Tesarik wrote:
> On Mon, 16 Apr 2012 11:21:28 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>
>> Currently, booting up 2nd kernel with multiple CPUs fails in most
>> cases since it enters 2nd kernel with AP if the crash happens on the
>> AP. The problem is to signal startup IPI from AP to BSP. Typical
>> result of the operation I saw is the machine hanging during the 2nd
>> kernel boot.
>>
>> To solve this issue, always enter 2nd kernel with BSP. To do this, I
>> modify logic for shooting down CPUs. I use simple existing logic only
>> in this mechanism, not complicating crash path to machine_kexec().
>
> These patches looked pretty good. I seem to recall that Fenghua (from
> Intel) had an alternative solution for booting from AP. Unfortunately I
> can't find his mails in my kexec mailbox...
>
> Anyway, what's the latest upstream status?

It's still in experimental state.

The patch itself was nacked by Erick since switching the CPU that 
entered 2nd kenrel through NMI reduced reliability of kdump.

At the discussion of my 2nd patch set that tried to reset BSP flag at 
boot on the 2nd kernel, Erick suggested that BSP flag could be changed 
at runtime and then behaviour when INIT was received varied and first we 
should discuss how unsetting BSP flag affects system.

I'm now going in this direction and the patch I posted a month ago is:

[PATCH] x86, apic: Add unset_bsp parameter to unset BSP flag at boot time
https://lkml.org/lkml/2013/3/18/107

According to Fenghua, some kind of firmware assumes that BSP flag is 
being kept throughout system is running. I have yet to see difference of 
behaviour when unsetting BSP flag on top of the patch on my machine. I 
think this is system dependent and it might be better to assign each 
user to decide whether to unset BSP flag or not.

BTW, the work of software cpu hotplug for BSP by Fenghua is orthogonal 
to my case. His work is for system including firmware that is affected 
if BSP flag is unset and assumes healthy system that cpu#0 is always 
BSP. On the other hand, our case is for crash kernel and we can no 
longer assume cpu#0 is BSP and can no longer use NMI to wake up other 
CPUs since we cannot use logic that depends on the state of CPUs 
sleeping in the 1st kernel.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
