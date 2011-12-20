Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rcw3Q-0001rO-Tn
 for kexec@lists.infradead.org; Tue, 20 Dec 2011 09:32:14 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2D1C73EE081
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 18:32:06 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 10D7945DEDA
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 18:32:06 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id ECB4045DEEF
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 18:32:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E0A251DB803B
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 18:32:05 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C2831DB8038
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 18:32:05 +0900 (JST)
Date: Tue, 20 Dec 2011 18:31:58 +0900 (   )
Message-Id: <20111220.183158.52163975.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 10/14] Generate and save VMCOREINFO and ELF note
 information
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111220171812.874961f9.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
 <20111028094858.20940.24950.stgit@localhost6.localdomain6>
 <20111220171812.874961f9.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Hello Kumagai-san,

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 10/14] Generate and save VMCOREINFO and ELF note information
Date: Tue, 20 Dec 2011 17:18:12 +0900

> Hi Hatayama-san,
> 
>> [snipped]
>>
>> diff --git a/elf_info.c b/elf_info.c
>> index 114dd05..48f8510 100644
>> --- a/elf_info.c
>> +++ b/elf_info.c
>> @@ -760,7 +760,7 @@ get_nr_cpus(void)
>>  int
>>  has_pt_note(void)
>>  {
>> -	if (offset_pt_note_memory && size_pt_note_memory)
>> +	if (offset_pt_note_memory || size_pt_note_memory)
>>  		return TRUE;
>>  	return FALSE;
>>  }
> 
> I have a question.
> In what kind of case is only one of the offset or the size set to 0 in PT_NOTE?
> 

Thanks for your reviewing.

On sadump processing, offset_pt_note_memory represents file offset to
a temporary file created specifically for writing PT_NOTE section. So
offset_pt_note_memory is always 0. Its file pointer is set to struct
sadump_info::file_elf_note. Please look at the end of
sadump_generate_elf_note_from_dumpfile().

On the other hand, on both ELF and kdump-compressed format, PT_NOTE
section is always located in the middle of the vmcores. On either
formats, there's always another header before the PT_NOTE section: on
ELF, ELF header, and on kdump-compressed format, at least. So
offset_pt_note_memory is always strictly greater than 0 on these
formats.

If condition of has_pt_note() is not weakened in such a way,
has_pt_note() amounts to always false and execution in
write_kdump_header() always passes through writing oepration for
PT_NOTE section.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
