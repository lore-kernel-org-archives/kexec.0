Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hi3Gx-0003TR-VA
	for kexec@lists.infradead.org; Sun, 29 Apr 2007 02:52:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] restoring x86 BIOS state before reboot
References: <20070406154628.GG12005@jukie.net>
Date: Sun, 29 Apr 2007 00:51:09 -0600
In-Reply-To: <20070406154628.GG12005@jukie.net> (Bart Trojanowski's message of
	"Fri, 6 Apr 2007 11:46:28 -0400")
Message-ID: <m1zm4rd676.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bart Trojanowski <bart@jukie.net>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>

Bart Trojanowski <bart@jukie.net> writes:

> Hi all,
>
> I am looking at a two stage boot where linux is loaded to do some system
> initialization before booting to Windows, which needs BIOS.
>
> I am interested in bypassing the BIOS on the second boot.
>
> I wanted to know if anyone has attempted to restore the BIOS memory such 
> that this could be attempted.  If not, I would love to get some pointers
> :)
>
> My plan right now is to backup the 128k of memory under 0x10000 to some
> staging memory under 0x90000, temporarily while in real mode, and then
> move it up somewhere higher once the kernel is running.
>
> Then on reboot I hope to undo the above and jump to 0x00007c00.
>
> Does this approach have any merit?

The primary problem isn't so much the BIOS memory.  That is usually
preserved.  But rather the BIOS gets confused at the massive change
in hardware state.  At least I think that is what happens.

On some BIOS/kernel configuration it isn't a problem I think I
got maybe a 20% success rate trying to use the 16bit linux entry
point that starts the new kernel from kexec when I was investigating
it.

You might get a little more success if you backup the BIOS memory
I don't know.

As long as you are not coming out of a panic situation there is
no theoretical reason why you shouldn't get the BIOS back and
working again, but the how of it is a challenge.

The possibility I keep playing with is to load the Bochs BIOS or
some other implementation of the basic boot services that I have
control over so that if it doesn't work the code can be fixed.
There has been some limited success with this technique in the
context of LinuxBIOS.

The ACPI tables should be reusable as is.

It may also be worth investigating if it is possible to bypass
the part of windows that uses BIOS calls.  I really don't have
a clue how a modern windows systems boots.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
