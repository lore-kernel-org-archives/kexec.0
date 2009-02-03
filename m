Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LURJo-0003kH-3p
	for kexec@lists.infradead.org; Tue, 03 Feb 2009 19:52:27 +0000
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 03 Feb 2009 11:52:09 -0800
In-Reply-To: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
	(Ming Lei's message of "Tue\, 27 Jan 2009 14\:22\:18 -0800")
Message-ID: <m14ozb1eom.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: should kernel image destination address be picked up by kernel
	itself?
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
To: Ming Lei <mlei@Brocade.COM>
Cc: kexec@lists.infradead.org

"Ming Lei" <mlei@Brocade.COM> writes:

> As I understand the code, current destination address is picked up by
> either the user(elf image) or kexec-tools. It is not automatic, can we
> let linux kernel choose the address instead? It is automatic and no way
> to wipe out something important.

I don't follow.  The basic model of kexec is:

- kexec is fed a standalone executables (things that run without OS
  support)

- All of the policy decisions are made in user space (such as where to
  execute from)

- standalone executables are loaded into an address space where
  physical address and virtual address are the same.

- Sophisticated page swapping happens in the kernel where
  sys_kexec_load was called so that any valid address on the machine
  is available to the standalone executable.

What problem do you see in that model?
Why is it a problem for you?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
