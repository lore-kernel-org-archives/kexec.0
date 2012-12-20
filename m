Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TlWPa-0007MZ-2G
 for kexec@lists.infradead.org; Thu, 20 Dec 2012 03:03:07 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CC8883EE0B5
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2012 12:02:58 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B339245DE78
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2012 12:02:58 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 99FFC45DE4E
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2012 12:02:58 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 89B141DB803E
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2012 12:02:58 +0900 (JST)
Received: from g01jpexchyt10.g01.fujitsu.local
 (g01jpexchyt10.g01.fujitsu.local [10.128.194.49])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 392641DB802F
 for <kexec@lists.infradead.org>; Thu, 20 Dec 2012 12:02:58 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH v2] Add the values related to buddy system for filtering
 free pages.
Date: Thu, 20 Dec 2012 03:02:56 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB2DEA3@G01JPEXMBYT03>
References: <20121210103913.020858db777e2f48c59713b6@mxc.nes.nec.co.jp>
 <20121219161856.e6aa984f.akpm@linux-foundation.org>
 <20121220112103.d698c09a9d1f27a253a63d37@mxc.nes.nec.co.jp>
In-Reply-To: <20121220112103.d698c09a9d1f27a253a63d37@mxc.nes.nec.co.jp>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "cpw@sgi.com" <cpw@sgi.com>

> From: kexec-bounces@lists.infradead.org
> [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Atsushi Kumagai
> Sent: Thursday, December 20, 2012 11:21 AM

> On Wed, 19 Dec 2012 16:18:56 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 10 Dec 2012 10:39:13 +0900
> > Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> >

> >
> > We might change the PageBuddy() implementation at any time, and
> > makedumpfile will break.  Or in this case, become less efficient.
> >
> > Is there any way in which we can move some of this logic into the
> > kernel?  In this case, add some kernel code which uses PageBuddy() on
> > behalf of makedumpfile, rather than replicating the PageBuddy() logic
> > in userspace?
> 
> In last month, Cliff Wickman proposed such idea:
> 
>   [PATCH v2] makedumpfile: request the kernel do page scans
>   http://lists.infradead.org/pipermail/kexec/2012-November/007318.html
> 
>   [PATCH] scan page tables for makedumpfile, 3.0.13 kernel
>   http://lists.infradead.org/pipermail/kexec/2012-November/007319.html
> 
> In his idea, the kernel does page scans to distinguish unnecessary pages
> (free pages and others) and returns the list of PFN's which should be
> excluded for makedumpfile.
> As a result, makedumpfile doesn't need to consider internal kernel
> behavior.
> 
> I think it's a good idea from the viewpoint of maintainability and
> performance.

I also think wide part of his code can be reused in this work. But the bad
performance is caused by a lot of ioremap, not a lot of copying. See my
profiling result I posted some days ago. Two issues, ioremap one and filtering
maintainability, should be considered separately. Even on ioremap issue,
there is secondary one to consider in memory consumption on the 2nd kernel.

Also, I have one question. Can we always think of 1st and 2nd kernels are same?
If I understand correctly, kexec/kdump can use the 2nd kernel different
from the 1st's. So, differnet kernels need to do the same thing as makedumpfile
does. If assuming two are same, problem is mush simplified.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
