Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eosBe-0006XV-9v
 for kexec@lists.infradead.org; Thu, 22 Feb 2018 14:49:31 +0000
Date: Thu, 22 Feb 2018 15:49:00 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] kexec: add a helper function to add ranges
Message-ID: <20180222144900.2uacca4yd3yomwiv@verge.net.au>
References: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
 <c2afb888-5bdd-074f-2ddd-525528379c3b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2afb888-5bdd-074f-2ddd-525528379c3b@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Geoff Levand <geoff@infradead.org>, Kexec-ml <kexec@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, nfont@linux.vnet.ibm.com

On Wed, Feb 21, 2018 at 02:37:31PM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 02/20/2018 07:48 PM, Hari Bathini wrote:
> > Add a helper function for adding ranges to avoid duplicating code.
> > 
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> 
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
