Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbBQk-0005zZ-BE
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 14:37:35 +0000
Date: Wed, 21 Nov 2012 09:37:30 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
Message-ID: <20121121143729.GC13114@redhat.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353483098-14883-5-git-send-email-yinghai@kernel.org>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, Nov 20, 2012 at 11:31:38PM -0800, Yinghai Lu wrote:

[..]
> +	/* avoid cross GB boundary */
> +	align = real_mode->kernel_alignment;
> +	addr = locate_hole(info, size, align, 0x100000, -1, -1);
> +	if (addr == ULONG_MAX)
> +		die("can not load bzImage64");
> +	/* same GB ? */
> +	while ((addr >> 30) != ((addr + size - 1) >> 30)) {
> +		addr = locate_hole(info, size, align, 0x100000,
> +				 round_down(addr + size - 1, (1UL<<30)), -1);
> +		if (addr == ULONG_MAX)
> +			die("can not load bzImage64");
> +	}
> +	dbgprintf("Found kernel buffer at %lx size %lx\n", addr, size);

Where does this limitation of not loading kernel across GB boundary come
from?

Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
