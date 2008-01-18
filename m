Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JFnFq-0004il-Uf
	for kexec@lists.infradead.org; Fri, 18 Jan 2008 09:11:22 +0000
Date: Fri, 18 Jan 2008 18:11:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -mm 1/2 -v2] kexec/i386: kexec page table code clean up
	- add arch_kimage
Message-ID: <20080118091108.GD10957@verge.net.au>
References: <1200377146.3505.50.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1200377146.3505.50.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ian Campbell <Ian.Campbell@citrix.com>, kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jan 15, 2008 at 02:05:46PM +0800, Huang, Ying wrote:
> This patch add an architecture specific struct arch_kimage into struct
> kimage. Three pointers to page table pages used by kexec are added to
> struct arch_kimage. The page tables pages are dynamically allocated in
> machine_kexec_prepare instead of statically from BSS segment. This
> will save up to 20k memory when kexec image is not loaded.

I like this idea a lot.

Acked-by: Simon Horman <horms@verge.net.au>

> Signed-off-by: Huang Ying <ying.huang@intel.com>

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
