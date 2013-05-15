Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcPhN-00042H-Do
 for kexec@lists.infradead.org; Wed, 15 May 2013 00:36:06 +0000
Date: Wed, 15 May 2013 09:35:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: check if memory is reserved only when loading
 kdump kernel.
Message-ID: <20130515003533.GA12246@verge.net.au>
References: <1368527570-19499-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1368527570-19499-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, May 14, 2013 at 06:32:50PM +0800, WANG Chao wrote:
> When memory for crashkernel isn't reserved, it's confusing that kexec
> spits error message for unloading kdump kernel as if we were loading it:
> 
>   # kexec -p -u
>   Memory for crashkernel is not reserved
>   Please reserve memory by passing "crashkernel=X@Y" parameter to the kernel
>   Then try loading kdump kernel
>   # echo $?
>   1
> 
> It's more appropriate to test if memory is reserved only when
> loading kdump kernel. With this patch:
> 
>   # kexec -p -u
>   # echo $?
>   0
> 
> It's also the same behavior with the case of trying to unload kernel
> from unloaded state.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
