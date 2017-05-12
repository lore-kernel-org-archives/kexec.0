Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d90YU-0003BQ-2M
 for kexec@lists.infradead.org; Fri, 12 May 2017 02:43:47 +0000
Received: by mail-pf0-f182.google.com with SMTP id m17so22789915pfg.3
 for <kexec@lists.infradead.org>; Thu, 11 May 2017 19:43:25 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
References: <cover.1493272570.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
 <cf5a82bf-8232-f39f-7ab4-69250492d4a2@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC910B@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <383e5f5d-8be8-f3cc-f937-5713f785a4df@redhat.com>
Date: Fri, 12 May 2017 08:13:20 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EC910B@BPXM01GP.gisp.nec.co.jp>
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
Cc: "keescook@chromium.org" <keescook@chromium.org>, "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>

Hi Atsushi,

Thanks for the testing.

On Wednesday 10 May 2017 01:37 PM, Atsushi Kumagai wrote:
>> Hi Atsushi,
>>
>> On Friday 28 April 2017 12:22 PM, Atsushi Kumagai wrote:
>>> Hello Pratyush,
>>>
>>> Thanks for your report, I have received this.
>>> I'm on vacation until Mar 8, I'll review it when I return from vacation.
>>
>> Any further comment on it?
>> Otherwise, I will send a v2 after accommodating concern from Xunlei.
>
> Unfortunately, it doesn't seem like I can make time anymore for review this week,
> but at least this patch doesn't seem to work in my environment (linux 4.8 without kaslr).
> Do you have any ideas ?

I see, why it would have caused. I have not tested this case, but I hope my v2 
should not have this issue.

~Pratyush
>
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff6be49f5 in fseek () from /lib64/libc.so.6
> Missing separate debuginfos, use: debuginfo-install bzip2-libs-1.0.6-13.el7.x86_64 elfutils-libelf-0.163-3.el7.x86_64 elfutils-libs-0.163-3.el7.x86_64 glibc-2.17-105.el7.x86_64 libgcc-4.8.5-4.el7.x86_64 libstdc++-4.8.5-4.el7.x86_64 snappy-1.1.0-3.el7.x86_64 xz-libs-5.1.2-12alpha.el7.x86_64 zlib-1.2.7-15.el7.x86_64
> (gdb) bt
> #0  0x00007ffff6be49f5 in fseek () from /lib64/libc.so.6
> #1  0x0000000000429d38 in read_vmcoreinfo_symbol (str_symbol=0x44cb0c "SYMBOL(_stext)=") at makedumpfile.c:2384
> #2  0x000000000042097a in get_kaslr_offset_x86_64 (vaddr=18446744071589596288) at arch/x86_64.c:45
> #3  0x0000000000414310 in resolve_config_entry (ce=0x701370, base_vaddr=<optimized out>, base_struct_name=0x0)
>     at erase_info.c:1091
> #4  0x0000000000415a89 in get_config_symbol_addr (base_struct_name=0x0, base_vaddr=0, ce=0x701370) at erase_info.c:1264
> #5  update_filter_info (filter_symbol=0x701370, size_symbol=0x701430) at erase_info.c:1579
> #6  0x0000000000416543 in process_config (config=<optimized out>) at erase_info.c:1789
> #7  process_config_file (name_config=<optimized out>) at erase_info.c:1862
> #8  0x0000000000417c57 in gather_filter_info () at erase_info.c:2356
> #9  0x0000000000443ccb in create_dumpfile () at makedumpfile.c:9863
> #10 0x000000000044561e in main (argc=<optimized out>, argv=<optimized out>) at makedumpfile.c:11342
> (gdb)
>
>
> Thanks,
> Atsushi Kumagai
>
>> ~Pratyush
>>
>>
>>>
>>> Thanks,
>>> Atsushi Kumagai
>>>
>>>> Hi All,
>>>>
>>>> We came across another failure in makedumpfile when kaslr is enabled. This
>>>> failure occurs when we try re-filtering. We try to erase some symbol from a
>>>> dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.
>>>>
>>>> We have very limited symbol information in vmcoreinfo. So symbols to be
>>>> erased may not be available in vmcoreinfo and we look for it in vmlinux.
>>>> However,  symbol address from vmlinux is a static address which differs
>>> >from run time address with KASLR_OFFSET. Therefore, reading any "virtual
>>>> address of vmlinux" from vmcore is not possible.
>>>>
>>>> These patches finds runtime  KASLR offset and then calculates run time
>>>> address of symbols read from vmlinux.
>>>>
>>>> Since, I am not an expert of x86, and these patches touch x86 part of
>>>> makedumpfile, therefore I have CCed x86 experts. Please, provide your
>>>> review comment and let me know if you think there could have been a better
>>>> way to resolve this issue.
>>>>
>>>> thanks
>>>>
>>>> ~Pratyush
>>>>
>>>> Pratyush Anand (2):
>>>>  makedumpfile: add runtime kaslr offset if it exists
>>>>  x86_64: calculate page_offset in case of re-filtering
>>>>
>>>> arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>>> erase_info.c   |  1 +
>>>> makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>> makedumpfile.h | 15 +++++++++++++++
>>>> 4 files changed, 103 insertions(+), 2 deletions(-)
>>>>
>>>> --
>>>> 2.9.3
>>>
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
