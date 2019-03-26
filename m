Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8iqw-0000TO-Jh
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 09:58:46 +0000
Date: Tue, 26 Mar 2019 10:58:31 +0100
In-Reply-To: <b1556461-fe83-2ba0-00a3-e8ecf3e286fe@amd.com>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130033703.GA23624@dhcp-128-65.nay.redhat.com>
 <b8936194-01ef-8b8f-254e-039fc951855d@amd.com>
 <95661569-d9c9-af13-11c4-c0d752710a1f@redhat.com>
 <b1556461-fe83-2ba0-00a3-e8ecf3e286fe@amd.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
From: Boris Petkov <bp@alien8.de>
Message-ID: <5B077919-37B4-4434-86BC-6F29DD73C195@alien8.de>
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, lijiang <lijiang@redhat.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, Toshi Kani <toshi.kani@hp.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

On March 25, 2019 8:34:25 PM GMT+01:00, "Lendacky, Thomas" <Thomas.Lendacky@amd.com> wrote:
>On 3/16/19 2:31 AM, lijiang 
>Adding a nice comment here about how IORES_DESC_NONE originally was to
>identify MMIO and reserved areas. Now IORES_DESC_RESERVED has been
>created
>for the reserved areas so the check needs to be expanded

Expanded and made explicit *which* areas should not be mapped encrypted and then the function name corrected. 

Thx.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
