From: Borislav Petkov <bp@alien8.de>
Date: Tue, 19 Apr 2022 12:32:25 +0200
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
Message-ID: <Yl6PueNCZZeobMWr@zn.tnic>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Apr 18, 2022 at 05:03:39PM -0500, Eric DeVolder wrote:
> I've examined the code with this thought in mind, and I'm not exactly sure how
> this code should be restructured for !HOTPLUG stubs. I'd very much appreciate
> an example in order to facilitate accommodating the request!

For example, see init_intel_microcode() in arch/x86/include/asm/microcode.h:

#ifdef CONFIG_MICROCODE_INTEL
extern struct microcode_ops * __init init_intel_microcode(void);
#else
static inline struct microcode_ops * __init init_intel_microcode(void)
{
        return NULL;
}
#endif /* CONFIG_MICROCODE_INTEL */

The actual definition then is in:

   arch/x86/kernel/cpu/microcode/intel.c:
   struct microcode_ops * __init init_intel_microcode(void)

and it gets enabled when CONFIG_MICROCODE_INTEL is enabled in the
.config. When CONFIG_MICROCODE_INTEL=n, the static inline stub gets used
and optimized away by the compiler.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

