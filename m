Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lerZQ-006YKy-FF
 for kexec@lists.infradead.org; Fri, 07 May 2021 03:54:34 +0000
Date: Fri, 7 May 2021 11:54:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
Message-ID: <20210507035418.GA23668@MiWiFi-R3L-srv>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-14-swboyd@chromium.org>
 <20210428101355.GB8374@localhost.localdomain>
 <CAE-0n517ZDD8ySTqT2GvKv-KNf1DFP2qmaqt3Pc=-AEndLTevg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE-0n517ZDD8ySTqT2GvKv-KNf1DFP2qmaqt3Pc=-AEndLTevg@mail.gmail.com>
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
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On 04/29/21 at 01:14am, Stephen Boyd wrote:
> Quoting Baoquan He (2021-04-28 03:13:55)
> > On 04/20/21 at 02:50pm, Stephen Boyd wrote:
> > > We can use the vmlinux_build_id array here now instead of open coding
> > > it. This mostly consolidates code.
> > >
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: <kexec@lists.infradead.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  include/linux/crash_core.h | 12 ++++-----
> > >  kernel/crash_core.c        | 50 ++------------------------------------
> > >  2 files changed, 8 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 206bde8308b2..de62a722431e 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> > >
> > >  #define VMCOREINFO_OSRELEASE(value) \
> > >       vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> > > -#define VMCOREINFO_BUILD_ID(value) \
> > > -     vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > > +#define VMCOREINFO_BUILD_ID()                                                \
> > > +     ({                                                              \
> > > +             static_assert(sizeof(vmlinux_build_id) == 20);          \
> > > +             vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \
> >
> > Since there has been static_assert at above, can we remove the magic
> > number '20'?
> >
> > And I checked format_decode(), didn't find which type corresponds to
> > 'N', could you tell?
> 
> It is documented in Documentation/core-api/printk-formats.rst (see "Raw
> buffer as a hex string") where the '20' replaces the '*' to specify a
> fixed size buffer to format. We could pass the 20 as an argument instead
> of encoding it in the format, but then it would still be there twice. We
> could use a #define but then it would have to be passed as an argument.

Thanks for telling, I can see 'phN' is used in many places, but haven't
figured out how it's parsed, e.g in format_decode() it's not related.
Anyway, I may need dig further or search to get it.

> 
> I don't know of a good way to enforce in printk that the buffer is the
> size that matches the format size. Maybe it shouldn't be an option to
> have a size in the format string if it's a problem to put the size of
> the buffer in there.

Oh, I meant that we may not need to enforce that because the size of
vmlinux_build_id can be guaranteed, always 20, we do not need to specify
the '20'? Afaik, we usually specify the format size when the string size
is variable, and we want to add '0' to make the width of printing is
fixed. Anyway, this dones't matter much.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> >
> > Other than these, this patch looks good to me, thanks for the effort.
> >
> 
> Thanks.
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
