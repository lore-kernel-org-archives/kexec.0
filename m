Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lONAE-00C06N-PF
 for kexec@lists.infradead.org; Mon, 22 Mar 2021 16:12:24 +0000
Received: by mail-ed1-x535.google.com with SMTP id h10so20007277edt.13
 for <kexec@lists.infradead.org>; Mon, 22 Mar 2021 09:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-4-david@redhat.com>
In-Reply-To: <20210322160200.19633-4-david@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Mar 2021 09:12:13 -0700
Message-ID: <CAPcyv4hGMoDYCbnFaa2A6JukE+AcOK5qvq2TZVDUomPZYkZjnA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kernel/resource: remove first_lvl / siblings_only
 logic
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
To: David Hildenbrand <david@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>, Oscar Salvador <osalvador@suse.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Mar 22, 2021 at 9:03 AM David Hildenbrand <david@redhat.com> wrote:
>
> All IORESOURCE_SYSTEM_RAM and IORESOURCE_MEM now properly consider the
> whole resource tree, not just the first level. Let's drop the unused
> first_lvl / siblings_only logic.
>
> All functions properly search the whole tree, so remove documentation
> that indicates that some functions behave differently.

Looks good, and the staging of the potential regressions as standalone
lead-in patches makes sense.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
