Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9q9-0001ej-Ju
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:56:22 +0000
Received: by mail-oi0-f50.google.com with SMTP id x201so121106227oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:56:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 20:26:00 +0530
Message-ID: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Subject: Re: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Thu, Apr 28, 2016 at 2:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Advertise the location of bootable RAM to kexec-tools.  kexec needs to
> know where it can place the kernel in RAM, and so be executable when
> the system needs to jump into it.
>
> Advertise these areas in /proc/iomem with a "System RAM (boot alias)"
> tag.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Can you please also share git tree path of corresponding kexec-tools changes?

Could it be a better idea (if things in user space become simpler)
that in stead of patch 5 and 6, we pass arch_phys_to_idmap_offset to
user space, and then user space manipulates existing "Crash kernel"
and "System RAM" resources.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
