Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUNLV-006zJt-Ti
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 05:36:52 +0000
Received: by mail-pf1-x435.google.com with SMTP id n38so995350pfv.2
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 22:36:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-13-swboyd@chromium.org>
 <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
Subject: Re: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
From: Stephen Boyd <swboyd@chromium.org>
Date: Wed, 07 Apr 2021 22:36:45 -0700
Message-ID: <161786020531.3790633.14618419586085886962@swboyd.mtv.corp.google.com>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Quoting Petr Mladek (2021-04-07 10:03:28)
> On Tue 2021-03-30 20:05:20, Stephen Boyd wrote:
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
> >  include/linux/crash_core.h |  6 +-----
> >  kernel/crash_core.c        | 41 ++------------------------------------
> >  2 files changed, 3 insertions(+), 44 deletions(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 206bde8308b2..fb8ab99bb2ee 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >  #define VMCOREINFO_OSRELEASE(value) \
> >       vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> >  #define VMCOREINFO_BUILD_ID(value) \
> > -     vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > +     vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)
> 
> Please, add also build check that BUILD_ID_MAX == 20.
> 

I added a BUILD_BUG_ON() in kernel/crash_core.c. I tried static_assert()
here but got mixed ISO errors from gcc-10, although it feels like it
should work.

In file included from ./arch/arm64/include/asm/cmpxchg.h:10,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/mm_types_task.h:13,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from kernel/crash_core.c:7:
kernel/crash_core.c: In function 'crash_save_vmcoreinfo_init':
./include/linux/build_bug.h:78:41: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/linux/crash_core.h:42:2: note: in expansion of macro 'static_assert'
   42 |  static_assert(ARRAY_SIZE(value) == BUILD_ID_SIZE_MAX); \
      |  ^~~~~~~~~~~~~
kernel/crash_core.c:401:2: note: in expansion of macro 'VMCOREINFO_BUILD_ID'
  401 |  VMCOREINFO_BUILD_ID(vmlinux_build_id);

> 
> The function add_build_id_vmcoreinfo() is used in
> crash_save_vmcoreinfo_init() in this context:
> 
> 
>         VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>         add_build_id_vmcoreinfo();
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
> 
>         VMCOREINFO_SYMBOL(init_uts_ns);
>         VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
> 
> The function is not longer need. VMCOREINFO_BUILD_ID()
> can be used directly:
> 
>         VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>         VMCOREINFO_BUILD_ID(vmlinux_build_id);
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
> 
>         VMCOREINFO_SYMBOL(init_uts_ns);
>         VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
> 
> 

Thanks. Makes sense. I've rolled that in.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
