Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVIeQ-0001WW-L1
 for kexec@lists.infradead.org; Tue, 19 Jun 2018 15:34:37 +0000
Date: Tue, 19 Jun 2018 17:34:13 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm64: Add support to supply 'kaslr-seed' to
 secondary kernel
Message-ID: <20180619153413.i5laoxvhj4d52kex@verge.net.au>
References: <1524733052-3276-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNrpJXSnRhxvnvXVshp7FvnPqm-idW6v540K0oMEt5_ng@mail.gmail.com>
 <40ef0d33-a4c8-6cee-af15-e81eef7b1cf4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40ef0d33-a4c8-6cee-af15-e81eef7b1cf4@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

On Mon, Jun 18, 2018 at 11:26:11AM +0530, Bhupesh Sharma wrote:
> Hello Simon,
> 
> On 05/15/2018 12:50 PM, Bhupesh Sharma wrote:
> > Hello Akashi,
> > 
> > On Thu, Apr 26, 2018 at 2:27 PM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > > This patch adds the support to supply 'kaslr-seed' to secondary kernel,
> > > when we do a 'kexec warm reboot to another kernel' (although the
> > > behaviour remains the same for the 'kdump' case as well) on arm64
> > > platforms using the 'kexec_load' invocation method.
> > > 
> > > Lets consider the case where the primary kernel working on the arm64
> > > platform supports kaslr (i.e 'CONFIG_RANDOMIZE_BASE' was set to y and
> > > we have a compliant EFI firmware which supports EFI_RNG_PROTOCOL and
> > > hence can pass a non-zero (valid) seed to the primary kernel).
> > > 
> > > Now the primary kernel reads the 'kaslr-seed' and wipes it to 0 and
> > > uses the seed value to randomize for e.g. the module base address
> > > offset.
> > > 
> > > In the case of 'kexec_load' (or even kdump for brevity),
> > > we rely on the user-space kexec-tools to pass an appropriate dtb to the
> > > secondary kernel and since 'kaslr-seed' is wiped to 0 by the primary
> > > kernel, the secondary will essentially work with *nokaslr* as
> > > 'kaslr-seed' is set to 0 when it is passed to the secondary kernel.
> > > 
> > > This can be true even in case the secondary kernel had
> > > 'CONFIG_RANDOMIZE_BASE' and 'CONFIG_RANDOMIZE_MODULE_REGION_FULL' set to
> > > y.
> > > 
> > > This patch addresses this issue by first checking if the device tree
> > > provided by the firmware to the kernel supports the 'kaslr-seed'
> > > property and verifies that it is really wiped to 0. If this condition is
> > > met, it fixes up the 'kaslr-seed' property by using the getrandom()
> > > syscall to get a suitable random number.
> > > 
> > > I verified this patch on my Qualcomm arm64 board and here are some test
> > > results:
> > > 
> > > 1. Ensure that the primary kernel is boot'ed with 'kaslr-seed'
> > >     dts property and it is really wiped to 0:
> > > 
> > >     [root@qualcomm-amberwing]# dtc -I dtb -O dts /sys/firmware/fdt | grep -A 10 -i chosen
> > >          chosen {
> > >                  kaslr-seed = <0x0 0x0>;
> > >                  ...
> > >          }
> > > 
> > > 2. Now issue 'kexec_load' to load the secondary kernel (let's assume
> > >     that we are using the same kernel as the secondary kernel):
> > >     # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
> > >       -r`.img --reuse-cmdline -d
> > > 
> > > 3. Issue 'kexec -e' to warm boot to the secondary:
> > >     # kexec -e
> > > 
> > > 4. Now after the secondary boots, confirm that the load address of the
> > >     modules is randomized in every successive boot:
> > > 
> > >     [root@qualcomm-amberwing]# cat /proc/modules
> > >     sunrpc 524288 1 - Live 0xffff0307db190000
> > >     vfat 262144 1 - Live 0xffff0307db110000
> > >     fat 262144 1 vfat, Live 0xffff0307db090000
> > >     crc32_ce 262144 0 - Live 0xffff0307d8c70000
> > >     ...
> > > 
> > > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > > ---
> > > Changes since v1:
> > >   - Addressed Akashi's comments regarding the goto label path.
> > >   - v1 can be viewed here: https://marc.info/?l=kexec&m=152373724406110&w=2
> > 
> > Ping. Any comments on this v2?

...

> Ping. Seems we don't have comments on this v2 (since the last month or so).
> 
> Having the capability to pass an appropriate 'kaslr-seed' value to the
> secondary kernel is important for booting KASLR enabled secondary kernels -
> which is an important use case for kexec for distributions like Fedora.
> 
> Kindly consider applying this patch which has been properly tested on a
> couple of arm64 machines both for KASLR and non-KASLR boot cases.
> 
> Right now, I am forced to keep this patch locally and refer KASLR users on
> arm64 to my public github tree which has this patch committed on top of the
> upstream kexec-tools. I would prefer to route them to the upstream
> kexec-tools itself (rather than my github tree), once this patch is applied
> there.

Thanks for the patch, applied.
My questions were covered in the review of v1.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
