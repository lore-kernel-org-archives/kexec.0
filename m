Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLmu3-0008Mt-0V
 for kexec@lists.infradead.org; Tue, 07 Apr 2020 12:00:28 +0000
Date: Tue, 7 Apr 2020 14:00:21 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/3] kexec-xen: Introduce xen_get_kexec_range to wrap
 xc_kexec_get_range
Message-ID: <20200407120021.GB17530@vergenet.net>
References: <1585760237-26924-1-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585760237-26924-1-git-send-email-vrd@amazon.de>
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
To: Varad Gautam <vrd@amazon.de>
Cc: kexec@lists.infradead.org, dwmw@amazon.co.uk

On Wed, Apr 01, 2020 at 06:57:15PM +0200, Varad Gautam wrote:
> And convert all callers of xc_kexec_get_range to use this. Allows reusing
> sanity checks for other KEXEC_RANGEs
> 
> v2: define xen_get_kexec_range outside of HAVE_LIBXENCTRL

Thanks, series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
