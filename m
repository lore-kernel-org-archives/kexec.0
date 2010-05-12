Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OC6Mo-0002pJ-3C
	for kexec@lists.infradead.org; Wed, 12 May 2010 07:28:31 +0000
Message-ID: <4BEA589A.1080009@ozlabs.org>
Date: Wed, 12 May 2010 17:28:26 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
References: <20100511174749.19309.44615.stgit@muvarov>	<4BEA2375.7040802@nerdbynature.de>
	<AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
In-Reply-To: <AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
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
Cc: kexec@lists.infradead.org

Maxim Uvarov wrote:
>
> This -Werror came from mips. kexec/arch/mips/Makefile. It is already
> removed in the git. We already saw this problem.

BTW, I just did a clone of the kexec git tree repository and the -Werror is 
still in kexec/arch/mips/Makefile.  Simon's patch of May 4th 
("[PATCH] build: Don't modify CFLAGS in kexec/arch/mips/Makefile") doesn't
seem to be in there [yet].

Cheers,

Matt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
