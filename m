Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VorfK-0008Hd-QL
 for kexec@lists.infradead.org; Fri, 06 Dec 2013 09:25:43 +0000
Date: Fri, 6 Dec 2013 18:25:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Fix add_usable_memory to use buf of type uint64_t.
Message-ID: <20131206092516.GA1107@verge.net.au>
References: <20131205192530.1961.78838.stgit@mars>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131205192530.1961.78838.stgit@mars>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Kexec-ml <kexec@lists.infradead.org>

On Fri, Dec 06, 2013 at 12:55:30AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> A switchover from /kexec/arch/ppc64/fs2dt.c to common code under
> /kexec/fs2dt.c broke the kdump on ppc64. The function add_usable_memory()
> assumes that 'memory@*' node exports two 32bit values and fails
> to populate mem ranges correctly. On ppc64, 'memory@*' exports two 64bit
> values as below:
> 
> # hexdump /proc/device-tree/memory\@0/reg
> 0000000 0000 0000 0000 0000 0000 0000 0800 0000
> 0000010
> #
> 
> This patch fixes add_usable_memory() to use buf[2] of type uint64_t.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
