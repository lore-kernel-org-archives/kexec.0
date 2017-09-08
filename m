Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq9ck-00060R-JU
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 03:06:33 +0000
Received: by mail-pf0-x22c.google.com with SMTP id y29so1745736pff.0
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 20:06:08 -0700 (PDT)
Date: Fri, 8 Sep 2017 12:07:51 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
Message-ID: <20170908030750.GF17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
 <20170829100112.GC2901@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170829100112.GC2901@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, arnd@arndb.de, vgoyal@redhat.com, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, Aug 29, 2017 at 11:01:12AM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> > On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > > memory. The other PT_LOAD segments are placed relative to the first one.
> > 
> > I really don't like assuming things about the vmlinux ELF file.
> > 
> > > Regarding kernel verification, since there is no standard way to contain
> > > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
> > > approach, that is, appending a signature right after the kernel binary
> > > itself like module signing.
> > 
> > I also *really* don't like this. It's a bizarre in-band mechanism,
> > without explcit information. It's not a nice ABI.
> > 
> > If we can load an Image, why do we need to be able to load a vmlinux?
> 
> So IIUC, the whole point of this is to be able to kexec_file_load() a
> vmlinux + signature bundle, for !CONFIG_EFI kernels.
> 
> For that, I think that we actually need a new kexec_file_load${N}
> syscall, where we can pass the signature for the kernel as a separate
> file. Ideally also with a flags argument and perhaps the ability to sign
> the initrd too.

Verifying root file system would be another topic in general.

> That way we don't ahve to come up with a magic vmlinux+signature format,
> as we can just pass a regular image and a signature for that image
> separately. That should work for PPC and others, too.

Since some discussions are to be expected around vmlinux signing,
I will drop vmlinux support in v2.

(This means, as you mentioned, that we have no way to sign
a !CONFIG_EFI kernel for now. The possible solution in future would
be to utilize file extended attributes as proposed by powerpc guys?)

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
