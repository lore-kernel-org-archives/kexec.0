Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wahzu-0001Hr-UC
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 08:48:43 +0000
Date: Thu, 17 Apr 2014 10:48:19 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Fix a bug found during regression testing
 for v1.5.6
Message-ID: <20140417104819.0180bb4c@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97204D20@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9720436D@BPXM01GP.gisp.nec.co.jp>
 <20140416105009.402c94fc@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE97204D20@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, 17 Apr 2014 08:33:19 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> >> Date: Wed, 16 Apr 2014 14:56:01 +0900
> >> Subject: [PATCH] Exclude small cycle regions wrongly.
> >>
> >> In bitmap initialization, if a cycle region is smaller than 8 pages
> >> and its start_pfn is aligned to multiple of 8 pages, it will be
> >> excluded wrongly.
> >>
> >>   Example case:
> >>     pfn_start=0x103ff80, pfn_start_roundup=0x103ff80
> >>     pfn_end=0x103ff84, pfn_end_round=0x103ff80
> >>
> >> This case doesn't meet any conditions to set bits in
> >> create_1st_bitmap_cyclic() and initialize_2nd_bitmap_cyclic().
> >> We should admit the case where pfn_start is equal to pfn_end_round
> >> like above.
> >
> >Hello Kumagai-san,
> >
> >FWIW I cleaned up these bit operations in makedumpfile, completely
> >removing this code and instead adding functions for efficient setting
> >and clearing of a range of bits in a bitmap:
> >
> >set_bits(char *buf, size_t start, size_t end);
> >clear_bits(char *buf, size_t start, size_t end);
> >
> >The whole branch is still sitting on my disk, because I based it on
> >my other patch series (generic handling of multi-page exclusions), and
> >there were quite some conflicts when I tried to rebase it on devel.
> >
> >But if you include it in v1.5.6, I will do the rebase nevertheless,
> >so it doesn't have to wait for your decision about the other series.
> >
> >Can we do it that way?
> 
> Yes. If you can rebase your local branch on the current devel branch,
> reviewing them for v1.5.7 will go on smoothly.

Hm, I'm not sure I know what to do. So, let me make a summary of my
local makedumpfile branches:

1. pfn_t: introduce the mdf_pfn_t type
2. cycle_align: make cycle alignment unnecessary
3. bitmap_ops: helpers to set/clear range of bits (not yet sent)
4. hugepage: handling of compound pages (not yet sent)

Most branches are independent, (except hugepage depends on
cycle_align), but since they often change the same lines of code, I
must send them in some order, or they won't apply cleanly.

Now, do I understand you correctly that you want me to postpone all of
them _AFTER_ v1.5.6 is released?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
