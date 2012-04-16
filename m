Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SJfcQ-0007Rn-0l
 for kexec@lists.infradead.org; Mon, 16 Apr 2012 06:40:59 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4C9F43EE0BC
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 15:40:53 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3012345DE5A
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 15:40:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0D9EC45DE55
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 15:40:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E85001DB8056
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 15:40:52 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CF771DB804F
 for <kexec@lists.infradead.org>; Mon, 16 Apr 2012 15:40:52 +0900 (JST)
Date: Mon, 16 Apr 2012 15:40:30 +0900 (JST)
Message-Id: <20120416.154030.310066043.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/2] kdump: Enter 2nd kernel with BSP for enabling
 multiple CPUs
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <beaa8ade-b7af-4e71-b4e0-a418ceb83f1e@email.android.com>
References: <20120416021951.9303.58568.stgit@localhost6.localdomain6>
 <beaa8ade-b7af-4e71-b4e0-a418ceb83f1e@email.android.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] kdump: Enter 2nd kernel with BSP for enabling multiple CPUs
Date: Sun, 15 Apr 2012 19:59:52 -0700

> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>>Currently, booting up 2nd kernel with multiple CPUs fails in most
>>cases since it enters 2nd kernel with AP if the crash happens on the
>>AP. The problem is to signal startup IPI from AP to BSP.
> 
> If so, then we need to fix our code that sends startupIPIs.
> And perhaps the code that attempts to shutdown the other cpus.
> 

Now maxcpus=1 is set at default, in which configuration, 2nd kernel
doesn't try to wake up secondary and later CPUs. So there's no startup
IPI on the 2nd kernel now.

> It is not ok to switch cpus during kdump (reducing the reliability) just so you can write crash dumps faster.  Better would be to cope with secondary cpus not booting.

Even the current implememntation uses NMI to stop other CPUs. The
reliability you are concerned about here is the possibility where the
non-crashing BSP doesn't go into machine_kexec() due to some failures
of interrupt processing, right?

Alternative idea is:
  1) try to go into 2nd kernel with BSP,
  2) after some seconds, then try to go into 2nd kernel with crashing
  CPU. Then, think of CPUs except for the crashing cpu as abnormal,
  and use crashing cpu only on the 2nd kernel.

This seems as reliable as the current one.

> 
> I do like the direction of pounding on things so we can get multiple cpus going in large configurations.  Although I am surprised you are cpu bound and not disk bound in the time to write your crash dumps.
> 

What do you indicate in the 1st sentence? I don't understand around
``pounding on thing'', sorry.

For the 2nd, it depends on data. If data is sparse enough, the data
size is significantly reduced, and so IO size is also reduced. If data
is randomized enough, compression takes much time and the data remains
the same size, resulting in cpu bound processing.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
