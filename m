From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Wed, 9 Feb 2022 13:01:54 +0100
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
Message-ID: <20220209120154.GC3113@kunlun.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello,

On Wed, Feb 09, 2022 at 07:44:15AM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch.
> 
> 
> Am 11.01.22 um 12:37 schrieb Michal Suchanek:
> 
> Could you please remove the dot/period at the end of the git commit message
> summary?

Sure

> > Copy the code from s390x
> > 
> > Both powerpc and s390x use appended signature format (as opposed to EFI
> > based patforms using PE format).
> 
> patforms ? platforms

Thanks for noticing

> How can this be tested?

Apparently KEXEC_SIG_FORCE is x86 only although the use of the option is
arch neutral:

arch/x86/Kconfig:config KEXEC_SIG_FORCE
kernel/kexec_file.c:            if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE))
{

Maybe it should be moved?

I used a patched kernel that enables lockdown in secure boot, and then
verified that signed kernel can be loaded by kexec and unsigned not,
with KEXEC_SIG enabled and IMA_KEXEC disabled.

The lockdown support can be enabled on any platform, and although I
can't find it documented anywhere there appears to be code in kexec_file
to take it into account:
kernel/kexec.c: result = security_locked_down(LOCKDOWN_KEXEC);
kernel/kexec_file.c:                security_locked_down(LOCKDOWN_KEXEC))
kernel/module.c:        return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
kernel/params.c:            security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
and lockdown can be enabled with a buildtime option, a kernel parameter, or a
debugfs file.

Still for testing lifting KEXEC_SIG_FORCE to some arch-neutral Kconfig file is
probably the simplest option.

kexec -s option should be used to select kexec_file rather than the old
style kexec which would either fail always or succeed always regardelss
of signature.

> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
> >        explanation why the s390 code is usable on powerpc.
> >      - Include correct header for mod_check_sig
> >      - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
> >        in kconfig text
> > ---
> >   arch/powerpc/Kconfig        | 16 ++++++++++++++++
> >   arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 52 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index dea74d7717c0..1cde9b6c5987 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -560,6 +560,22 @@ config KEXEC_FILE
> >   config ARCH_HAS_KEXEC_PURGATORY
> >   	def_bool KEXEC_FILE
> > +config KEXEC_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > +	help
> > +	  This option makes kernel signature verification mandatory for
> > +	  the kexec_file_load() syscall.
> > +
> > +	  In addition to that option, you need to enable signature
> > +	  verification for the corresponding kernel image type being
> > +	  loaded in order for this to work.
> > +
> > +	  Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
> > +	  verification. In addition IMA adds kernel hashes to the measurement
> > +	  list, extends IMA PCR in the TPM, and implements kernel image
> > +	  blacklist by hash.
> 
> So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? What is
> the disadvantage, and two implementations(?) needed then? More overhead?

IMA_KEXEC does more than KEXEC_SIG. The overhead is probably not big
unless you are trying to really minimize the kernel code size.

Arguably the simpler implementation hass less potential for bugs, too.
Both in code and in user configuration required to enable the feature.

Interestingly IMA_ARCH_POLICY depends on KEXEC_SIG rather than
IMA_KEXEC. Just mind-boggling.

The main problem with IMA_KEXEC from my point of view is it is not portable.
To record the measurements TPM support is requireed which is not available on
all platforms. It does not support PE so it cannot be used on platforms
that use PE kernel signature format.

> 
> > +
> >   config RELOCATABLE
> >   	bool "Build a relocatable kernel"
> >   	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> > diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> > index eeb258002d1e..98d1cb5135b4 100644
> > --- a/arch/powerpc/kexec/elf_64.c
> > +++ b/arch/powerpc/kexec/elf_64.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/of_fdt.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > +#include <linux/module_signature.h>
> >   static void *elf64_load(struct kimage *image, char *kernel_buf,
> >   			unsigned long kernel_len, char *initrd,
> > @@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
> >   	return ret ? ERR_PTR(ret) : NULL;
> >   }
> > +#ifdef CONFIG_KEXEC_SIG
> > +int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
> > +{
> > +	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
> > +	struct module_signature *ms;
> > +	unsigned long sig_len;
> 
> Use size_t to match the signature of `verify_pkcs7_signature()`?

Nope. struct module_signature uses unsigned long, and this needs to be
matched to avoid type errors on 32bit.

Technically using size_t for in-memory buffers is misguided because
AFAICT no memory buffer can be bigger than ULONG_MAX, and size_t is
non-native type on 32bit.

Sure, the situation with ssize_t/int is different but that's not what we
are dealing with here.

Thanks

Michal

