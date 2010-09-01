Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oqn5m-0007zy-8R
	for kexec@lists.infradead.org; Wed, 01 Sep 2010 13:11:06 +0000
Date: Wed, 1 Sep 2010 22:11:01 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Add CFLAGS to compile mips purgatory
Message-ID: <20100901131101.GC4998@verge.net.au>
References: <20100901121932.16599.8572.stgit@muvarov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100901121932.16599.8572.stgit@muvarov>
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

On Wed, Sep 01, 2010 at 04:19:32PM +0400, Maxim Uvarov wrote:
> Required in case if "-mabi=64" option was specified to build 64 bit mips
> application, if not compiler tries to link 64 bit binaries with 32 bit
> system libraries.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
