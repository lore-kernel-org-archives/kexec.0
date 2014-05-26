Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WorRO-0008HR-TQ
 for kexec@lists.infradead.org; Mon, 26 May 2014 09:43:35 +0000
Date: Mon, 26 May 2014 11:43:08 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v3 1/2] Generic handling of multi-page exclusions
Message-ID: <20140526114308.7320477b@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97211576@BPXM01GP.gisp.nec.co.jp>
References: <1399482403-3656-2-git-send-email-ptesarik@suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
 <20140514.193723.161348018.d.hatayama@jp.fujitsu.com>
 <20140514.195428.247303438.d.hatayama@jp.fujitsu.com>
 <20140514143832.16136269@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE97211576@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 16 May 2014 07:24:02 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >On Wed, 14 May 2014 19:54:28 +0900 (JST)
> >HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> >
> >> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> >> Subject: Re: [PATCH v3 1/2] Generic handling of multi-page exclusions
> >> Date: Wed, 14 May 2014 19:37:23 +0900
> >>
> >> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> >> > Subject: RE: [PATCH v3 1/2] Generic handling of multi-page exclusions
> >> > Date: Wed, 14 May 2014 07:54:17 +0000
> >> >
> >> >> Hello Petr,
> >> >>
> >> >>>When multiple pages are excluded from the dump, store the extents in
> >> >>>struct cycle and check if anything is still pending on the next invocation
> >> >>>of __exclude_unnecessary_pages. This assumes that:
> >> >>>
> >> >>>  1. after __exclude_unnecessary_pages is called for a struct mem_map_data
> >> >>>     that extends beyond the current cycle, it is not called again during
> >> >>>     that cycle,
> >> >>>  2. in the next cycle, __exclude_unnecessary_pages is not called before
> >> >>>     this final struct mem_map_data.
> >> >>>
> >> >>>Both assumptions are met if struct mem_map_data segments:
> >> >>>
> >> >>>  1. do not overlap,
> >> >>>  2. are sorted by physical address in ascending order.
> >> >>
> >> >> In ELF case, write_elf_pages_cyclic() processes PT_LOAD entries from
> >> >> PT_LOAD(0), this can break both assumptions unluckily.
>[...]
> 
> I thought it's better to keep the original PT_LOAD list at first, but the
> current code can split it already. So I think we shouldn't worry about
> modification to PT_LOAD entries now.
> If crash doesn't use virt_start and virt_end too, your idea sounds good to me.

I'm not sure how to continue here.

First, crash does not use virt_start and virt_end from the ELF headers.
It uses the same algorithm as makedumpfile to convert virtual addresses
to physical addresses (in fact, I believe makedumpfile initially copied
the code from crash).

Second, I understand that this change has a high risk of introducing
regressions, so I would rather keep the well-tested code path. It is,
of course, possible to fix the multi-page exclusions in ELF files.

Let me explain:

Every PT_LOAD segment behaves as an isolated run through this portion
of physical RAM. I mean, makedumpfile has never coped with page
exclusions that start in one segment and continue in another segment.
So, if we accept this limitation, then exclude_pfn_start and
exclude_pfn_end can be reset in each iteration of the PT_LOAD main
cycle. This adds only two lines to my previous patch.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
