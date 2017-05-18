Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBGMy-0003AR-Dy
 for kexec@lists.infradead.org; Thu, 18 May 2017 08:01:14 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: Help regarding renaming of vmcore-incomplete to vmcore
Date: Thu, 18 May 2017 07:58:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701ED8CD2@BPXM01GP.gisp.nec.co.jp>
References: <CAAhEX+KVeHHNucs6tZwvwFD9QXNptj1-1fih=seu8uRdB6S13w@mail.gmail.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC8190@BPXM01GP.gisp.nec.co.jp>
 <CAAhEX+KCL=y+KhCMsEiTqN=prEZDDZb=37LdWvReLoyEmUiChg@mail.gmail.com>
In-Reply-To: <CAAhEX+KCL=y+KhCMsEiTqN=prEZDDZb=37LdWvReLoyEmUiChg@mail.gmail.com>
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
To: Dumslicer Halo <dumslicer@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>I can't find this file in my system? Can you help me with it?

In the first place, I don't know how you got core dump and what
kind of environment you tested with, so it's difficult to give
pointed advice.

If you explain what you did in order from first in detail,
I could be of your help.

Thanks,
Atsushi Kumagai

>On 8 May 2017 at 07:11, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:
>> Hello,
>>
>>>Hi I am a university student, and have made some changes to
>>>makedumpfile to produce a gzipped output of core dump. The issue I'm
>>>facing is that the output i get from makedumpfile (after it completes
>>>successfully) is vmcore-incomplete.gzip.
>>>
>>>But this file is not being renamed to vmcore.gzip (even thought the
>>>dump the complete as I verified it by loading into CRASH utility). Can
>>>someone please point out to me the changes I should make to solve this
>>>bug (or  can point to the code where this renaming is done).
>>
>> makedumpfile doesn't have such renaming mechanism, it just name the dump
>> as user specify. I guess "vmcore-incomplete" you said is came from kexec-tools.
>> For example, kexec-tools of RHEL7 generate the code below for dump-capture kernel:
>>
>>    110     echo "kdump: saving vmcore"
>>    111     $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete || return 1
>>    112     mv $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore
>>    113     sync
>>
>> $CORE_COLLECTOR is makedumpfile, so the code generate "vmcore-incomplete"
>> by makedumpfile and rename it to vmcore by mv.
>> If you want "vmcore.gzip", you should just specify vmcore.gzip for
>> makedumpfile.
>>
>>
>> Thanks,
>> Atsushi Kumagai
>>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
