Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEN4D-0003rV-Ql
 for kexec@lists.infradead.org; Tue, 23 Feb 2021 02:04:50 +0000
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <20210218020203.GC2871@MiWiFi-R3L-srv>
From: john.p.donnelly@oracle.com
Message-ID: <fcb8e523-e639-1a71-d59d-53b98260ae88@oracle.com>
Date: Mon, 22 Feb 2021 20:03:13 -0600
In-Reply-To: <20210218020203.GC2871@MiWiFi-R3L-srv>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: linux-doc@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>

On 2/17/21 8:02 PM, Baoquan He wrote:
> On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
>> This adds crashkernel=auto feature to configure reserved memory for
>> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
>> different kernel distributions and different archs based on their
>> needs.
>>
>> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
>> ---
>>   Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
>>   .../admin-guide/kernel-parameters.txt         |  6 +++++
>>   arch/Kconfig                                  | 24 +++++++++++++++++++
>>   kernel/crash_core.c                           |  7 ++++++
>>   4 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..e55cdc404c6b 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -285,7 +285,8 @@ This would mean:
>>       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>>       3) if the RAM size is larger than 2G, then reserve 128M
>>   
>> -
>> +Or you can use crashkernel=auto to choose the crash kernel memory size
>> +based on the recommended configuration set for each arch.
>>   
>>   Boot into System Kernel
>>   =======================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 7d4e523646c3..aa2099465458 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -736,6 +736,12 @@
>>   			a memory unit (amount[KMG]). See also
>>   			Documentation/admin-guide/kdump/kdump.rst for an example.
>>   
>> +	crashkernel=auto
>> +			[KNL] This parameter will set the reserved memory for
>> +			the crash kernel based on the value of the CRASH_AUTO_STR
>> +			that is the best effort estimation for each arch. See also
>> +			arch/Kconfig for further details.
>> +
>>   	crashkernel=size[KMG],high
>>   			[KNL, X86-64] range could be above 4G. Allow kernel
>>   			to allocate physical memory region from top, so could
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index af14a567b493..f87c88ffa2f8 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>>   config CRASH_CORE
>>   	bool
>>   
>> +if CRASH_CORE
>> +
>> +config CRASH_AUTO_STR
>> +	string "Memory reserved for crash kernel"
>> +	depends on CRASH_CORE
>> +	default "1G-64G:128M,64G-1T:256M,1T-:512M"
>> +	help
>> +	  This configures the reserved memory dependent
>> +	  on the value of System RAM. The syntax is:
>> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>> +	              range=start-[end]
>> +
>> +	  For example:
>> +	      crashkernel=512M-2G:64M,2G-:128M
>> +
>> +	  This would mean:
>> +
>> +	      1) if the RAM is smaller than 512M, then don't reserve anything
>> +	         (this is the "rescue" case)
>> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>> +	      3) if the RAM size is larger than 2G, then reserve 128M
>> +
>> +endif # CRASH_CORE
> 
> Wondering if this CRASH_CORE ifdeffery is a little redundent here
> since CRASH_CORE dependency has been added. Except of this, I like this
> patch. As we discussed in private threads, we can try to push it into
> mainline and continue improving later.

Hi,

Are we good to move forward with this and apply it now?

Dave Young acked it.

Thank you,

John.

(Note - I am currently not on any vger.kernel.org dlist at the moment so 
please cc me ).



> 
> 
>> +
>>   config KEXEC_CORE
>>   	select CRASH_CORE
>>   	bool
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 106e4500fd53..ab0a2b4b1ffa 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/crash_core.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/kexec.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>>   	if (suffix)
>>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>   				suffix);
>> +#ifdef CONFIG_CRASH_AUTO_STR
>> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
>> +		ck_cmdline = CONFIG_CRASH_AUTO_STR;
>> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
>> +	}
>> +#endif
>>   	/*
>>   	 * if the commandline contains a ':', then that's the extended
>>   	 * syntax -- if not, it must be the classic syntax
>> -- 
>> 2.27.0
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
