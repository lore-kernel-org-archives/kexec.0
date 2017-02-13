Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdOfM-0002tG-PI
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 22:00:15 +0000
Date: Mon, 13 Feb 2017 22:58:09 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] crashdump/arm64: Add
 get_crash_kernel_load_range() function
Message-ID: <20170213215809.GD9543@olila.local.net-space.pl>
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
 <1486764462-14176-3-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486764462-14176-3-git-send-email-eric.devolder@oracle.com>
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
Cc: panand@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, horms@verge.net.au, dyoung@redhat.com

Two nitpicks below...

On Fri, Feb 10, 2017 at 04:07:33PM -0600, Eric DeVolder wrote:
> Implement get_crash_kernel_load_range() in support of
> print crash kernel region size option.

This contradicts what is provided in patch body. You should rather say here
that you provide a stub to fulfill requirements of subsequent patch(es).

> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kexec/arch/arm64/crashdump-arm64.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> index d2272c8..b0e4713 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -19,3 +19,9 @@ int is_crashkernel_mem_reserved(void)
>  {
>  	return 0;
>  }
> +
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
> +{
> +	/* Crash kernel region size is not exposed by the system */

Usually I add a full stop at the end of comment. Just my preference.

Otherwise:

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
