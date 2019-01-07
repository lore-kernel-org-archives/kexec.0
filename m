Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQQB-0002VV-8k
 for kexec@lists.infradead.org; Mon, 07 Jan 2019 08:38:08 +0000
Received: by mail-io1-xd43.google.com with SMTP id l14so34244322ioj.5
 for <kexec@lists.infradead.org>; Mon, 07 Jan 2019 00:38:06 -0800 (PST)
MIME-Version: 1.0
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx> <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx>
 <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 7 Jan 2019 16:37:54 +0800
Message-ID: <CAFgQCTt2=6mwFid8HS+K5UsqkBv8y7N5WOoKpVxYzNxjwmV75A@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of bottom-up
 after parsing hotplug attr
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
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, linux-acpi@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, kexec@lists.infradead.org, Daniel Vacek <neelx@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org, Stefan Agner <stefan@agner.ch>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>

I send out a series [RFC PATCH 0/4] x86_64/mm: remove bottom-up
allocation style by pushing forward the parsing of mem hotplug info (
https://lore.kernel.org/lkml/1546849485-27933-1-git-send-email-kernelfans@gmail.com/T/#t).
Please give comment if you are interested.

Thanks,
Pingfan

On Fri, Jan 4, 2019 at 2:47 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jan 02, 2019 at 07:05:38PM +0200, Mike Rapoport wrote:
> > I agree that currently the bottom-up allocation after the kernel text has
> > issues with KASLR. But this issues are not necessarily related to the
> > memory hotplug. Even with a single memory node, a bottom-up allocation will
> > fail if KASLR would put the kernel near the end of node0.
> >
> > What I am trying to understand is whether there is a fundamental reason to
> > prevent allocations from [0, kernel_start)?
> >
> > Maybe Tejun can recall why he suggested to start bottom-up allocations from
> > kernel_end.
>
> That's from 79442ed189ac ("mm/memblock.c: introduce bottom-up
> allocation mode").  I wasn't involved in that patch, so no idea why
> the restrictions were added, but FWIW it doesn't seem necessary to me.
>
> Thanks.
>
> --
> tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
