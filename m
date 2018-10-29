Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH4X1-00060I-Ac
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 10:12:25 +0000
Date: Mon, 29 Oct 2018 11:12:06 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: fix BAD_FREE in get_efi_runtime_map()
Message-ID: <20181029101206.lygflu5yq2utfi52@verge.net.au>
References: <1540194856-22759-1-git-send-email-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540194856-22759-1-git-send-email-piliu@redhat.com>
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

On Mon, Oct 22, 2018 at 03:54:16PM +0800, Pingfan Liu wrote:
> If the err_out label is reached, address of a stack variable is passed to
> free(). Fix it.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
