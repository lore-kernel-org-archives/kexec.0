Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLprR-0005zU-Op
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 08:10:31 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: Fix string append in dump_log_entry()
Date: Fri, 7 Mar 2014 08:08:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F3A9A@BPXM01GP.gisp.nec.co.jp>
References: <20140226220546.4030cdbf@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE971EF130@BPXM01GP.gisp.nec.co.jp>
 <20140304151814.55a3d687@hananiah.suse.cz>
In-Reply-To: <20140304151814.55a3d687@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> Hello Petr,
>
>Hello Kumagai-san,
>
>> >To quote the sprintf(3) man page:
>> >
>> >    Some programs imprudently rely on code such as the following
>> >
>> >        sprintf(buf, "%s some further text", buf);
>> >
>> >    to append text to buf.  However, the standards explicitly note that
>> >    the results are undefined if source and destination buffers overlap
>> >    when calling sprintf(), snprintf(), vsprintf(), and vsnprintf().
>> >    Depending on the version of gcc(1) used, and the compiler options
>> >    employed, calls such as the above will not produce the expected results.
>> >
>> >The original code is actually miscompiled on openSUSE 13.1.
>> >
>> >It's also overkill to call sprintf() for something that can be done
>> >with a simple assignment.
>> >
>> >Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>>
>> Thanks, it seems good to me.
>>
>> Actually, Nick sent the same patch in last July and we tried to
>> take care of buffer overflow at the same time as below:
>>
>> http://lists.infradead.org/pipermail/kexec/2013-August/009430.html
>>
>> However, this thread has been left open, so I was wondering if you
>> could take over this work. Of course you can decline this, then I'll
>> do it later as another patch.
>
>I don't mind taking over this work, but I don't think it's a good thing
>to combine the buffer overflow fix with the sprintf buffer overlap
>fix.
>
>What is the expected plan? Are you waiting for me to send a two-patch
>series now?

Yes, I agree with separating the two fixes.
Thanks for your help !


Atsushi Kumagai

>Petr Tesarik
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
