Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1It6gA-00016M-H8
	for kexec@lists.infradead.org; Fri, 16 Nov 2007 14:16:45 -0500
Date: Fri, 16 Nov 2007 11:16:30 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/5] Add the array length of "free_list" for filtering
	free pages
Message-ID: <20071116191624.GD8971@verge.net.au>
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
	<473D0176.6090702@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <473D0176.6090702@mxs.nes.nec.co.jp>
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
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, Nov 16, 2007 at 11:33:26AM +0900, Ken'ichi Ohmichi wrote:
> 
> This patch adds the array length of "free_area.free_list" to the vmcoreinfo
> data so that makedumpfile (dump filtering command) can exclude all free pages
> in linux-2.6.24.
> 
> makedumpfile creates a small dumpfile by excluding unnecessary pages for the
> analysis. To distinguish unnecessary pages, makedumpfile gets the vmcoreinfo
> data which has the minimum debugging information only for dump filtering.
> 
> In 2.6.24-rc1 or later, the free_area.free_list is an array which has one list
> for each migrate types instead of a single list. makedumpfile needs the array
> length of "free_area.free_list" and the vmcoreinfo data should contain it.
> 
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Tested-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

This seems fine to me. Though from a point of maintainability
would it be better if VMCOREINFO_LENGTH derived the length
from the element of the type in question. Just a thought,
I haven't hacked it up to see how practical it might be.

Acked-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
