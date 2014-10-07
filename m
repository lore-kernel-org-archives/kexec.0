Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412706539.32313.89.camel@smoke>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 07 Oct 2014 11:28:59 -0700
In-Reply-To: <20141007152219.GB27216@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com> <1412370971.32313.30.camel@smoke>
 <20141007152219.GB27216@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On Tue, 2014-10-07 at 16:22 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> > > Does this patch series work with kexec on UEFI machines?
> > 
> > I have not done much more than some simple re-boot tests using the
> > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > but yes, it should work.
> 
> Where you booting the kernel as an UEFI application, or were you using the
> Linux loader? The latter arguably isn't a UEFI boot because the kernel doesn't
> know of or have access to UEFI (and arguably said laoder shouldn't even be
> there).

I used the Linux loader. 

> I've just had a go on Juno, but I wasn't able to get the tool to work.

No, I wouldn't think it would.  Proper UEFI re-boot is
still todo.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
