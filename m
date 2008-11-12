Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0PXV-0005Hv-EB
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 23:54:26 +0000
Message-ID: <491B681B.6040405@kernel.org>
Date: Wed, 12 Nov 2008 15:34:51 -0800
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>
	<491B398C.9090207@goop.org>
In-Reply-To: <491B398C.9090207@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Jeremy Fitzhardinge wrote:
> 
> resource_size_t should always be 64-bit on PAE now.
> 

Yes, but this would affect non-PAE kernels too.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
