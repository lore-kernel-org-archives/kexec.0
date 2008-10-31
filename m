Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KvqEY-0005wJ-NC
	for kexec@lists.infradead.org; Fri, 31 Oct 2008 09:23:59 +0000
Date: Fri, 31 Oct 2008 10:23:41 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3 -v4] kexec/i386: kexec page table code clean up
Message-ID: <20081031092341.GD14127@elte.hu>
References: <1225417677.24095.135.camel@yhuang-dev.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225417677.24095.135.camel@yhuang-dev.sh.intel.com>
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
Cc: Ian Campbell <Ian.Campbell@citrix.com>, kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>


* Huang Ying <ying.huang@intel.com> wrote:

> This patchset cleans up page table setup code of kexec on i386.
> 
> This patchset is based on v2.6.28-rc2-338-g65fc716 and has been 
> tested on i386.

applied to tip/x86/crashdump:

 9868ee6: kexec/i386: setup kexec page table in C
 92be3d6: kexec/i386: allocate page table pages dynamically
 31498a0: kexec/i386: remove PAGE_SIZE alignment from relocate_kernel

thanks! They are nice cleanups - both the .text reduction and the 
linecount reduction is nice:

 4 files changed, 102 insertions(+), 152 deletions(-)

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
