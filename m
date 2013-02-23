Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U9FT9-00069Q-Gj
 for kexec@lists.infradead.org; Sat, 23 Feb 2013 13:48:52 +0000
Received: by mail-wg0-f47.google.com with SMTP id dr13so1215551wgb.26
 for <kexec@lists.infradead.org>; Sat, 23 Feb 2013 05:48:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130222135938.c6f28ff5.akpm@linux-foundation.org>
References: <5126F5BD.1030602@cn.fujitsu.com>
 <20130222135938.c6f28ff5.akpm@linux-foundation.org>
Date: Sat, 23 Feb 2013 21:48:48 +0800
Message-ID: <CANBD6kHEASSBMzo9n85-gfrpO7q_GV+GYKkrJJcGRFFR7Z5w3w@mail.gmail.com>
Subject: Re: [PATCH] kexec: fix memory leak in function kimage_normal_alloc
From: Yanfei Zhang <zhangyanfei.yes@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sasha.levin@oracle.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

2013/2/23 Andrew Morton <akpm@linux-foundation.org>:
> On Fri, 22 Feb 2013 12:36:13 +0800
> Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:
>
>> If kimage_normal_alloc() fails to alloc pages for image->swap_page, it
>> should call kimage_free_page_list() to free allocated pages in
>> image->control_pages list before it frees image.
>>
>> ...
>>
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -223,6 +223,8 @@ out:
>>
>>  }
>>
>> +static void kimage_free_page_list(struct list_head *list);
>> +
>>  static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>>                               unsigned long nr_segments,
>>                               struct kexec_segment __user *segments)
>> @@ -248,22 +250,22 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>>                                          get_order(KEXEC_CONTROL_PAGE_SIZE));
>>       if (!image->control_code_page) {
>>               printk(KERN_ERR "Could not allocate control_code_buffer\n");
>> -             goto out;
>> +             goto out_free;
>>       }
>>
>>       image->swap_page = kimage_alloc_control_pages(image, 0);
>>       if (!image->swap_page) {
>>               printk(KERN_ERR "Could not allocate swap buffer\n");
>> -             goto out;
>> +             goto out_free;
>>       }
>>
>> -     result = 0;
>> - out:
>> -     if (result == 0)
>> -             *rimage = image;
>> -     else
>> -             kfree(image);
>> +     *rimage = image;
>> +     return 0;
>>
>> +out_free:
>> +     kimage_free_page_list(&image->control_pages);
>> +     kfree(image);
>> +out:
>>       return result;
>>  }
>
> kimage_alloc_normal_control_pages() won't add any pages to the image if
> one of its allocation attemtps failed.  So afaict the first `goto
> out_free' could be just `goto out'.

Nop, the first 'goto out_free' is to free allocated 'image' if the allocation of
image->control_code_page failed. If changed to 'goto out', 'image' cannot
be freed and leads to memory leak.

>
> The second `goto out_free' does appear to be needed: it frees the pages
> allocated by the first call to kimage_alloc_control_pages().  I think.
> The kimage_alloc_control_pages() handling of image->type is a bit
> twisty.

Yeah, it could just call kimage_alloc_normal_control_pages directly.

>
> Please double-check the logic?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
