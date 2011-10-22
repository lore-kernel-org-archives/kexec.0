Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RHQ4c-0006t6-LY
	for kexec@lists.infradead.org; Sat, 22 Oct 2011 01:08:31 +0000
Date: Sat, 22 Oct 2011 10:08:21 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] intel-iommu:make identity_map default for crash dump
Message-ID: <20111022010821.GF21850@verge.net.au>
References: <20111021123154.GA5821@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111021123154.GA5821@darkstar.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: iommu@lists.linux-foundation.org, luyu@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Fri, Oct 21, 2011 at 08:31:54PM +0800, Dave Young wrote:
> kdump kernel sometimes will get DMAR faults which
> is caused by random in-flight dma from 1st kernel
> 
> Here make the identity_mapping as default for this case

This seems reasonable to me. Although I am curious to know
what the side effects of using IDENTMAP_ALL might be.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
