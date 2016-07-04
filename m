Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKChU-0005YN-9M
 for kexec@lists.infradead.org; Mon, 04 Jul 2016 22:50:48 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64MiHiJ050782
 for <kexec@lists.infradead.org>; Mon, 4 Jul 2016 18:50:26 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x6gjetug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 04 Jul 2016 18:50:26 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 4 Jul 2016 19:50:23 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC] arm64: kexec_file_load support
Date: Mon, 04 Jul 2016 19:50:19 -0300
In-Reply-To: <20160704065814.GO20774@linaro.org>
References: <20160701051111.GL20774@linaro.org> <3300473.zhbeG65qgA@hactar>
 <20160704065814.GO20774@linaro.org>
MIME-Version: 1.0
Message-Id: <5766907.oiVi8ABPsz@hactar>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, catalin.marinas@arm.com, dyoung@redhat.com, vgoyal@redhat.com

Hello,

Am Montag, 04 Juli 2016, 15:58:15 schrieb AKASHI Takahiro:
> On Fri, Jul 01, 2016 at 12:46:31PM -0300, Thiago Jung Bauermann wrote:
> > I agree that it would be better if we could have a system call where a
> 
> > custom device tree could be passed. One suggestion is:
> For powerpc, you might be able to use dtbImage instead of Image
> without changing the kernel interfaces.

That works for custom kernels, but for signed kernels from a distro, I 
believe that's not an option.

> > kexec_file_load2(int fds[], int fd_types[], int nr_fds,
> > 
> > 		 unsigned long cmdline_len, const char *cmdline_ptr,
> > 		
> > 		unsigned long flags);
> 
> You don't want to simply add one more argument, i.e. dtb_fd, don't you.

I'm just trying to avoid having to add another argument later if we find out 
someone is loading another segment that we didn't know about. :-)

The older kexec_load system call allows passing an arbitrary number of 
segments (sort of, currently capped at 16) to the kernel, so my suggestions 
preserve that feature.

If people think that adding another argument for dtb_fd is enough, I won't 
mind.

> I prefer a slightly-simpler interface:
>         struct kexec_file_fd {
>                 enum kexec_file_type;
>                 int fd;
>         }
> 
>         int kexec_file_load2(struct kexec_file_fd[], int nr_fds, int
> flags);

I like this one.

> Or if you want to keep the compatibility with the existing system call,
> 
>         int kexec_file_load(int kernel_fd, int initrd_fd,
>                         unsigned long cmdline_len, const char
> *cmdline_ptr, unsigned long flags,
>                         int struct kexec_file_fd[], int nr_fds);
> 
> Here SYSCALL_DEFINE7() have to be defined, and I'm not sure that we will
> not have a problem in adding a system call with more than 6 arguments.

That's very clever. We can do what you suggest above or even just add dtb_fd 
with SYSCALL_DEFINE6. Either option would be good.

> > Where fds is an array with nr_fds file descriptors and fd_types is an
> > array specifying what each fd in fds is. So for example, if fds[i] is
> > the kernel, then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD.
> > If fds[i] is the device tree blob, fd_types[i], would have the value
> > KEXEC_FILE_DTB and so on. That way, the syscall can be extended for an
> > arbitrary number and types of segments that have to be loaded, just
> > like kexec_load.
> > 
> > Another option is to have a struct:
> > 
> > kexec_file_load2(struct kexec_file_params *params, unsigned long
> > params_sz);
> Wow, we can add any number of new parameters with this interface.

Yeah, maybe it's a bit too much.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
