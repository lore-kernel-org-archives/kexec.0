Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]
	helo=relay.sgi.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HrH0w-0002JH-JQ
	for kexec@lists.infradead.org; Thu, 24 May 2007 18:22:19 +0100
Message-ID: <4655C9B3.7060903@sgi.com>
Date: Thu, 24 May 2007 10:21:55 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
References: <20070501133912.GA8247@suse.de>
	<20070524093556oomichi@mail.jp.nec.com>
In-Reply-To: <20070524093556oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Dave Anderson <anderson@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Ken'ichi Ohmichi wrote:
> Hi Bernhard,
> 
> 2007/05/01 15:39:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>> This patch implements support for following the debug information link in the
>> .gnu_debuginfo section if the specified binary contains one. That makes it
>> possible to call makedumpfile with -x /boot/vmlinux-<version> on distributions
>> that ship extra -debuginfo packages for the kernel.
> 
> Isn't it good to specify the debuginfo file directly instead of your patch ?
> I confirmed that makedumpfile without your patch can run by specifying the
> debuginfo file directly.
> 
> makedumpfile needs only .debug_info section and doesn't need other sections,
> so it needs only the debuginfo file. I will add the following comment to the
> manual for "Debugging Information in Separate Files". Please let me know your
> opinion.
> 
> -------------------------------------------------------------------------------
>        -x VMLINUX
>               Specify the first kernel’s VMLINUX  with  debug  information  to
>               analyze the first kernel’s memory usage.
> +             If there is a file containing debug information and separated from
> +             VMLINUX, the file should be specified instead of VMLINUX.

This behavior seems to be different from that of crash. If a vmlinux
does not contain debug_info and a separate vmlinux-<version>.debug is
present, the 'crash' would try to look up for the accompanying debug
file.

The way 'crash' looks up for the accompanying debug file seems
ambiguous and not documented. The purpose of makedumpfile is to create
an output file for 'crash' to consume. I hope 'crash' and 'makedumpfile'
can use same semantics to specify the vmlinux and its accompanying
debug file.

Thanks,
 - jay

>               The  page  size of the first kernel and the second kernel should
>               match.
>               Example:
>               # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile
> -------------------------------------------------------------------------------
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
