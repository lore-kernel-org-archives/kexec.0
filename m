Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fsrQL-00026A-69
 for kexec@lists.infradead.org; Thu, 23 Aug 2018 15:21:27 +0000
Date: Thu, 23 Aug 2018 17:21:02 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180823152102.GF21323@nazgul.tnic>
References: <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
 <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
 <20180720073245.GA26926@nazgul.tnic>
 <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
 <54D39850-F883-4EC6-B160-0CD88D47A997@alien8.de>
 <53536964-2b57-4630-de91-3d4da2b643a8@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53536964-2b57-4630-de91-3d4da2b643a8@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>

On Thu, Aug 16, 2018 at 01:35:28PM +0800, lijiang wrote:
> I personally prefer solution A, which is presented in posted patches.
> What do you think, Boris? And other reviewers?

Ok, thanks for taking the time and effort in explaning this in detail.

Solution B really turns out to be too complex after all. So as long as
that @encrypted argument does not need to propagate any further than a
couple of helpers - as it does now - I guess we can do solution A.

BUT! Wait until next week before sending your patches again because the
merge window isn't over yet.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
