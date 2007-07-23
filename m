Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ICq39-0001yk-DL
	for kexec@lists.infradead.org; Mon, 23 Jul 2007 01:01:41 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6N3vMBU017889
	for <kexec@lists.infradead.org>; Sun, 22 Jul 2007 23:57:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6N51UvV529326
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 01:01:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6N51UaF021908
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 01:01:30 -0400
Date: Mon, 23 Jul 2007 10:31:47 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070723050147.GA5691@in.ibm.com>
References: <20070716123633.GA10920@in.ibm.com>
	<20070718230740oomichi@mail.jp.nec.com>
	<20070719163915.GN9623@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070719163915.GN9623@redhat.com>
Reply-To: vgoyal@in.ibm.com
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
To: Don Zickus <dzickus@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Jul 19, 2007 at 12:39:15PM -0400, Don Zickus wrote:
[..]
> 
> I am not a big fan of this approach as it forces distros to require
> kexec-tools when building a kernel.  Even Joe Hacker who wants a custom
> kernel (and not interested in kexec) would have to not only download the
> kernel.src.rpm but kexec-tools just to build a kernel that probably
> doesn't have kexec enabled.
> 
> I had to deal with a similar experience when providing a build dependency
> on the unifdef package when create the kernel-headers rpm for RHEL-5.  A
> lot of people were confused and upset by this dependency.  Luckily
> upstream resolved this by just putting similar code in the kernel/scripts
> directory and thus removing the dependency (well not for RHEL-5).  I would
> rather not have to deal with this again unless I know there is a more
> permanent solution that would remove this dependency.
> 

That's a good point Don. kernel rpm being dependent on kexec-tools rpm is
not a good idea.

> After talking to Dave Anderson about this more, I start to understand why
> Ken'ichi prefers to implement the new features in userspace instead of the
> kernel (it makes things automatically work with older kernels), but I
> still am not a big fan of it.  I was hoping for a complete in kernel
> solution (that way you never need the vmlinux file).  Perhaps makedumpfile
> can support both vmlinux files (if provided) or interface with the kernel
> (if the vmlinux is not provided?).
> 

I am also in favour of a complete kernel based solution. Export required
info from kernel and let kexec-tools parse that info, pass it to second
kernel and it will be appended to vmcore.

This will put some restrictions on that we can't keep on changing the
format of the info very frequently and some new features might not work
with older kernels. But I guess, kexec-tools can provide an override option
where dump filtering info can be passed on kexec-tools command line (as
suggested by ken'chi). If user passes this info on command line then
kexec-tools will not read the info exported from kernel. This way new
features can be made to work on older kernels. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
