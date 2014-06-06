Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wt0Nj-0004mL-H2
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 20:04:56 +0000
Date: Fri, 6 Jun 2014 16:04:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140606200418.GN1526@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
 <20140605150159.GA14083@redhat.com>
 <20140606073748.GC3343@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140606073748.GC3343@darkstar.nay.redhat.com>
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

On Fri, Jun 06, 2014 at 03:37:48PM +0800, Dave Young wrote:
> On 06/05/14 at 11:01am, Vivek Goyal wrote:
> > On Thu, Jun 05, 2014 at 04:31:34PM +0800, Dave Young wrote:
> > 
> > [..]
> > > > +	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line,
> > > > +			info.command_line_len, info.kexec_flags);
> > > 
> > > Vivek,
> > > 
> > > I tried your patch on my uefi test machine, but kexec load fails like below:
> > > 
> > > [root@localhost ~]# kexec -l /boot/vmlinuz-3.15.0-rc8+ --use-kexec2-syscall
> > > Could not find a free area of memory of 0xa000 bytes ...
> > 
> > Hi Dave,
> > 
> > I think this message is coming from kexec-tools from old loading path. I
> > think somehow new path did not even kick in. I tried above and I got
> > -EBADF as I did not pass initrd. Can you run gdb on kexec and see if
> > you are getting to syscall or run strace.
> 
> Seems I can not reproduce the local hole fail issue but I'm sure it happens
> before the new syscall callback.
> 
> This time I got -ENOEXEC. It's caused by CONFIG_EFI_MIXED=y. In case EFI_MIXED
> 64bit kernel runs on 32bit efi firmware thus XLF_CAN_BE_LOADED_ABOVE_4G is not
> set thus bzImage probe will fail with NOEXEC.

Yep, current bzImage loader only supports loading 64bit image which can
be loaded above 4G.

I am wondering how user space implementation is taking care of it. I guess
we are falling back to 32bit implementation where we use 32bit entry and
assume that bzImage has to be below 4G.

We will have to do similar thing in kernel when 32bit loader comes in.
Compile that in for 64bit kernel and let it handle the case of bzImage
not being loadable above 4G.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
