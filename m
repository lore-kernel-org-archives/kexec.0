Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IxAb5-0005eC-Bq
	for kexec@lists.infradead.org; Wed, 28 Nov 2007 00:16:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<200711271445.56792.ak@suse.de>
	<20071127142826.GB31376@hmsreliant.think-freely.org>
	<200711271543.11809.ak@suse.de>
	<20071127144856.GC31376@hmsreliant.think-freely.org>
	<m14pf7k8ns.fsf@ebiederm.dsl.xmission.com>
	<474C832C.1060903@redhat.com>
	<20071127210558.GI14887@hmsendeavour.rdu.redhat.com>
	<m1r6ibia9v.fsf@ebiederm.dsl.xmission.com> <474CA520.60804@redhat.com>
Date: Tue, 27 Nov 2007 17:15:06 -0700
In-Reply-To: <474CA520.60804@redhat.com> (Ben Woodard's message of "Tue, 27
	Nov 2007 15:15:44 -0800")
Message-ID: <m1d4tvi5th.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Ben Woodard <woodard@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

Ben Woodard <woodard@redhat.com> writes:

> Eric W. Biederman wrote:
>> Neil Horman <nhorman@redhat.com> writes:
>>
>>>> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
>>
>> Ben, what chipset is this?
>
> nVidia MCP55 pro
>
> It is the original version of
> http://www.supermicro.com/Aplus/motherboard/Opteron8000/MCP55/H8QM8-2.cfm
>
> i.e. not the -2. However, they don't seem to advertise the original
> version. Supermicro assures me that they are practically the same but I haven't
> played with the -2 version yet.
>

That is enough for an initial approximation.  Unless something has
changed radically the Nvidia chipsets can put the ioapic instead of
the local apic in virtual wire mode so that is worth testing.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
