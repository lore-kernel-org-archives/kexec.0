Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.17.9])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCj1F-0003jw-68
	for kexec@lists.infradead.org; Fri, 14 May 2010 00:44:50 +0000
Date: Thu, 13 May 2010 17:43:43 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1005131739060.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
	<alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
	<AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
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
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org, horms@verge.net.au, cbouatmailru@gmail.com

On Thu, 13 May 2010 at 15:50, Maxim Uvarov wrote:
> zImage should not work with kexec. Only vmlinux.

"should"?

PPC64 has something nice there:

  > kexec/arch/ppc64/kexec-zImage-ppc64.c:
  > fprintf(stderr, "zImage support is still broken\n");

....but I could not figure out where this is called from.

Anyway, tried vmlinux now and it's working, yay!

Thanks a lot, Maxim!

Christian.
-- 
BOFH excuse #363:

Out of cards on drive D:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
