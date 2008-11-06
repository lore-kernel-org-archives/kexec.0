Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky8w4-00048X-FL
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 17:46:26 +0000
Date: Thu, 6 Nov 2008 15:45:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 08/16] x86: Emergency virtualization disable function
Message-ID: <20081106174538.GU5247@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-9-git-send-email-ehabkost@redhat.com>
	<m1bpwu3wod.fsf@frodo.ebiederm.org>
	<20081105175235.GJ5247@blackpad> <4912BD67.8000704@redhat.com>
	<m1mygd2lxs.fsf@frodo.ebiederm.org> <4912C75B.8050508@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4912C75B.8050508@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Thu, Nov 06, 2008 at 12:30:51PM +0200, Avi Kivity wrote:
> Eric W. Biederman wrote:
>>
>>> If you want to be extra simple and safe, remove kvm from the equation.  Make the
>>> disabling code part of kdump/emergency_restart and only rely on the convention
>>> that cr3.vmxe == vmxon.
>>>     
>> Convention?
>>   
>
> There is a de-facto convention supported by at least vmware and kvm.  If  
> cr4.vmxe is 1, then we are in vmx operation.  If cr4.vmxe is 0, then we  
> are not in vmx operation.  This allows us to determine whether we need  
> to execute vmxoff without any APIs.

I am just worried about the probing needed to make sure CR4 is available
(and that the CR4.VMXE bit means what we expect it to mean), before we
try to read it and check VMXE. The same for SVM and the MSRs we need to
touch to disable SVM.

I prefer to reuse code that already exists on KVM and is working than
adding new probing code that I won't be able to test on all hardware
configurations.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
