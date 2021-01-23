Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l36cu-0007YY-B3
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 00:18:05 +0000
Received: by mail-ej1-x635.google.com with SMTP id by1so10155289ejc.0
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 16:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-2-pasha.tatashin@soleen.com>
 <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
In-Reply-To: <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 19:17:26 -0500
Message-ID: <CA+CK2bCRhS9dozo0jf9mUp6woJh6_8NLLcqMdY4yHc6+mX2bXQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/18] arm64: kexec: make dtb_mem always enabled
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 29, 2020 at 1:00 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
> > enabled. This adds ugly ifdefs to c files.
>
> ~s/dtb_mem/ARCH_HAS_KIMAGE_ARCH/ ?
> dtb_mem is just one member of struct kimage_arch.
>
>
> > Always enabled dtb_mem, when it is not used, it is NULL.
> > Change the dtb_mem to phys_addr_t, as it is a physical address.
>
> Regardless,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you.

Pasha

>
>
> Thanks,
>
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
