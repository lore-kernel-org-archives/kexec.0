Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dcSO1-0003Po-Gb
 for kexec@lists.infradead.org; Tue, 01 Aug 2017 08:18:47 +0000
Received: by mail-pg0-f50.google.com with SMTP id y129so5048085pgy.4
 for <kexec@lists.infradead.org>; Tue, 01 Aug 2017 01:18:20 -0700 (PDT)
Subject: Re: [PATCH] makedumpfile: x86: Take care of init_level4_pgt rename in
 kernel
From: Pratyush Anand <panand@redhat.com>
References: <b5a4b87480473137478313355b0a6fd9f197f945.1501432848.git.panand@redhat.com>
 <20170731023838.GA7947@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF57F4@BPXM01GP.gisp.nec.co.jp>
 <5d126fad-5ccf-7fd8-1bf2-29675ac0d75e@redhat.com>
Message-ID: <03231128-333a-7c06-b3b9-9f7056af65be@redhat.com>
Date: Tue, 1 Aug 2017 13:48:16 +0530
MIME-Version: 1.0
In-Reply-To: <5d126fad-5ccf-7fd8-1bf2-29675ac0d75e@redhat.com>
Content-Language: en-US
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
Cc: Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Tuesday 01 August 2017 01:29 PM, Pratyush Anand wrote:
> Hi Atsushi,
> 
> Thanks for the review.
> 
> On Tuesday 01 August 2017 01:11 PM, Atsushi Kumagai wrote:
>> Hello Pratyush,
>>
>> Thanks for your work.
>>
>>> On 07/30/17 at 10:11pm, Pratyush Anand wrote:
>>>> Following commit renamed init_level4_pgt to init_top_pgt in kernel.
>>>>
>>>> commit 65ade2f872b474fa8a04c2d397783350326634e6
>>>> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Date:   Tue Jun 6 14:31:27 2017 +0300
>>>>
>>>>      x86/boot/64: Rename init_level4_pgt and early_level4_pgt
>>>>
>>>> This patch takes care of above kernel modification in makedumpfile.
>>>>
>>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>>> ---
>>>>   makedumpfile.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>>> index f85003a33551..e875f4bb539e 100644
>>>> --- a/makedumpfile.c
>>>> +++ b/makedumpfile.c
>>>> @@ -1486,6 +1486,8 @@ get_symbol_info(void)
>>>>       SYMBOL_INIT(_stext, "_stext");
>>>>       SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
>>>>       SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
>>>> +    if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>>>> +        SYMBOL_INIT(init_level4_pgt, "init_top_pgt");
>>>>       SYMBOL_INIT(vmlist, "vmlist");
>>>>       SYMBOL_INIT(vmap_area_list, "vmap_area_list");
>>>>       SYMBOL_INIT(node_online_map, "node_online_map");
>>>> @@ -2104,7 +2106,10 @@ write_vmcoreinfo_data(void)
>>>>       WRITE_SYMBOL("init_uts_ns", init_uts_ns);
>>>>       WRITE_SYMBOL("_stext", _stext);
>>>>       WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>>>> -    WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>>>> +    if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>>>> +        WRITE_SYMBOL("init_top_pgt", init_level4_pgt);
>>>> +    else
>>>> +        WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>>
>> Whether the source is init_level4_pgt or init_top_pgt, the value will
>> be kept as SYMBOL(init_level4_pgt), so this conditional judgment is 
>> meaningless.
> 

Probably you meant that we read old and new symbol in SYMBOL(init_level4_pgt), 
so the above if statement will always be false, right?

Hummm..in that case vmcoreinfo will have bad info.

> IIUC,we will have above if condition true for v4.13 kernel and false for older 
> kernel, right? Now, if keep the name "init_level4_pgt" in a vmcore generated 
> for v4.13, would that be good, even though that would work conceptually?
> 
> I thought that generated vmcoreinfo from vmlinux should look like as being 
> encoded into kernel, so same name of symbol as in kernel.
> 
>>
>> I think what you want to do is like commit: ed46b6ad9, but I don't want to
>> introduce a new flag every time a symbol name is changed. So how about
>> unification into "init_level4_pgt" for backward compatibility ?
>> The old name can be read in all versions of makedumpfile.
> 

Still not sure, it it will be a good idea to have  "init_level4_pgt" in newer 
generated vmcoreinfo ...

> I agree, and so I kept "init_level4_pgt" for internal usage of makedumpfile. 
> But, IMHO any output file (like generated vmcoreinfo with -g) should have 
> matching kernel symbol.

-- 
Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
