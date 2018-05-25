Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fM9Un-00063K-1c
 for kexec@lists.infradead.org; Fri, 25 May 2018 09:58:51 +0000
Date: Fri, 25 May 2018 11:58:35 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] Makefile.in: Add uninstall rule
Message-ID: <20180525095834.ndy2racs3k3w4af7@verge.net.au>
References: <1527148627-11641-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527148627-11641-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, bhupesh.linux@gmail.com, Dave Young <dyoung@redhat.com>, Russell King <rmk@arm.linux.org.uk>

On Thu, May 24, 2018 at 01:27:07PM +0530, Bhupesh Sharma wrote:
> Presently the Makedumpfile.in doesn't include a uninstall rule, which is
> useful in case we want to preform a reverse of the install process
> done by Makefile.in
> 
> This patch adds this rule, thus making it easier to remove installed
> executables and man pages in case one needs to uninstall the same.
> 
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
> Changes since v1:
>  - As per Dave's suggestion, seperated the two patches included in the
>    patchset in v1 as individual patches in v2.
>  - Another patch sent by me now obsoletes the kdump tool and the 'make
>    uninstall' rule can come in handy (especially on arm systems with
>    low memory footprints) to remove already installed version of kdump
>    tool and related man-pages.
>    (the patch can be viewed here - http://lists.infradead.org/pipermail/kexec/2018-May/020754.html)
>  - v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2018-April/020527.html
> 
>  Makefile.in | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 2 deletions(-)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
