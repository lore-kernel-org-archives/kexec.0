Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgxWx-0002Nw-NA
	for kexec@lists.infradead.org; Wed, 02 Apr 2008 07:37:12 +0000
Date: Wed, 2 Apr 2008 16:37:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-ID: <20080402073704.GB8272@verge.net.au>
References: <20080331131818.DDD1.ODA@valinux.co.jp>
	<20080331053059.GD13693@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080331053059.GD13693@verge.net.au>
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

On Mon, Mar 31, 2008 at 02:31:01PM +0900, Simon Horman wrote:
> On Mon, Mar 31, 2008 at 01:26:04PM +0900, Itsuro ODA wrote:
> > This patch is for kexec-tools-testing-20080324.
> 
> This looks fine to me. Are you expecting any compatibility issues
> to crop up? If not, I'm happy to go ahead an merge this code.
> 
> full disclosure: Oda-san and I both work at VA Linux Japan, so if
> someone else wants to review the code please feel free.

As there wasn't any further discussion I have gone ahead and
applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
