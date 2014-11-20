Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1416446382.23886.90.camel@smoke>
Subject: Re: [PATCH 0/8] arm64 kexec kernel patches V6
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 19 Nov 2014 17:19:42 -0800
In-Reply-To: <546AE4BE.1020909@huawei.com>
References: <D2393EB95A9993478029A6FE6A290A9F8129D1FE@szxeml510-mbx.china.huawei.com>
 <546AE4BE.1020909@huawei.com>
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
To: Anurup M <anurup.m@huawei.com>
Cc: sanil.kumar@hisilicon.com, kexec@lists.infradead.org

On Tue, 2014-11-18 at 11:48 +0530, Anurup M wrote:
> 	I get a relocation error  when I try to load using latest kexec-tools from https://git.linaro.org/people/geoff.levand/kexec-tools.git.
> 
> ############## error log ###############
> machine_apply_elf_rel: CALL26 94000000->97ffff62
> sym: sha256_update info: 12 other: 00 shndx: 1 value: 5f58 size: 16c
> sym: sha256_update value: 81af7f58 addr: 81af81e4
> machine_apply_elf_rel: CALL26 94000000->97ffff5d
> sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
> sym: .data value: 81af8630 addr: 81af8550
> machine_apply_elf_rel: ABS64 0->81af8630
> Symbol: sha256_regions is in a bss section cannot set
> ##############
> 
> 	What should be the problem? 

It seems either your purgatory code was not built correctly,
or the kexec-tools relocator didn't do the correct thing.

Please post the output from your gcc with the --version option and
the command line used to compile purgatory/purgatory.c.

> I use foundation model and the kernel image from
> https://git.linaro.org/people/geoff.levand/linux-kexec.git branch: origin/kexec-v6
> and rootfs from Linaro (http://releases.linaro.org/14.09/openembedded/aarch64)
> 
> 	The above error is not seen when I use kexec-tools branch: origin/kdump.
> 
> 	Also wish to know how to verify the kdump feature.

As I mentioned before, these patches only add kexec re-boot support.  kdump
has not been ported to arm64 yet.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
