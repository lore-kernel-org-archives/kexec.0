Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jzips-0006v9-UH
	for kexec@lists.infradead.org; Sat, 24 May 2008 01:46:17 +0000
Received: by an-out-0708.google.com with SMTP id c24so223964ana.99
	for <kexec@lists.infradead.org>; Fri, 23 May 2008 18:46:16 -0700 (PDT)
Message-ID: <e2ed954f0805231846p41e64212lf990d8446a77833f@mail.gmail.com>
Date: Fri, 23 May 2008 18:46:16 -0700
From: "Jamey Sharp" <jamey@thetovacompany.com>
Subject: Re: [RFC] Win32 port of the userspace tools using MinGW.
In-Reply-To: <20080523231223.GD4517@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080516054813.GA21670@oh.minilop.net>
	<20080523231223.GD4517@verge.net.au>
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

On Fri, May 23, 2008 at 4:12 PM, Simon Horman <horms@verge.net.au> wrote:
> Firstly, thanks for your work in not only getting this port up and going,
> but methodically posted patches relating to it. You have made my job
> very easy :-)

I tried. I'm happy to hear I succeeded. :-)

> The patch looks a little invasive, but I guess that is to be expected
> given the nature of what you re doing. I wonder if there will be other
> equally different ports (by which I mean its the first time the code has
> been made to work outside of some Linux environment) and thus whether it
> is worth abstracting some of these things somehow. Just a thought.

Someone contacted me off-list about doing the same thing for MacOS X,
which my employer wants as well. And I could imagine interest in similar
work for various BSDs and others. So yes, making the code base more
portable would make some people happy.

There were a few cases where I added #ifdefs and Makefile conditionals
that might affect other porters. Here are some suggestions for improving
the kexec-tools' portability; I hope somebody else can pick them up...

The largest affected pieces of code were for crashdump kernel loading. I
have no idea how to hook the BSOD in Windows. :-) Other platforms will
probably have the same problem. Allowing all crashdump support to be
disabled at compile time would be an independent helpful patch.

Some code is architecture-specific on Linux but may be platform-generic
elsewhere. The get_memory_ranges function is an example: I think the
copy in win32.c will work on all architectures that Windows supports,
but /proc/iomem apparently is formatted a little differently on
different Linux architectures. The physical_arch function I recently
introduced should be another example, though its implementation is
presently a bit kludged. I don't know how best to structure the code
when some implementations should be in arch/ and some shouldn't.

I think get_memory_ranges could stand to be completely refactored.
First, the kexec-tools only require RANGE_RAM, AFAICT, so parsing more
information out of /proc/iomem is wasted effort and extra maintenance
cost. Then, most implementations are very similar. Looking over all the
implementations and seeing how they can be unified would help.

Finally, there are a handful of features that are not very portable and
may not be so useful on other platforms anyway:
- shutdown/reboot
- current video mode detection
- reusing kernel command line or initrd
- bringing down network interfaces
Making it easier to omit those features at compile-time would help with
porting. I chose minimal-patch approaches for all of these, rather than
clean fixes.

> I'm not opposed to the patch as it is.

Awesome! I have very little time left to clean it up further, though
like you I wish I were offering a less-invasive patch.

> Can you advise if there is any way to cross compile this code on a Linux
> (i686) box?

Oh, I meant to mention that. I did all this development on a Debian
x86-64 box; I cross-compiled everything for 32-bit targets as that's all
I cared about. So my configure command is:

./configure --host=i586-mingw32msvc --target=i486-linux-gnu \
            --build=x86_64-linux-gnu TARGET_CC="gcc -m32"

(I overrode TARGET_CC because I don't have an "i486-linux-gnu-gcc", just
the 64-bit GCC with "-m32".)

> The licence in include/byteswap.h.  How does that effect the licencing
> of the rest of the code?  Is it going to cause any distributions - I am
> thinking about Debian - to have a cow?

I meant to mention that too. :-) Apparently the Cygwin license mentioned
there can be found here:
    http://cygwin.com/license.html

It's GPLv2, with a special exception for linking with code that meets
the OSI's Open Source definition.

If anyone is concerned, byteswap.h can be rewritten from scratch in a
few minutes. :-) Last I checked, GCC on x86 generates the special x86
byte-swap instructions when fed the naive shift/or C implementation, so
byteswap.h doesn't need to be anything fancy.

> Lastly, I'm a big fan of <= 80 character wide lines.

OK. I'll resubmit with 80-column line limits and the kernel brace style.

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
