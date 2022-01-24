From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 24 Jan 2022 17:53:34 +0800
Subject: [PATCHv4 0/4] arm64: make phys_to_virt() correct
In-Reply-To: <20220124091023.GB8955@vergenet.net>
References: <20220118074812.27702-1-piliu@redhat.com>
 <20220124091023.GB8955@vergenet.net>
Message-ID: <CAF+s44Qq55jVs8NZ-KPcq0SJ87yRDSuwq_qynGqWSyYrtyOhVQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Jan 24, 2022 at 5:10 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Tue, Jan 18, 2022 at 03:48:08PM +0800, Pingfan Liu wrote:
> > Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
> > One issue is contributed by phys_offset not signed.
> > The other is contributed by wrong page_offset.
> >
> > v3 -> v4:
> > address the date type in [1/4] and [2/4]
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
> >
> >
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec at lists.infradead.org
>
> Thanks, series applied.
>

Hi Simon and Philipp, appreciate the help and patient review.

Best Regards,

Pingfan


