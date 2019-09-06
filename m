Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6GLK-0005gD-ON
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 15:40:12 +0000
Received: by mail-ed1-x544.google.com with SMTP id p2so5509394edx.11
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 08:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-3-pasha.tatashin@soleen.com>
 <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
In-Reply-To: <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 11:39:58 -0400
Message-ID: <CA+CK2bBgUH8v_bYEyJKPsLZFDxse6xYRwGR8KN=SzgHnrR9yhA@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] arm64, hibernate: use get_safe_page directly
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
> Nit: The pattern for the subject prefix should be "arm64: hibernate:"..
> Its usually possible to spot the pattern from "git log --oneline $file".

Sure, I will change here and in other places to "arm64: hibernate:"

>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > create_safe_exec_page is a local function that uses the
> > get_safe_page() to allocate page table and pages and one pages
> > that is getting mapped.
>
> I can't parse this.
>
> create_safe_exec_page() uses hibernate's allocator to create a set of page table to map a
> single page that will contain the relocation code.

Thanks I will rephrase it with your suggestion.

>
>
> > Remove the allocator related arguments, and use get_safe_page
> > directly, as it is done in other local functions in this
> > file.
> ... because kexec can't use this as it doesn't have a working allocator.
> Removing this function pointer makes it easier to refactor the code later.

Thanks, I will add it to the description.

>
> (this thing is only a function pointer so kexec could use it too ... It looks like you're
> creating extra work. Patch 7 moves these new calls out to a new file... presumably so
> another patch can remove them again)
>
> As stand-alone cleanup the patch looks fine, but you probably don't need to do this.

Without this clean-up moving to common code becomes messier. So, I
would like to keep this change.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
