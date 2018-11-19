Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOgnG-0001Wo-VO
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 10:28:40 +0000
Date: Mon, 19 Nov 2018 11:28:12 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181119102812.GA14688@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, akpm@linux-foundation.org

On Mon, Nov 19, 2018 at 05:55:15PM +0800, Dave Young wrote:
> Another thing is it is not worth to get the exact info, the 1st kernel
> reserved part is just fine to be reserved as well in 2nd kernel, no 
> side effects.  Actually there might be some obscure use cases we
> do not find which rely those reserved memory ranges so it is better to
> have.

That makes sense as an argument. The cleaner thing would be to figure
out only *which* ranges we're going to need but that is probably harder
than simply exporting what the first kernel sees. But why we're doing
it, needs to be in the commit message so that it is clear when bug
hunting later.

...

> The basic problem is that this device is in PCI segment 1 and
> the kernel PCI probing cannot find it without all the e820 i/o
> reservations being present in the e820 table. And the crash kernel
> does not have those reservations because the kexec command does not
> pass i/o reservation via the memmap= command line option. (This
> problem does not show up for other vendors, as SGI is apparently the
> only one using extended PCI. The lookup of devices in PCI segment 0
> actually fails for everyone, but devices in segment 0 are then found
> by some legacy lookup method.) The workaround for this is to fix kexec
> to pass i/o reserved areas to the crash kernel.

Yap, this is the *why* I'm looking for. Lianbo, in your next submission,
please add Dave's explanations to your commit messages.

If it says "we need to do X" in the commit message, without a reason
given *why* we need to, then there's no way for us to know *why* we did
it, when looking at this months from now. And we absolutely need the
*why* when staring at the code and fixing the next bug/issue.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
