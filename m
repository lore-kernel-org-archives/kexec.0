Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Weg3J-0006Up-5p
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 07:32:37 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: fix free partial_bitmap2 error
Date: Mon, 28 Apr 2014 07:28:16 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720DF20@BPXM01GP.gisp.nec.co.jp>
References: <1398390182-8480-1-git-send-email-zzou@redhat.com>
In-Reply-To: <1398390182-8480-1-git-send-email-zzou@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "zzou@redhat.com" <zzou@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Description:
>In create_dump_bitmap, after prepare_bitmap2_buffer_cyclic was invoked,
>info->partial_bitmap2 will pointed to a block of contiguous memory. But
>free it in a wrong way because what free_bitmap2_buffer() free is
>info->bitmap2 not info->partial_bitmap2.
>
>Signed-off-by: Arthur Zou <zzou@redhat.com>

Good catch, Thanks!

>---
> makedumpfile.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index ce4a866..f0d2997 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -5143,7 +5143,8 @@ create_dump_bitmap(void)
>
> 			info->num_dumpable = get_num_dumpable_cyclic();
>
>-			free_bitmap2_buffer();
>+			if (info->partial_bitmap2 != NULL)
>+				free(info->partial_bitmap2);

I think it's better to create free_bitmap2_buffer_cyclic() for this.

BTW, write_kdump_pages_and_bitmap_cyclic() also have the same mistake:

        struct cycle cycle = {0};
        for_each_cycle(0, info->max_mapnr, &cycle)
        {
                if (!create_1st_bitmap_cyclic(&cycle))
                        return FALSE;
                if (!write_kdump_bitmap1_cyclic(&cycle))
                        return FALSE;
        }


        free_bitmap1_buffer();

What we should do here is to free partial_bitmap1, so we should
create free_bitmap1_buffer_cyclic() and call it here instead.
Luckily, this mistake is harmless due to the free() at the end
of main():

                if (info->partial_bitmap1 != NULL)
                        free(info->partial_bitmap1);
                if (info->partial_bitmap2 != NULL)
                        free(info->partial_bitmap2);

Now, I think it's better to remove these free(), it's possible
if partial_bitmap1 and partial_bitmap2 are freed in
write_kdump_pages_and_bitmap_cyclic() or write_elf_pages_cyclic().

So could you fix your patch based on my comments?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
