Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6JT0-0005EZ-A8
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 19:00:19 +0000
Received: by mail-ed1-x541.google.com with SMTP id t50so7258799edd.2
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 12:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-10-pasha.tatashin@soleen.com>
 <2d9f7511-ce65-d5ca-653e-f4d43994a32d@arm.com>
In-Reply-To: <2d9f7511-ce65-d5ca-653e-f4d43994a32d@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 15:00:05 -0400
Message-ID: <CA+CK2bAkimTmsj-iGVq6AkMMNAb7+J5wm-Ra-qovS+3Ou5j33w@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] arm64, trans_pgd: add trans_pgd_create_empty
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

On Fri, Sep 6, 2019 at 11:20 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > This functions returns a zeroed trans_pgd using the allocator that is
> > specified in the info argument.
> >
> > trans_pgds should be created by using this function.
>
> This function takes the allocator you give it, and calls it once.
>
> Given both users need one pgd, and have to provide the allocator, it seems strange that
> they aren't trusted to call it.
>
> I don't think this patch is necessary.
>
> Let the caller pass in the pgd_t to the helpers.

Ok.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
