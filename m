Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbUiw-0003rj-2J
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 06:23:14 +0000
Date: Fri, 5 Sep 2008 16:23:12 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] sh: Add ELF relocation support for
	R_SH_DIR32/R_SH_REL32 relocs.
Message-ID: <20080905062311.GB23955@verge.net.au>
References: <20080905021348.GB20338@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080905021348.GB20338@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org

On Fri, Sep 05, 2008 at 11:13:48AM +0900, Paul Mundt wrote:
> Simple handler for the common SHcompact ELF relocations.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
