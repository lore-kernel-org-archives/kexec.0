Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb7NV-0006c6-OL
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 15:08:27 +0000
Date: Tue, 7 Feb 2017 16:07:49 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 03/12] crashdump/cris: Add
 print_crashkernel_region_size() function
Message-ID: <20170207150749.GD13477@olila.local.net-space.pl>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
 <1486410144-28595-4-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486410144-28595-4-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Mon, Feb 06, 2017 at 01:42:15PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> Provide just print_crashkernel_region_size() stub. This way
> we can properly build kexec utility on cris arch even
> if the functionality is not available on it.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kexec/arch/cris/kexec-cris.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
> index 4ac2f89..5601d8e 100644
> --- a/kexec/arch/cris/kexec-cris.c
> +++ b/kexec/arch/cris/kexec-cris.c
> @@ -77,6 +77,11 @@ int is_crashkernel_mem_reserved(void)
>  	return 0;
>  }
>
> +void print_crashkernel_region_size(void)
> +{
> +	printf("Crashkernel functionality is not available.\n");

Error message is a bit confusing. What about "Crash kernel region size cannot
be printed because this info is not exposed by the system."?

Or simpler: Crash kernel region size is not exposed by the system.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
