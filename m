Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OEYtB-0002MX-1M
	for kexec@lists.infradead.org; Wed, 19 May 2010 02:20:05 +0000
Message-ID: <4BF34AD7.8000001@ozlabs.org>
Date: Wed, 19 May 2010 12:20:07 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec-tools: Fix option/argument parsing
References: <4BECCE4D.2030905@ozlabs.org> <20100519003716.GE8536@verge.net.au>
In-Reply-To: <20100519003716.GE8536@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org

Howdy Simon,


Simon Horman wrote:
> On Fri, May 14, 2010 at 02:15:09PM +1000, Matt Evans wrote:
> 
> [snip]
> 
>> diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
>> deleted file mode 100644
>> index 75065b9..0000000
>> --- a/kexec/arch/x86_64/include/arch/options.h
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -#ifndef KEXEC_ARCH_X86_64_OPTIONS_H
>> -#define KEXEC_ARCH_X86_64_OPTIONS_H
>> -
>> -#define OPT_RESET_VGA      (OPT_MAX+0)
>> -#define OPT_SERIAL         (OPT_MAX+1)
>> -#define OPT_SERIAL_BAUD    (OPT_MAX+2)
>> -#define OPT_CONSOLE_VGA    (OPT_MAX+3)
>> -#define OPT_CONSOLE_SERIAL (OPT_MAX+4)
>> -#define OPT_ARCH_MAX       (OPT_MAX+5)
>> -
>> -#define KEXEC_ARCH_OPTIONS \
>> -	KEXEC_OPTIONS \
>> -	{ "reset-vga",	    0, 0, OPT_RESET_VGA }, \
>> -	{ "serial",	    1, 0, OPT_SERIAL }, \
>> -	{ "serial-baud",    1, 0, OPT_SERIAL_BAUD }, \
>> -	{ "console-vga",    0, 0, OPT_CONSOLE_VGA }, \
>> -	{ "console-serial", 0, 0, OPT_CONSOLE_SERIAL }, \
>> -
>> -#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
>> -
>> -#endif /* KEXEC_ARCH_X86_64_OPTIONS_H */
>> -
>> diff --git a/kexec/arch/x86_64/include/arch/options.h b/kexec/arch/x86_64/include/arch/options.h
>> new file mode 120000
>> index 0000000..047b0f9
>> --- /dev/null
>> +++ b/kexec/arch/x86_64/include/arch/options.h
>> @@ -0,0 +1 @@
>> +../../../i386/include/arch/options.h
>> \ No newline at end of file
> 
> The fragment above seems to a) belong in the previous fragment and
> b) be bogus. In any case x86_64 fails to build.
> 
> kexec/kexec.c: In function 'main':
> kexec/kexec.c:1061: error: 'KEXEC_ALL_OPTIONS' undeclared (first use in this function)

Well, a bit weird but not bogus:  It's a type change chunk (see 'new file mode'), replacing kexec/arch/x86_64/include/arch/options.h with a symlink to kexec/arch/i386/include/arch/options.h.

I've tested it applies cleanly with git-apply, and builds on x86-64 -- are you applying it with patch?

I used a symlink, though grotty, as many places look to include <arch/options.h> and the x86-64/i386 builds essentially have the same set of options.

I'll repost the patch without the trailing whitespace (oops) but if there's a better way to do this let me know & I'll include that instead.

Cheers,


Matt


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
