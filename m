Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUanL-00990T-Qu
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 19:58:30 +0000
Received: by mail-pg1-x532.google.com with SMTP id t140so2141048pgb.13
 for <kexec@lists.infradead.org>; Thu, 08 Apr 2021 12:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20210408101743.GB22237@MiWiFi-R3L-srv>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-13-swboyd@chromium.org>
 <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
 <20210408101743.GB22237@MiWiFi-R3L-srv>
Subject: Re: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 08 Apr 2021 12:58:24 -0700
Message-ID: <161791190437.3790633.11239676305383366588@swboyd.mtv.corp.google.com>
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
To: Baoquan He <bhe@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Quoting Baoquan He (2021-04-08 03:17:43)
> On 04/07/21 at 07:03pm, Petr Mladek wrote:
> > On Tue 2021-03-30 20:05:20, Stephen Boyd wrote:
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
> > >  include/linux/crash_core.h |  6 +-----
> > >  kernel/crash_core.c        | 41 ++------------------------------------
> > >  2 files changed, 3 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 206bde8308b2..fb8ab99bb2ee 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> > >  #define VMCOREINFO_OSRELEASE(value) \
> > >     vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> > >  #define VMCOREINFO_BUILD_ID(value) \
> > > -   vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > > +   vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)
> 
> I may miss something, wondering why we need add '20' here.

The build ID is an array of 20 bytes and this format is to print 20
bytes in hex.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
