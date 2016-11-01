Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1RiZ-00026g-0C
 for kexec@lists.infradead.org; Tue, 01 Nov 2016 05:34:39 +0000
Date: Tue, 1 Nov 2016 13:34:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [Makedumpfile PATCH V2 0/4] x86_64: Fix page_offset for
 randomized base enabled
Message-ID: <20161101053411.GA4952@dhcp-128-65.nay.redhat.com>
References: <cover.1477901442.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, louis.bouchard@canonical.com, kexec@lists.infradead.org, cpw@sgi.com, bhe@redhat.com

Pratyush, the patches works for me, thanks~

On 10/31/16 at 01:47pm, Pratyush Anand wrote:
> Patch 1/4 fixes page_offset calculation, so that it is correctly calculated
> on KASLR enabled kernel as well.
> Patch 2/4 simplifies VA to PA translation. New code has been benchmarked
> against old code on a 4T system.
> Patch 3/4 and 4/4 is removal of (now) unnecessary code.
> 
> I think, we should find a way to kill find_vememmap() as well, so that
> VMEMMAP_START can be removed. I have very limited idea about x86, so unable
> to do that as of now.

It was introduced in below commit, ccing Cliff Wickman, see if he has
thoughts.

commit 46176a97f329904c10d4efe5582594d55a04339c
Author: Cliff Wickman <cpw@sgi.com>
Date:   Mon Oct 26 23:20:18 2015 +0900

> 
> Changes since V1:
> * A bug in patch 1/4 fixed
> * Patch log of 2/4 improved to include more number of trials
> 
> Pratyush Anand (4):
>   x86_64: Calculate page_offset from pt_load
>   x86_64: translate all VA to PA using page table values
>   x86_64: kill is_vmalloc_addr_x86_64()
>   x86_64: kill some unused initialization
> 
>  arch/x86_64.c  | 84 ++++++++++++++++++++--------------------------------------
>  makedumpfile.h |  9 +++----
>  2 files changed, 32 insertions(+), 61 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
