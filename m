Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bnPZ0-0002kB-2S
 for kexec@lists.infradead.org; Fri, 23 Sep 2016 12:26:47 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id u8NCQMn2029356
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 21:26:22 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id u8NCQLg14953 for <kexec@lists.infradead.org>;
 Fri, 23 Sep 2016 21:26:21 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id u8NCQLAX029154
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 21:26:21 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile issues many readpage_elf: Attempt to read
 non-existent page
Date: Fri, 23 Sep 2016 12:04:42 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E6B42E@BPXM01GP.gisp.nec.co.jp>
References: <57E3DCDB.5020308@canonical.com>
In-Reply-To: <57E3DCDB.5020308@canonical.com>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Hello,
>
>I am investigating an issue with makedumpfile and kernel 4.8 where makedumpfile
>(1.6.0) exits on error with the following message :
>
>  get_mem_map: Can't distinguish the memory type.
>
>I found commit 2c21d4656e8d3c2af2b1e14809d076941ae69e96 in the upstream
>development branch that is supposed to fix this :
>
>[PATCH v2] Support _count -> _refcount rename in struct page
>
>    _count member was renamed to _refcount in linux commit 0139aa7b7fa12
>    ("mm: rename _count, field of the struct page, to _refcount") and this
>    broke makedumpfile. The reason for making the change was to find all users
>    accessing it directly and not through the recommended API. I tried
>    suggesting to revert the change but failed, I see no other choice than to
>    start supporting both _count and _refcount in makedumpfile.
>
>Though, when I apply the patch and test on either Ubuntu's 4.8.0-11 kernel, or
>kernel.org's mainline 4.8.0-040800rc7 kernel, I get the following repeated
>multiple times :
>
>> makedumpfile -c -d 31 /proc/vmcore /var/crash/201609221517/dump-incomplete
>> [    7.513337] kdump-tools[715]: readpage_elf: Attempt to read non-existent page at 0x134dfff78000.
>> [    7.524186] kdump-tools[715]: readmem: type_addr: 0, addr:ffff9b4dfff78000, size:16
>> [    7.528440] kdump-tools[715]: section_mem_map_addr: Can't get a struct mem_section(ffff9b4dfff78000).
>> [    7.536562] kdump-tools[715]: readpage_elf: Attempt to read non-existent page at 0x134dfff78000.
>> [    7.544356] kdump-tools[715]: readmem: type_addr: 0, addr:ffff9b4dfff78010, size:16
>> [    7.552422] kdump-tools[715]: section_mem_map_addr: Can't get a struct mem_section(ffff9b4dfff78010).
>> [    7.560317] kdump-tools[715]: readpage_elf: Attempt to read non-existent page at 0x134dfff78000.
>> [    7.568422] kdump-tools[715]: readmem: type_addr: 0, addr:ffff9b4dfff78020, size:16
>> [    7.572296] kdump-tools[715]: section_mem_map_addr: Can't get a struct mem_section(ffff9b4dfff78020).
>
>I also tested with all the commits in the upstream/development branch with no
>luck, I still get the same behavior.
>
>Does someone have an idea of where this could come from ?

Thanks for your report, but I'm afraid that I'm going on
vacation till Oct 2.
I hope someone helps you until I'm back.


Regards,
Atsushi Kumagai

>TIA,
>
>Louis
>--
>Louis Bouchard
>Software engineer, Cloud & Sustaining eng.
>Canonical Ltd
>Ubuntu developer                       Debian Maintainer
>GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
