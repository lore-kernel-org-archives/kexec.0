Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lON9I-00BzqB-AL
 for kexec@lists.infradead.org; Mon, 22 Mar 2021 16:11:26 +0000
Received: by mail-ej1-x630.google.com with SMTP id u9so22210743ejj.7
 for <kexec@lists.infradead.org>; Mon, 22 Mar 2021 09:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-3-david@redhat.com>
In-Reply-To: <20210322160200.19633-3-david@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Mar 2021 09:11:14 -0700
Message-ID: <CAPcyv4ijmTQgPwD+mS4JfSC-=1dLM6jhMqt6vL8TJd-_FbZa+g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all busy
 IORESOURCE_MEM resources
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

On Mon, Mar 22, 2021 at 9:02 AM David Hildenbrand <david@redhat.com> wrote:
>
> It used to be true that we can have system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., dax/kmem and virtio-mem).
>
> The function walk_mem_res() only consideres the first level and is
> used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
> fail to identify System RAM added by dax/kmem and virtio-mem as
> "IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
> "normal RAM" in __ioremap_caller().
>
> Let's find all busy IORESOURCE_MEM resources, making the function
> behave similar to walk_system_ram_res().

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
