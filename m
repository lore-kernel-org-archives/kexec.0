Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bST0f-0006o1-R9
 for kexec@lists.infradead.org; Wed, 27 Jul 2016 17:52:46 +0000
Received: by mail-oi0-f53.google.com with SMTP id l72so28561482oig.2
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 10:52:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7514609d50e28f6632e3a265fdd08020c33353b6.1469641659.git.panand@redhat.com>
References: <7514609d50e28f6632e3a265fdd08020c33353b6.1469641659.git.panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Date: Wed, 27 Jul 2016 23:22:24 +0530
Message-ID: <CAHB_GuoySL5Dwns9a5OD8V1t2Eq3o6ZxXBZ5a35MfV216LaDvw@mail.gmail.com>
Subject: Re: [PATCH] kexec: fix mem_regions_sort()
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
To: Kexec Mailing List <kexec@lists.infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>

Missed CCing Russell because of --suppress-cc :(

CCing now.

On Wed, Jul 27, 2016 at 11:19 PM, Pratyush Anand <panand@redhat.com> wrote:
> ranges->ranges is  "struct memory_range *", however each element which need
> to be sorted is of type "struct memory_range". So, correct "size" argument
> of qsort() as sizeof(*ranges->ranges).
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Cc:Russell King <rmk@arm.linux.org.uk>
> Cc:Simon Horman <horms@verge.net.au>
> ---
>  kexec/mem_regions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index e61c07472f1b..50c8abccb93a 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -24,7 +24,7 @@ static int mem_range_cmp(const void *a1, const void *a2)
>   */
>  void mem_regions_sort(struct memory_ranges *ranges)
>  {
> -       qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
> +       qsort(ranges->ranges, ranges->size, sizeof(*ranges->ranges),
>               mem_range_cmp);
>  }
>
> --
> 2.5.5
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
