Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Lw0uS-0007ZZ-8g
	for kexec@lists.infradead.org; Mon, 20 Apr 2009 21:20:33 +0000
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
	<m14ozb1eom.fsf@fess.ebiederm.org>
	<4C94DE2070B172459E4F1EE14BD2364E02D878D9@HQ-EXCH-5.corp.brocade.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Apr 2009 14:19:58 -0700
In-Reply-To: <4C94DE2070B172459E4F1EE14BD2364E02D878D9@HQ-EXCH-5.corp.brocade.com>
	(Ming Lei's message of "Thu\, 16 Apr 2009 11\:48\:33 -0700")
Message-ID: <m1ljpvja4h.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: should kernel image destination address be picked up by kernel
	itself?
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Ming Lei <mlei@Brocade.COM>
Cc: kexec@lists.infradead.org

"Ming Lei" <mlei@Brocade.COM> writes:

> Eric,
>
>>>"Ming Lei" <mlei@Brocade.COM> writes:
>>> As I understand the code, current destination address is picked up by
>>> either the user(elf image) or kexec-tools. It is not automatic, can
> we
>>> let linux kernel choose the address instead? It is automatic and no
> way
>>> to wipe out something important.
>
>>I don't follow.  The basic model of kexec is:
>>2)- All of the policy decisions are made in user space (such as where
> to
>>  execute from)
>
>>3)- standalone executables are loaded into an address space where
>>  physical address and virtual address are the same.
>
>>4)- Sophisticated page swapping happens in the kernel where
>>  sys_kexec_load was called so that any valid address on the machine
>>  is available to the standalone executable.
>
>>What problem do you see in that model?
>>Why is it a problem for you?
>
>>Eric
>
> I generally agree on 2). However, to choose where to copy the kimage
> segments, should the kernel be the one to make this decision so to avoid
> export memory map to user space, since the kernel knows where are all
> the free memory. This doesn't complicate the kernel code and meanwhile
> simplify the user space code and reduce the requirement for different
> platforms(so other platforms doesn't need to export kernel memory map).

Nothing needs to export the kernel memory map.  What is exported is
the kernels knowledge of where physical memory is.  Where the running
kernel is irrelevant.

I am fairly certain openfirmware provides that interface today.
And even outside of the context of kexec we need that information to
pass to the newly loaded kernel so it knows what memory it can use.

> I think 3) and 4) is more the requirements from x86. On ppc32 I don't
> see the need for it. So 3) and 4) should be in platform specifics.

3 is the design and if ppc32 doesn't do that it is broken.

4 also is a general requirement.  It is rare an architecture will have
a 1M+ range of physically contiguous pages.

Dealing with physical addresses in early boot and not having to get
sophisticated and play page table games is very desirable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
