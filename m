Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky1Q6-0006qd-Vm
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 09:44:55 +0000
Message-ID: <4912BC86.8050607@redhat.com>
Date: Thu, 06 Nov 2008 11:44:38 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 15/16] kvm: x86: set kdump virt_disable function on
	initialization
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>	<1225810364-8990-16-git-send-email-ehabkost@redhat.com>
	<m1od0u3wyq.fsf@frodo.ebiederm.org>
In-Reply-To: <m1od0u3wyq.fsf@frodo.ebiederm.org>
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
>>  
>> +	r = set_virt_disable_func(crash_hardware_disable);
>>     
>
> Can we make this say:
> set_virt_disable_func(kvm_x86_ops->crash_hardware_disable);
>
> So we can avoid going through 2 levels of function pointers?
> I find that a little scary in code that might be running
> at the edge of stack overflow.
>   

Actually, with scheduling disabled we can overflow the stack as much as 
we like.  It will reduce the quality of the dump, but everything ought 
to work.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
