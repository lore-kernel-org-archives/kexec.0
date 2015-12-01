Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: "Azriel Samson" <asamson@codeaurora.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
In-Reply-To: <20151201021615.GA5704@dhcppc13.redhat.com>
Subject: RE: [PATCH v12 08/16] arm64/kexec: Add core kexec support
Date: Tue, 1 Dec 2015 11:32:47 -0700
Message-ID: <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
MIME-Version: 1.0
Content-Language: en-us
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Pratyush Anand' <panand@redhat.com>, 'Geoff Levand' <geoff@infradead.org>
Cc: 'Mark Rutland' <mark.rutland@arm.com>, marc.zyngier@arm.com, 'Catalin Marinas' <catalin.marinas@arm.com>, 'Will Deacon' <will.deacon@arm.com>, 'AKASHI Takahiro' <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, 'Dave Young' <dyoung@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

I tested with v11 on our platform and I too needed the invalidation fix.

Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,=
=A0
a Linux Foundation Collaborative Project

-----Original Message-----
From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Pratyush
Anand
Sent: Monday, November 30, 2015 7:16 PM
To: Geoff Levand
Cc: Mark Rutland; marc.zyngier@arm.com; Catalin Marinas; Will Deacon; AKASHI
Takahiro; linux-arm-kernel@lists.infradead.org; Dave Young;
kexec@lists.infradead.org; christoffer.dall@linaro.org
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support

Hi Geoff,

On 30/11/2015:10:51:15 AM, Geoff Levand wrote:
> Hi,
> =

> On Fri, 2015-11-27 at 18:43 +0530, Pratyush Anand wrote:
> =

> > On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> > > +> > 	> > /* Test the entry flags. */
> > > +.Ltest_source:
> > > +> > 	> > tbz> > 	> > x18, IND_SOURCE_BIT, .Ltest_indirection
> > > +
> > > +> > 	> > mov x20, x13> > 	> > 	> > 	> > 	> > /*  x20
=3D copy dest */
> > > +> > 	> > mov x21, x12> > 	> > 	> > 	> > 	> > /*  x21
=3D copy src */
> > =

> > Till v10 we had here invalidation for relocated destination page to =

> > PoC. I could not understand, why it was removed. Removing that piece =

> > of code breaks kexec booting with mustang. I need [1] to kexec boot =

> > into second kernel with mustang platform.
> =

> We need to flush the new kernel to PoC.  The code that was here that =

> was doing that would only be executed when the new kernel needed =

> relocation (the standard kexec case).  We also need to flush kernels =

> that do not need relocation (the standard kdump case).
> =

> I moved the new kernel flush to kexec_segment_flush(), called =

> unconditionally in machine_kexec() so we can handle both cases with =

> one piece of code.

Yes, I had noticed that. Actually flushing before cache is disabled can
always cause heisenbug.

> =

> Have you experienced a problem on mustang with the current version?

Yes, v10 works fine, but I need invalidation fix for both v11 and v12 to
work on mustang.
I have not tested vanilla v12 on seattle, but v12 ported on rhelsa needs
invalidation fix to work on seattle as well.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
