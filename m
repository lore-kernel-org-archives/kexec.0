Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d96jJ-0001HB-C7
 for kexec@lists.infradead.org; Fri, 12 May 2017 09:19:22 +0000
Received: by mail-vk0-x22d.google.com with SMTP id g23so14701122vke.3
 for <kexec@lists.infradead.org>; Fri, 12 May 2017 02:19:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EC8190@BPXM01GP.gisp.nec.co.jp>
References: <CAAhEX+KVeHHNucs6tZwvwFD9QXNptj1-1fih=seu8uRdB6S13w@mail.gmail.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC8190@BPXM01GP.gisp.nec.co.jp>
From: Dumslicer Halo <dumslicer@gmail.com>
Date: Fri, 12 May 2017 14:48:58 +0530
Message-ID: <CAAhEX+KCL=y+KhCMsEiTqN=prEZDDZb=37LdWvReLoyEmUiChg@mail.gmail.com>
Subject: Re: Help regarding renaming of vmcore-incomplete to vmcore
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

I can't find this file in my system? Can you help me with it?

On 8 May 2017 at 07:11, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:
> Hello,
>
>>Hi I am a university student, and have made some changes to
>>makedumpfile to produce a gzipped output of core dump. The issue I'm
>>facing is that the output i get from makedumpfile (after it completes
>>successfully) is vmcore-incomplete.gzip.
>>
>>But this file is not being renamed to vmcore.gzip (even thought the
>>dump the complete as I verified it by loading into CRASH utility). Can
>>someone please point out to me the changes I should make to solve this
>>bug (or  can point to the code where this renaming is done).
>
> makedumpfile doesn't have such renaming mechanism, it just name the dump
> as user specify. I guess "vmcore-incomplete" you said is came from kexec-tools.
> For example, kexec-tools of RHEL7 generate the code below for dump-capture kernel:
>
>    110     echo "kdump: saving vmcore"
>    111     $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete || return 1
>    112     mv $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore
>    113     sync
>
> $CORE_COLLECTOR is makedumpfile, so the code generate "vmcore-incomplete"
> by makedumpfile and rename it to vmcore by mv.
> If you want "vmcore.gzip", you should just specify vmcore.gzip for
> makedumpfile.
>
>
> Thanks,
> Atsushi Kumagai
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
