Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1nRI-00075Q-Tm
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 06:23:06 +0000
Date: Fri, 30 Mar 2018 08:22:47 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec/ppc64: leverage kexec_file_load support
Message-ID: <20180330062247.ajauok2qa4y4tvyw@verge.net.au>
References: <152205397129.8303.10583424055676557501.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <152205397129.8303.10583424055676557501.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, bauerman@linux.vnet.ibm.com

On Mon, Mar 26, 2018 at 02:16:34PM +0530, Hari Bathini wrote:
> PPC64 kernel now supports kexec_file_load system call. Leverage it by
> enabling that support here. Note that loading crash kernel with this
> system call is not yet supported in the kernel and trying to load one
> will fail with '-ENOTSUPP' error.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
