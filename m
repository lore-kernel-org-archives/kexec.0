Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412712462.32313.127.camel@smoke>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 07 Oct 2014 13:07:42 -0700
In-Reply-To: <20141007180954.GH27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi Vivek,

On Tue, 2014-10-07 at 14:09 -0400, Vivek Goyal wrote:
> I tried and I get following.
> 
> [root@apm-mustang-ev3-06 sbin]# ./kexec -l /root/git/sa2/vmlinux
> --initrd=/boot/initramfs-3.17.0-rc7+.img
> --append="BOOT_IMAGE=/vmlinuz-3.17.0-rc5+
> root=/dev/mapper/fedora_dhcp--17--165-root ro
> rd.lvm.lv=fedora_dhcp-17-165/root rd.lvm.lv=fedora_dhcp-17-165/swap
> vconsole.font=latarcyrheb-sun16 console=tty0 console=ttyS0,115200
> LANG=en_US.UTF-8 crashkernel=160M earlyprintk=ttyS0,115200"
> kexec version: 14.10.02.15.58-g706fbeb
> Modified cmdline: root=/dev/mapper/rhsfadp_apm--mustang--ev3--06-root 
> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from
> purgatory is diabled
> get_memory_ranges_dt:756: Invalid /proc/device-tree.
> kexec: kexec/arch/arm64/kexec-arm64.c:625: virt_to_phys: Assertion
> `arm64_mem.memstart' failed.
> Aborted

I added a kexec-tools fix for this failed assertion.  Could you pull
my latest and send me the output with the kexec --debug option added?

I guess you are trying to boot the kernel as a UEFI application,
which I have not yet done, so not supported.  You need to use a
UEFI kernel loader.

> What's "Modified cmdline" ? That seems to have truncated everything I 
> passed in.

The kexec-tools fs2dt code prints out the Modified cmdline when a node
is added to the DT.  In this case it is OK, since the arm64 code first
adds other nodes.  Your new cmdline is added later, but you did not
get there do to the failed assertion.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
