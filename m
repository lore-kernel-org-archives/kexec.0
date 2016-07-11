Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMVQ6-00031n-9Y
 for kexec@lists.infradead.org; Mon, 11 Jul 2016 07:14:23 +0000
Received: by mail-pa0-x22b.google.com with SMTP id ks6so7050749pab.0
 for <kexec@lists.infradead.org>; Mon, 11 Jul 2016 00:14:01 -0700 (PDT)
Date: Mon, 11 Jul 2016 16:19:35 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [RFC] arm64: kexec_file_load support
Message-ID: <20160711071934.GZ20774@linaro.org>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
 <11139482.zLvCKVycQr@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11139482.zLvCKVycQr@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, catalin.marinas@arm.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Fri, Jul 08, 2016 at 11:48:44AM -0300, Thiago Jung Bauermann wrote:
> Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> > If so maybe change a bit from your precious mentioned 7 args proposal like
> > below?
> > 
> > struct kexec_file_fd {
> > 	enum kexec_file_type;
> > 	int fd;
> > }
> > 
> > struct kexec_fdset {
> > 	int nr_fd;
> > 	struct kexec_file_fd fd[0];
> > }
> > 
> > int kexec_file_load(int kernel_fd, int initrd_fd,
> > 		    unsigned long cmdline_len, const char *cmdline_ptr,
> > 		    unsigned long flags, struct kexec_fdset *extra_fds);
> 
> 
> Is there a way for the kernel to distinguish whether the process passed 5 or 
> 6 arguments? How can it know whether extra_fds is a valid argument or just 
> garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
> the process can signal that it is using the new interface.

Good point. What I had in my mind is "open" system call.
Glibc's implementation of open() checks for the second argument, flags,
to determine whether or not the third argument, mode, is required.

So our current consensus is that, for the time being, we will extend
the existing system call interface to allow extra file descriptors,
and *if* we really need a different type of parameters in the future,
we will add another system call.

If we all agree, I can post a kernel patch for this change as a RFC.
(I've already verified it with my prototype of kexec_file_load support
on arm64.)

Thanks,
-Takahiro AKASHI

> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
