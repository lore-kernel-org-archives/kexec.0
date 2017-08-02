Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dcoyc-0001DY-Lx
 for kexec@lists.infradead.org; Wed, 02 Aug 2017 08:26:07 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: x86: Take care of init_level4_pgt rename
 in kernel
Date: Wed, 2 Aug 2017 08:14:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF5E93@BPXM01GP.gisp.nec.co.jp>
References: <b5a4b87480473137478313355b0a6fd9f197f945.1501432848.git.panand@redhat.com>
 <20170731023838.GA7947@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF57F4@BPXM01GP.gisp.nec.co.jp>
 <5d126fad-5ccf-7fd8-1bf2-29675ac0d75e@redhat.com>
In-Reply-To: <5d126fad-5ccf-7fd8-1bf2-29675ac0d75e@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Hi Atsushi,
>
>Thanks for the review.
>
>On Tuesday 01 August 2017 01:11 PM, Atsushi Kumagai wrote:
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
>>>>   	SYMBOL_INIT(_stext, "_stext");
>>>>   	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
>>>>   	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
>>>> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>>>> +		SYMBOL_INIT(init_level4_pgt, "init_top_pgt");
>>>>   	SYMBOL_INIT(vmlist, "vmlist");
>>>>   	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
>>>>   	SYMBOL_INIT(node_online_map, "node_online_map");
>>>> @@ -2104,7 +2106,10 @@ write_vmcoreinfo_data(void)
>>>>   	WRITE_SYMBOL("init_uts_ns", init_uts_ns);
>>>>   	WRITE_SYMBOL("_stext", _stext);
>>>>   	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>>>> -	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>>>> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>>>> +		WRITE_SYMBOL("init_top_pgt", init_level4_pgt);
>>>> +	else
>>>> +		WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>>
>> Whether the source is init_level4_pgt or init_top_pgt, the value will
>> be kept as SYMBOL(init_level4_pgt), so this conditional judgment is meaningless.
>
>IIUC,we will have above if condition true for v4.13 kernel and false for older
>kernel, right? Now, if keep the name "init_level4_pgt" in a vmcore generated
>for v4.13, would that be good, even though that would work conceptually?

SYMBOL(init_level4_pgt) should always have a valid address since it will be
initialized by the code you write as below:

	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
		SYMBOL_INIT(init_level4_pgt, "init_top_pgt");

SYMBOL(init_level4_pgt) will have the address of init_top_pgt in v4.13 and
it will have the address of init_level4_pgt in older kernel.

>I thought that generated vmcoreinfo from vmlinux should look like as being
>encoded into kernel, so same name of symbol as in kernel.

Yes, it's polite if the vmcoreinfo file has the original symbol name,
but it's not necessary since the file is only for makedumpfile itself.
In v4.13, the address of init_top_pgt will be saved into the vmcoreinfo file
as SYMBOL(init_level4_pg), but it shouldn't be a problem.

>>>> I think what you want to do is like commit: ed46b6ad9, but I don't want to
>>>> introduce a new flag every time a symbol name is changed. So how about
>>>> unification into "init_level4_pgt" for backward compatibility ?
>>>> The old name can be read in all versions of makedumpfile.
>>>
>>
>> Still not sure, it it will be a good idea to have  "init_level4_pgt" in newer
>> generated vmcoreinfo ...
>
>So, what is the suggestion?
>Introduce a new variable like commit: ed46b6ad9 or keep symbol of
>"init_level4_pgt" in generated vmcoreinfo for all kernels?

My opinion is the latter. I can't find the reason to keep the original 
symbol name in the vmcoreinfo file even at the cost of adding extra code.


Thanks,
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
