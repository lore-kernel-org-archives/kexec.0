Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from brm-mailgate-1.brocade.com ([144.49.197.2])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LuWdb-0002Lh-Bl
	for kexec@lists.infradead.org; Thu, 16 Apr 2009 18:48:46 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: should kernel image destination address be picked up by kernel
	itself?
Date: Thu, 16 Apr 2009 11:48:33 -0700
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E02D878D9@HQ-EXCH-5.corp.brocade.com>
In-Reply-To: <m14ozb1eom.fsf@fess.ebiederm.org>
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
	<m14ozb1eom.fsf@fess.ebiederm.org>
From: "Ming Lei" <mlei@Brocade.COM>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Eric,

>>"Ming Lei" <mlei@Brocade.COM> writes:
>> As I understand the code, current destination address is picked up by
>> either the user(elf image) or kexec-tools. It is not automatic, can
we
>> let linux kernel choose the address instead? It is automatic and no
way
>> to wipe out something important.

>I don't follow.  The basic model of kexec is:
>2)- All of the policy decisions are made in user space (such as where
to
>  execute from)

>3)- standalone executables are loaded into an address space where
>  physical address and virtual address are the same.

>4)- Sophisticated page swapping happens in the kernel where
>  sys_kexec_load was called so that any valid address on the machine
>  is available to the standalone executable.

>What problem do you see in that model?
>Why is it a problem for you?

>Eric

I generally agree on 2). However, to choose where to copy the kimage
segments, should the kernel be the one to make this decision so to avoid
export memory map to user space, since the kernel knows where are all
the free memory. This doesn't complicate the kernel code and meanwhile
simplify the user space code and reduce the requirement for different
platforms(so other platforms doesn't need to export kernel memory map).

I think 3) and 4) is more the requirements from x86. On ppc32 I don't
see the need for it. So 3) and 4) should be in platform specifics.

Ming 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
