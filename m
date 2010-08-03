Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Og6qw-0002sJ-Ax
	for kexec@lists.infradead.org; Tue, 03 Aug 2010 02:03:38 +0000
Subject: Re: [PATCH] x86,setup: add serial_console_port_base in boot_params
References: <4C3F8B46.7080809@kernel.org> <20100731083409.GC5859@lenovo>
	<4C5469AF.2010608@zytor.com> <20100731183211.GB29357@lenovo>
	<4C548F7D.6000509@zytor.com> <4C54D3AD.8020906@kernel.org>
	<m14offuk8p.fsf@fess.ebiederm.org> <4C55041C.1030008@kernel.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 02 Aug 2010 19:03:04 -0700
In-Reply-To: <4C55041C.1030008@kernel.org> (Yinghai Lu's message of "Sat\,
	31 Jul 2010 22\:20\:28 -0700")
Message-ID: <m18w4o4fmv.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cyrill Gorcunov <gorcunov@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

Yinghai Lu <yinghai@kernel.org> writes:

> On 07/31/2010 07:42 PM, Eric W. Biederman wrote:
>> Yinghai Lu <yinghai@kernel.org> writes:
>> 
>>> On 07/31/2010 02:02 PM, H. Peter Anvin wrote:
>>>> On 07/31/2010 11:32 AM, Cyrill Gorcunov wrote:
>>>>>>
>>>>>> No, this is the internal part of the boot protocol, so it's not an issue.
>>>>>>
>>>>>
>>>>> Peter, I didn't mean any issue here, I meant that bootloaders don't know about
>>>>> this field yet and they will have to update own sources to pass port value
>>>>> at proper place of boot params. Or I miss something?
>>>>>
>>>>
>>>> Boot loaders that use the 16-bit entry point are unaffected.
>>>>
>>>> Boot loaders which use the 32-bit entry point but properly clears the
>>>> zero page simply will not have the feature.
>>>>
>>>> Boot loaders which use the 32-bit entry point but doesn't clear the zero
>>>> page are broken.
>>>>
>>> can you if this one is right for kexec path?
>> 
>> I am walking out the door, but this seems like nonsense to me.
>> 
>> Further I don't see why we would add something to the zero page
>> when we have a perfectly good way to pass this information via
>> the kernel command line.  strstr and strtoul are trivial little
>> functions so I don't see why anything would need to parse anything
>> other than console= or early_printk=.  The difference in code size
>> is negligible.
>> 
> so you prefer to check command line for console info in arch/x86/boot/compressed/misc.c again?
>
> that commandline is analyzed in arch/x86/boot/tty.c already.

Instead of changing 2 or 3 bootloaders, waiting years for the change
to propagate, and then trying to change users habits.

I definitely do.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
