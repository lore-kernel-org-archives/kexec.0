Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KO0GV-0001Kj-6h
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 01:14:07 +0000
Date: Wed, 30 Jul 2008 10:13:25 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch] kdump: sh: parse elfcorehdr command line argument
Message-ID: <20080730011325.GA7529@linux-sh.org>
References: <20080730002937.GA21998@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730002937.GA21998@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linux-sh@vger.kernel.org

On Wed, Jul 30, 2008 at 10:29:39AM +1000, Simon Horman wrote:
> A quick cut and paste from other architectures to allow SH
> to parse the elfcorehdr command line argument which is required
> for both is_kdump_kernel() and vmcore to function.
> (the former is as yet unused on SH).
> 
> Tested compilation only
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
This was the first thing I was going to do this morning, but you beat me
to it. :-)

Applied, thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
