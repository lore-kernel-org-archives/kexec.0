Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvjFY-0007FD-Hm
	for kexec@lists.infradead.org; Fri, 31 Oct 2008 01:56:33 +0000
Date: Fri, 31 Oct 2008 12:56:25 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -mm 0/3 -v3] kexec/i386: kexec page table code clean up
Message-ID: <20081031015623.GA27118@verge.net.au>
References: <1225354615.24095.110.camel@yhuang-dev.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225354615.24095.110.camel@yhuang-dev.sh.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: Ian Campbell <Ian.Campbell@citrix.com>, kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Oct 30, 2008 at 04:16:55PM +0800, Huang Ying wrote:
> This patchset cleans up page table setup code of kexec on i386.
> 
> This patchset is based on 2.6.28-rc2-mm1 and has been tested on i386.
> 
> v3:
> 
> - Remove PAGE_SIZE alignment from relocate_kernel()
> 
> - Re-based on 2.6.28-rc2-mm1
> 
> v2:
> 
> - Rename some function names, such as alloc_page_tables ->
>   machine_kexec_alloc_page_tables, etc.
> 
> - Cleanup error processing for machine_alloc_page_tables.

These changes seem reasonable to me.

Reviewd-by: Simon Horman <horms@verge.net.au>

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
