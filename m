Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEbu6-0003Gy-GY
 for kexec@lists.infradead.org; Tue, 23 Feb 2021 17:55:23 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
Date: Tue, 23 Feb 2021 17:54:39 +0000
Message-ID: <277127DD-9294-46D7-B05D-15275EF1B93B@oracle.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <20210218020203.GC2871@MiWiFi-R3L-srv>
 <CACPcB9d7-kJR7OG2OrLcAhFhiMO26PB82Uv9bK9FkCfH__zWZQ@mail.gmail.com>
 <20210223135605.GA3553@MiWiFi-R3L-srv>
In-Reply-To: <20210223135605.GA3553@MiWiFi-R3L-srv>
Content-Language: en-US
Content-ID: <7D34A01A774BA7459C32BD985212D743@namprd10.prod.outlook.com>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, YiFei Zhu <yifeifz2@illinois.edu>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>



> On Feb 23, 2021, at 5:56 AM, Baoquan He <bhe@redhat.com> wrote:
> 
> On 02/23/21 at 08:01pm, Kairui Song wrote:
>> On Thu, Feb 18, 2021 at 10:03 AM Baoquan He <bhe@redhat.com> wrote:
>>> 
>>> On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
> ...
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index af14a567b493..f87c88ffa2f8 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>>>> config CRASH_CORE
>>>>      bool
>>>> 
>>>> +if CRASH_CORE
>>>> +
>>>> +config CRASH_AUTO_STR
>>>> +     string "Memory reserved for crash kernel"
>>>> +     depends on CRASH_CORE
>>>> +     default "1G-64G:128M,64G-1T:256M,1T-:512M"
>>>> +     help
>>>> +       This configures the reserved memory dependent
>>>> +       on the value of System RAM. The syntax is:
>>>> +       crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>>>> +                   range=start-[end]
>>>> +
>>>> +       For example:
>>>> +           crashkernel=512M-2G:64M,2G-:128M
>>>> +
>>>> +       This would mean:
>>>> +
>>>> +           1) if the RAM is smaller than 512M, then don't reserve anything
>>>> +              (this is the "rescue" case)
>>>> +           2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>>>> +           3) if the RAM size is larger than 2G, then reserve 128M
>>>> +
>>>> +endif # CRASH_CORE
>>> 
>>> Wondering if this CRASH_CORE ifdeffery is a little redundent here
>>> since CRASH_CORE dependency has been added. Except of this, I like this
>>> patch. As we discussed in private threads, we can try to push it into
>>> mainline and continue improving later.
>>> 
>> 
>> I believe "if CRASH_CORE" is not needed as it already "depends on
>> CRASH_CORE", tested with CRASH_CORE=y or 'not set', it just works.
> 
> Thanks for testing and confirmation, Kairui.
> 
> Saeed, can you post a v4 with CRASH_CORE ifdeffery removed? Maybe this
> week?

Thanks Kairui and Baoquan for testing and review. I just sent the v4. Hope we move forward and apply this week.

Saeed

> 
> Thanks
> Baoquan
> 
>> 
>>>> +
>>>> config KEXEC_CORE
>>>>      select CRASH_CORE
>>>>      bool
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index 106e4500fd53..ab0a2b4b1ffa 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -7,6 +7,7 @@
>>>> #include <linux/crash_core.h>
>>>> #include <linux/utsname.h>
>>>> #include <linux/vmalloc.h>
>>>> +#include <linux/kexec.h>
>>>> 
>>>> #include <asm/page.h>
>>>> #include <asm/sections.h>
>>>> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>>>>      if (suffix)
>>>>              return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>>>                              suffix);
>>>> +#ifdef CONFIG_CRASH_AUTO_STR
>>>> +     if (strncmp(ck_cmdline, "auto", 4) == 0) {
>>>> +             ck_cmdline = CONFIG_CRASH_AUTO_STR;
>>>> +             pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
>>>> +     }
>>>> +#endif
>>>>      /*
>>>>       * if the commandline contains a ':', then that's the extended
>>>>       * syntax -- if not, it must be the classic syntax
>>>> --
>>>> 2.27.0
>>>> 
>>> 
>>> 
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/kexec__;!!GqivPVa7Brio!MaBAPZr-j_WcNPodmosfVOyl0ipO6u22Ex-7gSi--wlwbmTgmkhsf-0yftioew3jnkS5WV5v$ 
>>> 
>> 
>> 
>> -- 
>> Best Regards,
>> Kairui Song
>> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
