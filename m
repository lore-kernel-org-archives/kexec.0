Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1404931759.26155.70.camel@smoke>
Subject: Re: Kexec on arm64
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Jul 2014 11:49:19 -0700
In-Reply-To: <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
Mime-Version: 1.0
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
To: Arun Chandran <achandran@mvista.com>
Cc: kexec@lists.infradead.org

Hi Arun,

On Wed, 2014-07-09 at 19:28 +0530, Arun Chandran wrote:
> After copying the resulting binaries to my target; I tried loading the
> kernel Image
> 
> # kexec -l /Image
> Modified cmdline: root=/dev/nfs
> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
> from purgatory is diabled
> Cannot determine the file type of /Image
> 
> It failed to load the kernel Image. Any pointers?

My kexec-tools [1] only supports loading of arm64 elf files, so
vmlinux, or a stripped version of it.  Image is a raw binary, and
is not yet supported.

Maybe something like this is what you need:

 ./kexec -d --load /boot/vmlinux.strip --append="console=ttyAMA0 earlyprintk=pl011,0x1c090000 root=/dev/vda rw --verbose" --dtb=/boot/fdt.dtb
 ./kexec -d -e

Also, my current master branch will only work reliably with PSCI
boot.  Spin-table boot has a bug and will be unstable for the next
few days.  Spin-table will re-boot, but only the primary cpu will
come up.

[1] https://git.linaro.org/people/geoff.levand/kexec-tools.git
 https://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
