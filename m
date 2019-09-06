Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6GMN-0006F0-JK
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 15:41:16 +0000
Received: by mail-ed1-x543.google.com with SMTP id y91so6671985ede.9
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 08:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-5-pasha.tatashin@soleen.com>
 <2e826560-4005-fa16-8bbb-fc0e25763dcc@arm.com>
In-Reply-To: <2e826560-4005-fa16-8bbb-fc0e25763dcc@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 11:41:03 -0400
Message-ID: <CA+CK2bDU9ZZbXsqfEzMV9JDRUq0vMRNHObpQ0q-YtwbEbq702w@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] arm64,
 hibernate: rename dst to page in create_safe_exec_page
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > create_safe_exec_page() allocates a safe page and maps it at a
> > specific location, also this function returns the physical address
> > of newly allocated page.
> >
> > The destination VA, and PA are specified in arguments: dst_addr,
> > phys_dst_addr
> >
> > However, within the function it uses "dst" which has unsigned long
> > type, but is actually a pointers in the current virtual space. This
> > is confusing to read.
>
> The type? There are plenty of places in the kernel that an unsigned-long is actually a
> pointer. This isn't unusual.
>
>
> > Rename dst to more appropriate page (page that is created), and also
> > change its time to "void *"
>
> If you think its clearer,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
