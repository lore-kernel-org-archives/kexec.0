Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1428446891.11876.1.camel@infradead.org>
Subject: Re: [PATCH 5/6] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 07 Apr 2015 15:48:11 -0700
In-Reply-To: <552407F1.1040909@arm.com>
References: <cover.1426793116.git.geoff@infradead.org>
 <88216e29d97715cecac8630bc57342d0be860235.1426793116.git.geoff@infradead.org>
 <552407F1.1040909@arm.com>
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
To: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Suzuki,

On Tue, 2015-04-07 at 17:38 +0100, Suzuki K. Poulose wrote:
> On 19/03/15 20:35, Geoff Levand wrote:
> > +static void kexec_list_flush(unsigned long kimage_head)
> > +{
> > +       void *dest;
> 
> What is the use of dest ?

dest is left over from when I had a generic list walk routine.  I'll
remove it.
 
> > +       unsigned long *entry;
> > +
> > +       for (entry = &kimage_head, dest = NULL; ; entry++) {
> > +               unsigned int flag = *entry &
> > +                       (IND_DESTINATION | IND_INDIRECTION | IND_DONE |
> > +                       IND_SOURCE);
> You could instead do :
> 
> 	flag = *entry & IND_FLAGS;

Yes, now that the patch to define IND_FLAGS has been merged.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
