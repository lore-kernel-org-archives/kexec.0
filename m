Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAGfJ-0006LS-8r
 for kexec@lists.infradead.org; Mon, 15 May 2017 14:08:01 +0000
Date: Mon, 15 May 2017 22:07:11 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Handle additional e820 memmap type strings
Message-ID: <20170515140711.GB21797@x1>
References: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On 05/10/17 at 11:03am, Eric DeVolder wrote:
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

Should we change the "reserved" one to "Reserved" so that we don't need
to have "reserved" and "Reserved" at the same time?

>  	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
>  		range->type = RANGE_ACPI_NVS;
>  	else if (strcmp(type, "Uncached RAM") == 0)
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
