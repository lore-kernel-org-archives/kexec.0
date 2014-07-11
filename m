Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5Yyq-0005o8-2E
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 11:27:08 +0000
Received: by mail-vc0-f179.google.com with SMTP id id10so1739904vcb.10
 for <kexec@lists.infradead.org>; Fri, 11 Jul 2014 04:26:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404931759.26155.70.camel@smoke>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
 <1404931759.26155.70.camel@smoke>
Date: Fri, 11 Jul 2014 16:56:45 +0530
Message-ID: <CAFdej00cCymXM1wu31X7p6_Njy9sL-c7+k-v-+5jrmAuozsMng@mail.gmail.com>
Subject: Re: Kexec on arm64
From: Arun Chandran <achandran@mvista.com>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Hi Geoff,

This is a minor "NULL check" issue in the code.

kexec fails to load, without kernel command line option (--append).

The below code fixes that issue (missing null check.

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 894e0e1..0ca0df4 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -135,8 +135,10 @@ int arm64_load_other_segments(struct kexec_info *info)

        /* Processing for arm64_opts.dtb and arm64_opts.command_line. */

-       strncpy(command_line, arm64_opts.command_line, sizeof(command_line));
-       command_line[sizeof(command_line) - 1] = 0;
+       if (arm64_opts.command_line != NULL) {
+               strncpy(command_line, arm64_opts.command_line,
sizeof(command_line));
+               command_line[sizeof(command_line) - 1] = 0;
+       }


--Arun







On Thu, Jul 10, 2014 at 12:19 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Wed, 2014-07-09 at 19:28 +0530, Arun Chandran wrote:
>> After copying the resulting binaries to my target; I tried loading the
>> kernel Image
>>
>> # kexec -l /Image
>> Modified cmdline: root=/dev/nfs
>> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
>> from purgatory is diabled
>> Cannot determine the file type of /Image
>>
>> It failed to load the kernel Image. Any pointers?
>
> My kexec-tools [1] only supports loading of arm64 elf files, so
> vmlinux, or a stripped version of it.  Image is a raw binary, and
> is not yet supported.
>
> Maybe something like this is what you need:
>
>  ./kexec -d --load /boot/vmlinux.strip --append="console=ttyAMA0 earlyprintk=pl011,0x1c090000 root=/dev/vda rw --verbose" --dtb=/boot/fdt.dtb
>  ./kexec -d -e
>
> Also, my current master branch will only work reliably with PSCI
> boot.  Spin-table boot has a bug and will be unstable for the next
> few days.  Spin-table will re-boot, but only the primary cpu will
> come up.
>
> [1] https://git.linaro.org/people/geoff.levand/kexec-tools.git
>  https://git.linaro.org/people/geoff.levand/linux-kexec.git
>
> -Geoff
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
