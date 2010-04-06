Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NzGyt-0007ZT-E9
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 22:10:48 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012820.229410717@sous-sol.org>
	<m1vdc8juju.fsf@fess.ebiederm.org> <4BB83EAE.5090609@bwalle.de>
	<20100404085338.GU24846@8bytes.org> <m17hond01n.fsf@fess.ebiederm.org>
	<20100404100101.GW24846@8bytes.org>
	<20100406174257.GG29241@sequoia.sous-sol.org>
	<20100406175106.GH28166@amd.com> <20100406203956.GI3029@redhat.com>
	<20100406211315.GJ3029@redhat.com>
	<z2w86802c441004061445q5a05832fmaece2723436f803f@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 06 Apr 2010 15:10:14 -0700
In-Reply-To: <z2w86802c441004061445q5a05832fmaece2723436f803f@mail.gmail.com>
	(Yinghai Lu's message of "Tue\, 6 Apr 2010 14\:45\:51 -0700")
Message-ID: <m1y6h0qlkp.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Bernhard Walle <bernhard@bwalle.de>, Joerg Roedel <joerg.roedel@amd.com>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Yinghai Lu <yinghai@kernel.org> writes:

> not sure if it is related:

I don't think it is.

> for crashing kernel, it could do early_memtest to check if some device
> are still do dma operation.

Devices doing DMA in general are not a problem in the kdump kernel
because we are using an area of memory that has been reserved since
the beginning of time and no DMA's should be targeting it.  The challenge
is how to regain control of the IOMMU.

> When I use kexec to start second kernel, if enable the early_memtest
> in second kernel, it will find some pages RAM are BAD,
> and it will mark them and not use them.  memtest=1 should be good enough.
> Fresh restart will not report there is any BAD ram in the same system.

I assume you are not talking kdump here.

On-going DMA in the case of kexec indicates some device driver isn't shutting
itself down when it's shutdown method is called.

Odds are it is a network controller that doesn't stop DMA when it is brought
down or it is, possibly a really weird disk driver.

If you are seeing this with the kdump kernel this may indeed indicate an
IOMMU reinitialization problem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
