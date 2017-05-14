Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dA2wZ-0005W6-Oy
 for kexec@lists.infradead.org; Sun, 14 May 2017 23:28:57 +0000
Subject: Re: [PATCH] Handle additional e820 memmap type strings
References: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <bdc48f5f-9855-6562-73ea-027c8ad7e7a1@oracle.com>
Date: Sun, 14 May 2017 18:28:15 -0500
MIME-Version: 1.0
In-Reply-To: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

There have been no reviews of this patch yet; just bubbling it up to the 
top to gain some attention.

Regards,
eric

On 05/10/2017 11:03 AM, Eric DeVolder wrote:
> Keep pace with changes to linux arch/x86/kernel/e820.c to
> function e820_type_to_string(). With this change, the following
> messages from kexec are eliminated (and allows kexec to load):
>
>  Unknown type (Reserved) while parsing /sys/firmware/memmap/8/type.
>  Please report this as bug. Using RANGE_RESERVED now.
>
>  Unknown type (Unknown E820 type) while parsing /sys/firmware/memmap/4/type.
>  Please report this as bug. Using RANGE_RESERVED now.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kexec/firmware_memmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> index 4d84f00..1ee214a 100644
> --- a/kexec/firmware_memmap.c
> +++ b/kexec/firmware_memmap.c
> @@ -164,6 +164,10 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
>  		range->type = RANGE_RESERVED;
>  	else if (strcmp(type, "reserved") == 0)
>  		range->type = RANGE_RESERVED;
> +	else if (strcmp(type, "Reserved") == 0)
> +		range->type = RANGE_RESERVED;
> +	else if (strcmp(type, "Unknown E820 type") == 0)
> +		range->type = RANGE_RESERVED;
>  	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
>  		range->type = RANGE_ACPI_NVS;
>  	else if (strcmp(type, "Uncached RAM") == 0)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
