Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5X3Y-0003Bs-Av
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 09:23:53 +0000
Received: by mail-vc0-f171.google.com with SMTP id id10so1502362vcb.2
 for <kexec@lists.infradead.org>; Fri, 11 Jul 2014 02:23:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404931759.26155.70.camel@smoke>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
 <1404931759.26155.70.camel@smoke>
Date: Fri, 11 Jul 2014 14:53:29 +0530
Message-ID: <CAFdej00pBJwJBCPR0bYzgqLBSzFbb7LpOydJu=w8Ry4Me=tPow@mail.gmail.com>
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

Finally I am able to get my kernel loaded with the patch below.


diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 894e0e1..bfca40d 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -327,7 +327,7 @@ static int get_memory_ranges_dt(struct
memory_range *array, unsigned int *count)
                        dbgprintf("%s:  RAM: %016llx - %016llx\n", __func__,
                                r.start, r.end);

-                       if (!arm64_mem.memstart || r.start < arm64_mem.memstart)
+                       if ((region->size) && (!arm64_mem.memstart ||
r.start < arm64_mem.memstart))
                                arm64_mem.memstart = r.start;
                }
        }


I suspect it was due to zero sized memory ranges in my dtb followed by the
actual region.

get_memory_ranges_dt: node_1676 memory
get_memory_ranges_dt:  RAM: 0000004000000000 - 0000004400000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000

As a result of that arm64_mem.memstart was getting overwritten with zero.
and I was stuck at the error

kexec: kexec/arch/arm64/kexec-arm64.c:242: virt_to_phys: Assertion
`arm64_mem.memstart' failed.

So check the validity of region before updating the 'memstart'

I will try with kexec -e next.

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
