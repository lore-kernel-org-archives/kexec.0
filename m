Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCdl9-0006jr-DD
	for kexec@lists.infradead.org; Thu, 13 May 2010 19:07:52 +0000
Received: by wwa36 with SMTP id 36so1113389wwa.36
	for <kexec@lists.infradead.org>; Thu, 13 May 2010 12:07:49 -0700 (PDT)
Date: Thu, 13 May 2010 23:07:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Message-ID: <20100513190743.GA14447@oksana.dev.rtsoft.ru>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
	<15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15016EE5-7B40-40C9-9E45-58409644CE17@kernel.crashing.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Maxim Uvarov <muvarov@gmail.com>, lists@nerdbynature.de, horms@verge.net.au, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On Thu, May 13, 2010 at 07:27:59PM +0200, Segher Boessenkool wrote:
> >Linker does not provide some vital functions when building
> >freestanding
> >applications with a new toolchain,
> 
> That's because the compiler provides those functions, not the linker.
> 
> >so we have to provide our own CRT.
> 
> ...in libgcc.  Why don't you link against that?

For the same reason we don't link kernel against libgcc?
I.e. just a matter of taste. There are two camps: those who
argue against libgcc, and those who argue for libgcc.

Hey! You were in this thread! :-)

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg17224.html

Purgatory is just a small (tiny) piece of code that runs
between kernels. Whether use libgcc or not, personally, I have
no strong opinion. Kexec didn't use it, so we kept it the same
way.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
