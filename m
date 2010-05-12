Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.186])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OC5sD-0001fW-RQ
	for kexec@lists.infradead.org; Wed, 12 May 2010 06:56:54 +0000
Date: Tue, 11 May 2010 23:56:51 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1005112351200.3067@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA2375.7040802@nerdbynature.de>
	<AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
MIME-Version: 1.0
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On Wed, 12 May 2010 at 10:31, Maxim Uvarov wrote:
> Yes, that is expected result for old tool chains. New tool chains (from code
> sourcery )  need this crt.S.
> I think we can have --with-oldtoolchain option to configure to point to old
> tool chains. (or even rename it to --with-crts,
> I don't know what is better.)

Yes, I've seen this --with-oldtoolchain flag in ./configure, but: when 
exactly is my toolchain old enough so that this flag has to be used? Is my 
binutils 2.18 too old?

So, I'm all in favour of --with-crts (which I would use when compilation breaks
with some descriptive error message) or, even better: can't we set this 
flag during ./configure automatically, based on the actual toolchain installed
on the system? ./configure should be able to determine this, no?

> This -Werror came from mips. kexec/arch/mips/Makefile. It is already removed
> in the git. We already saw this problem.

Powerpc including a mops Makefile, whooha :-)

Thanks,
Christian.
-- 
BOFH excuse #91:

Mouse chewed through power cable

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
