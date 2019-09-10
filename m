Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7cAa-0005NM-3e
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 09:10:41 +0000
Received: by mail-ed1-x542.google.com with SMTP id i8so16285650edn.13
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 02:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-5-pasha.tatashin@soleen.com>
 <e2ceb43a-d7bf-e0c6-c3ea-b83c95ba880d@suse.com>
In-Reply-To: <e2ceb43a-d7bf-e0c6-c3ea-b83c95ba880d@suse.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 10 Sep 2019 10:10:26 +0100
Message-ID: <CA+CK2bAsW0ExS2a2ZaGUmF2igKE7TM0qdCSYMaJn=0+pkM7ugQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/17] arm64: hibernate: use get_safe_page directly
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
To: Matthias Brugger <mbrugger@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> On 09/09/2019 20:12, Pavel Tatashin wrote:
> > create_safe_exec_page() uses hibernate's allocator to create a set of page
> > table to map a single page that will contain the relocation code.
> >
> > Remove the allocator related arguments, and use get_safe_page directly, as
> > it is done in other local functions in this file to simplify function
> > prototype.
> >
> > Removing this function pointer makes it easier to refactor the code later.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>

Thank you

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
