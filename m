Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 25 Aug 2017 14:13:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
Message-ID: <20170825061353.GB8604@dhcp-128-65.nay.redhat.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
 <20170825020348.GA7308@akashi-kouhiroshi-no-MacBook-Air.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170825020348.GA7308@akashi-kouhiroshi-no-MacBook-Air.local>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/25/17 at 11:03am, AKASHI Takahiro wrote:
> On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> > On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > > memory. The other PT_LOAD segments are placed relative to the first one.
> > 
> > I really don't like assuming things about the vmlinux ELF file.
> 
> If so, vmlinux is not an appropriate format for loading.
> 
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
> Well, kexec-tools does. I don't know why Geoff wanted to support vmlinux.
> I'm just trying to support what kexec-tools does support.

We only add things when it is really necessary, kexec-tools
functionalities should have some historic reasons.

If only for doing kexec-tools has done I would say just not to do it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
