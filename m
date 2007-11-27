Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix50u-00070v-D2
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 18:18:35 +0000
Date: Tue, 27 Nov 2007 10:18:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 4/5] Fix the configuration dependencies
In-Reply-To: <474BE583.2080000@mxs.nes.nec.co.jp>
Message-ID: <Pine.LNX.4.64.0711271017440.2310@schroedinger.engr.sgi.com>
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
	<473D0170.1060304@mxs.nes.nec.co.jp>
	<20071125235843.69440d4a.akpm@linux-foundation.org>
	<474BE583.2080000@mxs.nes.nec.co.jp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On Tue, 27 Nov 2007, Ken'ichi Ohmichi wrote:

> I guess that Christoph Lameter deleted the above part (which is added
> by the attached patch again) with the other part of discontigmem lines,
> because it depended on CONFIG_ARCH_DISCONTIGMEM_ENABLE.
> But the dependency was wrong, and it should depend on CONFIG_NUMA.
> The part is necessary for a NUMA kernel even if sparsemem.

Acked-by: Christoph Lameter <clameter@sgi.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
