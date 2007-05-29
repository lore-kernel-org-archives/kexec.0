Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ht06Q-0007nd-KD
	for kexec@lists.infradead.org; Tue, 29 May 2007 07:43:05 -0400
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
In-reply-to: <4655C9B3.7060903@sgi.com>
Message-Id: <20070529204311oomichi@mail.jp.nec.com>
References: <4655C9B3.7060903@sgi.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Tue, 29 May 2007 20:43:11 +0900
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, Dave Anderson <anderson@redhat.com>


Hi Jay,

Sorry for the late response.

2007/05/24 12:44:26 -0700, Jay Lan <jlan@sgi.com> wrote:
>Bernhard Walle wrote:
>> Hello,
>> 
>> * Dave Anderson <anderson@redhat.com> [2007-05-24 20:31]:
>>> The crash utility hides the details of there being a separate debug
>>> file in the same way the gdb does when working with a binary executable
>>> that has a separate debuginfo file.  It tries *not* to be ambiguous,
>>> i.e., the point is to stay true to the "crash vmlinux vmcore" model.
>> 
>> It's documented in the GDB documentation:
>> http://sourceware.org/gdb/current/onlinedocs/gdb_16.html#SEC154
>
>Thanks for the pointer, Bernhard. I installed kernel-debuginfo rpm
>but crash still failed to find the debug information... I had to
>copy the kernel-<version>.debug to /boot for it to work.
>
>So, i think it is a good idea for makedumpfile to follow the same
>convension as crash and gdb, Ken'ichi?

No, I don't think it is worthy that a kernel file is specified *only*
for getting the path to a debuginfo file. It is smart to specify
a debuginfo file directly.  The crash utility needs both a kernel
file and a debuginfo file, but makedumpfile needs only a debuginfo
file as I said.

BTW, I recommend using a makedumpfile's CONFIGFILE instead of a
debuginfo file.  If a system has a CONFIGFILE, makedumpfile can
run without a debuginfo file.  It is smaller than a debuginfo file,
and it is easy to distribute it to each system.
I don't think each system should have a debuginfo file, because the
file is big and a user may analyze a dumpfile on a remote analysis
system. 


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
