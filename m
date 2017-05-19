Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBY1a-0003zf-Ez
 for kexec@lists.infradead.org; Fri, 19 May 2017 02:52:20 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Error on re-filtering the dump file with
 no free pages
Date: Fri, 19 May 2017 02:35:40 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701ED9104@BPXM01GP.gisp.nec.co.jp>
References: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED89ED@BPXM01GP.gisp.nec.co.jp>
 <20170518140254.3db3f205@TP-holzheu>
In-Reply-To: <20170518140254.3db3f205@TP-holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>

>> Hello Zaslonko,
>>
>> > When re-filtering the dump file after the free pages have already been
>> > stripped out we get an error "Can't get necessary symbols for excluding
>> > free pages" if newly specified dump level is below 16 (preserves free
>> > pages).
>> > According to the code, the check for the new dump level is done BEFORE
>> > the new dump level is actually set (based on the dump level specified in
>> > the command and the one from the input dump file).
>> > Moving the new_dump_level calculation ahead would fix the error.
>>
>> Well, I guess the real problem is different.
>> The error you said is printed by exclude_free_page():
>>
>>         if ((SYMBOL(node_data) == NOT_FOUND_SYMBOL)
>>             && (SYMBOL(pgdat_list) == NOT_FOUND_SYMBOL)
>>             && (SYMBOL(contig_page_data) == NOT_FOUND_SYMBOL)) {
>>                 ERRMSG("Can't get necessary symbols for excluding free pages.\n");
>>                 return FALSE;
>>         }
>>
>> I think the availability of these symbols are not related to free pages.
>> exclude_free_page() is called if info->page_is_buddy is null, I estimate that
>> this situation occurs only if the kernel is older(2.6.16 or before).
>>
>> However, I don't think you use such too old kernel, so I suspect that
>> setup_page_is_buddy() should be updated for newer kernel.
>
>Mikhail is on vacation now - so I try to explain:

Thanks for your explanation, I understand this issue properly.

>The test case is as follows:
>
> 1) We have a -d31 filtered dump "dump.d31"
> 2) We want to compress the dump with "makedumpfile -c dump.31 dump31.compressed"
>
>This fails with:
>
>makedumpfile -c dump.31 dump.31.compressed
>Excluding unnecessary pages        : [100.0 %]
>exclude_free_page: Can't get necessary symbols for excluding free pages.
>dump_level is changed to 31, because dump.31 was created by dump_level(31).
>makedumpfile Failed.
>
>The problem is that setup_page_is_buddy() is not called in this case because
>info->dump_level is still 0 since it was not adjusted early enough:
>
>        if (info->dump_level & DL_EXCLUDE_FREE)
>                setup_page_is_buddy();
>
>Because it is not set info->page_is_buddy is NULL and therefore the following
>if condition gets true:
>
>        if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
>                if (!exclude_free_page(cycle))
>                        return FALSE;
>
>Since we don't have the symbols in VMCOREINFO (and IMHO don't need it?) the
>exclude_free_page() functions fails with the described error message.

It seems that it's better if I update the condition check of exclude_free_page()
for recent kernels, but those symbols are unnecessary in this case as you thought
anyway. exclude_free_page() shouldn't be called for recent kernels, I don't think
this is an actual problem.

>So our fix is to adjust the info->level before setup_page_is_buddy() is called.

I'm sure this fix is reasonable, I'll merge this into v1.6.2.

Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
