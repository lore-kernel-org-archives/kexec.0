Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fJcA8-000317-MZ
 for kexec@lists.infradead.org; Fri, 18 May 2018 09:59:02 +0000
Received: by mail-pl0-x244.google.com with SMTP id u6-v6so4304386pls.9
 for <kexec@lists.infradead.org>; Fri, 18 May 2018 02:58:49 -0700 (PDT)
Date: Fri, 18 May 2018 18:58:48 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
Message-ID: <20180518095847.GO2737@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
 <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
 <3d70c7d1-4985-a427-ecc6-a7edc84edfff@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d70c7d1-4985-a427-ecc6-a7edc84edfff@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Wed, May 16, 2018 at 09:34:41AM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 15/05/18 18:11, James Morse wrote:
> > On 25/04/18 07:26, AKASHI Takahiro wrote:
> >> Enabling crash dump (kdump) includes
> >> * prepare contents of ELF header of a core dump file, /proc/vmcore,
> >>   using crash_prepare_elf64_headers(), and
> >> * add two device tree properties, "linux,usable-memory-range" and
> >>   "linux,elfcorehdr", which represent repsectively a memory range
> >>   to be used by crash dump kernel and the header's location
> 
> >> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >> index 37c0a9dc2e47..ec674f4d267c 100644
> >> --- a/arch/arm64/kernel/machine_kexec_file.c
> >> +++ b/arch/arm64/kernel/machine_kexec_file.c
> >> @@ -76,6 +81,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> 
> >> +static void fill_property(void *buf, u64 val64, int cells)
> >> +{
> >> +	u32 val32;
> >> +
> >> +	if (cells == 1) {
> >> +		val32 = cpu_to_fdt32((u32)val64);
> >> +		memcpy(buf, &val32, sizeof(val32));
> >> +	} else {
> > 
> >> +		memset(buf, 0, cells * sizeof(u32) - sizeof(u64));
> >> +		buf += cells * sizeof(u32) - sizeof(u64);
> > 
> > Is this trying to clear the 'top' cells and shuffle the pointer to point at the
> > 'bottom' 2? I'm pretty sure this isn't endian safe.
> 
> It came to me at 2am: this only works on big-endian, which is exactly what you
> want as that is the DT format.

Oops, I was almost tricked as I haven't tested kexec on BE
for a long time :)

Thanks,
-Takahiro AKASHI

> 
> > Do we really expect a system to have #address-cells > 2?
> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
