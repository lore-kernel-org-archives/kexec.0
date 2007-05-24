Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HrI1m-0000VY-R0
	for kexec@lists.infradead.org; Thu, 24 May 2007 14:27:33 -0400
Message-ID: <4655D9EA.8020601@redhat.com>
Date: Thu, 24 May 2007 14:31:06 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
References: <20070501133912.GA8247@suse.de>
	<20070524093556oomichi@mail.jp.nec.com> <4655C9B3.7060903@sgi.com>
In-Reply-To: <4655C9B3.7060903@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Jay Lan wrote:
> Ken'ichi Ohmichi wrote:
> =

>>Hi Bernhard,
>>
>>2007/05/01 15:39:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>>
>>>This patch implements support for following the debug information link i=
n the
>>>.gnu_debuginfo section if the specified binary contains one. That makes =
it
>>>possible to call makedumpfile with -x /boot/vmlinux-<version> on distrib=
utions
>>>that ship extra -debuginfo packages for the kernel.
>>
>>Isn't it good to specify the debuginfo file directly instead of your patc=
h ?
>>I confirmed that makedumpfile without your patch can run by specifying the
>>debuginfo file directly.
>>
>>makedumpfile needs only .debug_info section and doesn't need other sectio=
ns,
>>so it needs only the debuginfo file. I will add the following comment to =
the
>>manual for "Debugging Information in Separate Files". Please let me know =
your
>>opinion.
>>
>>-------------------------------------------------------------------------=
------
>>       -x VMLINUX
>>              Specify the first kernel=92s VMLINUX  with  debug  informat=
ion  to
>>              analyze the first kernel=92s memory usage.
>>+             If there is a file containing debug information and separat=
ed from
>>+             VMLINUX, the file should be specified instead of VMLINUX.
> =

> =

> This behavior seems to be different from that of crash. If a vmlinux
> does not contain debug_info and a separate vmlinux-<version>.debug is
> present, the 'crash' would try to look up for the accompanying debug
> file.
> =

> The way 'crash' looks up for the accompanying debug file seems
> ambiguous and not documented. The purpose of makedumpfile is to create
> an output file for 'crash' to consume. I hope 'crash' and 'makedumpfile'
> can use same semantics to specify the vmlinux and its accompanying
> debug file.

The crash utility hides the details of there being a separate debug
file in the same way the gdb does when working with a binary executable
that has a separate debuginfo file.  It tries *not* to be ambiguous,
i.e., the point is to stay true to the "crash vmlinux vmcore" model.

Not only that, crash needs stuff such as the kernel's static data,
which is located only in the stripped vmlinux file.  That's apparently
not the case with makedumpfile.

That being said, does any other distro besides RHEL3 actually use
the split vmlinux/vmlinux.debug format?  Thankfully Red Hat came
to its senses in RHEL4 and beyond...

Dave


> =

> Thanks,
>  - jay
> =

> =

>>              The  page  size of the first kernel and the second kernel s=
hould
>>              match.
>>              Example:
>>              # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile
>>-------------------------------------------------------------------------=
------
>>
>>
>>Thanks
>>Ken'ichi Ohmichi
>>
>>_______________________________________________
>>kexec mailing list
>>kexec@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/kexec
> =

> =




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
