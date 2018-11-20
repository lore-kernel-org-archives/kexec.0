Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPBki-0006Dh-Ix
 for kexec@lists.infradead.org; Tue, 20 Nov 2018 19:32:06 +0000
Date: Tue, 20 Nov 2018 20:29:35 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181120192935.GK2527@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
 <20181119102812.GA14688@zn.tnic>
 <a1c58bb8-390b-e249-599f-c973d575e1ca@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1c58bb8-390b-e249-599f-c973d575e1ca@redhat.com>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org

On Tue, Nov 20, 2018 at 11:37:26AM +0800, lijiang wrote:
> BTW: Boris has mentioned the solution which adds the new descriptor 'IORES_DESC_RESERVED'.
> 
> Which solution do you prefer? Add the new I/O resource descriptor 'IORES_DESC_RESERVED'(patch v7)
> or exactly comparing a string(patch v6)?

The new I/O descriptor of course - the string comparison thing is
fragile and error-prone.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
