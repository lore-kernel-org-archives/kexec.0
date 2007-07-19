Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBZ8P-0006In-DY
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 12:45:51 -0400
Date: Thu, 19 Jul 2007 12:39:15 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070719163915.GN9623@redhat.com>
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
Cc: Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com

On Wed, Jul 18, 2007 at 11:07:40PM +0900, Ken'ichi Ohmichi wrote:
> The content of mkdfinfo file has been increasing whenever adding
> features and correcting bugs. The content is increasing even now.
> And, the feature addition is done not only for new kernels but also
> for old upstream kernels. When the content of mkdfinfo file is taken 
> into the kernel and fixed, the feature addition in the future is
> remarkably limited. So makedumpfile needs mkdfinfo file outside of
> the kernel.
> 
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

I am not a big fan of this approach as it forces distros to require
kexec-tools when building a kernel.  Even Joe Hacker who wants a custom
kernel (and not interested in kexec) would have to not only download the
kernel.src.rpm but kexec-tools just to build a kernel that probably
doesn't have kexec enabled.

I had to deal with a similar experience when providing a build dependency
on the unifdef package when create the kernel-headers rpm for RHEL-5.  A
lot of people were confused and upset by this dependency.  Luckily
upstream resolved this by just putting similar code in the kernel/scripts
directory and thus removing the dependency (well not for RHEL-5).  I would
rather not have to deal with this again unless I know there is a more
permanent solution that would remove this dependency.

After talking to Dave Anderson about this more, I start to understand why
Ken'ichi prefers to implement the new features in userspace instead of the
kernel (it makes things automatically work with older kernels), but I
still am not a big fan of it.  I was hoping for a complete in kernel
solution (that way you never need the vmlinux file).  Perhaps makedumpfile
can support both vmlinux files (if provided) or interface with the kernel
(if the vmlinux is not provided?).

Just my input.  I might as well argue with Ken'ichi here than the
bugzilla. :-)

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
