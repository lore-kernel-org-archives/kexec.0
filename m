Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJEEx-0000ZM-Dv
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 11:07:44 +0000
Received: by mail-ej1-x641.google.com with SMTP id u21so7589905eja.2
 for <kexec@lists.infradead.org>; Fri, 18 Sep 2020 04:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200917193835.30910-1-matthias.bgg@kernel.org>
 <CAFTCetQ--QcB-8Br3skQhzj-Sei_tG+0_kX1J_dpur-f7CTdvw@mail.gmail.com>
 <c5453053-bce9-626b-a162-13f37c9d5c2c@suse.com>
In-Reply-To: <c5453053-bce9-626b-a162-13f37c9d5c2c@suse.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Fri, 18 Sep 2020 16:37:29 +0530
Message-ID: <CAFTCetRAoYhqke+p+GhuOiSKn1ZJ1Z1PM+e=09DTyWC6rPw4BQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add purgatory printing
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
To: Matthias Brugger <mbrugger@suse.com>
Cc: geoff@infradead.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, matthias.bgg@kernel.org

Hi Matthias,

On Fri, Sep 18, 2020 at 2:01 PM Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 18/09/2020 07:16, Bhupesh SHARMA wrote:
> > Hi Matthias,
> >
> > Thanks for the patch. Some nitpicks inline:
> >
> > On Fri, Sep 18, 2020 at 1:09 AM <matthias.bgg@kernel.org> wrote:
> >>
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Add option to allow purgatory printing on arm64 hardware
> >> by passing the console name which should be used.
> >> Based on a patch by Geoff Levand.
> >>
> >> Cc: Geoff Levand <geoff@infradead.org>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>   kexec/arch/arm64/include/arch/options.h |  6 ++-
> >>   kexec/arch/arm64/kexec-arm64.c          | 61 +++++++++++++++++++++++++
> >>   purgatory/arch/arm64/purgatory-arm64.c  | 17 ++++++-
> >>   3 files changed, 82 insertions(+), 2 deletions(-)
> >
> > Probably we also need to update the man page 'kexec/kexec.8' to add
> > documentation about the newly introduced argument.
> >
>
> I checked the documentation and under "ARCHITECTURE OPTIONS" and it only
> documents a subset of the x86(_64) architecture specific commands. So I think
> there is more work to do to get the documentation right.
>
> But after having a look, I think we might want to use "--serial" as option
> instead of "--console" to be in sync with x86. Although many architectures
> reinvent the options, if we can get it as near to x86 as possible, I think that
> would be a good thing. I'll do that in v2.

That's a good suggestion. I think the '--serial' option is a better
one as compared to '--console'.

> >> diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
> >> index a17d933..be7d169 100644
> >> --- a/kexec/arch/arm64/include/arch/options.h
> >> +++ b/kexec/arch/arm64/include/arch/options.h
> >> @@ -5,7 +5,8 @@
> >>   #define OPT_DTB                        ((OPT_MAX)+1)
> >>   #define OPT_INITRD             ((OPT_MAX)+2)
> >>   #define OPT_REUSE_CMDLINE      ((OPT_MAX)+3)
> >> -#define OPT_ARCH_MAX           ((OPT_MAX)+4)
> >> +#define OPT_CONSOLE            ((OPT_MAX)+4)
> >> +#define OPT_ARCH_MAX           ((OPT_MAX)+5)
> >>
> >>   #define KEXEC_ARCH_OPTIONS \
> >>          KEXEC_OPTIONS \
> >> @@ -13,6 +14,7 @@
> >>          { "command-line",  1, NULL, OPT_APPEND }, \
> >>          { "dtb",           1, NULL, OPT_DTB }, \
> >>          { "initrd",        1, NULL, OPT_INITRD }, \
> >> +       { "console",       1, NULL, OPT_CONSOLE }, \
> >>          { "ramdisk",       1, NULL, OPT_INITRD }, \
> >>          { "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
> >>
> >> @@ -25,6 +27,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
> >>   "     --command-line=STRING Set the kernel command line to STRING.\n"
> >>   "     --dtb=FILE            Use FILE as the device tree blob.\n"
> >>   "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
> >> +"     --console=STRING      Console used for purgatory printing.\n"
> >>   "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
> >>   "     --reuse-cmdline       Use kernel command line from running system.\n";
> >
> > Just a thought... sometimes the console string is also available as a
> > part of the '--reuse-cmdline' command line argument passed to the
> > kdump kernel. Can we also try to extract the --console string from the
> > cmdline provided to the primary kernel itself?
> >
>
> Well the problem is, that there can be more then one consoles present, so which
> one would be the correct one?
> I see this more like a debug feature which you use knowing which console you are
> looking for the debug messages. In the end it only helps you to see if kdump
> failed in the production system kernel or in the crash kernel.

Indeed, I think we need to add some more comments to explain this
option and distinguish it better from the serial port(s) mentioned in
the '--reuse-cmdline' option.

> >> @@ -32,6 +35,7 @@ struct arm64_opts {
> >>          const char *command_line;
> >>          const char *dtb;
> >>          const char *initrd;
> >> +       const char *console;
> >>   };
> >>
> >>   extern struct arm64_opts arm64_opts;
> >> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> >> index 45ebc54..44c9e6e 100644
> >> --- a/kexec/arch/arm64/kexec-arm64.c
> >> +++ b/kexec/arch/arm64/kexec-arm64.c
> >> @@ -165,6 +165,8 @@ int arch_process_options(int argc, char **argv)
> >>                          break;
> >>                  case OPT_KEXEC_FILE_SYSCALL:
> >>                          do_kexec_file_syscall = 1;
> >> +               case OPT_CONSOLE:
> >> +                       arm64_opts.console = optarg;
> >>                          break;
> >>                  default:
> >>                          break; /* Ignore core and unknown options. */
> >> @@ -180,12 +182,62 @@ int arch_process_options(int argc, char **argv)
> >>          dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__,
> >>                  (do_kexec_file_syscall && arm64_opts.dtb ? "(ignored)" :
> >>                                                          arm64_opts.dtb));
> >> +       dbgprintf("%s:%d: console: %s\n", __func__, __LINE__,
> >> +               arm64_opts.console);
> >> +
> >>          if (do_kexec_file_syscall)
> >>                  arm64_opts.dtb = NULL;
> >>
> >>          return 0;
> >>   }
> >>
> >> +/**
> >> + * find_purgatory_sink - Find a sink for purgatory output.
> >> + */
> >> +
> >> +static uint64_t find_purgatory_sink(const char *console)
> >> +{
> >> +       int fd, ret;
> >> +       char folder[255], device[255], mem[255];
> >> +       struct stat sb;
> >> +       char buffer[18];
> >
> > Just trying to understand the reasoning behind keeping the buffer 18
> > chars long. Can the bytes read from the console exceed the array size
> > here (may be a boundary check is required here to avoid overflows)?
> >
>
> The buffer having a size of 18 is somewhat random. We use it to read the string
> at for example
> /sys/class/tty/ttyAMA0/iomem_base
>
> And we read the size of the buffer, so no overflow is possible here. But: we
> expect a value like 0x94080000 which has actually 10 characters.
>
> >> +       uint64_t iomem = 0x0;
> >> +
> >> +       if (!console)
> >> +               return 0;
> >> +
> >> +       sprintf(device, "/sys/class/tty/%s", console);
>
> But your comment made me think of another thing. If the console string from the
> command line is really long the sprintf would cause overflows. In v2 I'll update
> the code to use snprintf instead.

Indeed, I am mainly worried about overflow issues with sprintf (and
helpers), having recently spent time debugging several such overflow
issues in upstream code. If we have concerns we can allocate the char
array dynamically and free it after use. Also we can add some boundary
checks for the dynamically allocated char array and how it is printed
in the purgatory code (to make sure that there are no overflows here).

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
