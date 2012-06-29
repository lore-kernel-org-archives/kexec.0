Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkStL-0001J4-F5
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 04:33:14 +0000
Date: Fri, 29 Jun 2012 13:30:38 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/3] makedumpfile: Xen4: exclude domU pages for Xen4
Message-Id: <20120629133038.850a845b.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <201206221718.05680.Norbert.Trapp@ts.fujitsu.com>
References: <201206221718.05680.Norbert.Trapp@ts.fujitsu.com>
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
To: Norbert.Trapp@ts.fujitsu.com
Cc: kexec@lists.infradead.org, fngw.zhang@huawei.com

Hello Norbert,

Thank you for your work.

But, I don't know much about Xen, so I want to ask for help from Zhangfengwei
and other experts in Xen.


Thanks
Atsushi Kumagai


On Fri, 22 Jun 2012 17:18:05 +0200
Norbert Trapp <Norbert.Trapp@ts.fujitsu.com> wrote:

> 
> Saving just the dom0 and Xen pages is a good idea because usually
> the crash can be analysed in dom0 and saving just the Xen and dom0 pages
> allows the machine to restart quickly.
> 
> makedumpfile needs to be modified to exclude domU pages when using Xen4
> since the Xen implementation has changed. The Xen version can be determined
> in the kcore file and then either Xen3 or Xen4 functions are used. The other
> modifications are based on the goal of quickly finding the dom0 and Xen pages.
> 
> The domU page exclusion for Xen4 is implemented so far just for x86_64.
> 
> The kvtop_xen_x86_64 modification for a faster method to run through the page
> table	(last_p.._read)	was seen in the crash utility source code.
> 
>  arch/x86_64.c  |  244 ++++++++++++++++++++++++++++----------
>  elf_info.c     |    2 +
>  makedumpfile.c |  362 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  makedumpfile.h |   79 +++++++++++--
>  4 files changed, 591 insertions(+), 96 deletions(-)
> 
> With kind regards
> 
> Norbert Trapp
> PDG ES&S SWE OS 6
> 
> FUJITSU
> Fujitsu Technology Solutions GmbH
> Domagkstrasse 28, D-80807 Muenchen, Germany
> E-mail: Norbert.Trapp@xxxxxxxxxxxxxx
> Web: ts.fujitsu.com
> Company details: ts.fujitsu.com/imprint
> Please be advised that neither Fujitsu, its affiliates, its employees or agents accept liability for any errors,
> omissions or damages caused by delays of receipt or by any virus infection in this message or its attachments,
> or which may otherwise arise as a result of this e-mail transmission.
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
