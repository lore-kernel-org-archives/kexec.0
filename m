Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Oct 2014 16:22:19 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141007152219.GB27216@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412370971.32313.30.camel@smoke>
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Geoff,

> > Does this patch series work with kexec on UEFI machines?
> 
> I have not done much more than some simple re-boot tests using the
> base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> but yes, it should work.

Where you booting the kernel as an UEFI application, or were you using the
Linux loader? The latter arguably isn't a UEFI boot because the kernel doesn't
know of or have access to UEFI (and arguably said laoder shouldn't even be
there).

I've just had a go on Juno, but I wasn't able to get the tool to work.
It seems that it's unhappy with the DTB because the EFI stub deleted the
memory nodes (to enforce use of the UEFI memory map). I'm not sure what
the tool needs to parse the memory map for, so I don't know what the
best way around that is.

nanook@localhost:~/opt/sbin$ ./kexec /home/nanook/vmlinux 
kexec version: 14.10.02.15.58-g706fbeb
Modified cmdline: root=/dev/nfs 
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from purgatory is diabled
get_memory_ranges_dt:756: Invalid /proc/device-tree.
kexec: kexec/arch/arm64/kexec-arm64.c:625: virt_to_phys: Assertion `arm64_mem.memstart' failed.
Aborted

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
