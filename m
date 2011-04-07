Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]
	helo=AM1EHSOBE005.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7qzV-0008Vh-CZ
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 15:19:26 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: Question regarding the kexec support for FSL Book E
Date: Thu, 7 Apr 2011 15:19:12 +0000
Message-ID: <BANLkTimw4e=mF-8K+zwtXed9BcA1c8=7-g@mail.gmail.com>
References: <4D9D5F17.2040208@in.ibm.com> <4D9D7465.8030102@linutronix.de>
	<4D9D9B1E.70001@in.ibm.com>
In-Reply-To: <4D9D9B1E.70001@in.ibm.com>
Content-Language: en-US
Content-ID: <FBEACFE2F1CEA046820AF32EB0A1E611@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

On Thu, Apr 7, 2011 at 6:08 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
> So the 0-2GiB 1:1 mapping, could create a 1:1 entry for the
> relocate_new_kernel()'s physical address(which is again somewhere in
> 0..2GiB) too.
> But the virtual address for relocate_new_kernel() could be different (not
> necessarily 1:1, as mapped by the primary kernel). So we will have one
> mapping setup
> by the primary kernel and the other by the 1:1 mapping.
> This is the case of "multiple mappings", I was referring to above.
>
> How is this case taken care of ? Is it via the temporary mapping ? What is
> the virtual
> =A0address used by temporary mapping for the "relocate_new_kernel()" ?

When you load the new kexec image with kexec -l, I believe we make
sure we are in the first 2gb of memory. Then when you kexec, all the
TLB's are torn down and we setup a 1:1 virtual:physical mapping for
the first 2GB of memory. Then some assembly copies kernel from the
stored location to the destination and we boot the new kernel.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
