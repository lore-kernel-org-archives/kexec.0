Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ht5hx-0002sJ-CV
	for kexec@lists.infradead.org; Tue, 29 May 2007 18:42:11 +0100
Message-ID: <465C6667.2020207@sgi.com>
Date: Tue, 29 May 2007 10:44:07 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
References: <4655C9B3.7060903@sgi.com> <20070529204311oomichi@mail.jp.nec.com>
In-Reply-To: <20070529204311oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, Dave Anderson <anderson@redhat.com>

Ken'ichi Ohmichi wrote:
> Hi Jay,
> 
> Sorry for the late response.
> 
> 2007/05/24 12:44:26 -0700, Jay Lan <jlan@sgi.com> wrote:
>> Bernhard Walle wrote:
>>> Hello,
>>>
>>> * Dave Anderson <anderson@redhat.com> [2007-05-24 20:31]:
>>>> The crash utility hides the details of there being a separate debug
>>>> file in the same way the gdb does when working with a binary executable
>>>> that has a separate debuginfo file.  It tries *not* to be ambiguous,
>>>> i.e., the point is to stay true to the "crash vmlinux vmcore" model.
>>> It's documented in the GDB documentation:
>>> http://sourceware.org/gdb/current/onlinedocs/gdb_16.html#SEC154
>> Thanks for the pointer, Bernhard. I installed kernel-debuginfo rpm
>> but crash still failed to find the debug information... I had to
>> copy the kernel-<version>.debug to /boot for it to work.
>>
>> So, i think it is a good idea for makedumpfile to follow the same
>> convension as crash and gdb, Ken'ichi?
> 
> No, I don't think it is worthy that a kernel file is specified *only*
> for getting the path to a debuginfo file. It is smart to specify
> a debuginfo file directly.  The crash utility needs both a kernel
> file and a debuginfo file, but makedumpfile needs only a debuginfo
> file as I said.
> 
> BTW, I recommend using a makedumpfile's CONFIGFILE instead of a
> debuginfo file.  If a system has a CONFIGFILE, makedumpfile can
> run without a debuginfo file.  It is smaller than a debuginfo file,
> and it is easy to distribute it to each system.
> I don't think each system should have a debuginfo file, because the
> file is big and a user may analyze a dumpfile on a remote analysis
> system. 

Ohmichi San,

Any way to make kernel debugging easier is great news!!! However...

If i run makedumpfile -x option to produce a dumpfile as below:
 # makedumpfile -c -d 31 -x VMLINUX VMCORE DUMPFILE

The size of these files are:
  16468 -rw-------  1 jlan wheel   16983716 2007-05-29 10:23 DUMPFILE

1719048 -r--------  1 jlan wheel 1760303684 2007-05-24 11:35 VMCORE
  55488 -rwxr-xr-x  1 jlan wheel   56819470 2007-05-24 11:33 VMLINUX

and crash was able to read and analyze the DUMPFILE together with the
VMLINUX.

Now when i used makedumpfile -g option to generate a CONFIGFILE:

 # makedumpfile -g CONFIGFILE -x VMLINUX

the size of CONFIGFILE is only 696 bytes. Besides, makedumpfile
failed to generate a DUMPFILE using the CONFIGFILE:

 # makedumpfile -c -d 31 -i CONFIGFILE VMCORE DUMPFILE
 CONFIGFILE and VMCORE don't match.

 makedumpfile Failed.


I think the CONFIGFILE is too small to be good?

What did i miss here?

Thanks,
 - jay


> 
> 
> Thanks
> Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
