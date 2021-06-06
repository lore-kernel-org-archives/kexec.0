Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpmgZ-00HWLR-Re
 for kexec@lists.infradead.org; Sun, 06 Jun 2021 06:55:05 +0000
Date: Sun, 6 Jun 2021 08:54:52 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCHv2] arm64/crashdump-arm64: deduce the paddr of _text
Message-ID: <20210606065449.GA4363@vergenet.net>
References: <20210526104128.42755-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210526104128.42755-1-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, May 26, 2021 at 06:41:28PM +0800, Pingfan Liu wrote:
> Since kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
> permanent kernel mapping"), the physical address of 'Kernel code' in
> /proc/iomem is mapped from _text, instead, from _stext.
> 
> Taking the compatibility into account, it had better deduce the paddr of
> _text despite of the unavailability through /proc/iomem. It can be
> achieved by utilizing the fact _text aligned on 2MB.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Simon Horman <horms@verge.net.au>
> To: kexec@lists.infradead.org
> ---
> v1 -> v2:
>  deduce paddr of _text to cope with compability.

Thanks, and sorry for the delay.

Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
