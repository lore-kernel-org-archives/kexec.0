Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dcRtM-0002G0-7J
 for kexec@lists.infradead.org; Tue, 01 Aug 2017 07:47:02 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: x86: Take care of init_level4_pgt rename
 in kernel
Date: Tue, 1 Aug 2017 07:41:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF57F4@BPXM01GP.gisp.nec.co.jp>
References: <b5a4b87480473137478313355b0a6fd9f197f945.1501432848.git.panand@redhat.com>
 <20170731023838.GA7947@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20170731023838.GA7947@dhcp-128-65.nay.redhat.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>

Hello Pratyush,

Thanks for your work.

>On 07/30/17 at 10:11pm, Pratyush Anand wrote:
>> Following commit renamed init_level4_pgt to init_top_pgt in kernel.
>>
>> commit 65ade2f872b474fa8a04c2d397783350326634e6
>> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Date:   Tue Jun 6 14:31:27 2017 +0300
>>
>>     x86/boot/64: Rename init_level4_pgt and early_level4_pgt
>>
>> This patch takes care of above kernel modification in makedumpfile.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>  makedumpfile.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index f85003a33551..e875f4bb539e 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -1486,6 +1486,8 @@ get_symbol_info(void)
>>  	SYMBOL_INIT(_stext, "_stext");
>>  	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
>>  	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
>> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>> +		SYMBOL_INIT(init_level4_pgt, "init_top_pgt");
>>  	SYMBOL_INIT(vmlist, "vmlist");
>>  	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
>>  	SYMBOL_INIT(node_online_map, "node_online_map");
>> @@ -2104,7 +2106,10 @@ write_vmcoreinfo_data(void)
>>  	WRITE_SYMBOL("init_uts_ns", init_uts_ns);
>>  	WRITE_SYMBOL("_stext", _stext);
>>  	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>> -	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>> +		WRITE_SYMBOL("init_top_pgt", init_level4_pgt);
>> +	else
>> +		WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);

Whether the source is init_level4_pgt or init_top_pgt, the value will
be kept as SYMBOL(init_level4_pgt), so this conditional judgment is meaningless.

I think what you want to do is like commit: ed46b6ad9, but I don't want to
introduce a new flag every time a symbol name is changed. So how about
unification into "init_level4_pgt" for backward compatibility ?
The old name can be read in all versions of makedumpfile.


Thanks,
Atsushi Kumagai

>>  	WRITE_SYMBOL("vmlist", vmlist);
>>  	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
>>  	WRITE_SYMBOL("node_online_map", node_online_map);
>> @@ -2500,6 +2505,8 @@ read_vmcoreinfo(void)
>>  	READ_SYMBOL("_stext", _stext);
>>  	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>>  	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
>> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL)
>> +		READ_SYMBOL("init_top_pgt", init_level4_pgt);
>>  	READ_SYMBOL("vmlist", vmlist);
>>  	READ_SYMBOL("vmap_area_list", vmap_area_list);
>>  	READ_SYMBOL("node_online_map", node_online_map);
>> --
>> 2.9.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
>Tested-by: Dave Young <dyoung@redhat.com>
>
>Thanks
>Dave
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
