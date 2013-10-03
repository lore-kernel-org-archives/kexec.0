Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VRcAd-000115-FM
 for kexec@lists.infradead.org; Thu, 03 Oct 2013 06:13:56 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DB5443EE1D6
 for <kexec@lists.infradead.org>; Thu,  3 Oct 2013 15:13:22 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CC89345DE51
 for <kexec@lists.infradead.org>; Thu,  3 Oct 2013 15:13:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B1E3345DE4E
 for <kexec@lists.infradead.org>; Thu,  3 Oct 2013 15:13:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A3DF3E08002
 for <kexec@lists.infradead.org>; Thu,  3 Oct 2013 15:13:22 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 51BB31DB803B
 for <kexec@lists.infradead.org>; Thu,  3 Oct 2013 15:13:22 +0900 (JST)
Message-ID: <524D0ADF.2010507@jp.fujitsu.com>
Date: Thu, 03 Oct 2013 15:12:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
References: <20131002140356.63706540@holzheu>
In-Reply-To: <20131002140356.63706540@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>, Jan Willeke <willeke@de.ibm.com>

(2013/10/02 21:03), Michael Holzheu wrote:
> Hello Alexey,
>
> Looks like the following commit broke mmap for /proc/vmcore:
>
> commit c4fe24485729fc2cbff324c111e67a1cc2f9adea
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Tue Aug 20 22:17:24 2013 +0300
>
>      sparc: fix PCI device proc file mmap(2)
>
> Because /proc/vmcore (fs/proc/vmcore.c) does not implement the
> get_unmapped_area() fops function mmap now always returns EIO.
>
> Michael
>

I confirmed the bug on v3.12-rc3. According to makedumpfile's log,
mmap failed on /proc/vmcore.

mem_map (271)
   mem_map    : ffffea001da40000
   pfn_start  : 878000
   pfn_end    : 880000
Kernel can't mmap vmcore, using reads.
STEP [Excluding unnecessary pages] : 1.268799 seconds
STEP [Excluding unnecessary pages] : 1.268756 seconds
STEP [Copying data               ] : 44.847924 seconds
Writing erase info...

I'll post a patch later.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
