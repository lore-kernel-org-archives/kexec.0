Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1ND303-0003Ar-LO
	for kexec@lists.infradead.org; Tue, 24 Nov 2009 21:32:44 +0000
Date: Wed, 25 Nov 2009 08:32:37 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-arm: add uImage support
Message-ID: <20091124213237.GH3435@verge.net.au>
References: <1258747662-14093-1-git-send-email-mat@brain-dump.org>
	<20091121034120.GF13498@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091121034120.GF13498@verge.net.au>
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
To: Marc Andre Tanner <mat@brain-dump.org>
Cc: kexec@lists.infradead.org

On Sat, Nov 21, 2009 at 02:41:20PM +1100, Simon Horman wrote:
> On Fri, Nov 20, 2009 at 09:07:42PM +0100, Marc Andre Tanner wrote:
> > uImages are basically just zImages with a special header,
> > we therefore just skip the header and let the normal zImage
> > infrastructure do the actual work.
> 
> This looks entirely reasonable to me.
> Unless someone jumps in and comments
> in the next few days I'll apply it.

I've gone ahead an applied this change.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
