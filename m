Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kpwtw-0000s7-NT
	for kexec@lists.infradead.org; Wed, 15 Oct 2008 03:18:21 +0000
Date: Wed, 15 Oct 2008 14:18:18 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
Message-ID: <20081015031818.GC27243@verge.net.au>
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org

On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:
> Hello all,
>
> As you all know it is not easy to count exact value of memory ranges from
> device tree on powerpc.
> It very depends on how dts file was written. What do you think about really
> dynamic allocation buffers
> for this buffers?

Conceptually I have no objections to the change,
though I would like to get some review from ppc people.
(linuxppc-dev@ozlabs.org CCed)

> Patch is attached.

This patch doesn't seem to compile for me.

# powerpc64-unknown-linux-gnu-gcc --version
powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#make
[snip]
kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn't a
prototype
kexec/arch/ppc64/kexec-ppc64.c: In function 'realloc_memory_ranges':
kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of 'realloc' makes pointer from integer without a cast
kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function 'realloc'
kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable 'tmp'

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
