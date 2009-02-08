Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LW7jk-0007Zz-1Y
	for kexec@lists.infradead.org; Sun, 08 Feb 2009 11:22:22 +0000
Date: Sun, 8 Feb 2009 20:21:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86_64 : exclude gart memory region in kexec tools
Message-ID: <20090208112124.GB6069@verge.net.au>
References: <200902042202.03966.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200902042202.03966.chandru@in.ibm.com>
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
To: Chandru <chandru@in.ibm.com>
Cc: kexec@lists.infradead.org

On Wed, Feb 04, 2009 at 10:02:03PM +0530, Chandru wrote:
> The following patch was discussed sometime back on kexec-tools mailing list.
> http://lists.infradead.org/pipermail/kexec/2008-December/003096.html
> Sending it here again for inclusion into kexec-tools. thanks
> ====================================
> 
> 
> Exclude GART memory region and make kexec-tools to not create elf headers to 
> it.  Currently it seems like the dump analysis tools do not need a copy of the 
> GART memory region, hence ignoring it in kexec-tools. Symtoms of accessing
> this region in kdump kernel included hangs, spurious restarts, and MCE
> (Machine Check Exception) panics in some AMD Opteron systems

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
