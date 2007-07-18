Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IBIfb-0003VE-QX
	for kexec@lists.infradead.org; Wed, 18 Jul 2007 19:11:01 -0400
Date: Thu, 19 Jul 2007 01:10:50 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070718231050.GB25660@suse.de>
References: <20070716123633.GA10920@in.ibm.com>
	<20070718230740oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070718230740oomichi@mail.jp.nec.com>
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
Cc: Neil Horman <nhorman@redhat.com>, vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dan Aloni <da-x@monatomic.org>

Hello,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-07-18 16:07]:
> I propose the solution including Dan's, Vivek's and Bernhard's opinions.
> How about the following sequence for distributors ?
> (It is not necessary to rebuild 2nd-kernel initrd even if 1st-kernel changes.
>  A new option "--mkdfinfo" is added to kexec command.)
> 
> * On the kernel building system
>   1. Create the kernel files.
>      # cd linux-2.6.xx
>      # make
>   2. Create the mkdfinfo file from the vmlinux.
>      # makedumpfile -g mkdfinfo-2.6.xx -x vmlinux
>      (OSRELEASE is taken from the vmlinux.)
>   3. Pack the kernel package with the kernel files and the mkdfinfo file.
> 
> * On each system
>   4. Preload 2nd-kernel and the mkdfinfo file.
>      # kexec -p vmlinux-kdump --mkdfinfo=mkdfinfo-2.6.xx ...
>      - 2nd-kernel is preloaded.
>      - 1st-kernel's PAGESIZE is taken by sysconf().
>      - The mkdfinfo file and the above PAGESIZE is preloaded
>        into /proc/vmcore's PT_NOTE segment.
>   5. Panic happens, and the system switchs to 2nd-kernel.
>   6. Create a filtered dump file.
>      # makedumpfile -cd31 /proc/vmcore dumpfile
>      (User doesn't need to specify the mkdfinfo file, because the
>       contents of the mkdfinfo file is included into /proc/vmcore.)

I like the proposal. The advantage over exporting the needed
information from the kernel directly is that makedumpfile (and the
contents of the mkdfinfo file [1]) can be changed without changing the
kernel which simplifies maintenance.

If now everybody agrees that this is the way to go, I can also offer
to implement the kernel and kexec userspace utility part
implementation of that stuff.

Maybe we should wait until Simon Horman is back here as he's the
current maintainer of kexec-tools(-testing).


Thanks,
   Bernhard

[1] didn't we agree to vmcoreinfo?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
