Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KlGVd-0003ZR-HF
	for kexec@lists.infradead.org; Thu, 02 Oct 2008 05:13:54 +0000
Date: Thu, 2 Oct 2008 15:13:50 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: kdump broken on Altix 350
Message-ID: <20081002051348.GA1027@verge.net.au>
References: <57C9024A16AD2D4C97DC78E552063EA34DB4172D@orsmsx505.amr.corp.intel.com>
	<200809292342.m8TNgq4u004680@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200809292342.m8TNgq4u004680@agluck-lia64.sc.intel.com>
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
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jay Lan <jlan@sgi.com>, Bernhard Walle <bwalle@suse.de>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Sep 29, 2008 at 04:42:52PM -0700, Luck, Tony wrote:
> Does this make kexec/kdump happier?  Bare minimum testing so far
> (builds and boots on tiger ... didn't try kexec yet).

Hi Tony,

your analysis (in your previous email) was more or less the same
conclusion that I had come too, though I was puzzling over
why you had put the reserved area for cpu0 where you had - I assumed
I was misunderstanding things.

This patch looks good to me.

Jay,

With this patch I assume that we still need an order of operations fix for
kexec-tools but no section merging changes. Is that correct?

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
