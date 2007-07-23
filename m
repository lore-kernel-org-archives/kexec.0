Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ICwNi-0006id-VV
	for kexec@lists.infradead.org; Mon, 23 Jul 2007 07:47:22 -0400
Subject: Re: Determine version of kernel that produced vmcore
In-reply-to: <20070723050147.GA5691@in.ibm.com>
Message-Id: <20070723204723oomichi@mail.jp.nec.com>
References: <20070723050147.GA5691@in.ibm.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 23 Jul 2007 20:47:23 +0900
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
To: vgoyal@in.ibm.com
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

2007/07/23 10:31:47 +0530, Vivek Goyal <vgoyal@in.ibm.com> wrote:
>On Thu, Jul 19, 2007 at 12:39:15PM -0400, Don Zickus wrote:
>[..]
>> 
>> I am not a big fan of this approach as it forces distros to require
>> kexec-tools when building a kernel.  Even Joe Hacker who wants a custom
>> kernel (and not interested in kexec) would have to not only download the
>> kernel.src.rpm but kexec-tools just to build a kernel that probably
>> doesn't have kexec enabled.
>> 
>> I had to deal with a similar experience when providing a build dependency
>> on the unifdef package when create the kernel-headers rpm for RHEL-5.  A
>> lot of people were confused and upset by this dependency.  Luckily
>> upstream resolved this by just putting similar code in the kernel/scripts
>> directory and thus removing the dependency (well not for RHEL-5).  I would
>> rather not have to deal with this again unless I know there is a more
>> permanent solution that would remove this dependency.
>> 
>
>That's a good point Don. kernel rpm being dependent on kexec-tools rpm is
>not a good idea.

That's right. The kernel package should not be dependent on kexec-tools
package (including makedumpfile). I understand Dan Aloni's proposal
(including the dump filtering information in kernel) makes many
advantages. Ok, I agree with his proposal.

BTW, we should test makedumpfile by each linux(-rc1 ?) releases.
Now, I test the makedumpfile functions by comparing the crash utility's
output of /proc/vmcore and the one of the filtered dumpfile.
Often, the crash utility cannot read /proc/vmcore of the latest kernel.
Does anybody know the crash's option that the crash can run loosely for
the early test ?


>> After talking to Dave Anderson about this more, I start to understand why
>> Ken'ichi prefers to implement the new features in userspace instead of the
>> kernel (it makes things automatically work with older kernels), but I
>> still am not a big fan of it.  I was hoping for a complete in kernel
>> solution (that way you never need the vmlinux file).  Perhaps makedumpfile
>> can support both vmlinux files (if provided) or interface with the kernel
>> (if the vmlinux is not provided?).
>> 
>
>I am also in favour of a complete kernel based solution. Export required
>info from kernel and let kexec-tools parse that info, pass it to second
>kernel and it will be appended to vmcore.
>
>This will put some restrictions on that we can't keep on changing the
>format of the info very frequently and some new features might not work
>with older kernels. But I guess, kexec-tools can provide an override option
>where dump filtering info can be passed on kexec-tools command line (as
>suggested by ken'chi). If user passes this info on command line then
>kexec-tools will not read the info exported from kernel. This way new
>features can be made to work on older kernels. 

That sounds good.


Dan Aloni, I'd like to cooperate with you for implementing this feature.
If you have some patches other than 2007/07/10 patches, could you send
me them ?  I will update them.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
