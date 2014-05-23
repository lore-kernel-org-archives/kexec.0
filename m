Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wnjmw-0006gr-Rh
 for kexec@lists.infradead.org; Fri, 23 May 2014 07:21:11 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Date: Fri, 23 May 2014 07:18:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97213537@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
 <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
 <20140509204924.GA9918@redhat.com>
 <20140515072249.GA2170@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972110ED@BPXM01GP.gisp.nec.co.jp>
 <20140519111538.GD1661@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140519111538.GD1661@dhcp-16-116.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hello Bao,

>Hi Astushi,
>
>> No, 16MB was used for bitmaps also in my case.
>> --cyclic-buffer option means specifying each bitmap size, so allocated bitmap
>> size is the double of --cyclic-buffer.
>> (But now, this behavior is only for ELF case, just the specified size is allocated
>> in kdump case. Yes, it's confusing...)
>>
>>        --cyclic-buffer buffer_size
>>               Specify the buffer size in kilo bytes for analysis in the cyclic
>>               mode.  Actually, the double of buffer_size kilo  bytes  will  be
>>               allocated  in  memory.  In the cyclic mode, the number of cycles
>>               is represented as:
>
>
>Yeah, I was wrong about this. If specified --cyclic-buffer doesn't
>exceed the memory limit, it is equal to info->bufsize_cyclic. But for
>elf dump, it need be double. E.g if free memory is 30M, --cyclic-buffer
>is 16M, it will absolutely fail. But the code check here should be done
>separately. Since it's meaningless for elf dump if 2 x --cyclic-buffer
>exceeds the free memory.
>
>	if (info->bufsize_cyclic > free_memory) {
>	.......
>	{
>
>I think code here need be changed.

Exactly, this is a bug.
I can fix it simply by modification to the check above, but I think it's
better to change the ELF path to get rid of the 1st bitmap buffer since it's
unused. Then the required buffer size will be just <--cyclic-buffer> in both
cases, so I'll post the patch to do it later.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
