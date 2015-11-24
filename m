Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a13fi-0007nE-H6
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 02:49:35 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile-1.5.9: Introduce parallel compression processing.
Date: Tue, 24 Nov 2015 02:48:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E0674F@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7CC4@BPXM01GP.gisp.nec.co.jp>
 <56308618.3080908@canonical.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DF7F43@BPXM01GP.gisp.nec.co.jp>
 <56309A33.4000201@canonical.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E059DD@BPXM01GP.gisp.nec.co.jp>
 <564EF47D.7090202@canonical.com>
In-Reply-To: <564EF47D.7090202@canonical.com>
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>>>>> o Support new kernels - The supported kernel is updated to 4.1 in
>>>>>> this version. At first I'm going to extend the supported version to
>>>>>> 4.2, but I found an issue that makedumpfile seems to exclude
>>>>>> necessary pages by mistake on linux 4.2. When crash-7.1.3 reads
>>>>>> that filtered dump file, the following message is shown.
>>>>>>
>>>>>> crash: page excluded: kernel virtual address: f3fe0000  type:
>>>>>> "fill_task_struct"
>>>>>>
>>>>>> This will be fixed in the next version.
>>>>>
>>>>> Have you fixed the 4.2 kernel issue already or you intend to work on
>>>>> it in the future ?
>>>>
>>>> I haven't done anything yet, I was going to work from now.
>>>>
>>>>> Both Debian and Ubuntu run 4.2 kernel so if waiting for a fix is
>>>>> acceptable I would rather bring in a 1.5.9 + patch version.
>>>>
>>>> So it will be helpful if you can do it.
>>>>
>>>>
>>>> Thanks, Atsushi Kumagai
>>>>
>>>
>>> That is perfect.  Just let me know once you have identified a fix and I
>>> will include it in the new package.
>>
>> I confirmed that there is no problem in makedumpfile, so you don't need to
>> update your makedumpfile packages.
>>
>> That was a crash side issue and the problem is still under discussion. The
>> warning I reported first is going to be solved in the next crash version,
>> but "struct" and "task" commands with task_struct (or some corresponding
>> fields) can fail if a dumpfile of linux 4.2 is filtered.
>>
>> You should see this thread for more details:
>>
>> https://www.redhat.com/archives/crash-utility/2015-November/msg00021.html
>>
>>
>> Thanks, Atsushi Kumagai
>>
>
>As I understand it, 1.5.9 will work fine on 4.2 kernels.  But as the released
>source stand, 1.5.9 only supports up to 4.1.  Should I simply go ahead and
>"manually" add support statement for 4.2 (in README & makedumpfile.h) or you
>prefer to change it in your git tree ?

I've updated the git tree, you can pick up the commit:

commit 1c01d4bfb383c10a97e256f4a6cbf1d92ed133f6
Author: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date:   Tue Nov 24 10:50:07 2015 +0900

    [PATCH] Support newer kernels.

    A new makedumpfile supports newer kernels:

          - 4.2    (x86 FLATMEM)
          - 4.2    (x86 SPARSEMEM)
          - 4.2    (x86_64 SPARSEMEM)

    Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>


Thanks,
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
