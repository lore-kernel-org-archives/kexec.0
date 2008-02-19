Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRLdb-0008Qe-BC
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 06:07:31 +0000
Date: Tue, 19 Feb 2008 15:07:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] sh: Remove hardcoded PAGE_SIZE in NetBSD loader
Message-ID: <20080219060725.GB8917@verge.net.au>
References: <20080204043531.GB27300@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080204043531.GB27300@linux-sh.org>
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

On Mon, Feb 04, 2008 at 01:35:31PM +0900, Paul Mundt wrote:
> The Linux host supports a multitude of page sizes, so having this
> hardcoded doesn't really help matters. This also has the benefit of
> killing off dependence on asm/ headers when none is needed. While
> I'm not suggesting that anyone actually boot NetBSD, without this,
> my build also ends up breaking.

Thanks, Paul. Applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
