Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dD0xV-0002Xa-2Y
 for kexec@lists.infradead.org; Tue, 23 May 2017 03:58:10 +0000
Received: by mail-pf0-f178.google.com with SMTP id 9so101107085pfj.1
 for <kexec@lists.infradead.org>; Mon, 22 May 2017 20:57:46 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
References: <cover.1493272570.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
 <cf5a82bf-8232-f39f-7ab4-69250492d4a2@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC910B@BPXM01GP.gisp.nec.co.jp>
 <383e5f5d-8be8-f3cc-f937-5713f785a4df@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED695B@BPXM01GP.gisp.nec.co.jp>
 <a69827b0-ff2d-4f1b-a119-88e0b941ac81@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDA053@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <6e1e4b85-5625-fdc2-da11-07c3bcb0e987@redhat.com>
Date: Tue, 23 May 2017 09:27:39 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDA053@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "bhe@redhat.com" <bhe@redhat.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Xunlei Pang <xlpang@redhat.com>, "mingo@kernel.org" <mingo@kernel.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Atsushi,

Thanks a lot for testing it.

On Tuesday 23 May 2017 08:39 AM, Atsushi Kumagai wrote:
>>>>>>> Thanks for your report, I have received this.
>>>>>>> I'm on vacation until Mar 8, I'll review it when I return from vacation.
>>>>>>
>>>>>> Any further comment on it?
>>>>>> Otherwise, I will send a v2 after accommodating concern from Xunlei.
>>>>>
>>>>> Unfortunately, it doesn't seem like I can make time anymore for review this week,
>>>>> but at least this patch doesn't seem to work in my environment (linux 4.8 without kaslr).
>>>>> Do you have any ideas ?
>>>>
>>>> I see, why it would have caused. I have not tested this case, but I hope my v2
>>>> should not have this issue.
>>>
>>> Umm, v2 still doesn't work in my environment...
>>> It seems that I have to investigate this deeper.
>>
>> Hummm, I thought we would see file_vmcoreinfo as NULL in
>> get_kaslr_offset_x86_64() in your case. However, it's not true.
>>
>> I think, it will have to be initialized with NULL in main().
>>
>> Can you please try following fixup on top of this series:
>
> I found the cause, please see below:
>
> initial()
>   + find_kaslr_offsets()
>     + open_vmcoreinfo()
>     + get_kaslr_offset()        // set info->kaslr_offset
>     + close_vmcoreinfo()
> gather_filter_info()
>   (snip)
>   + resolve_config_entry()
>     + get_kaslr_offset()        // occur SIGSEGV since info->file_vmcoreinfo is closed

Since info->file_vmcoreinfo is closed,therefore it should be NULL. But 
currently, close_vmcoreinfo() does not set it to NULL. We should also set 
info->file_vmcoreinfo to NULL in close_vmcoreinfo() apart from main().

>
>
> The cause code is in [PATCH v2 1/2],
>
> diff --git a/erase_info.c b/erase_info.c
> index f2ba914..60abfa1 100644
> --- a/erase_info.c
> +++ b/erase_info.c
> @@ -1088,6 +1088,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_vaddr,
>                                                         ce->line, ce->name);
>                         return FALSE;
>                 }
> +               ce->sym_addr += get_kaslr_offset(ce->sym_addr);
>                 ce->type_name = get_symbol_type_name(ce->name,
>                                         DWARF_INFO_GET_SYMBOL_TYPE,
>                                         &ce->size, &ce->type_flag);
>
>
> I think we should use info->kaslr_offset instead of get_kaslr_offset(),
> how about you ?

Actually,  we are not sure at this point that ce->sym_addr is a kernel linear 
address. It could be a module address and that can have different 
randomization offset.

My intention is to calculate all types of kaslr offsets in 
find_kaslr_offsets() very early and then store them in different "info" 
elements. Now, whenever we call get_kaslr_offset() we would return right 
offset as per the input address.
I have very little idea about x86. So, I have left a TODO to calculate offset 
for non-linear addresses.

>
> BTW, I'm not sure why you didn't meet this issue...

Because, I tested with kaslr kernel, so when get_kaslr_offset(ce->sym_addr) 
was called, I already had a valid info->kaslr_offset.

So, what about following fixup

diff --git a/makedumpfile.c b/makedumpfile.c
index 57235690569e..4986d098d69a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8685,6 +8685,7 @@ close_vmcoreinfo(void)
         if(fclose(info->file_vmcoreinfo) < 0)
                 ERRMSG("Can't close the vmcoreinfo file(%s). %s\n",
                     info->name_vmcoreinfo, strerror(errno));
+       info->file_vmcoreinfo = NULL;
  }

  void
@@ -11076,6 +11077,7 @@ main(int argc, char *argv[])
                     strerror(errno));
                 goto out;
         }
+       info->file_vmcoreinfo = NULL;
         info->fd_vmlinux = -1;
         info->fd_xen_syms = -1;
         info->fd_memory = -1;

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
