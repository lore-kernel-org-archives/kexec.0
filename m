Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHvWP-0003Oe-01
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 11:15:34 +0000
Message-ID: <4F8567CB.9000005@redhat.com>
Date: Wed, 11 Apr 2012 14:15:23 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F85472A.4080009@redhat.com>
 <4F855903.3070703@cn.fujitsu.com>
In-Reply-To: <4F855903.3070703@cn.fujitsu.com>
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
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

On 04/11/2012 01:12 PM, zhangyanfei wrote:
> > 
> >> TODO:
> >>   1. In kexec-tools, get VMCSINFO via sysfs and dump it as note information
> >>      into vmcore.
> >>   2. Dump VMCS region of each guest vcpu and VMCSINFO into qemu-process
> >>      core file. To do this, we will modify kernel core dumper, gdb gcore
> >>      and crash gcore.
> > 
> > 
> > Seems excessive.  Why do you want vmcs information in qemu cores?  A
> > qemu crash is very rarely related to kvm, let alone the vmcs.  I
> > understand that you may want it in a kernel core dump, though I've never
> > needed to myself.  Can you outline a case where this data was needed?
> > 
>
> If a qemu process comes to a fatal error that causes itself to be core dumped
> by kernel, the running guest based on the qemu process will be included in that
> qemu core file. But with no vmcsinfo information in qemu core file, we could not
> get the guest's states(registers' values), then we could not make a complete
> guest vmcore.

We can't anyway.  Many registers (GPRs except RSP, fpu) are not stored
in the VMCS, but in kvm data structures.

So for this case we'd want a kvm callback to execute (that would make it
work cross vendor, too).

>
> >>   3. Dump guest image from the qemu-process core file into a vmcore.
> > 
> > For this perhaps a different approach is better - modify the core dumper
> > to call kvm to extract the relevant vmcs information into an elf note. 
> > This way there is no need to reconstruct the guest data from the
> > offsets.  It's also more reliable, since vmread can access cached fields
> > that direct memory access cannot.
> > 
>
> Does this approach is a replacement for TODO 2 ? That is to say, when generating
> a qemu core by kernel core dumper, we could call kvm to extract the relevant vmcs
> information into an elf note instead of VMCSINFO and the whole vmcs regions.

Yes.  I'm not convinced it's important though.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
