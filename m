Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f94og-0000OD-Kx
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 08:21:20 +0000
Date: Thu, 19 Apr 2018 10:21:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: Set -fno-PIC along with -mcmodel=large
Message-ID: <20180419082105.zfg4d4l4ykcez3td@verge.net.au>
References: <87608dprce.fsf@coreos.com>
 <b6fd5727-9199-1350-c175-8f9a780a095f@infradead.org>
 <bd88df09-e87b-4820-b066-bd6ba90f3c6a@infradead.org>
 <20180418125425.6tkoopcix5kgisd2@verge.net.au>
 <CAMVW178-zYqR9n4rNGtsLLL0Uvqaqr=SBOJGVUVHxC97+ZzSsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMVW178-zYqR9n4rNGtsLLL0Uvqaqr=SBOJGVUVHxC97+ZzSsQ@mail.gmail.com>
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
To: David Michael <david.michael@coreos.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org

On Wed, Apr 18, 2018 at 12:45:59PM -0400, David Michael wrote:
> On Wed, Apr 18, 2018 at 8:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Apr 12, 2018 at 04:37:25PM -0700, Geoff Levand wrote:
> >> Hi Simon,
> >>
> >> On 02/02/2018 03:48 PM, Geoff Levand wrote:
> >> > Hi,
> >> >
> >> > On 01/07/2018 08:26 AM, David Michael wrote:
> >> >> As seen in GCC's gcc/config/aarch64/aarch64.c, -fPIC with large
> >> >> code model is unsupported.  This fixes the "sorry, unimplemented"
> >> >> errors when building with compilers defaulting to -fPIC.
> >> >> ---
> >> >>
> >> >> purgatory/arch/arm64/entry.S:1:0: sorry, unimplemented: code model 'large' with -fPIC
> >> >>
> >> >> This change fixes it.  Can something like this be applied?
> >> >
> >> > This change seems reasonable considering large model + PIC is unsupported.
> >> >
> >> > Reviewed by: Geoff Levand <geoff@infradead.org>
> >>
> >> Could you please merged this fix so arm64 builds work OK on Gentoo
> >> and Gentoo derivatives.
> >
> > Sure, but it really ought to have a Signed-off-by line from David.
> 
> Sorry about that.  Should I resend the patch, or can you amend it with
> this line?
> 
> Signed-off-by: David Michael <david.michael@coreos.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
