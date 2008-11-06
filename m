Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky23I-0007Oc-6C
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 10:25:24 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-9-git-send-email-ehabkost@redhat.com>
	<m1bpwu3wod.fsf@frodo.ebiederm.org> <20081105175235.GJ5247@blackpad>
	<4912BD67.8000704@redhat.com>
Date: Thu, 06 Nov 2008 02:22:39 -0800
In-Reply-To: <4912BD67.8000704@redhat.com> (Avi Kivity's message of "Thu, 06
	Nov 2008 11:48:23 +0200")
Message-ID: <m1mygd2lxs.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/16] x86: Emergency virtualization disable function
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
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Avi Kivity <avi@redhat.com> writes:

> Eduardo Habkost wrote:
>> We could move the set_virt_disable_func() calls to vmx.c and svm.c (on
>> hardware_setup/hardware_unsetup). One could argue that it is sort of a
>> coincidence that we need the code for both vmx and svm.
>>
>
> I don't share this fear of function calls, but perhaps that's due to lack of
> experience with kdump.

Mostly I'm just afraid of extra complexity.

> If you want to be extra simple and safe, remove kvm from the equation.  Make the
> disabling code part of kdump/emergency_restart and only rely on the convention
> that cr3.vmxe == vmxon.
Convention?

> That has the advantage of working with other virtualization systems as well.

Sounds good.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
