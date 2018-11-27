Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRfNi-0001xV-17
 for kexec@lists.infradead.org; Tue, 27 Nov 2018 15:34:36 +0000
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
 <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
 <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <703ce20d-be09-9b8d-d457-5b002a50dff7@intel.com>
Date: Tue, 27 Nov 2018 07:34:16 -0800
MIME-Version: 1.0
In-Reply-To: <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
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
To: lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, tony.luck@intel.com, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 11/27/18 2:04 AM, lijiang wrote:
> What happens if we don't modify this functions
> __ioremap_check_desc_other()? -When SEV is active, it might map these
> reserved regions with the encryption mask. That is incorrect. 

This is missing another sentence or two to "connect the dots".

SEV uses data that comes from the e820 table to tell whether or not the
memory should be encrypted?  If we don't reflect these reserved areas in
the e820 table, the SEV code will set up encrypted mappings for device
memory, for instance?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
