Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gS2IQ-0002wI-Jd
 for kexec@lists.infradead.org; Wed, 28 Nov 2018 16:02:40 +0000
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
 <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
 <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
 <703ce20d-be09-9b8d-d457-5b002a50dff7@intel.com>
 <d84fbefb-f856-c600-5207-c63f48b1b308@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <4ff951f6-c1bf-ff98-b70b-a138e54488af@intel.com>
Date: Wed, 28 Nov 2018 08:02:26 -0800
MIME-Version: 1.0
In-Reply-To: <d84fbefb-f856-c600-5207-c63f48b1b308@redhat.com>
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

On 11/27/18 7:51 PM, lijiang wrote:
> But now, the 'E820_TYPE_RESERVED' type is converted to the descriptor 'IORES_DESC_RESERVED'
> instead of 'IORES_DESC_NONE', it has been changed and the value of 'mem_flags.desc_other'
> is equal to 'true'. This is wrong.

Thanks for the improved description of the problem.  Seems to all make
sense now.

Could you include this in the changelog for the next version?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
