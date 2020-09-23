Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKvDe-0007iG-7B
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 03:13:23 +0000
Received: by mail-io1-f68.google.com with SMTP id j2so22121338ioj.7
 for <kexec@lists.infradead.org>; Tue, 22 Sep 2020 20:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
 <e91c0c4d-ff35-1eee-22c5-e2e258e618ec@loongson.cn>
In-Reply-To: <e91c0c4d-ff35-1eee-22c5-e2e258e618ec@loongson.cn>
From: Huacai Chen <chenhc@lemote.com>
Date: Wed, 23 Sep 2020 11:13:08 +0800
Message-ID: <CAAhV-H6=Ytj2=A72w=G9kyOt0noiPMtdo=+cYVA65CUUXGcPMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
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
To: Jinyang He <hejinyang@loongson.cn>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Fuxin Zhang <zhangfx@lemote.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi, Jinyang,

On Wed, Sep 23, 2020 at 11:02 AM Jinyang He <hejinyang@loongson.cn> wrote:
>
> On 09/23/2020 10:30 AM, Huacai Chen wrote:
> > Kexec-tools use mem=X@Y to pass usable memories to crash kernel, but in
> > commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
> > BIOS passed memories are removed by early_parse_mem(). I think this is
> > reasonable for a normal kernel but not for a crash kernel, because a
> > crash kernel should be able to see all old memories, even though it is
> > not supposed to use them.
> >
> > Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >   arch/mips/kernel/setup.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 4c04a86..e2804a2 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -392,8 +392,10 @@ static int __init early_parse_mem(char *p)
> >        */
> >       if (usermem == 0) {
> >               usermem = 1;
> > +#ifndef CONFIG_CRASH_DUMP
> >               memblock_remove(memblock_start_of_DRAM(),
> >                       memblock_end_of_DRAM() - memblock_start_of_DRAM());
> > +#endif
>
> Hi, Huacai,
>
> For this patch, I knew something what had happened. "mem=" parsing
> works wrong for Loongson64. You can referenced the follow patch:
> https://patchwork.kernel.org/patch/11789555/
>
> memblock_add() calls memblock_add_range(,,, MAX_NUMNODES,)
> For Loongson64 enabling NUMA, we need memblock_add_node(). (Or
> using memblock_set_node() after memblock_add())
This seems like another story.

>
> Besides, "mem=" may be useless for kdump. Youling had submitted a patch
> about removing "mem="  serveral days ago.
kexec-tools use "mem=" to pass usable memory for the crash kernel,
Youling removes the base address of "mem=", but "mem=" is still here.

>
> For Loongson64 platform, you can try crashkernel=SIZE@38M after fixed
> "mem=".
> 38M means 40M - 2M, 2M is needed because old firmware compatibility.
"crashkernel=" is for the normal kernel specified by BIOS, and "mem="
is for the crash kernel specified by kexec-tools.

Huacai
>
> Thanks,
> - Jinyang.
>
> >       }
> >       start = 0;
> >       size = memparse(p, &p);
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
