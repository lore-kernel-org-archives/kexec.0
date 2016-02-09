Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173019pub.verizon.net ([206.46.173.19])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTCH7-0000Xg-Vr
 for kexec@lists.infradead.org; Tue, 09 Feb 2016 17:40:35 +0000
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul
 16 2014))
 with ESMTPA id <0O2A0041DJQEW010@vms173019.mailsrvcs.net> for
 kexec@lists.infradead.org; Tue, 09 Feb 2016 11:39:50 -0600 (CST)
Received: from [IPv6:2001:470:b8f6:1b:e553:a7f5:748e:1b1d]
 (unknown [IPv6:2001:470:b8f6:1b:e553:a7f5:748e:1b1d])
 by serve.minyard.net (Postfix) with ESMTPSA id 04FDEC2C	for
 <kexec@lists.infradead.org>; Tue,  9 Feb 2016 11:39:49 -0600 (CST)
Subject: Re: Handling an elf kernel dump with a randomized base
References: <56BA07BD.3090009@acm.org>
From: Corey Minyard <minyard@acm.org>
Message-id: <56BA2465.1090800@acm.org>
Date: Tue, 09 Feb 2016 11:39:49 -0600
MIME-version: 1.0
In-reply-to: <56BA07BD.3090009@acm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: minyard@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

On 02/09/2016 09:37 AM, Corey Minyard wrote:
> I have been working on getting kernels on different architectures with 
> randomized
> base operational.  One problem I've run into is that kernel dumps 
> taken this way are
> not debuggable with gdb, the symbols are, of course, all in the wrong 
> places.
>
> The way gdb handles relocation is to add an AT_ENTRY value in an auxv 
> note.  It holds
> the relocated start address and gdb uses that to figure out the 
> offsets.  This is
> easy enough to add if you have the information, I'm wondering the best 
> way to do
> this looking at getting it into the mainstream kernel and the crash 
> dump tools.
>
> There is some handling of this on x86_64 with KERNELOFFSET, but it 
> doesn't work for
> gdb.
>
> I can think of two ways to add this:
>
> * Add a vmcoreinfo value with the entry point and have the extraction 
> tool create
> the elf note.
>
> * Put the entry point in sysfs and have kexec add the note like it 
> does for
> vmcoreinfo.
>

I thought of a third possibility.  You could have a downstream tool that 
looks at the
value of a symbol (like _stext) in the vmcoreinfo and the vmlinux file 
and adds the
auxv note to the core dump.  That would require no changes to anything, but
would require the downstream tool.

-corey

> I'd like to avoid any solution that requires putting vmlinux or any 
> other large file
> on the target system, as this is not always possible for small 
> embedded systems.
>
> Thanks,
>
> -corey


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
