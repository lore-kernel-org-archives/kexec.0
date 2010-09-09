Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtcJZ-0001L8-7E
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 08:17:01 +0000
Date: Thu, 9 Sep 2010 17:16:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] Revert "powerpc new toolchains fix (crt.S)"
Message-ID: <20100909081656.GL19303@verge.net.au>
References: <20100907151025.5784.98190.stgit@muvarov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100907151025.5784.98190.stgit@muvarov>
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

On Tue, Sep 07, 2010 at 07:10:25PM +0400, Maxim Uvarov wrote:
> This reverts commit 45e8f29639d9f97b74389e5bd28c7a5cccbf3e2a.
> purgatory/arch/ppc/crt.S and purgatory/arch/ppc/misc.S are the same
> files.

Thanks, applied both patches.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
