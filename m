Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imPto-000868-3T
 for kexec@lists.infradead.org; Tue, 31 Dec 2019 22:22:01 +0000
Received: by mail-ot1-x342.google.com with SMTP id 66so51718435otd.9
 for <kexec@lists.infradead.org>; Tue, 31 Dec 2019 14:21:59 -0800 (PST)
MIME-Version: 1.0
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191231014630.GA24942@dhcp-128-65.nay.redhat.com>
 <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
In-Reply-To: <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Dec 2019 14:21:48 -0800
Message-ID: <CAPcyv4idLx58iH0tA08vrVdvornd-jAwSwHQ6Eha+Z_UQUDDAQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem=
 entries
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
To: Dave Young <dyoung@redhat.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>, linux-efi <linux-efi@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

On Tue, Dec 31, 2019 at 1:11 PM Dan Williams <dan.j.williams@intel.com> wrote:
> Perhaps a prettier way to do this is to push the handling of each
> efi_fake_mem entry into a subroutine. However, I notice when a memmap
> allocated by efi_memmap_alloc() is replaced by another dynamically
> allocated memmap the previous one isn't released. I have a series that
> fixes that up as well.

Available here:
http://lore.kernel.org/r/157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
