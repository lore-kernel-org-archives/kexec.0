Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hH73x-0001iG-Qh
 for kexec@lists.infradead.org; Thu, 18 Apr 2019 13:26:51 +0000
Date: Thu, 18 Apr 2019 15:26:41 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190418132641.GJ27160@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
 <20190415154155.GH29317@zn.tnic>
 <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
 <20190418100138.GD27160@zn.tnic>
 <b04098df-5c4e-b8c8-3d8d-bab68a5e197a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b04098df-5c4e-b8c8-3d8d-bab68a5e197a@amd.com>
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "x86@kernel.org" <x86@kernel.org>, lijiang <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On Thu, Apr 18, 2019 at 01:17:03PM +0000, Lendacky, Thomas wrote:
> You could probably make this unsigned int for now since you're creating
> the new enum used to assign to this variable and it only uses two bits
> currently.

Right.

> > +	if (res->desc & (IORES_DESC_NONE | IORES_DESC_RESERVED))
> > +		return 0;
> 
> The IORES_DESC_xxxx enums are not bits, just sequential numbers, so you
> won't be able to test them this way.  You can probably get away with a
> switch statement here.

Ah, good catch. I thought they're BITs too. Oh well.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
