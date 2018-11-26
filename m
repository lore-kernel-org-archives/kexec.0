Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRLG1-0000hK-Q0
 for kexec@lists.infradead.org; Mon, 26 Nov 2018 18:05:19 +0000
Date: Mon, 26 Nov 2018 19:04:55 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/2 RESEND v7] add reserved e820 ranges to the kdump
 kernel e820 table
Message-ID: <20181126180455.GI4843@zn.tnic>
References: <20181124051223.19994-1-lijiang@redhat.com>
 <d457ed46-d983-20b2-ad7f-9eaa6d98f2bf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d457ed46-d983-20b2-ad7f-9eaa6d98f2bf@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: tony.luck@intel.com, fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Nov 26, 2018 at 09:44:46AM -0800, Dave Hansen wrote:
> On 11/23/18 9:12 PM, Lianbo Jiang wrote:
> > These patches add the new I/O resource descriptor 'IORES_DESC_RESERVED'
> > for the iomem resources search interfaces, and in order to make it still
> > work after the new descriptor is added, these codes originally related
> > to 'IORES_DESC_NONE' have been updated.
> 
> I'm having a really hard time figuring out what problem these patches solve.
> 
> What end-user visible behavior does this set change?

Yeah, that was a long process of digging out the "why".

I'd recommend reading the previous threads and, more specifically:

https://lkml.kernel.org/r/CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe%2B38zw@mail.gmail.com

in short: we need to export e820 reserved ranges to the second kernel so
that it can talk to PCI devices properly. (And I'm wondering how it did
work until now...)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
