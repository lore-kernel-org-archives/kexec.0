Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eosii-0006QQ-Ep
 for kexec@lists.infradead.org; Thu, 22 Feb 2018 15:23:43 +0000
Date: Thu, 22 Feb 2018 16:23:11 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] kexec/ppc64: add support to parse ibm,
 dynamic-memory-v2 property
Message-ID: <20180222152311.7qevbho4caaift2i@verge.net.au>
References: <151913628039.8893.12994971144990413141.stgit@hbathini.in.ibm.com>
 <151913628939.8893.17231490402797441078.stgit@hbathini.in.ibm.com>
 <d0635103-435a-cc32-b40c-165b9eea214a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0635103-435a-cc32-b40c-165b9eea214a@linux.vnet.ibm.com>
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

On Wed, Feb 21, 2018 at 02:40:47PM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 02/20/2018 07:48 PM, Hari Bathini wrote:
> > Add support to parse the new 'ibm,dynamic-memory-v2' property in the
> > 'ibm,dynamic-reconfiguration-memory' node. This replaces the old
> > 'ibm,dynamic-memory' property and is enabled in the kernel with a
> > patch series that starts with commit 0c38ed6f6f0b ("powerpc/pseries:
> > Enable support of ibm,dynamic-memory-v2"). All LMBs that share the same
> > flags and are adjacent are grouped together in the newer version of the
> > property making it compact to represent larger memory configurations.
> > 
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> 
> Thanks for fixing this. Patches looks good to me.
> 
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
