Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbtOH-000Frr-DL
 for kexec@lists.infradead.org; Wed, 28 Apr 2021 23:14:46 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id
 e9-20020a4ada090000b02901f91091e5acso2189986oou.0
 for <kexec@lists.infradead.org>; Wed, 28 Apr 2021 16:14:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20210428101355.GB8374@localhost.localdomain>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-14-swboyd@chromium.org>
 <20210428101355.GB8374@localhost.localdomain>
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 29 Apr 2021 01:14:43 +0200
Message-ID: <CAE-0n517ZDD8ySTqT2GvKv-KNf1DFP2qmaqt3Pc=-AEndLTevg@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Quoting Baoquan He (2021-04-28 03:13:55)
> On 04/20/21 at 02:50pm, Stephen Boyd wrote:
> > We can use the vmlinux_build_id array here now instead of open coding
> > it. This mostly consolidates code.
> >
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: <kexec@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  include/linux/crash_core.h | 12 ++++-----
> >  kernel/crash_core.c        | 50 ++------------------------------------
> >  2 files changed, 8 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 206bde8308b2..de62a722431e 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >
> >  #define VMCOREINFO_OSRELEASE(value) \
> >       vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> > -#define VMCOREINFO_BUILD_ID(value) \
> > -     vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > +#define VMCOREINFO_BUILD_ID()                                                \
> > +     ({                                                              \
> > +             static_assert(sizeof(vmlinux_build_id) == 20);          \
> > +             vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \
>
> Since there has been static_assert at above, can we remove the magic
> number '20'?
>
> And I checked format_decode(), didn't find which type corresponds to
> 'N', could you tell?

It is documented in Documentation/core-api/printk-formats.rst (see "Raw
buffer as a hex string") where the '20' replaces the '*' to specify a
fixed size buffer to format. We could pass the 20 as an argument instead
of encoding it in the format, but then it would still be there twice. We
could use a #define but then it would have to be passed as an argument.

I don't know of a good way to enforce in printk that the buffer is the
size that matches the format size. Maybe it shouldn't be an option to
have a size in the format string if it's a problem to put the size of
the buffer in there.

>
> Other than these, this patch looks good to me, thanks for the effort.
>

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
