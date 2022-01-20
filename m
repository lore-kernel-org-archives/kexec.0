From: Baoquan He <bhe@redhat.com>
Date: Thu, 20 Jan 2022 17:45:39 +0800
Subject: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
In-Reply-To: <Yef5oz/XiZT/Pxfy@xhacker>
References: <20211206160514.2000-1-jszhang@kernel.org>
 <20220116133847.GE2388@MiWiFi-R3L-srv> <YebK70Sx4w8zLfj/@xhacker>
 <20220119080859.GB4977@MiWiFi-R3L-srv>
 <CA+zEjCvqYAWaWW9hVbHqYm_GbV-BaiOM4c77WHnxDNh+SRDUuw@mail.gmail.com>
 <20220119093322.GC4977@MiWiFi-R3L-srv> <Yef5oz/XiZT/Pxfy@xhacker>
Message-ID: <20220120094539.GC18398@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/19/22 at 07:44pm, Jisheng Zhang wrote:
> On Wed, Jan 19, 2022 at 05:33:22PM +0800, Baoquan He wrote:
> > On 01/19/22 at 09:52am, Alexandre Ghiti wrote:
> > > Hi Baoquan,
> > > 
> > > On Wed, Jan 19, 2022 at 9:11 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 01/18/22 at 10:13pm, Jisheng Zhang wrote:
> > > > > On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> > > > > > Hi Jisheng,
> > > > >
> > > > > Hi Baoquan,
> > > > >
> > > > > >
> > > > > > On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > > > > > > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > > > > > > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > > > > > > and increase compile coverage.
> > > > > >
> > > > > > I go through this patchset, You mention the benefits it brings are
> > > > > > 1) simplity the code;
> > > > > > 2) increase compile coverage;
> > > > > >
> > > > > > For benefit 1), it mainly removes the dummy function in x86, arm and
> > > > > > arm64, right?
> > > > >
> > > > > Another benefit: remove those #ifdef #else #endif usage. Recently, I
> > > > > fixed a bug due to lots of "#ifdefs":
> > > > > http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html
> > > >
> > > > Glad to know the fix. While, sometime the ifdeffery is necessary. I am
> > > > sorry about the one in riscv and you have fixed, it's truly a bug . But,
> > > > the increasing compile coverage at below you tried to make, it may cause
> > > > issue. Please see below my comment.
> > > >
> > > > >
> > > > > >
> > > > > > For benefit 2), increasing compile coverage, could you tell more how it
> > > > > > achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> > > > > > purpose? Please forgive my poor compiling knowledge.
> > > > >
> > > > > Just my humble opinion, let's compare the code::
> > > > >
> > > > > #ifdef CONFIG_KEXEC_CORE
> > > > >
> > > > > code block A;
> > > > >
> > > > > #endif
> > > > >
> > > > > If KEXEC_CORE is disabled, code block A won't be compiled at all, the
> > > > > preprocessor will remove code block A;
> > > > >
> > > > > If we convert the code to:
> > > > >
> > > > > if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> > > > >       code block A;
> > > > > }
> > > > >
> > > > > Even if KEXEC_CORE is disabled, code block A is still compiled.
> > > >
> > > > This is what I am worried about. Before, if CONFIG_KEXEC_CORE is
> > > > unset, those relevant codes are not compiled in. I can't see what
> > > > benefit is brought in if compiled in the unneeded code block. Do I miss
> > > > anything?
> > > >
> > > 
> > > This is explained in Documentation/process/coding-style.rst "21)
> > > Conditional Compilation".
> > 
> > Thanks for the pointer, Alex.
> > 
> > I read that part, while my confusion isn't gone. With the current code,
> > CONFIG_KEXEC_CORE is set,
> >   - reserve_crashkernel_low() and reserve_crashkernel() compiled in.
> 
> Although the code block will be compiled, but the code block will be
> optimized out.
> 
> > CONFIG_KEXEC_CORE is unset,
> >   - reserve_crashkernel_low() and reserve_crashkernel() compiled out. 
> > 
> > After this patch applied, does it have the same effect as the old code?
> 
> I compared the .o, and can confirm they acchieve the same effect.

Checked the .o, it's truly as you said. I didn't know this before,
thank you and Alex, learned this now.

Seems only static function has this effect. I tested your x86 patch,
those two functions are all optimized out. If I remove the static,
the entire reserve_crashkernel_low() exists, while reserve_crashkernel()
will be optimized as a empty function. 


