Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsZC1-0003cm-Td
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 15:03:06 +0000
Date: Thu, 5 Jun 2014 11:01:59 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140605150159.GA14083@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140605083134.GE3506@darkstar.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, chaowang@redhat.com

On Thu, Jun 05, 2014 at 04:31:34PM +0800, Dave Young wrote:

[..]
> > +	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line,
> > +			info.command_line_len, info.kexec_flags);
> 
> Vivek,
> 
> I tried your patch on my uefi test machine, but kexec load fails like below:
> 
> [root@localhost ~]# kexec -l /boot/vmlinuz-3.15.0-rc8+ --use-kexec2-syscall
> Could not find a free area of memory of 0xa000 bytes ...

Hi Dave,

I think this message is coming from kexec-tools from old loading path. I
think somehow new path did not even kick in. I tried above and I got
-EBADF as I did not pass initrd. Can you run gdb on kexec and see if
you are getting to syscall or run strace.

> 
> Another issue is that the syscall should allow load kernel only without initrd

Agreed. Currently my code is not handling it. I am thinking of ways how to
make passing initrd fd optional.

> 
> and
> cmdline since kernel can mount root and embed cmdline in itself.

Passing command line is already optional. I tried it and kexec loaded
successfully.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
