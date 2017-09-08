Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq9Pe-00060x-R0
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 02:53:02 +0000
Received: by mail-pf0-x236.google.com with SMTP id e199so2461227pfh.3
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 19:52:38 -0700 (PDT)
Date: Fri, 8 Sep 2017 11:54:22 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
Message-ID: <20170908025421.GE17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
 <20170825020348.GA7308@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825061353.GB8604@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170825061353.GB8604@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On Fri, Aug 25, 2017 at 02:13:53PM +0800, Dave Young wrote:
> On 08/25/17 at 11:03am, AKASHI Takahiro wrote:
> > On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > > > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > > > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > > > memory. The other PT_LOAD segments are placed relative to the first one.
> > > 
> > > I really don't like assuming things about the vmlinux ELF file.
> > 
> > If so, vmlinux is not an appropriate format for loading.
> > 
> > > > Regarding kernel verification, since there is no standard way to contain
> > > > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
> > > > approach, that is, appending a signature right after the kernel binary
> > > > itself like module signing.
> > > 
> > > I also *really* don't like this. It's a bizarre in-band mechanism,
> > > without explcit information. It's not a nice ABI.
> > > 
> > > If we can load an Image, why do we need to be able to load a vmlinux?
> > 
> > Well, kexec-tools does. I don't know why Geoff wanted to support vmlinux.
> > I'm just trying to support what kexec-tools does support.
> 
> We only add things when it is really necessary, kexec-tools
> functionalities should have some historic reasons.

Geoff had been working on kexec since old kernels (3.14 or 15?).

> If only for doing kexec-tools has done I would say just not to do it.

Sure

-Takahiro AKASHI

> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
