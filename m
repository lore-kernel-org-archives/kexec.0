Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e3zWT-0003FZ-Oh
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 07:09:42 +0000
Date: Mon, 16 Oct 2017 09:01:57 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/4] kexec-tools: mips: Don't set lowmem_limit to 2G for
 64-bit systems.
Message-ID: <20171016070156.pcdlmsqyj5mep7hr@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-3-david.daney@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-3-david.daney@cavium.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org

On Thu, Oct 12, 2017 at 02:02:26PM -0700, David Daney wrote:
> The 64-bit MIPS architecture doesn't have the same 2G limit the 32-bit
> version has.  Set MAXMEM and lowmem_limit to 0 for 64-bit MIPS so that
> memory above 2G is usable in the kdump core files.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
