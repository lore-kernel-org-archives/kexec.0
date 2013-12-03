Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnlGR-0003Un-Ht
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 08:23:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
Date: Tue, 3 Dec 2013 08:05:06 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971CA130@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "jingbai.ma@hp.com" <jingbai.ma@hp.com>

On 2013/11/29 13:57:21, kexec <kexec-bounces@lists.infradead.org> wrote:
> (2013/11/29 13:23), Atsushi Kumagai wrote:
> > On 2013/11/29 12:24:45, kexec <kexec-bounces@lists.infradead.org> wrote:
> >> (2013/11/29 12:02), Atsushi Kumagai wrote:
> >>> On 2013/11/28 16:50:21, kexec <kexec-bounces@lists.infradead.org> wrote:
> >>>>>> ping, in case you overlooked this...
> >>>>>
> >>>>> Sorry for the delayed response, I prioritize the release of v1.5.5 now.
> >>>>>
> >>>>> Thanks for your advice, check_cyclic_buffer_overrun() should be fixed
> >>>>> as you said. In addition, I'm considering other way to address such case,
> >>>>> that is to bring the number of "overflowed pages" to the next cycle and
> >>>>> exclude them at the top of __exclude_unnecessary_pages() like below:
> >>>>>
> >>>>>                   /*
> >>>>>                    * The pages which should be excluded still remain.
> >>>>>                    */
> >>>>>                   if (remainder >= 1) {
> >>>>>                           int i;
> >>>>>                           unsigned long tmp;
> >>>>>                           for (i = 0; i < remainder; ++i) {
> >>>>>                                   if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i)) {
> >>>>>                                           pfn_user++;
> >>>>>                                           tmp++;
> >>>>>                                   }
> >>>>>                           }
> >>>>>                           pfn += tmp;
> >>>>>                           remainder -= tmp;
> >>>>>                           mem_map += (tmp - 1) * SIZE(page);
> >>>>>                           continue;
> >>>>>                   }
> >>>>>
> >>>>> If this way works well, then aligning info->buf_size_cyclic will be
> >>>>> unnecessary.
> >>>>>
> >>>>
> >>>> I selected the current implementation of changing cyclic buffer size becuase
> >>>> I thought it was simpler than carrying over remaining filtered pages to next cycle
> >>>> in that there was no need to add extra code in filtering processing.
> >>>>
> >>>> I guess the reason why you think this is better now is how to detect maximum order of
> >>>> huge page is hard in some way, right?
> >>>
> >>> The maximum order will be gotten from HUGETLB_PAGE_ORDER or HPAGE_PMD_ORDER,
> >>> so I don't say it's hard. However, the carrying over method doesn't depend on
> >>> such kernel symbols, so I think it's robuster.
> >>>
> >>
> >> Then, it's better to remove check_cyclic_buffer_overrun() and rewrite part of free page
> >> filtering in __exclude_unnecessary_pages(). Could you do that too?
> >
> > Sure, I'll modify it too.
> >
>
> This is a suggestion from different point of view...
>
> In general, data on crash dump can be corrupted. Thus, order contained in a page
> descriptor can also be corrupted. For example, if the corrupted value were a huge
> number, wide range of pages after buddy page would be filtered falsely.
>
> So, actually we should sanity check data in crash dump before using them for application
> level feature. I've picked up order contained in page descriptor, so there would be other
> data used in makedumpfile that are not checked.

What you said is reasonable, but how will you do such sanity check ?
Certain standard values are necessary for sanity check, how will
you prepare such values ?
(Get them from kernel source and hard-code them in makedumpfile ?)

> Unlike diskdump, we no longer need to care about kernel/hardware level data integrity
> outside of user-land, but we still care about data its own integrity.
>
> On the other hand, if we do it, we might face some difficulty, for example, hardness of
> maintenance or performance bottleneck; it might be the reason why we don't see sanity
> check in makedumpfile now.

There are many values which should be checked, e.g. page.flags, page._count,
page.mapping, list_head.next and so on.
If we introduce sanity check for them, the issues you mentioned will be appear
distinctly.

So I think makedumpfile has to trust crash dump in practice.


Thanks
Atsushi Kumagai

> --
> Thanks.
> HATAYAMA, Daisuke
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
