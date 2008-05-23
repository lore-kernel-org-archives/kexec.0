Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.247])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JzfVk-0000Na-F8
	for kexec@lists.infradead.org; Fri, 23 May 2008 22:13:16 +0000
Received: by an-out-0708.google.com with SMTP id c24so207878ana.99
	for <kexec@lists.infradead.org>; Fri, 23 May 2008 15:13:13 -0700 (PDT)
Message-ID: <e2ed954f0805231513i28cb788bt856d91afcab4e227@mail.gmail.com>
Date: Fri, 23 May 2008 15:13:12 -0700
From: "Jamey Sharp" <jamey@thetovacompany.com>
Subject: Re: [RFC] Win32 port of the userspace tools using MinGW.
In-Reply-To: <20080522153403.1e6e714a@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080516054813.GA21670@oh.minilop.net>
	<20080522153403.1e6e714a@kopernikus.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, May 22, 2008 at 6:34 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * Jamey Sharp <jamey@thetovacompany.com> [2008-05-15 22:48]:
>> OK, I haven't quite gotten around to posting the Windows kernel driver
>> source that goes with this.
>
> Do you plan to release the driver sources?

Yes, and I've finally done so. The code I wrote is licensed under GPLv2
or later; some Linux kernel source is included verbatim or with
modifications, and is licensed accordingly.
    http://source.thetovacompany.com/kexec-win/

I've only tried cross-compiling this code from Linux. In principle it
should build with MinGW on Windows as well, if anyone cares. :-)

My versions of machine_kexec_32.c and relocate_kernel_32.S have some
changes. I've been trying to find time to propose them as patches to
Linux kexec, but I've been waiting until I could test them, which hasn't
happened yet. I started from Linux v2.6.25 if anyone cares to diff them.

The load_kimage function in kexec.c is roughly equivalent to
sys_kexec_load in Linux but with a lot less code. It doesn't handle the
possibility of being allocated pages at addresses that won't fit in an
unsigned long. But I think it handles everything else that Linux does,
with less complexity. I'd really like to get review on that, and see if
something like my algorithm should go into the Linux implementation too.

>> +
>> +     if(memory_range)
>> +     {
>> +             *range = memory_range;
>> +             *ranges = memory_ranges;
>> +             return 0;
>> +     }
>
> I think you should use the kernel coding style here, i.e. the '{' in
> the same line as the 'if'.

I assume you mean I should use kernel style throughout, not just in the
quoted bit. :-) Sure, I can do that. I was hoping for more feedback than
just code style though. :-)

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
