Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYG7G-0002Ec-Fg
 for kexec@lists.infradead.org; Sat, 15 Dec 2018 20:00:52 +0000
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7705385ljd.12
 for <kexec@lists.infradead.org>; Sat, 15 Dec 2018 12:00:39 -0800 (PST)
MIME-Version: 1.0
References: <1543555965-14399-1-git-send-email-bhsharma@redhat.com>
 <1543555965-14399-5-git-send-email-bhsharma@redhat.com>
 <20181204031236.GA21466@linaro.org>
 <CACi5LpODgNN0tFJfTH7bkWKdFJ4HuN6X=oFyZ1tKey4gBxix4Q@mail.gmail.com>
 <CAAMcf8A06=Cud=NPCKZfb1EDPSMiw5M79+WfgBqENRMySd5Xvg@mail.gmail.com>
In-Reply-To: <CAAMcf8A06=Cud=NPCKZfb1EDPSMiw5M79+WfgBqENRMySd5Xvg@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sun, 16 Dec 2018 01:30:25 +0530
Message-ID: <CACi5LpNUEJev+SCHiHTkKo6LU-dMLEHL=g-H4zyYvsYcJnbS5Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] kexec/kexec-arm64.c: Add missing error handling paths
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
To: Vicente Bergas <vicencb@gmail.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

On Fri, Dec 14, 2018 at 6:44 PM Vicente Bergas <vicencb@gmail.com> wrote:
>
> On Sun, Dec 9, 2018 at 10:45 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> > Hello Akashi,
> >
> > Thanks for your review and sorry for my late reply.
> > It seems I found the root cause of the issue and it is quite different
> > from what I was thinking before.
> >
> > The issue happens because we pass '/chosen' string to
> > 'fdt_add_subnode()' in 'kexec/dt-ops.c' instead of 'chosen' string.
> >
> > The different strings being passed to 'fdt_add_subnode()' and
> > 'fdt_path_offset()' are 'chosen' and '/chosen' respectively for
> > adding/finding offset of the '/chosen' node in the kernel, see
> > 'drivers/firmware/efi/libstub/fdt.c' for details of such use-cases.
> >
> > When I fix the 'kexec-tools' to pass the same strings according to the
> > function being called, it fixes all the 'kexec -l' and 'kexec -p'
> > use-cases I could try on my boards, including the '--dtb' use cases.
> > So, I think this should be a workable solution.
> >
> > @Vicente: Can you please drop the earlier approaches I shared and just
> > try the hack'ish patch below. If this works for all the use-cases at
> > your side, I can try and send a formal version of this one out.
>
> Hi Bhupesh,
> I have tried several combinations of --append, --reuse-cmdline, --dtb
> and --ramdisk for the --load option: all of them worked fine.
> At the moment I do not have a proper setup to test the --exec option
> on that board without the chosen node in its dtb. I will report back
> when done.
> Thank you very much.

Thanks a lot for your quick reply. Glad that this patch makes things
better for you.
I will send a formal patch soon on the same lines.

Thanks,
Bhupesh

> > /----------------------/
> > From 7fb5e848cef268f6c3c61e001050cfd9202f5790 Mon Sep 17 00:00:00 2001
> > From: Bhupesh Sharma <bhsharma@redhat.com>
> > Date: Sun, 2 Dec 2018 02:07:56 +0530
> > Subject: [PATCH] arm64: Fix fdt handling
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  kexec/dt-ops.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
> > index 915dbf55afd2..33d9b14900a9 100644
> > --- a/kexec/dt-ops.c
> > +++ b/kexec/dt-ops.c
> > @@ -9,6 +9,7 @@
> >  #include "dt-ops.h"
> >
> >  static const char n_chosen[] = "/chosen";
> > +static const char chosen[] = "chosen";
> >
> >  static const char p_bootargs[] = "bootargs";
> >  static const char p_initrd_start[] = "linux,initrd-start";
> > @@ -26,7 +27,7 @@ int dtb_set_initrd(char **dtb, off_t *dtb_size,
> > off_t start, off_t end)
> >
> >      value = cpu_to_fdt64(start);
> >
> > -    result = dtb_set_property(dtb, dtb_size, n_chosen, p_initrd_start,
> > +    result = dtb_set_property(dtb, dtb_size, chosen, p_initrd_start,
> >          &value, sizeof(value));
> >
> >      if (result)
> > @@ -34,11 +35,11 @@ int dtb_set_initrd(char **dtb, off_t *dtb_size,
> > off_t start, off_t end)
> >
> >      value = cpu_to_fdt64(end);
> >
> > -    result = dtb_set_property(dtb, dtb_size, n_chosen, p_initrd_end,
> > +    result = dtb_set_property(dtb, dtb_size, chosen, p_initrd_end,
> >          &value, sizeof(value));
> >
> >      if (result) {
> > -        dtb_delete_property(*dtb, n_chosen, p_initrd_start);
> > +        dtb_delete_property(*dtb, chosen, p_initrd_start);
> >          return result;
> >      }
> >
> > @@ -47,7 +48,7 @@ int dtb_set_initrd(char **dtb, off_t *dtb_size,
> > off_t start, off_t end)
> >
> >  int dtb_set_bootargs(char **dtb, off_t *dtb_size, const char *command_line)
> >  {
> > -    return dtb_set_property(dtb, dtb_size, n_chosen, p_bootargs,
> > +    return dtb_set_property(dtb, dtb_size, chosen, p_bootargs,
> >          command_line, strlen(command_line) + 1);
> >  }
> >
> > @@ -79,16 +80,17 @@ int dtb_set_property(char **dtb, off_t *dtb_size,
> > const char *node,
> >          goto on_error;
> >      }
> >
> > -    nodeoffset = fdt_path_offset(new_dtb, node);
> > -
> > +    nodeoffset = fdt_path_offset(new_dtb, n_chosen);
> > +
> >      if (nodeoffset == -FDT_ERR_NOTFOUND) {
> > -        result = fdt_add_subnode(new_dtb, nodeoffset, node);
> > +        result = fdt_add_subnode(new_dtb, 0, node);
> >
> > -        if (result) {
> > +        if (result < 0) {
> >              dbgprintf("%s: fdt_add_subnode failed: %s\n", __func__,
> >                  fdt_strerror(result));
> >              goto on_error;
> >          }
> > +        nodeoffset = result;
> >      } else if (nodeoffset < 0) {
> >          dbgprintf("%s: fdt_path_offset failed: %s\n", __func__,
> >              fdt_strerror(nodeoffset));
> > @@ -127,7 +129,7 @@ on_error:
> >  int dtb_delete_property(char *dtb, const char *node, const char *prop)
> >  {
> >      int result;
> > -    int nodeoffset = fdt_path_offset(dtb, node);
> > +    int nodeoffset = fdt_path_offset(dtb, n_chosen);
> >
> >      if (nodeoffset < 0) {
> >          dbgprintf("%s: fdt_path_offset failed: %s\n", __func__,
> > --
> > 2.7.4
> > On Tue, Dec 4, 2018 at 8:39 AM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Bhupesh,
> > >
> > > Thank you for submitting a patch. One comment:
> > >
> > > On Fri, Nov 30, 2018 at 11:02:45AM +0530, Bhupesh Sharma wrote:
> > > > While creating the 2nd dtb to be passed to the secondary kernel
> > > > for arm64, we need to handle the return values from helper fdt
> > > > functions properly, to make sure that we can handle various command-line
> > > > options being passed to 'kexec' both for kexec load and kdump
> > > > purposes.
> > > >
> > > > This will provide proper error reporting to the calling
> > > > function in case something goes wrong.
> > > >
> > > > Without this patch, we get misleading error FDT_ERR_BADOFFSET reported
> > > > when we pass a .dtb to 'kexec -p' using '--dtb' option, which doesn't
> > > > contain the '/chosen' node (for e.g. the rockchip sapphire board
> > > > dtb -> rk3399-sapphire.dtb).
> > > >
> > > >    # kexec -d -p Image --reuse-cmdline --dtb rk3399-sapphire.dtb
> > > >    <..snip..>
> > > >    load_crashdump_segments: elfcorehdr 0xbfff0000-0xbfff33ff
> > > >    get_cells_size: #address-cells:2 #size-cells:2
> > > >    cells_size_fitted: bfff0000-bfff33ff
> > > >    cells_size_fitted: 8ee00000-bfffffff
> > > >    setup_2nd_dtb: no kaslr-seed found
> > > >    setup_2nd_dtb: fdt_setprop failed: FDT_ERR_BADOFFSET
> > > >    kexec: setup_2nd_dtb failed.
> > > >    kexec: load failed.
> > > >
> > > > Now after the fix, we get the correct error FDT_ERR_NOTFOUND reported
> > > > to the calling function:
> > > >
> > > >    # kexec -d -l Image --append 'debug' --dtb rk3399-sapphire.dtb
> > > >    <..snip..>
> > > >    load_crashdump_segments: elfcorehdr 0xbfff0000-0xbfff33ff
> > > >    get_cells_size: #address-cells:2 #size-cells:2
> > > >    cells_size_fitted: bfff0000-bfff33ff
> > > >    cells_size_fitted: 8ee00000-bfffffff
> > > >    setup_2nd_dtb: /chosen node not found - can't create dtb for dump kernel: FDT_ERR_NOTFOUND
> > > >    kexec: setup_2nd_dtb failed.
> > > >    kexec: load failed.
> > > >
> > > >
> > > > Cc: Simon Horman <horms@verge.net.au>
> > > > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > > > ---
> > > >  kexec/arch/arm64/kexec-arm64.c | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > > > index f4913b2e9480..560d83455f95 100644
> > > > --- a/kexec/arch/arm64/kexec-arm64.c
> > > > +++ b/kexec/arch/arm64/kexec-arm64.c
> > > > @@ -515,6 +515,11 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
> > > >               }
> > > >
> > > >               nodeoffset = fdt_path_offset(new_buf, "/chosen");
> > > > +             if (nodeoffset < 0) {
> > > > +                     result = nodeoffset;
> > > > +                     goto on_error;
> > > > +             }
> > > > +
> > >
> > > I think that the issue should be fixed much earlier:
> > >
> > > |       /* fixup 'kaslr-seed' with a random value, if supported */
> > > |       nodeoffset = fdt_path_offset(new_buf, "/chosen");
> > > |       prop = fdt_getprop_w(new_buf, nodeoffset,
> > > |                       "kaslr-seed", &len);
> > >
> > > When we fail to locate "/chosen" here, we'd be better off to create it
> > > (if necessary). So, *logically*, we won't have to worry about it later on.
> > >
> > > -Takahiro Akashi
> > >
> > >
> > > >               result = fdt_setprop_inplace(new_buf,
> > > >                               nodeoffset, "kaslr-seed",
> > > >                               &fdt_val64, sizeof(fdt_val64));
> > > > @@ -529,6 +534,14 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
> > > >       if (on_crash) {
> > > >               /* add linux,elfcorehdr */
> > > >               nodeoffset = fdt_path_offset(new_buf, "/chosen");
> > > > +             if (nodeoffset < 0) {
> > > > +                     result = nodeoffset;
> > > > +                     dbgprintf("%s: /chosen node not found - can't create "
> > > > +                             "dtb for dump kernel: %s\n", __func__,
> > > > +                             fdt_strerror(result));
> > > > +                     goto on_error;
> > > > +             }
> > > > +
> > > >               result = fdt_setprop_range(new_buf, nodeoffset,
> > > >                               PROP_ELFCOREHDR, &elfcorehdr_mem,
> > > >                               address_cells, size_cells);
> > > > @@ -541,6 +554,14 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
> > > >
> > > >               /* add linux,usable-memory-range */
> > > >               nodeoffset = fdt_path_offset(new_buf, "/chosen");
> > > > +             if (nodeoffset < 0) {
> > > > +                     result = nodeoffset;
> > > > +                     dbgprintf("%s: /chosen node not found - can't create "
> > > > +                             "dtb for dump kernel: %s\n", __func__,
> > > > +                             fdt_strerror(result));
> > > > +                     goto on_error;
> > > > +             }
> > > > +
> > > >               result = fdt_setprop_range(new_buf, nodeoffset,
> > > >                               PROP_USABLE_MEM_RANGE, &crash_reserved_mem,
> > > >                               address_cells, size_cells);
> > > > --
> > > > 2.7.4
> > > >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
