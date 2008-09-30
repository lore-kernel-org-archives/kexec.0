Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [85.21.88.6] (helo=buildserver.ru.mvista.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kkiyk-0001LL-VZ
	for kexec@lists.infradead.org; Tue, 30 Sep 2008 17:25:43 +0000
Date: Tue, 30 Sep 2008 21:25:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] Remove legacy kdump kernel build support
Message-ID: <20080930172540.GA21378@oksana.dev.rtsoft.ru>
References: <20080930124828.GA1945@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080930124828.GA1945@in.ibm.com>
Reply-To: avorontsov@ru.mvista.com
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
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, kexec@lists.infradead.org

On Tue, Sep 30, 2008 at 06:18:28PM +0530, Mohan Kumar M wrote:
> Remove legacy kdump kernel build support
> 
> This patch removes legacy kdump kernel build support(i.e compiling  a
> kdump kernel at a fixed hardcoded address 32MB). With the relocatable
> kernel support its now possible to use the regular kernel binary for
> capturing the dump also. Relocatable kdump kernel does not require
> trampoline code for exception handlers. It removes kdump.h as most of the
> macros defined in kdump.h are not used any more. Also the relocatable
> kdump kernel allows us to load kdump kernel any where as specified by
> crashkernel parameter instead of hardcoded address 32MB.

Can we leave the legacy support for a while? On PPC32 we don't have
the relocatable kernel support, but we have kdump patches floating
around[1], and they use the `hard-coded values' approach, so far.

I'm not sure if anybody is currently working on a PPC32 kernel
relocation support.. but for sure it will take some time to implement.

Thanks,

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
