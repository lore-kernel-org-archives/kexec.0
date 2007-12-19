Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4rcw-0007h1-2I
	for kexec@lists.infradead.org; Wed, 19 Dec 2007 05:38:00 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
References: <1197967675.854275.930419561848.0.gpush@pokey>
	<20071218232558.GA14092@redhat.com>
In-Reply-To: <20071218232558.GA14092@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 19 Dec 2007 14:37:34 +0900
Message-Id: <200712191437.35644.jk@ozlabs.org>
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
To: kexec@lists.infradead.org

(resend to kexec list)

Hi Vivek,

> I got a stupid question.
>
> - What's the advantage of building a 32bit binary for powerpc64 bit
>   platforms?

So you don't need to have 64-bit libc and libz present. It's often the 
case that you have an entire 32-bit userspace environment, but still 
require 64-bit libraries just for the kexec program.

>   IOW, why do you need to build 32bit purgatory?

We build the purgatory for the $target architecture, that's all. My 
setup involves:

 build: powerpc-linux-gnu
 host: powerpc-linux-uclibc
 target: powerpc64-linux-uclibc

So I'm aiming for a 64-bit purgatory here, we generally tend to boot 
64-bit kernels on powerpc64 machines.

>   Can't we launch 32bit kernel from 64bit purgatory?

I assume so, but you wouldn't be able to do this on 32-bit machines, of 
course. I haven't been trying the case where the purgatory arch != 
kernel arch.

> > This allows us to kexec a powerpc64 kernel from a powerpc
> > userspace. x86{,_64} users might find this handy too, but I don't
> > have hardware to test.
>
> I think x86 it already happens. I think I can launch 64bit kernel
> from a 32bit kexec.

OK, this change should make this possible for all arches, just by 
specifying --host and --target - are you able to make sure that you can 
build a kexec where host=i386-linux and target=x86_64-linux ?

Cheers,


Jeremy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
