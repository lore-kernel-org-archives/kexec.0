Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dARz3-0003G3-Qa
 for kexec@lists.infradead.org; Tue, 16 May 2017 02:13:12 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
Date: Tue, 16 May 2017 02:05:20 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701ED695B@BPXM01GP.gisp.nec.co.jp>
References: <cover.1493272570.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
 <cf5a82bf-8232-f39f-7ab4-69250492d4a2@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC910B@BPXM01GP.gisp.nec.co.jp>
 <383e5f5d-8be8-f3cc-f937-5713f785a4df@redhat.com>
In-Reply-To: <383e5f5d-8be8-f3cc-f937-5713f785a4df@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>

>Hi Atsushi,
>
>Thanks for the testing.
>
>On Wednesday 10 May 2017 01:37 PM, Atsushi Kumagai wrote:
>>> Hi Atsushi,
>>>
>>> On Friday 28 April 2017 12:22 PM, Atsushi Kumagai wrote:
>>>> Hello Pratyush,
>>>>
>>>> Thanks for your report, I have received this.
>>>> I'm on vacation until Mar 8, I'll review it when I return from vacation.
>>>
>>> Any further comment on it?
>>> Otherwise, I will send a v2 after accommodating concern from Xunlei.
>>
>> Unfortunately, it doesn't seem like I can make time anymore for review this week,
>> but at least this patch doesn't seem to work in my environment (linux 4.8 without kaslr).
>> Do you have any ideas ?
>
>I see, why it would have caused. I have not tested this case, but I hope my v2
>should not have this issue.

Umm, v2 still doesn't work in my environment...
It seems that I have to investigate this deeper.

  $ cat scrub.conf
  [vmlinux]
  erase modules size 50
  $

  (gdb) r -cd31 -x vmlinux --config scrub.conf vmcore dumpfile.cd31
  Starting program: /work/kdump_utils/makedumpfile/makedumpfile -cd31 -x vmlinux --config scrub.conf vmcore dumpfile.cd31
  warning: no loadable sections found in added symbol-file system-supplied DSO at 0x7ffff7ffd000
  [Thread debugging using libthread_db enabled]

  Program received signal SIGSEGV, Segmentation fault.
  0x000000308366ee0d in fseek () from /lib64/libc.so.6
  Missing separate debuginfos, use: debuginfo-install bzip2-libs-1.0.5-7.el6_0.x86_64 elfutils-libelf-0.152-1.el6.x86_64 elfutils-libs-0.152-1.el6.x86_64 glibc-2.12-1.132.el6.x86_64 libgcc-4.4.7-4.el6.x86_64 libstdc++-4.4.7-4.el6.x86_64 snappy-1.1.0-1.el6.x86_64 xz-libs-4.999.9-0.3.beta.20091007git.el6.x86_64 zlib-1.2.3-29.el6.x86_64
  (gdb) bt
  #0  0x000000308366ee0d in fseek () from /lib64/libc.so.6
  #1  0x0000000000420937 in get_kaslr_offset_x86_64 (vaddr=18446744071589596288) at arch/x86_64.c:43
  #2  0x0000000000414310 in resolve_config_entry (ce=0x701370, base_vaddr=<value optimized out>, base_struct_name=0x0) at erase_info.c:1091
  #3  0x0000000000415a89 in get_config_symbol_addr (filter_symbol=0x701370, size_symbol=0x701430) at erase_info.c:1264
  #4  update_filter_info (filter_symbol=0x701370, size_symbol=0x701430) at erase_info.c:1579
  #5  0x0000000000416543 in process_config (name_config=<value optimized out>) at erase_info.c:1789
  #6  process_config_file (name_config=<value optimized out>) at erase_info.c:1862
  #7  0x0000000000417c57 in gather_filter_info () at erase_info.c:2356
  #8  0x0000000000443e5b in create_dumpfile () at makedumpfile.c:9870
  #9  0x00000000004457ae in main (argc=<value optimized out>, argv=<value optimized out>) at makedumpfile.c:11349
  (gdb)

Thanks,
Atsushi Kuamgai

>~Pratyush
>>
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff6be49f5 in fseek () from /lib64/libc.so.6
>> Missing separate debuginfos, use: debuginfo-install bzip2-libs-1.0.6-13.el7.x86_64 elfutils-libelf-0.163-3.el7.x86_64
>elfutils-libs-0.163-3.el7.x86_64 glibc-2.17-105.el7.x86_64 libgcc-4.8.5-4.el7.x86_64 libstdc++-4.8.5-4.el7.x86_64
>snappy-1.1.0-3.el7.x86_64 xz-libs-5.1.2-12alpha.el7.x86_64 zlib-1.2.7-15.el7.x86_64
>> (gdb) bt
>> #0  0x00007ffff6be49f5 in fseek () from /lib64/libc.so.6
>> #1  0x0000000000429d38 in read_vmcoreinfo_symbol (str_symbol=0x44cb0c "SYMBOL(_stext)=") at makedumpfile.c:2384
>> #2  0x000000000042097a in get_kaslr_offset_x86_64 (vaddr=18446744071589596288) at arch/x86_64.c:45
>> #3  0x0000000000414310 in resolve_config_entry (ce=0x701370, base_vaddr=<optimized out>, base_struct_name=0x0)
>>     at erase_info.c:1091
>> #4  0x0000000000415a89 in get_config_symbol_addr (base_struct_name=0x0, base_vaddr=0, ce=0x701370) at erase_info.c:1264
>> #5  update_filter_info (filter_symbol=0x701370, size_symbol=0x701430) at erase_info.c:1579
>> #6  0x0000000000416543 in process_config (config=<optimized out>) at erase_info.c:1789
>> #7  process_config_file (name_config=<optimized out>) at erase_info.c:1862
>> #8  0x0000000000417c57 in gather_filter_info () at erase_info.c:2356
>> #9  0x0000000000443ccb in create_dumpfile () at makedumpfile.c:9863
>> #10 0x000000000044561e in main (argc=<optimized out>, argv=<optimized out>) at makedumpfile.c:11342
>> (gdb)
>>
>>
>> Thanks,
>> Atsushi Kumagai
>>
>>> ~Pratyush
>>>
>>>
>>>>
>>>> Thanks,
>>>> Atsushi Kumagai
>>>>
>>>>> Hi All,
>>>>>
>>>>> We came across another failure in makedumpfile when kaslr is enabled. This
>>>>> failure occurs when we try re-filtering. We try to erase some symbol from a
>>>>> dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.
>>>>>
>>>>> We have very limited symbol information in vmcoreinfo. So symbols to be
>>>>> erased may not be available in vmcoreinfo and we look for it in vmlinux.
>>>>> However,  symbol address from vmlinux is a static address which differs
>>>> >from run time address with KASLR_OFFSET. Therefore, reading any "virtual
>>>>> address of vmlinux" from vmcore is not possible.
>>>>>
>>>>> These patches finds runtime  KASLR offset and then calculates run time
>>>>> address of symbols read from vmlinux.
>>>>>
>>>>> Since, I am not an expert of x86, and these patches touch x86 part of
>>>>> makedumpfile, therefore I have CCed x86 experts. Please, provide your
>>>>> review comment and let me know if you think there could have been a better
>>>>> way to resolve this issue.
>>>>>
>>>>> thanks
>>>>>
>>>>> ~Pratyush
>>>>>
>>>>> Pratyush Anand (2):
>>>>>  makedumpfile: add runtime kaslr offset if it exists
>>>>>  x86_64: calculate page_offset in case of re-filtering
>>>>>
>>>>> arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>>>> erase_info.c   |  1 +
>>>>> makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>>> makedumpfile.h | 15 +++++++++++++++
>>>>> 4 files changed, 103 insertions(+), 2 deletions(-)
>>>>>
>>>>> --
>>>>> 2.9.3
>>>>
>>
>>
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
