Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LjrNx-0000Sz-LC
	for kexec@lists.infradead.org; Wed, 18 Mar 2009 08:44:31 +0000
Date: Wed, 18 Mar 2009 19:44:24 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec jump: SuperH vmlinux support
Message-ID: <20090318084422.GF21399@verge.net.au>
References: <20090318060746.667.44875.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090318060746.667.44875.sendpatchset@rx1.opensource.se>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Mar 18, 2009 at 03:07:46PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Create elf header and modify the kernel command line
> when loading a crash kernel or a kexec jump kernel.

Thanks, applied this one too.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
