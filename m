From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 7 Jan 2022 11:39:52 -0300
Subject: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <YdgtNvd68kWakErr@smile.fi.intel.com>
References: <20220106200007.112357-1-gpiccoli@igalia.com>
 <YdgtNvd68kWakErr@smile.fi.intel.com>
Message-ID: <9a6e628e-a6fc-9879-288b-eedc32151234@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 07/01/2022 09:08, Andy Shevchenko wrote:
> [...]
>> +	while (buf) {
>> +		func = strsep(&buf, ",");
> 
> Don't we have a parser of this format already?
> Anyway, you may reduce code by
> 
> 	unsigned long addr;
> 	char *func = buf;
> 
> 	while ((func = strsep(&func, ",")) {
> 

Hi Andy, thanks for the review! Looking the kernel code for some similar
parameters, I couldn't see any better alternative (like a helper) to do
this parsing - checked for example the ftrace parameters (borrowed my
code from there, in fact heh), initcall_blacklist, module_blacklist,
usbcore.quirks, etc.

I'll try to follow your suggestion, to reduce a bit the code...though I
confess the original code reads more clearly for me.

Cheers,


Guilherme

