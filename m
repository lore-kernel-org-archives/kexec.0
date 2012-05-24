Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SXLxp-0003zi-UG
 for kexec@lists.infradead.org; Thu, 24 May 2012 00:31:38 +0000
Date: Thu, 24 May 2012 09:31:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [v2 PATCH] ppc: move DEBUG code to --debug
Message-ID: <20120524003128.GB3986@verge.net.au>
References: <1336977296-30314-1-git-send-email-amwang@redhat.com>
 <20120518025931.GB26916@verge.net.au> <4FBCDD04.8070104@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FBCDD04.8070104@in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, Cong Wang <amwang@redhat.com>

On Wed, May 23, 2012 at 06:20:12PM +0530, Suzuki K. Poulose wrote:
> On 05/18/2012 08:29 AM, Simon Horman wrote:
> >On Mon, May 14, 2012 at 02:34:56PM +0800, Cong Wang wrote:
> >>From: Cong Wang<xiyou.wangcong@gmail.com>
> >>
> >>
> >>From: Cong Wang<xiyou.wangcong@gmail.com>
> >>V2: Fix a compile error
> >>
> >>Like commit 28d4ab53280853d2aeefdfb7c369331e89ab9ac2
> >>("Add generic debug option"), this one moves code
> >>under #if DEBUG to --debug on ppc arch.
> >>
> >>Sorry that I still can't find a ppc32 machine to test this.
> >
> >Thank, I don't have any ppc32 (or 64) hardware to test on,
> >but I did use a cross-compiler to check that it builds.
> >
> >>Cc: Simon Horman<horms@verge.net.au>
> >>Signed-off-by: Cong Wang<xiyou.wangcong@gmail.com>
> 
> It builds and works fine for me on PPC32. Sample output below.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
