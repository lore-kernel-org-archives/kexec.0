Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wsohr-00005U-5M
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 07:36:55 +0000
Date: Fri, 6 Jun 2014 15:37:48 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140606073748.GC3343@darkstar.nay.redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
 <20140605150159.GA14083@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140605150159.GA14083@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, chaowang@redhat.com

On 06/05/14 at 11:01am, Vivek Goyal wrote:
> On Thu, Jun 05, 2014 at 04:31:34PM +0800, Dave Young wrote:
> 
> [..]
> > > +	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line,
> > > +			info.command_line_len, info.kexec_flags);
> > 
> > Vivek,
> > 
> > I tried your patch on my uefi test machine, but kexec load fails like below:
> > 
> > [root@localhost ~]# kexec -l /boot/vmlinuz-3.15.0-rc8+ --use-kexec2-syscall
> > Could not find a free area of memory of 0xa000 bytes ...
> 
> Hi Dave,
> 
> I think this message is coming from kexec-tools from old loading path. I
> think somehow new path did not even kick in. I tried above and I got
> -EBADF as I did not pass initrd. Can you run gdb on kexec and see if
> you are getting to syscall or run strace.

Seems I can not reproduce the local hole fail issue but I'm sure it happens
before the new syscall callback.

This time I got -ENOEXEC. It's caused by CONFIG_EFI_MIXED=y. In case EFI_MIXED
64bit kernel runs on 32bit efi firmware thus XLF_CAN_BE_LOADED_ABOVE_4G is not
set thus bzImage probe will fail with NOEXEC.

> 
> > 
> > Another issue is that the syscall should allow load kernel only without initrd
> 
> Agreed. Currently my code is not handling it. I am thinking of ways how to
> make passing initrd fd optional.
> 
> > 
> > and
> > cmdline since kernel can mount root and embed cmdline in itself.
> 
> Passing command line is already optional. I tried it and kexec loaded
> successfully.
> 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
