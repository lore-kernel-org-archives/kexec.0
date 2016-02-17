Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aVx5q-0007hQ-E7
 for kexec@lists.infradead.org; Wed, 17 Feb 2016 08:04:15 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 3/3] makedumpfile: Rewrite readpage_elf
Date: Wed, 17 Feb 2016 07:58:10 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E1F5F6@BPXM01GP.gisp.nec.co.jp>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210085009.4df4d14d@hananiah.suse.cz> <20160210221817.GJ382@ycc.fr>
In-Reply-To: <20160210221817.GJ382@ycc.fr>
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
To: Ivan Delalande <colona@arista.com>, Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>

>On Wed, Feb 10, 2016 at 08:50:09AM +0100, Petr Tesarik wrote:
>> The current code in readpage_elf (and readpage_elf_parallel) is extremely
>> hard to follow. Additionally, it still does not cover all possible cases.
>> For example, attempts to read outside of any ELF segment will end up with
>> phys_start being 0, frac_head a negative number, interpreted as a large
>> positive number by memset() and write past buffer end.
>>
>> Instead of trying to handle even more "corner cases", I rewrote the
>> algorithm from scratch. The basic idea is simple: set a goal to fill the
>> page buffer with data, then work towards that goal by:
>>
>>   - filling holes with zeroes (see Note below),
>>   - p_filesz portions with file data and
>>   - remaining p_memsz portions again with zeroes.
>>
>> Repeat this method for each LOAD until the goal is achieved, or an error
>> occurs. In most cases, the loop runs only once.
>>
>> Note: A "hole" is data at a physical address that is not covered by any
>> ELF LOAD program header. In other words, the ELF file does not specify
>> any data for such a hole (not even zeroes). So, why does makedumpfile
>> fill them with zeroes? It's because makedumpfile works with page
>> granularity (the compressed format does not even have a way to store
>> a partial page), so if only part of a page is stored, a complete page
>> must be provided to make this partial data accessible.
>>
>> Credits to Ivan Delalande <colona@arista.com> who first found the
>> problem and wrote the original fix.
>>
>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>
>Tested-by: Ivan Delalande <colona@arista.com>
>
>Dump-dmesg works well and gives the expected results with our various
>setups (x86_64 only). Thanks for your work Petr!

Thanks for your great work, Petr and Ivan.
I'll merge this patch set into v1.6.0.


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
