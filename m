Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from www.linutronix.de ([62.245.132.108] helo=linutronix.de)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7rz3-0000db-PB
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 16:23:02 +0000
Date: Thu, 7 Apr 2011 18:22:58 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question regarding the kexec support for FSL Book E
Message-ID: <20110407162258.GA15298@linutronix.de>
References: <4D9D5F17.2040208@in.ibm.com> <4D9D7465.8030102@linutronix.de>
	<4D9D9B1E.70001@in.ibm.com>
	<BANLkTimw4e=mF-8K+zwtXed9BcA1c8=7-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTimw4e=mF-8K+zwtXed9BcA1c8=7-g@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Suzuki Poulose <suzuki@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

* McClintock Matthew-B29882 | 2011-04-07 15:19:12 [+0000]:

>On Thu, Apr 7, 2011 at 6:08 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
>> How is this case taken care of ? Is it via the temporary mapping ? What =
is
>> the virtual
>> =A0address used by temporary mapping for the "relocate_new_kernel()" ?

It is the same as the physical :) It is hard to tell where exactly the
kernel image will be. It is somewhere between 0 and
KEXEC_CONTROL_MEMORY_LIMIT. It is allocated in
kimage_alloc_normal_control_pages(). It should not matter where it is.

>When you load the new kexec image with kexec -l, I believe we make
>sure we are in the first 2gb of memory. Then when you kexec, all the
>TLB's are torn down and we setup a 1:1 virtual:physical mapping for
>the first 2GB of memory. Then some assembly copies kernel from the
>stored location to the destination and we boot the new kernel.

arch/powerpc/include/asm/kexec.h:
|#ifdef CONFIG_FSL_BOOKE
|
|/*
| * On FSL-BookE we setup a 1:1 mapping which covers the first 2GiB of memo=
ry
| * and therefore we can only deal with memory within this range
| */
|#define KEXEC_SOURCE_MEMORY_LIMIT      (2 * 1024 * 1024 * 1024UL - 1)
|#define KEXEC_DESTINATION_MEMORY_LIMIT (2 * 1024 * 1024 * 1024UL - 1)
|#define KEXEC_CONTROL_MEMORY_LIMIT     (2 * 1024 * 1024 * 1024UL - 1)
|
|#else

So the kernel never gives memory above 2GiB to userland.

>
>-M

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
