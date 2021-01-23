Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l36fs-000839-K0
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 00:21:09 +0000
Received: by mail-ed1-x536.google.com with SMTP id g24so8500016edw.9
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 16:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-5-pasha.tatashin@soleen.com>
 <82db4b88-7e69-9298-f1cb-d3afcd29b1ae@arm.com>
In-Reply-To: <82db4b88-7e69-9298-f1cb-d3afcd29b1ae@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 19:20:31 -0500
Message-ID: <CA+CK2bAEOx8JWZYpLzNRWNbny=gg+Hz89ajdxUnjKanZjUaROQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] arm64: trans_pgd: pass allocator
 trans_pgd_create_copy
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Selin Dag <selindag@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Make trans_pgd_create_copy and its subroutines to use allocator that is
> > passed as an argument
>
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
