Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV00H-0007tn-0Y
 for kexec@lists.infradead.org; Thu, 06 Dec 2018 20:12:11 +0000
Date: Thu, 6 Dec 2018 21:11:47 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20181206201147.GG3986@zn.tnic>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130033703.GA23624@dhcp-128-65.nay.redhat.com>
 <bbf6352b-b060-4cb8-dfd2-99166b0149a7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbf6352b-b060-4cb8-dfd2-99166b0149a7@redhat.com>
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
Cc: tony.luck@intel.com, fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org, Toshi Kani <toshi.kani@hp.com>, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>

On Fri, Nov 30, 2018 at 03:04:44PM +0800, lijiang wrote:
> I have noticed the changes on x86, but for IA64, i'm not sure whether it should do the same
> thing, so keep it as before.
> 
> If IA64 people would like to give any comment, that will be appreciated.

I think you should not touch ia64 and not make Tony unnecessarily power
up the old rust.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
