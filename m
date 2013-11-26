Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlFpt-0007qt-T3
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 10:25:43 +0000
Date: Tue, 26 Nov 2013 18:24:51 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Message-ID: <20131126102451.GC22934@dhcp-16-252.nay.redhat.com>
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
 <5294368A.8030804@jp.fujitsu.com>
 <20131126075742.GB22934@dhcp-16-252.nay.redhat.com>
 <529460EA.2080006@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529460EA.2080006@jp.fujitsu.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com

On 11/26/13 at 05:50pm, HATAYAMA Daisuke wrote:
> (2013/11/26 16:57), Baoquan He wrote:
> >On 11/26/13 at 02:50pm, HATAYAMA Daisuke wrote:
> >>(2013/11/26 11:52), Baoquan He wrote:
> >>>On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
> >>>>(2013/11/25 11:31), Baoquan He wrote:
> >
> >>
> >>
> >>BTW, I could successfully clean up the code in this way in kdump-compressed code,
> >>but I couldn't do that in the code from ELF to ELF... So I have yet to post
> >>such clean up patch.
> >
> >This is cool, cleanup like this would make code clearer. Let's wait your
> >clean up patch, I can help review and test.
> >
> 
> For that, you need to pass a part with the currnet cycle to __exclude_unnecessary_pages(),
> not a whole (mmd->pfn_start, mmd->pfn_end). There might be similar part that needs fix,
> but sorry I don't have good memory...
> 
> int
> exclude_unnecessary_pages_cyclic(void)
> {
> <cut>
>                         if (mmd->pfn_end >= info->cyclic_start_pfn &&
>                             mmd->pfn_start <= info->cyclic_end_pfn) {
>                                 if (!__exclude_unnecessary_pages(mmd->mem_map,
>                                                                  mmd->pfn_start, mmd->pfn_end))
>                                         return FALSE;
>                         }
> 
> For ELF-to-ELF code, unfortunately, I gave up in the middle of source code reading.
> At lesst, if I remember correctly, I think the code relied on the current
> update_mmap_range() implementation. It might be hard to clean up there in a natural way.

Yeah, understood. How about I post a patch based on my v1,
then you can do the cleanup work of elf part deliberately.


> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
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
