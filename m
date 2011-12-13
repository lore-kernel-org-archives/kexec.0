Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RaG8a-0001yw-Ue
 for kexec@lists.infradead.org; Tue, 13 Dec 2011 00:22:32 +0000
Subject: Re: [PATCH] makedumpfile: fix off-by-one bug in page_to_pfn()
In-reply-to: <4EE5C82F.1000404@cn.fujitsu.com>
Message-Id: <20111213092110tachibana@mail.jp.nec.com>
References: <4EE5C82F.1000404@cn.fujitsu.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Tue, 13 Dec 2011 09:21:10 +0900
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
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Hi Wen,

On 2011/12/12 17:23:59 +0800, Wen Congyang <wency@cn.fujitsu.com> wrote:
> At 11/24/2011 01:20 PM, Atsushi Kumagai Write:
> > Hi Wen,
> > 
> > Thank you for the patch. 
> > I will check it.
> 
> Hi, kumagai
> 
> do you have any comment for this patch?

Sorry for late reply.
I will merge your fix to the next makedumpfile. By the way, did you 
detect this problem only by source program? Or by result of makedumpfile?
If there is no problem, please let me know it.

Thanks
tachibana


> 
> Thanks
> Wen Congyang
> 
> > 
> > Thanks
> > Kumagai
> > 
> > 
> > On Wed, 23 Nov 2011 13:53:51 +0800
> > Wen Congyang <wency@cn.fujitsu.com> wrote:
> > 
> >> The pfn region in a mmd is [mmd->pfn_start, mmd->pfn_end).
> >> So the max index should be mmd->pfn_end - mmd->pfn_start -1.
> >> If index >=(not >) mmd->pfn_end - mmd->pfn_start, we should check
> >> the next mmd.
> >>
> >> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> >>
> >> ---
> >>  makedumpfile.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index 7b7c266..db8e53f 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -2879,7 +2879,7 @@ page_to_pfn(unsigned long page)
> >>  		if (page < mmd->mem_map)
> >>  			continue;
> >>  		index = (page - mmd->mem_map) / SIZE(page);
> >> -		if (index > mmd->pfn_end - mmd->pfn_start)
> >> +		if (index >= mmd->pfn_end - mmd->pfn_start)
> >>  			continue;
> >>  		pfn = mmd->pfn_start + index;
> >>  		break;
> >> -- 
> >> 1.7.1
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
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
