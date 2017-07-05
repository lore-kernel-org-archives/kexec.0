Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSt79-0008T9-LS
 for kexec@lists.infradead.org; Wed, 05 Jul 2017 22:49:45 +0000
Date: Thu, 6 Jul 2017 00:49:14 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [makedumpfile PATCH v2] Prevent data loss in last page of ELF
 core dumpfile
Message-ID: <20170705224914.GM4448@olila.local.net-space.pl>
References: <1499274802-30844-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1499274802-30844-1-git-send-email-eric.devolder@oracle.com>
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
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Wed, Jul 05, 2017 at 12:13:22PM -0500, Eric DeVolder wrote:
> When generating an ELF core dump file, if a segment size
> is not an exact multiple of PAGE_SIZE, then the corresponding
> generated segment is erroneously truncated to a PAGE_SIZE multiple.
> Thus a small loss of data up to PAGE_SIZE-1 bytes can occur.

Some nit picks below...

[...]

> With the patch applied, the file size is again correct.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
> v2: posted 05jul2017 to kexec-tools list
>  - feedback from Atsushi Kumagai pointed to real root of problem,
>    and patch changed accordingly
>
> v1: posted 03jul2017 to kexec-tools list
> ---
>  makedumpfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index e69b6df..26296f1 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5410,7 +5410,8 @@ create_1st_bitmap_file(void)
>  		if (pfn_start > info->max_mapnr)
>  			continue;
>  		pfn_end = MIN(pfn_end, info->max_mapnr);
> -
> +        /* Account for last page if it has less than page_size data in it */
> +        if (phys_end & (info->page_size-1)) ++pfn_end;

Something is wrong with column alignment. Tabs instead of spaces?
And "++pfn_end;" should be in new line.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
