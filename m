Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghmlg-0002My-Dw
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 02:41:58 +0000
Received: by mail-it1-x144.google.com with SMTP id g76so235759itg.2
 for <kexec@lists.infradead.org>; Thu, 10 Jan 2019 18:41:56 -0800 (PST)
MIME-Version: 1.0
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx> <20190108090138.GB18718@MiWiFi-R3L-srv>
 <20190108154852.GC14063@rapoport-lnx> <20190109142516.GA14211@MiWiFi-R3L-srv>
In-Reply-To: <20190109142516.GA14211@MiWiFi-R3L-srv>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 11 Jan 2019 10:41:44 +0800
Message-ID: <CAFgQCTt6YjoqfvZhEFNAvg-0_r_V5apowNAcg4SSLx1QOMSSWA@mail.gmail.com>
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
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
To: Baoquan He <bhe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Mathieu Malaterre <malat@debian.org>, kexec@lists.infradead.org, Daniel Vacek <neelx@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org, Stefan Agner <stefan@agner.ch>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>

On Wed, Jan 9, 2019 at 10:25 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/08/19 at 05:48pm, Mike Rapoport wrote:
> > On Tue, Jan 08, 2019 at 05:01:38PM +0800, Baoquan He wrote:
> > > Hi Mike,
> > >
> > > On 01/08/19 at 10:05am, Mike Rapoport wrote:
> > > > I'm not thrilled by duplicating this code (yet again).
> > > > I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> > > > allocate [0, kernel_start) unconditionally.
> > > > I'd just replace you first patch in v3 [2] with something like:
> > >
> > > In initmem_init(), we will restore the top-down allocation style anyway.
> > > While reserve_crashkernel() is called after initmem_init(), it's not
> > > appropriate to adjust memblock_find_in_range_node(), and we really want
> > > to find region bottom up for crashkernel reservation, no matter where
> > > kernel is loaded, better call __memblock_find_range_bottom_up().
> > >
> > > Create a wrapper to do the necessary handling, then call
> > > __memblock_find_range_bottom_up() directly, looks better.
> >
> > What bothers me is 'the necessary handling' which is already done in
> > several places in memblock in a similar, but yet slightly different way.
>
> The page aligning for start and the mirror flag setting, I suppose.
> >
> > memblock_find_in_range() and memblock_phys_alloc_nid() retry with different
> > MEMBLOCK_MIRROR, but memblock_phys_alloc_try_nid() does that only when
> > allocating from the specified node and does not retry when it falls back to
> > any node. And memblock_alloc_internal() has yet another set of fallbacks.
>
> Get what you mean, seems they are trying to allocate within mirrorred
> memory region, if fail, try the non-mirrorred region. If kernel data
> allocation failed, no need to care about if it's movable or not, it need
> to live firstly. For the bottom-up allocation wrapper, maybe we need do
> like this too?
>
> >
> > So what should be the necessary handling in the wrapper for
> > __memblock_find_range_bottom_up() ?
> >
> > BTW, even without any memblock modifications, retrying allocation in
> > reserve_crashkerenel() for different ranges, like the proposal at [1] would
> > also work, wouldn't it?
>
> Yes, it also looks good. This patch only calls once, seems a simpler
> line adding.
>
> In fact, below one and this patch, both is fine to me, as long as it
> fixes the problem customers are complaining about.
>
It seems that there is divergence on opinion. Maybe it is easier to
fix this bug by dyoung's patch. I will repost his patch.

Thanks and regards,
Pingfan
> >
> > [1] http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
>
> Thanks
> Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
