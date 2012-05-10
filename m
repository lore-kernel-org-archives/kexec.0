Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SSKH0-000302-Nd
 for kexec@lists.infradead.org; Thu, 10 May 2012 03:42:41 +0000
Date: Thu, 10 May 2012 12:40:27 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Message-Id: <20120510124027.dd6829f4.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120510.093829.347152059.d.hatayama@jp.fujitsu.com>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
 <20120223171646.18e3dd30.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120510.093829.347152059.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, suzuki@in.ibm.com, crash-utility@redhat.com

Hello HATAYAMA-san,

On Thu, 10 May 2012 09:38:29 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Helllo Kumagai-san,
> 
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
> Date: Thu, 23 Feb 2012 17:16:46 +0900
> 
> > Thank you for your work.
> > I will review your patches for v1.4.4.
> 
> Could you tell me when you plan to release version 1.4.4? Not
> necessarily exact date, rough schedule is enough. I need to post the
> corresponding patch to the crash utility's side after LZO feature is
> merged into makedumpfile.

At first, I planned to merge features below into v1.4.4.

 - vmalloc translation support for PPC32 (by Suzuki K. Poulose)
 - LZO Compression Support (by HATAYAMA Daisuke)
 - sadump: check if given cpu is online in per-cpu related helper functions
   (by HATAYAMA Daisuke)

However, the first one is being discussed and the schedule is not clear.
So, I would like to postpone the feature for v1.4.5 and start testing 
the other two for v1.4.4. 

If I can start testing now, I will release v1.4.4 in this month.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
