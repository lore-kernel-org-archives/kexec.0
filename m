Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cpsSq-0000Sk-TR
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 08:14:54 +0000
Date: Mon, 20 Mar 2017 09:14:23 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH][kexec-tools] ppc: Fix format warning with die()
Message-ID: <20170320081423.GA21538@verge.net.au>
References: <20170316141118.22286-1-jussi.kukkonen@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170316141118.22286-1-jussi.kukkonen@intel.com>
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
To: Jussi Kukkonen <jussi.kukkonen@intel.com>
Cc: kexec@lists.infradead.org

On Thu, Mar 16, 2017 at 04:11:18PM +0200, Jussi Kukkonen wrote:
> Enable compiling kexec-tools for ppc with -Werror=format-security.
> 
> Signed-off-by: Jussi Kukkonen <jussi.kukkonen@intel.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
