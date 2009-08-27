Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Mghv5-0003Bo-BA
	for kexec@lists.infradead.org; Thu, 27 Aug 2009 16:33:55 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7RGXE9I020015
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 22:03:14 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RGXhpt2461820
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 22:03:43 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7RGXguV004548
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 22:03:42 +0530
Date: Thu, 27 Aug 2009 22:03:19 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: Does kexec support SMP on powerpc? E500 V2
Message-ID: <20090827163319.GA3223@in.ibm.com>
References: <e997b7420908270854v423b51f9vc7e2d012c91360f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e997b7420908270854v423b51f9vc7e2d012c91360f@mail.gmail.com>
Reply-To: mohan@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "wilbur.chan" <wilbur512@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Aug 27, 2009 at 11:54:22PM +0800, wilbur.chan wrote:
> There was a patch of kexec on SMP mips 64 , and I attempt to implement
> kexec on SMP powerpc .
> =

> I found that ,=A0 it was a little different with=A0 mips when booting a
> kernel. We know=A0 that, every CPU jumped directly into kernel on
> =

> mips, but on powerpc , E500 SMP,=A0 the 'master' CPU was in charge of
> 'slave'=A0 CPUs , so 'slave' CPU=A0 could do nothing
> =

> but to=A0 wait for 'master'=A0 to wake him up in Init function.
> =

> =

> How to implement kexec on SMP powerpc?

Wilbur, I am not sure about ppc32 arch. Check
kexec/purgatory/arch/ppc64/v2wrap.S which makes all secondary cpus to spin
in a loop at the physical address 0x60

Regards,
M. Mohan Kumar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
