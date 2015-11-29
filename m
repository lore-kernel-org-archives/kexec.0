Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a3Bpa-0003Ey-VD
 for kexec@lists.infradead.org; Sun, 29 Nov 2015 23:56:35 +0000
Date: Mon, 30 Nov 2015 08:56:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86/xen: Build memory type conversion code conditionally
Message-ID: <20151129235614.GC13342@verge.net.au>
References: <1448741838-958-1-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448741838-958-1-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, bhe@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, toshi.kani@hp.com, david.vrabel@citrix.com, jbeulich@suse.com, xen-devel@lists.xenproject.org

On Sat, Nov 28, 2015 at 09:17:18PM +0100, Daniel Kiper wrote:
> Xen is not aware of E820_PMEM and E820_PRAM memory types, so, build
> simply fails. Hence, build code referencing them conditionally.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

I believe this is fixed by
"x86: Make sure E820_PM[AE]M are defined if needed"
which I applied a few moments ago.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
