Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awA81-0002hs-R1
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 15:14:50 +0000
Received: by mail-oi0-f41.google.com with SMTP id x201so121754112oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 08:14:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviFU-0000jk-9q@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFU-0000jk-9q@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 20:44:29 +0530
Message-ID: <CAHB_GuoPDxqKbbfGHW8UEiuCxdMeEVBCMJpouaO--dbLomkzrQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] kexec: allow architectures to override boot mapping
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

On Thu, Apr 28, 2016 at 2:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> kexec physical addresses are the boot-time view of the system.  For
> certain ARM systems (such as Keystone 2), the boot view of the system
> does not match the kernel's view of the system: the boot view uses a
> special alias in the lower 4GB of the physical address space.
>
> To cater for these kinds of setups, we need to translate between the
> boot view physical addresses and the normal kernel view physical
> addresses.  This patch extracts the current transation points into
> linux/kexec.h, and allows an architecture to override the functions.
>
> Due to the translations required, we unfortunately end up with six
> translation functions, which are reduced down to four that the
> architecture can override.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I must be missing something when I am thinking that, had we passed
arch_phys_to_idmap_offset to user space, this patch would not have
been needed, and things would have been more simpler. Please help me
to understand why passing arch_phys_to_idmap_offset to user space
would not be a good idea.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
