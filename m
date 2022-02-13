From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 13 Feb 2022 12:50:31 -0500
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <20220209120154.GC3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
 <20220209120154.GC3113@kunlun.suse.cz>
Message-ID: <b49cb41873655f4fc1269faab5729111d55ce9da.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

On Wed, 2022-02-09 at 13:01 +0100, Michal Such?nek wrote:
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index dea74d7717c0..1cde9b6c5987 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -560,6 +560,22 @@ config KEXEC_FILE
> > >   config ARCH_HAS_KEXEC_PURGATORY
> > >     def_bool KEXEC_FILE
> > > +config KEXEC_SIG
> > > +   bool "Verify kernel signature during kexec_file_load() syscall"
> > > +   depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > > +   help
> > > +     This option makes kernel signature verification mandatory for
> > > +     the kexec_file_load() syscall.
> > > +
> > > +     In addition to that option, you need to enable signature
> > > +     verification for the corresponding kernel image type being
> > > +     loaded in order for this to work.
> > > +
> > > +     Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
> > > +     verification. In addition IMA adds kernel hashes to the measurement
> > > +     list, extends IMA PCR in the TPM, and implements kernel image
> > > +     blacklist by hash.
> > 
> > So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? What is
> > the disadvantage, and two implementations(?) needed then? More overhead?
> 
> IMA_KEXEC does more than KEXEC_SIG. The overhead is probably not big
> unless you are trying to really minimize the kernel code size.
> 
> Arguably the simpler implementation hass less potential for bugs, too.
> Both in code and in user configuration required to enable the feature.
> 
> Interestingly IMA_ARCH_POLICY depends on KEXEC_SIG rather than
> IMA_KEXEC. Just mind-boggling.

FYI, a soft boot doesn't clear the TPM PCRs.  To be able to verify the
IMA measurement list after a kexec against a TPM quote, requires
carrying the measurement list across kexec.

The "IMA_KEXEC" config enables carrying the IMA measurement list across
kexec.  It has nothing to do with verifying the appended signature. 
That is based on kernel module appended signature code.

> 
> The main problem with IMA_KEXEC from my point of view is it is not portable.
> To record the measurements TPM support is requireed which is not available on
> all platforms.

Measuring the kexec kernel image and extending the TPM with the
measurement is required for trusted boot.  Boot loaders extend the
TPM's BIOS measurements. Similarly, IMA does not require a TPM, but if
one is available the kexec kernel image measurement is extended into
the IMA measurement list.  Otherwise, IMA goes into "TPM by-pass" mode.

> It does not support PE so it cannot be used on platforms
> that use PE kernel signature format.

True.  However, a kernel image with an appended signature may be
kexec'ed, regardless of the architecture.  Because some boot loaders
don't support appended signatures, from my point of view does not make
IMA kexec support not portable.

-- 
thanks,

Mimi


