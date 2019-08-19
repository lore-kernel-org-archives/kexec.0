Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hzkbJ-0004HS-Hi
 for kexec@lists.infradead.org; Mon, 19 Aug 2019 16:33:46 +0000
Received: by mail-ed1-x544.google.com with SMTP id g8so2259078edm.6
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2019 09:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-4-pasha.tatashin@soleen.com>
 <20190819155824.GE9927@lakrids.cambridge.arm.com>
In-Reply-To: <20190819155824.GE9927@lakrids.cambridge.arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 Aug 2019 12:33:31 -0400
Message-ID: <CA+CK2bD4zE6eieSW2OLQwOQC7=4ncDc8wK6ZjhDO3Dv+BUqnzQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] arm64,
 hibernate: add trans_table public functions
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 19, 2019 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Aug 16, 2019 at 10:46:18PM -0400, Pavel Tatashin wrote:
> > trans_table_create_copy() and trans_table_map_page() are going to be
> > the basis for public interface of new subsystem that handles page
> > tables for cases which are between kernels: kexec, and hibernate.
>
> While the architecture uses the term 'translation table', in the kernel
> we generally use 'pgdir' or 'pgd' to refer to the tables, so please keep
> to that naming scheme.

The idea is to have a unique name space for new subsystem of page
tables that are used between kernels:
between stage 1 and stage 2 kexec kernel, and similarly between
kernels during hibernate boot process.

I picked: "trans_table" that stands for transitional page table:
meaning they are used only during transition between worlds.

All public functions in this subsystem will have trans_table_* prefix,
and page directory will be named: "trans_table". If this is confusing,
I can either use a different prefix, or describe what "trans_table"
stand for in trans_table.h/.c

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
