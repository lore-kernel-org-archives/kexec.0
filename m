Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxo44.mail.genotec.ch ([2001:1b50::82:195:224:44])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NE1Z8-0007e3-1O
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 14:12:55 +0000
Date: Fri, 27 Nov 2009 15:03:16 +0100
From: Marc Andre Tanner <mat@brain-dump.org>
Subject: Re: [PATCH] kexec-arm: add uImage support
Message-ID: <20091127140316.GA8722@debbook.brain-dump.org>
References: <1258747662-14093-1-git-send-email-mat@brain-dump.org>
	<20091121034120.GF13498@verge.net.au>
	<20091124213237.GH3435@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091124213237.GH3435@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Wed, Nov 25, 2009 at 08:32:37AM +1100, Simon Horman wrote:
> On Sat, Nov 21, 2009 at 02:41:20PM +1100, Simon Horman wrote:
> > On Fri, Nov 20, 2009 at 09:07:42PM +0100, Marc Andre Tanner wrote:
> > > uImages are basically just zImages with a special header,
> > > we therefore just skip the header and let the normal zImage
> > > infrastructure do the actual work.
> > 
> > This looks entirely reasonable to me.
> > Unless someone jumps in and comments
> > in the next few days I'll apply it.
> 
> I've gone ahead an applied this change.

Thanks,
Marc

-- 
 Marc Andre Tanner >< http://www.brain-dump.org/ >< GPG key: CF7D56C0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
