Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgCbp-00019l-JX
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 05:31:05 +0000
Date: Mon, 31 Mar 2008 14:31:01 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-ID: <20080331053059.GD13693@verge.net.au>
References: <20080331131818.DDD1.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080331131818.DDD1.ODA@valinux.co.jp>
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
To: Itsuro ODA <oda@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Mon, Mar 31, 2008 at 01:26:04PM +0900, Itsuro ODA wrote:
> This patch is for kexec-tools-testing-20080324.

This looks fine to me. Are you expecting any compatibility issues
to crop up? If not, I'm happy to go ahead an merge this code.

full disclosure: Oda-san and I both work at VA Linux Japan, so if
someone else wants to review the code please feel free.

-- 
Horms

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
