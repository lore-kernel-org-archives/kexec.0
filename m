Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SK85M-00055X-Vt
 for kexec@lists.infradead.org; Tue, 17 Apr 2012 13:04:46 +0000
Message-ID: <4F8D6A61.9030209@redhat.com>
Date: Tue, 17 Apr 2012 16:04:33 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F8D1F46.3090901@redhat.com>
 <4F8D4B4C.8070705@cn.fujitsu.com> <4F8D4D1C.4010400@redhat.com>
 <4F8D530C.3050908@cn.fujitsu.com>
In-Reply-To: <4F8D530C.3050908@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei <zhangyanfei@cn.fujitsu.com>, ebiederm@xmission.com, ludwig.nussel@suse.de

On 04/17/2012 02:25 PM, Wen Congyang wrote:
> > 
> >>
> >> For scenario 2, we also want the guest's registers values to be dumped into
> >> qemu process's core file when qemu process crashes. This is the task of TODO-list 2.
> > 
> > Why?  If qemu crashed it is because of an internal qemu fault.  If any
> > guest registers were involved, they would have been decoded by qemu
> > previously and would be present in the stack trace (for example mmio
> > address/data).
>
> Hmm, IIRC, if qemu meets some critical error, it will call abort() or assert().
> The guest registers are stored in the kernel, and qemu does not call
> cpu_synchronize_state() to get guest register. So I donot understand
> why the registers woubld be present int the stack trace...

There are two cases.  One case is where the problem was not caused
directly by guest action, for example a segmentation fault in the block
layer or the VNC server.  In this case the guest registers are immaterial.

The other case is where the problem was directly caused by guest action,
for example an mmio write to a device register triggered an error. In
this case kvm emulates the mmio instruction and returns KVM_EXIT_MMIO;
it can be seen in the kvm_run page.  The address/data pair is propagated
by the qemu memory core all the way to the device callback.  So the
instruction and register contents are unneeded for debugging the crash.

Is there a scenario where the guest registers help towards debugging a
qemu crash?

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
