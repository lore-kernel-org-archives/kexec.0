Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLgCk-0003Ta-4a
 for kexec@lists.infradead.org; Fri, 25 Sep 2020 05:23:34 +0000
Received: by mail-ot1-f71.google.com with SMTP id x52so456328otb.11
 for <kexec@lists.infradead.org>; Thu, 24 Sep 2020 22:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 25 Sep 2020 10:53:14 +0530
Message-ID: <CACi5LpN9sRz12EWJrWQOQPLbOPEboDikb7oG1tG=XZV+sOWLgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
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
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ktkhai@virtuozzo.com, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, RuiRui Yang <dyoung@redhat.com>, christian.brauner@ubuntu.com, Vivek Goyal <vgoyal@redhat.com>

Hi Alexander,

On Thu, Sep 24, 2020 at 6:18 PM Alexander Egorenkov
<egorenar@linux.ibm.com> wrote:
>
> The offset of the field 'init_uts_ns.name' has changed
> since
>
> commit 9a56493f6942c0e2df1579986128721da96e00d8
> Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> Date:   Mon Aug 3 13:16:21 2020 +0300
>
>     uts: Use generic ns_common::count

A minor nitpick:
You can add the following line to your .gitconfig:
one = show -s --pretty='format:%h (\"%s\")'

running a command '$ git one <SHA-ID>' will then give you an
abbreviated form to be used while referring to existing git commits in
the log message. For e.g. in this case, the output would be something
like:

$ git one 9a56493f6942c0e2df1579986128721da96e00d8
9a56493f6942 ("uts: Use generic ns_common::count")

Then you can use '9a56493f6942 ("uts: Use generic ns_common::count")'
to refer to an existing upstream patch in the log message.

But I think this can be fixed while applying the patch (if there are
no further revisions required).

> Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain
>
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..173fdc261882 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
>
>         VMCOREINFO_SYMBOL(init_uts_ns);
> +       VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>         VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> --
> 2.26.2

Thanks for making the changes we discussed in the v1 review. Otherwise
the patch looks fine to me, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
