Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x230.google.com ([2607:f8b0:4003:c01::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXSjw-00087m-2j
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 10:59:20 +0000
Received: by obbgg8 with SMTP id gg8so32538763obb.1
 for <kexec@lists.infradead.org>; Mon, 16 Mar 2015 03:58:58 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 16 Mar 2015 11:58:57 +0100
Message-ID: <CAMuHMdVb47ogpLe_4iSz-NAxdcASUZ2HzTpxh+ibjcdMtiO-tQ@mail.gmail.com>
Subject: kexec fails if OF_UNITTEST=y (was: Re: [PATCH v2] Removes OF_UNITTEST
 dependency on OF_DYNAMIC config symbol)
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
To: Gaurav Minocha <gaurav.minocha.os@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>

On Fri, Jan 23, 2015 at 2:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Jan 11, 2015 at 8:19 AM, Gaurav Minocha
> <gaurav.minocha.os@gmail.com> wrote:
>> This patch intends to remove the unittests dependency on
>> the functions defined in dynamic.c. So, rather than calling
>> of_attach_node defined in dynamic.c, minimal functionality
>> required to attach a new node is re-defined in unittest.c.
>> Also, now after executing the tests the test data is not
>> removed from the device tree so there is no need to call
>> of_detach_node.
>
> Could there be unwanted side effects of not removing the test data?

Unfortunately I found a regression introduced by commit 3ce04b4a9fdc30b6
("Removes OF_UNITTEST dependency on OF_DYNAMIC config symbol").

If the test data is still present, kexec (kexec-tools 2.0.7 released 24
November 2014, 1:2.0.7-5 in Debian) fails with:

unrecoverable error: short read
from"/proc/device-tree//testcase-data/large-property-PAGE_SIZEx8"

Granted, this is a bug in kexec-tools, but I'm reporting it anyway, as it is
a kernel regression with existing userspace.

I believe this bug was fixed in kexec-tools by commit d1932cd592e2a6aa
("kexec/fs2dt: Use slurp_file_len to avoid partial read of files"), but I
haven't tested the fix yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
