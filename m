Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTQxA-0006Y3-8H
 for kexec@lists.infradead.org; Sat, 30 Jul 2016 09:53:09 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Add more descriptions of multi-threads
 feature
Date: Sat, 30 Jul 2016 09:49:50 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E59336@BPXM01GP.gisp.nec.co.jp>
References: <1469763242-2221-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160730010538.GA2583@x1.redhat.com>
In-Reply-To: <20160730010538.GA2583@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello, 

>On 07/29/16 at 11:34am, Zhou Wenjian wrote:
>> It will have a bad performance if the threads number is larger than
>> the usable cpu number. So we should remind user of it.
>>
>> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>
>It makes sense to tell people who use option "-num-threads".
>Ack it.
>
>Acked-by: Baoquan He <bhe@redhat.com>

Looks good to me, I'll merge this into v1.6.1.

Thanks,
Atsushi Kumagai

>> ---
>>  makedumpfile.8 | 2 ++
>>  print_info.c   | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/makedumpfile.8 b/makedumpfile.8
>> index 3b6f7e2..f74abea 100644
>> --- a/makedumpfile.8
>> +++ b/makedumpfile.8
>> @@ -376,6 +376,8 @@ the kdump\-compressed format.
>>  \fB\-\-num\-threads\fR \fITHREADNUM\fR
>>  Using multiple threads to read and compress data of each page in parallel.
>>  And it will reduces time for saving \fIDUMPFILE\fR.
>> +Note that if the usable cpu number is less than the thread number, it may
>> +lead to great performance degradation.
>>  This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
>>  format from \fIVMCORE\fR in kdump\-compressed format or elf format.
>>  .br
>> diff --git a/print_info.c b/print_info.c
>> index 1a9f70c..2fbfb12 100644
>> --- a/print_info.c
>> +++ b/print_info.c
>> @@ -200,6 +200,8 @@ print_usage(void)
>>  	MSG("  [--num-threads THREADNUM]:\n");
>>  	MSG("      Using multiple threads to read and compress data of each page in parallel.\n");
>>  	MSG("      And it will reduces time for saving DUMPFILE.\n");
>> +	MSG("      Note that if the usable cpu number is less than the thread number, it may\n");
>> +	MSG("      lead to great performance degradation.\n");
>>  	MSG("      This feature only supports creating DUMPFILE in kdump-comressed format from\n");
>>  	MSG("      VMCORE in kdump-compressed format or elf format.\n");
>>  	MSG("\n");
>> --
>> 1.8.3.1
>>
>>
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
