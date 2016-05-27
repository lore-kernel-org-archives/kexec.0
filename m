Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6GBa-0000ye-JF
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:44:15 +0000
Received: by mail-oi0-f52.google.com with SMTP id b65so169652627oia.1
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:43:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 17:13:53 +0530
Message-ID: <CAHB_GuruHfjF_YRbP+1wTybGfvX02xQcUefbo0rv4xAtDdhakw@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 08/32] kexec: add max_size to memory_ranges
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Many implementations statically allocate the memory range array, which
> therefore will have a maximum allowable size.  Add this information to
> the memory_ranges structure, so we don't have to carry it around.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index c02ac8f..9194f1c 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -142,6 +142,7 @@ struct memory_range {
>
>  struct memory_ranges {
>          unsigned int size;
> +       unsigned int max_size;
>          struct memory_range *ranges;
>  };
>
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
