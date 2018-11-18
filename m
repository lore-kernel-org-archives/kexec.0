Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOLde-000727-T1
 for kexec@lists.infradead.org; Sun, 18 Nov 2018 11:53:20 +0000
Date: Sun, 18 Nov 2018 12:52:51 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181118115251.GB19380@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Fri, Nov 16, 2018 at 11:25:55AM +0800, lijiang wrote:
> For the pci mmconfig issue, it should be good enough that the e820 reserved region
> [mem 0x0000000078000000-0x000000008fffffff] is only passed to the second kernel, but
> the pci mmconfig region is not the same in another machine.

Yes. And now the question is, *which* reserved regions need to be mapped
for the second kernel to function properly? How do we figure that out?

> A simple case, hotplug a pci network card and use the ssh/nfs to dump the vmcore.
> If the pci mmconfig region is not reserved in kdump kernel, the pci hotplug device
> could not be recognized. So the pci network card won't work.

Yes that's a good example; put *that* example in your commit message.

> Here, there is an example about SME kdump. Maybe it can help to better understand.

You keep pasting that and I've read it already. And you keep repeating
that the reserved regions need to be mapped in the second kernel and I'm
asking, how do we determine *which* regions should we pass to the second
kernel?

If we should pass *all* reserved regions, why?

IOW, I'm looking for the *why* first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
