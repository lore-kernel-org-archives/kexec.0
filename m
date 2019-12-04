Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icb1q-0007g1-9x
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 20:13:44 +0000
Received: by mail-ot1-x344.google.com with SMTP id i15so432806oto.7
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 12:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20191204145233.11962-1-ardb@kernel.org>
 <20191204171744.o3ijdspnelqn5fgd@gabell>
 <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com>
 <20191204185708.hdoa5gzmfr547q53@gabell>
In-Reply-To: <20191204185708.hdoa5gzmfr547q53@gabell>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Thu, 5 Dec 2019 01:43:28 +0530
Message-ID: <CAFTCetTTgJRN+3+vqS+XbMMrra3xKqrEXzqEKpLsMn=G8peUjw@mail.gmail.com>
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-efi@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>, d.hatayama@fujitsu.com

Hello Masa,

(+Cc Simon)

On Thu, Dec 5, 2019 at 12:27 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> On Wed, Dec 04, 2019 at 06:17:59PM +0000, James Morse wrote:
> > Hi Masa,
> >
> > On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> > > Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> > >
> > > After applied your patch, the LPI tables are marked as reserved in
> > > /proc/iomem like as:
> > >
> > > 80300000-a1fdffff : System RAM
> > >   80480000-8134ffff : Kernel code
> > >   81350000-817bffff : reserved
> > >   817c0000-82acffff : Kernel data
> > >   830f0000-830fffff : reserved # Property table
> > >   83480000-83480fff : reserved # Pending table
> > >   83490000-8349ffff : reserved # Pending table
> > >
> > > However, kexec tries to allocate memory from System RAM, it doesn't care
> > > the reserved in System RAM.
> >
> > > I'm not sure why kexec doesn't care the reserved in System RAM, however,
> >
> > Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
> > tables being overwritten by kexec.
> >
> > Which version of kexec-tools are you using? Could you try:
> > https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem
>
> Thanks a lot! It worked and the issue is gone with Ard's patch and
> the linaro kexec (arm64/resv_mem branch).
>
> Ard, please feel free to add:
>
>         Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Same results at my side, so:
Tested-and-Reviewed-by: Bhipesh Sharma <bhsharma@redhat.com>

> >
> > > if the kexec behaivor is right, the LPI tables should not belong to
> > > System RAM.
> >
> > > Like as:
> > >
> > > 80300000-830effff : System RAM
> > >   80480000-8134ffff : Kernel code
> > >   81350000-817bffff : reserved
> > >   817c0000-82acffff : Kernel data
> > > 830f0000-830fffff : reserved # Property table
> > > 83480000-83480fff : reserved # Pending table
> > > 83490000-8349ffff : reserved # Pending table
> > > 834a0000-a1fdffff : System RAM
> > >
> > > I don't have ideas to separete LPI tables from System RAM... so I tried
> > > to add a new file to inform the LPI tables to userspace.
> >
> > This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
> > is kdump can't touch it, as you've told it this isn't memory.
> >
> > As these tables are memory, mapped by the linear map, I think Ard's patch is the right
> > thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
> > it honour all second level entries.
>
> I used the kexec on the top of master branch:
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>
> Should we use the linaro kexec for aarch64 machine?
> Or will the arm64/resv_mem branch be merged to the kexec on
> git.kernel.org...?

Glad that Ard's patch fixes the issue for you.
Regarding Akashi's patch, I think it was sent to upstream kexec-tools
some time ago (see [0}) but  seems not integrated in upstream
kexec-tools (now I noticed my Tested-by email for the same got bounced
off due to some gmail msmtp setting issues at my end - sorry for
that). I have added Simon in Cc list.

Hi Simon,

Can you please help pick [0] in upstream kexec-tools with Tested-by
from Masa and myself? Thanks a lot for your help.

[0]. http://lists.infradead.org/pipermail/kexec/2019-January/022201.html

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
