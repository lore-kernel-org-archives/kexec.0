Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCcE3-0008Nq-IY
	for kexec@lists.infradead.org; Thu, 13 May 2010 17:29:36 +0000
In-Reply-To: <20100512070849.9572.84728.stgit@muvarov>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
Mime-Version: 1.0 (Apple Message framework v753.1)
Message-Id: <15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Date: Thu, 13 May 2010 19:27:59 +0200
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: lists@nerdbynature.de, kexec@lists.infradead.org, horms@verge.net.au, linuxppc-dev@lists.ozlabs.org

> Linker does not provide some vital functions when building  
> freestanding
> applications with a new toolchain,

That's because the compiler provides those functions, not the linker.

> so we have to provide our own CRT.

...in libgcc.  Why don't you link against that?

> p.s.
> Without the CRT we won't see any build errors (since the purgatory is
> linked with --no-undefined), but the purgatory code won't work,

It would be nice if the build would check if anything unexpectedly
undefined is left.


Segher


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
