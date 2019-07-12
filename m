Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlqaA-0002PG-FJ
 for kexec@lists.infradead.org; Fri, 12 Jul 2019 08:07:07 +0000
Received: by mail-lf1-f65.google.com with SMTP id c19so5861291lfm.10
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2019 01:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
 <1562788469-22935-4-git-send-email-bhsharma@redhat.com>
 <20190711095800.i6flfrcdidw2t6la@verge.net.au>
In-Reply-To: <20190711095800.i6flfrcdidw2t6la@verge.net.au>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 12 Jul 2019 13:36:52 +0530
Message-ID: <CACi5LpNdPfr8-7-jgp98FbRWz7DaiM=fLt1uctv5rGwUK1rTbA@mail.gmail.com>
Subject: Re: [PATCH 3/4] kexec/kexec-zlib.h: Add 'is_zlib_file()' helper
 function
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
To: Simon Horman <horms@verge.net.au>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

Hi Simon,

On Thu, Jul 11, 2019 at 3:28 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Thu, Jul 11, 2019 at 01:24:28AM +0530, Bhupesh Sharma wrote:
> > This patch adds 'is_zlib_file()' helper function which can be
> > used to quickly determine with the passed kernel image is a zlib
> > compressed kernel image.
> >
> > This is specifically useful for arm64 zImage (or Image.gz) support,
> > which is introduced by later patches in this patchset.
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  kexec/kexec-zlib.h |  1 +
> >  kexec/zlib.c       | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/kexec/kexec-zlib.h b/kexec/kexec-zlib.h
> > index 43c107bf4a72..16300f294759 100644
> > --- a/kexec/kexec-zlib.h
> > +++ b/kexec/kexec-zlib.h
> > @@ -6,5 +6,6 @@
> >
> >  #include "config.h"
> >
> > +int is_zlib_file(const char *filename, off_t *r_size);
> >  char *zlib_decompress_file(const char *filename, off_t *r_size);
> >  #endif /* __KEXEC_ZLIB_H */
> > diff --git a/kexec/zlib.c b/kexec/zlib.c
> > index 95b608059d41..34d5ca566769 100644
> > --- a/kexec/zlib.c
> > +++ b/kexec/zlib.c
> > @@ -23,6 +23,32 @@ static void _gzerror(gzFile fp, int *errnum, const char **errmsg)
> >       }
> >  }
> >
> > +int is_zlib_file(const char *filename, off_t *r_size)
> > +{
> > +     gzFile fp;
> > +     int errnum;
> > +     const char *msg;
> > +
> > +     if (!filename)
> > +             goto out;
> > +
> > +     fp = gzopen(filename, "rb");
>
> Does fp need to be closed somewhere to avoid a leak?

Right. Will fix this in v2.

v2 will be soon on its way.

Thanks,
Bhupesh

> > +     if (fp == 0) {
> > +             _gzerror(fp, &errnum, &msg);
> > +             dbgprintf("Cannot open `%s': %s\n", filename, msg);
> > +             goto out;
> > +     }
> > +
> > +     if (gzdirect(fp))
> > +             /* It's not in gzip format */
> > +             goto out;
> > +
> > +     /* It's in gzip format */
> > +     return 1;
> > +out:
> > +     return 0;
> > +}
> > +
> >  char *zlib_decompress_file(const char *filename, off_t *r_size)
> >  {
> >       gzFile fp;
> > @@ -84,6 +110,12 @@ fail:
> >       return buf;
> >  }
> >  #else
> > +
> > +int is_zlib_file(const char *filename, off_t *r_size)
> > +{
> > +     return 0;
> > +}
> > +
> >  char *zlib_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
> >  {
> >       return NULL;
> > --
> > 2.7.4
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
