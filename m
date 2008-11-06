Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky29S-0000Bi-Mr
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 10:31:47 +0000
Message-ID: <4912C75B.8050508@redhat.com>
Date: Thu, 06 Nov 2008 12:30:51 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 08/16] x86: Emergency virtualization disable function
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>	<1225810364-8990-9-git-send-email-ehabkost@redhat.com>	<m1bpwu3wod.fsf@frodo.ebiederm.org>
	<20081105175235.GJ5247@blackpad>	<4912BD67.8000704@redhat.com>
	<m1mygd2lxs.fsf@frodo.ebiederm.org>
In-Reply-To: <m1mygd2lxs.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Eric W. Biederman wrote:
>
>> If you want to be extra simple and safe, remove kvm from the equation.  Make the
>> disabling code part of kdump/emergency_restart and only rely on the convention
>> that cr3.vmxe == vmxon.
>>     
> Convention?
>   

There is a de-facto convention supported by at least vmware and kvm.  If 
cr4.vmxe is 1, then we are in vmx operation.  If cr4.vmxe is 0, then we 
are not in vmx operation.  This allows us to determine whether we need 
to execute vmxoff without any APIs.


-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
