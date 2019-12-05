Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icvnp-00034W-Qh
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 18:24:39 +0000
Received: by mail-lf1-f71.google.com with SMTP id f16so648291lfc.2
 for <kexec@lists.infradead.org>; Thu, 05 Dec 2019 10:24:34 -0800 (PST)
MIME-Version: 1.0
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
 <1573556939-17803-5-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035971D4@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035971D4@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 5 Dec 2019 23:54:20 +0530
Message-ID: <CACi5LpP4KcUvRE8G5ngKE0iUT=Lu-D6d=B4B9ya8HpSr2KFuxQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] makedumpfile: Mark --mem-usage option unsupported
 for arm64
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: John Donnelly <john.p.donnelly@oracle.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Kazu,

On Wed, Dec 4, 2019 at 11:20 PM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> > -----Original Message-----
> > This patch marks '--mem-usage' option as unsupported for arm64
> > architecture.
> >
> > With the newer arm64 kernels supporting 48-bit/52-bit VA address spaces
> > and keeping a single binary for supporting the same, the address of
> > kernel symbols like _stext which could be earlier used to determine
> > VA_BITS value, can no longer to determine whether VA_BITS is set to 48
> > or 52 in the kernel space.
>
> The --mem-usage option works with older arm64 kernels, so we should not
> mark it unsupported for all arm64 kernels.
>
> (If we use ELF note vmcoreinfo in kcore, is it possible to support the
> option?  Let's think about it later..)

Ok, I am in the process of discussing this with arm64 maintainers in
detail as _stext symbol address can no longer be used to separate
48-bit v/s 52-bit kernel VA space configurations.

Also other user-space utilities like 'kexec-tools' also face a similar
problem with the 52-bit change (as the vmcore-dmesg stops working).

I am currently caught up with another high priority issue. Will come
back with more thoughts on this in a couple of days.

Thanks,
Bhupesh

> > Hence for now, it makes sense to mark '--mem-usage' option as
> > unsupported for arm64 architecture until we have more clarity from arm64
> > kernel maintainers on how to manage the same in future
> > kernel/makedumpfile versions.
> >
> > Cc: John Donnelly <john.p.donnelly@oracle.com>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: kexec@lists.infradead.org
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  makedumpfile.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index baf559e4d74e..ae60466a1e9c 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -11564,6 +11564,11 @@ main(int argc, char *argv[])
> >               MSG("\n");
> >               MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
> >       } else if (info->flag_mem_usage) {
> > +#ifdef __aarch64__
> > +             MSG("mem-usage not supported for arm64 architecure.\n");
> > +             goto out;
> > +#endif
> > +
> >               if (!check_param_for_creating_dumpfile(argc, argv)) {
> >                       MSG("Commandline parameter is invalid.\n");
> >                       MSG("Try `makedumpfile --help' for more information.\n");
> > --
> > 2.7.4
> >
>
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
