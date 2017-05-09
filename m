Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d7uxt-0007Oi-Jl
 for kexec@lists.infradead.org; Tue, 09 May 2017 02:33:31 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH] elf_info: fix file_size if segment is
 excluded
Date: Tue, 9 May 2017 02:29:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EC87C4@BPXM01GP.gisp.nec.co.jp>
References: <67b01a34efb197a9bafe002dd9775bc094d8bd6e.1494247220.git.panand@redhat.com>
 <7FA68CAA-173B-4988-A0E3-83DE747422FC@redhat.com>
In-Reply-To: <7FA68CAA-173B-4988-A0E3-83DE747422FC@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pratyush,

Thanks for your report, I have just one question.

>> exclude_segment() is called for Crash Kernel whose range is
>> 2b000000-350fffff.
>>
>> We see following after exclude_segment()
>>
>> LOAD (2)
>>  phys_start : 100000
>>  phys_end   : 2affffff
>>  virt_start : ffff8a5a40100000
>>  virt_end   : ffff8a5a6affffff
>>  file_offset: a5a40102000
>>  file_size  : dfefd000
>> LOAD (3)
>>  phys_start : 35100000
>>  phys_end   : dfffd000
>>  virt_start : ffff8a5a75100000
>>  virt_end   : ffff8a5b1fffd000
>>  file_offset: a5a75102000
>>  file_size  : 0
>>
>> Since file_size is calculated wrong therefore readpage_elf() does not
>> behave correctly.
>>
>> This patch fixes above wrong behavior.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>> elf_info.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/elf_info.c b/elf_info.c
>> index 8e2437622141..6bf5e3373595 100644
>> --- a/elf_info.c
>> +++ b/elf_info.c
>> @@ -826,9 +826,12 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
>>                temp_seg.virt_end = vend;
>>                temp_seg.file_offset = (*pt_loads)[i].file_offset
>>                    + temp_seg.virt_start - (*pt_loads)[i].virt_start;
>> +                temp_seg.file_size = temp_seg.phys_end
>> +                    - temp_seg.phys_start;
>>
>>                (*pt_loads)[i].virt_end = kvstart - 1;
>>                (*pt_loads)[i].phys_end =  start - 1;
>> +                (*pt_loads)[i].file_size -= temp_seg.file_size;

I think we should additionally subtract (end - start), right ? 
This code seems to leave Crash Kernel region for the former half of PT_LOAD.

Thanks,
Atsushi Kumagai

>>                tidx = i+1;
>>            } else if (kvstart != vstart) {
>> --
>> 2.9.3
>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
