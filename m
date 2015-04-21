Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YkV4r-0003Zj-Bq
 for kexec@lists.infradead.org; Tue, 21 Apr 2015 10:06:50 +0000
Received: by pabtp1 with SMTP id tp1so236521624pab.2
 for <kexec@lists.infradead.org>; Tue, 21 Apr 2015 03:06:28 -0700 (PDT)
Message-ID: <5536211E.9040704@linaro.org>
Date: Tue, 21 Apr 2015 19:06:22 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/6] arm64: allocate memory for other segments after
 kernel
References: <cover.1429201849.git.panand@redhat.com>
 <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
 <20150420032106.GF15033@dhcp-16-116.nay.redhat.com>
 <5535CFC6.4010802@redhat.com>
In-Reply-To: <5535CFC6.4010802@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org

Prayush,
Cc: Geoff

Please add me to Cc if you intend to modify my part of kexec-tools since I don't
subscribe kexec ML, and keep in mind that my repo on git.linaro.org is not for
public review.

On 04/21/2015 01:19 PM, Pratyush Anand wrote:
>
>
> On Monday 20 April 2015 08:51 AM, Baoquan He wrote:
>> On 04/16/15 at 10:17pm, Pratyush Anand wrote:
>>> In case of KEXEC_ON_CRASH, load other segments after the addresses where
>>> kernel segments finish.
>>>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> ---
>>>   kexec/arch/arm64/crashdump-arm64.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
>>> index 41266f294589..75f4e4d269ca 100644
>>> --- a/kexec/arch/arm64/crashdump-arm64.c
>>> +++ b/kexec/arch/arm64/crashdump-arm64.c
>>> @@ -312,5 +312,6 @@ void set_crash_entry(struct mem_ehdr *ehdr, struct kexec_info *info)
>>>   off_t locate_dtb_in_crashmem(struct kexec_info *info, off_t dtb_size)
>>>   {
>>>       return locate_hole(info, dtb_size, 128UL * 1024,
>>> -        crash_reserved_mem.start, crash_reserved_mem.end, 1);
>>> +        crash_reserved_mem.start + arm64_mem.text_offset +
>>> +        arm64_mem.image_size, crash_reserved_mem.end, 1);
>>
>> So you have decided to hard code the sequence of segment. It
>> seems not good. Why don't do it by calling add_buffer_phys_virt() or
>> implement a similar function if you don't like add_buffer_phys_virt.
>
> I agree that code is a bit tightly coupled here. I think, Takahiro  can comment better.

The *hard-coded* segments order is attributed to Geoff's original code.

> arm64 does use add_buffer_phys_virt to add all the buffers into segment list. arm64_load_other_segments function adds
> buffers for all segments other than kernel and elfcorehdr. This function calls add_buffer_phys_virt to load different
> segments like dtb, initrd and purgatory. Only limitation we are putting that we find free area for all these segments
> after the area where kernel finishes. Currently load sequence is like dtb, initrd and then purgatory. But I believe,
> even if we use other load sequence in arm64_load_other_segments, it should work.

I think that add_buffer_phys_virt() should be used instead of locate_hole() to remove
this enforced ordering because locate_hole() assumes that segments in struct info
be sorted properly.
I'm trying the following hack: (pls ignore #if's)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 2c5238c..642c4a9 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -583,6 +583,7 @@ int arm64_load_other_segments(struct kexec_info *info,
         struct mem_ehdr ehdr;
         unsigned long dtb_max;
         unsigned long dtb_base;
+       unsigned long hole_min, hole_max;
         char *initrd_buf = NULL;
         uint64_t purgatory_sink;
         unsigned long purgatory_base;
@@ -639,17 +640,28 @@ int arm64_load_other_segments(struct kexec_info *info,
          * to the DTB size for any DTB growth.
          */

-       dtb_max = dtb_2.size + 2 * 1024;
+       if (info->kexec_flags & KEXEC_ON_CRASH) {
+#if 1
+               hole_min = crash_reserved_mem.start;
+#else
+               hole_min = crash_reserved_mem.start + arm64_mem.text_offset
+                               + arm64_mem.image_size;
+#endif
+               hole_max = crash_reserved_mem.end;
+       } else {
+               hole_min = arm64_mem.memstart + arm64_mem.text_offset
+                               + arm64_mem.image_size;
+               hole_max = ULONG_MAX;
+       }

-       if (info->kexec_flags & KEXEC_ON_CRASH)
-               dtb_base = locate_dtb_in_crashmem(info, dtb_max);
-       else
-               dtb_base = locate_hole(info, dtb_max, 128UL * 1024,
-                       arm64_mem.memstart + arm64_mem.text_offset
-                               + arm64_mem.image_size,
-                       _ALIGN_UP(arm64_mem.memstart + arm64_mem.text_offset,
-                               512UL * 1024 * 1024),
-                       1);
+       dtb_max = dtb_2.size + 2 * 1024;
+#if 1
+       dtb_base = add_buffer_phys_virt(info, dtb_2.buf, dtb_2.size, dtb_max,
+                       128UL * 1024, hole_min, hole_max, 1, 0);
+#else
+       dtb_base = locate_hole(info, dtb_max, 128UL * 1024,
+                       hole_min, hole_max, 1);
+#endif
         dbgprintf("dtb:    base %lx, size %lxh (%ld)\n", dtb_base, dtb_2.size,
                 dtb_2.size);
@@ -670,8 +686,14 @@ int arm64_load_other_segments(struct kexec_info *info,
                         /* Put the initrd after the DTB with an alignment of
                          * page size. */

+#if 1
+                       initrd_base = add_buffer_phys_virt(info, initrd_buf,
+                               initrd_size, initrd_size, 0,
+                               hole_min, hole_max, 1, 0);
+#else
                         initrd_base = locate_hole(info, initrd_size, 0,
-                               dtb_base + dtb_max, -1, 1);
+                               dtb_base + dtb_max, hole_max, 1);
+#endif

                         dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
                                 initrd_base, initrd_size, initrd_size);
@@ -695,12 +717,14 @@ int arm64_load_other_segments(struct kexec_info *info,
                 return -EINVAL;
         }

+#if 0
         add_segment_phys_virt(info, dtb_2.buf, dtb_2.size, dtb_base,
                 dtb_2.size, 0);

         if (arm64_opts.initrd)
                 add_segment_phys_virt(info, initrd_buf, initrd_size,
                                 initrd_base, initrd_size, 0);
+#endif

         if (arm64_opts.lite)
                 info->entry = (void *)kernel_entry;
@@ -714,8 +738,13 @@ int arm64_load_other_segments(struct kexec_info *info,
                         return -EBADF;
                 }

+#if 1
+               elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+                       hole_min, hole_max, 1, 0);
+#else
                 elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
-                       purgatory_base, ULONG_MAX, 1, 0);
+                       purgatory_base, hole_max, 1, 0);
+#endif

                 info->entry = (void *)elf_rel_get_addr(&info->rhdr,
                         "purgatory_start");

Thanks,
-Takahiro AKASHI

>
> Not sure, if understood the question and replied well.
>
> ~Pratyush
>
>
>
>>
>>>   }
>>> --
>>> 2.1.0
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
