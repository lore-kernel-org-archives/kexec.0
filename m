Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wsnk4-00014C-Fu
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 06:35:09 +0000
Date: Fri, 6 Jun 2014 14:34:24 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH 06/13] kexec: New syscall kexec_file_load() declaration
Message-ID: <20140606063424.GD2785@dhcp-17-89.nay.redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-7-git-send-email-vgoyal@redhat.com>
 <20140605095603.GD3876@dhcp-17-89.nay.redhat.com>
 <20140605151639.GB14083@redhat.com>
 <20140605152209.GC14083@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140605152209.GC14083@redhat.com>
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com

On 06/05/14 at 11:22am, Vivek Goyal wrote:
> On Thu, Jun 05, 2014 at 11:16:39AM -0400, Vivek Goyal wrote:
> > On Thu, Jun 05, 2014 at 05:56:03PM +0800, WANG Chao wrote:
> > 
> > [..]
> > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > index c435c5f..a3044e6 100644
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -1098,6 +1098,13 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
> > > >  }
> > > >  #endif
> > > >  
> > > > +SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > +		const char __user *, cmdline_ptr, unsigned long,
> > > > +		cmdline_len, unsigned long, flags)
> > > 
> > > initrd is optional for system boot.
> > > 
> > > How about using int *kernel_fd and int *initrd_fd as the argument? Then
> > > if I don't need initrd, in userspace I can do this:
> > 
> > Hi Chao,
> > 
> > I really am not too keen converting plain int fd arguments into pointers.
> > 
> > Given the fact that fd is int, that means all valid values are greater
> > than 0. How about using -1 to denote that initrd is not being loaded?
> > 
> > This does create one little anomaly and that is for all -ve values we
> > will return -EBADF except -1 which we special cased.
> 
> Or we could do.
> 
> - Define extra flag which should be set by user if valid initrd fd is not
>   being passed. Say, KEXEC_FILE_NO_INITRAMFS. And if kernel sees that flag
>   it will not try to parse value passed in argument initrd_fd at all.
> 
> I think I like this better.

Yep, it makes more sense to me as well. Please add this new flag.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
