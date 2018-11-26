Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRM1o-0002tZ-Qw
 for kexec@lists.infradead.org; Mon, 26 Nov 2018 18:54:42 +0000
Subject: Re: [PATCH 0/2 RESEND v7] add reserved e820 ranges to the kdump
 kernel e820 table
References: <20181124051223.19994-1-lijiang@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <35e8ade5-d5a8-b5e4-180b-44b4ff0a83b1@intel.com>
Date: Mon, 26 Nov 2018 10:54:26 -0800
MIME-Version: 1.0
In-Reply-To: <20181124051223.19994-1-lijiang@redhat.com>
Content-Language: en-US
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
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, tony.luck@intel.com, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 11/23/18 9:12 PM, Lianbo Jiang wrote:
> These patches add the new I/O resource descriptor 'IORES_DESC_RESERVED'
> for the iomem resources search interfaces, and in order to make it still
> work after the new descriptor is added, these codes originally related
> to 'IORES_DESC_NONE' have been updated.

This is rather anemic "0/" text.  Could you please include some more
background in here?  The 2/2 patch is pretty good in this regard, but it
needs to be here, too.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
