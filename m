Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8mbh-0003it-Uk
 for kexec@lists.infradead.org; Wed, 18 Apr 2018 12:54:44 +0000
Date: Wed, 18 Apr 2018 14:54:25 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: Set -fno-PIC along with -mcmodel=large
Message-ID: <20180418125425.6tkoopcix5kgisd2@verge.net.au>
References: <87608dprce.fsf@coreos.com>
 <b6fd5727-9199-1350-c175-8f9a780a095f@infradead.org>
 <bd88df09-e87b-4820-b066-bd6ba90f3c6a@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd88df09-e87b-4820-b066-bd6ba90f3c6a@infradead.org>
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
Cc: David Michael <david.michael@coreos.com>, kexec@lists.infradead.org

On Thu, Apr 12, 2018 at 04:37:25PM -0700, Geoff Levand wrote:
> Hi Simon,
> 
> On 02/02/2018 03:48 PM, Geoff Levand wrote:
> > Hi,
> > 
> > On 01/07/2018 08:26 AM, David Michael wrote:
> >> As seen in GCC's gcc/config/aarch64/aarch64.c, -fPIC with large
> >> code model is unsupported.  This fixes the "sorry, unimplemented"
> >> errors when building with compilers defaulting to -fPIC.
> >> ---
> >>
> >> purgatory/arch/arm64/entry.S:1:0: sorry, unimplemented: code model 'large' with -fPIC
> >>
> >> This change fixes it.  Can something like this be applied?
> > 
> > This change seems reasonable considering large model + PIC is unsupported.
> > 
> > Reviewed by: Geoff Levand <geoff@infradead.org> 
> 
> Could you please merged this fix so arm64 builds work OK on Gentoo
> and Gentoo derivatives.

Sure, but it really ought to have a Signed-off-by line from David.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
