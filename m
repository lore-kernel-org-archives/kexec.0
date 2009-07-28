Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MVaTX-0008CZ-Mb
	for kexec@lists.infradead.org; Tue, 28 Jul 2009 00:23:31 +0000
Date: Tue, 28 Jul 2009 10:23:25 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Handle datarootdir for newer autoconf versions.
Message-ID: <20090728002324.GB20230@verge.net.au>
References: <20090727223758.GA22668@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090727223758.GA22668@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org

On Tue, Jul 28, 2009 at 07:37:58AM +0900, Paul Mundt wrote:
> This fixes up the:
> 
> config.status: WARNING:  'Makefile.in' seems to ignore the --datarootdir setting
> 
> warning when producing the output Makefile.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
