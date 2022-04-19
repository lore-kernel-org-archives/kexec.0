From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 19 Apr 2022 16:58:47 -0500
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <Yl6PueNCZZeobMWr@zn.tnic>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com> <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com> <Yl6PueNCZZeobMWr@zn.tnic>
Message-ID: <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/19/22 05:32, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 05:03:39PM -0500, Eric DeVolder wrote:
>> I've examined the code with this thought in mind, and I'm not exactly sure how
>> this code should be restructured for !HOTPLUG stubs. I'd very much appreciate
>> an example in order to facilitate accommodating the request!
> 
> For example, see init_intel_microcode() in arch/x86/include/asm/microcode.h:
> 
> #ifdef CONFIG_MICROCODE_INTEL
> extern struct microcode_ops * __init init_intel_microcode(void);
> #else
> static inline struct microcode_ops * __init init_intel_microcode(void)
> {
>          return NULL;
> }
> #endif /* CONFIG_MICROCODE_INTEL */
> 
> The actual definition then is in:
> 
>     arch/x86/kernel/cpu/microcode/intel.c:
>     struct microcode_ops * __init init_intel_microcode(void)
> 
> and it gets enabled when CONFIG_MICROCODE_INTEL is enabled in the
> .config. When CONFIG_MICROCODE_INTEL=n, the static inline stub gets used
> and optimized away by the compiler.
> 
> HTH.
> 

Thanks Boris. So in taking this concept and looking at, in particular, patch 4/8
"crash: add generic infrastructure for crash hotplug support", I'm not exactly
sure how to apply this technique.

For example, if the suggestion is to change crash_hotplug_init() to be the function
or a stub, then what is an appropriate place to the __init callout?

If instead the suggestion is to create !HOTPLUG stubs() for the registration
functions within crash_hotplug_init(), then that entails taking what are currently
static scope symbols in the callbacks and notifier_block and exposing (ie make non-
static) those, which doesn't seem beneficial.

Or if the suggestion is to create !HOTPLUG stubs() for the callbacks, then I thin that
is implying that crash_hotplug_init() is not #ifdef'd and always runs and always
sets-up these event handlers, regardless if we need them?

Perhaps said differently, I'm not seeing, yet, how this technique applies to this code.
Is there a specific function that you know you want this way?

Thanks,
eric

