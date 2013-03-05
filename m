Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UChOX-0001LW-HE
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 02:14:22 +0000
Date: Tue, 5 Mar 2013 11:14:18 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] kexec: Limit the crash memory ranges according to
 first kernel's memory limit.
Message-ID: <20130305021418.GI16128@verge.net.au>
References: <20130212104624.7781.32716.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130212104624.7781.32716.stgit@mars.in.ibm.com>
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Ananth Narayan <ananth@in.ibm.com>, bhe@redhat.com

On Tue, Feb 12, 2013 at 04:16:50PM +0530, Mahesh J Salgaonkar wrote:
> So far powerpc kernel never exported memory limit information which is
> reflected by mem= kernel cmdline option. Hence, kexec-tools always use
> to build ELF header for entire system RAM generating a dump bigger than
> the actual memory used by the first kernel.
> 
> The following upstream kernel commits now exports memory limit information
> through /proc/device-tree file:
>   4bc77a5ed - powerpc: Export memory limit via device tree
>   a84fcd468 - powerpc: Change memory_limit from phys_addr_t to unsigned
> 	      long long
> 
> This patch series now reads the memory limit information from
> device-tree file if present and limits the crash memory ranges accordingly.
> 
> Tested these patches on ppc32(ppc440) and ppc64 with a kernel patch by Suzuki.
> 
> Changes in v2:
> - Fixed few formatting and coding style issues.
> - Fixed error handling path and possible buffer overflow issue in patch 1/2.
> - Fixed an issue where an additional PT_LOAD section, representing zero size
>   memory segment (with start address == memory_limit), was getting added to ELF
>   section.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Thanks, both patches applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
