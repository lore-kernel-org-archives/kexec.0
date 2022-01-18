From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 18 Jan 2022 09:52:05 +0800
Subject: [PATCHv3 0/4] arm64: make phys_to_virt() correct
In-Reply-To: <20220114144755.GE16732@vergenet.net>
References: <20211228132659.40102-1-piliu@redhat.com>
 <20220114144755.GE16732@vergenet.net>
Message-ID: <CAF+s44RSh6qY1gUbRuyPMAiQGiuSxjzisxJVysGFThKUgUtOig@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Jan 14, 2022 at 10:48 PM Simon Horman <horms@verge.net.au> wrote:
>
> Hi Pingfan,
>
> On Tue, Dec 28, 2021 at 09:26:55PM +0800, Pingfan Liu wrote:
> > Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
> > One issue is contributed by phys_offset not signed.
> > The other is contributed by wrong page_offset.
> >
> > v2 -> v3:
> > Discussed with Kairui off-list, 48-bits VA kernel can not handle flipped
> > mm yet. So introducing [4/4], which judges whether the kernel is with
> > flipped mm layout and adopt different formula accordingly.
> >
> > As for [1-3/4], they are the same as [1-3/3] in V2.
> >
> > v1 -> v2
> > Fix broken patch [2/3] in v1
> > Move arch_scan_vmcoreinfo declaration to util_lib/include/elf_info.h
> > Using UINT64_MAX instread of 0xffffffffffffffff
>
> Thanks for the updated patches and sorry for the delay in reviewing them.
>
> I responded with some minor nits on patches 1/4 and 2/4.
> The other patches 3/4 and 4/4 look good to me.
>
Thank you for kindly reviewing.

I will update V4

Best Regards,

Pingfan
> Modulo any feedback from others I'd be happy to move forwards
> with applying this series once my nits have been addressed
> (via email or fresh patches).
>
> Thanks again,
> Simon
>


