Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIW7n-00011U-0o
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 12:01:23 +0000
Received: by mail-ed1-x542.google.com with SMTP id t16so5999959edw.7
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 05:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200916090821.929093-1-egorenar@linux.ibm.com>
In-Reply-To: <20200916090821.929093-1-egorenar@linux.ibm.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Wed, 16 Sep 2020 17:31:08 +0530
Message-ID: <CAFTCetT=6RZ4EMwKjx4p-SG=1xACfC-NVaFNq6KJonYaymWZVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Calculate offset to field 'init_uts_ns.name'
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
Cc: kexec@lists.infradead.org

Hi Alexander,

Thanks for the patch. See some nitpicks inline:

On Wed, Sep 16, 2020 at 2:39 PM Alexander Egorenkov
<egorenar@linux.ibm.com> wrote:
>
> The offset has changed in linux-next (v5.9.0) from 4 to 0 because
> there is no more 'kref' member variable at the beginning of 'init_uts_ns'.
> The change was introduced with commit 9a56493f6942c0e2df1579986128721da96e00d8.
> To handle both cases correctly, calculate the offset at run time instead.
>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  makedumpfile.c | 6 ++++--
>  makedumpfile.h | 4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4c4251e..5114705 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1159,7 +1159,7 @@ check_release(void)
>         if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>                 utsname = SYMBOL(system_utsname);
>         } else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -               utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +               utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);

I am not sure if it is an issue with my mail-client or if the
indentation is a bit different from the original code (I see a
additional space before the statement) [and likewise below].

Please fix those..

>         } else {
>                 ERRMSG("Can't get the symbol of system_utsname.\n");
>                 return FALSE;
> @@ -2077,7 +2077,7 @@ get_str_osrelease_from_vmlinux(void)
>         if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>                 utsname = SYMBOL(system_utsname);
>         } else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -               utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +               utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);
>         } else {
>                 ERRMSG("Can't get the symbol of system_utsname.\n");
>                 return FALSE;
> @@ -2697,6 +2697,8 @@ read_vmcoreinfo(void)
>                 READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
>         }
>
> +       READ_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);
> +
>         READ_ARRAY_LENGTH("node_data", node_data);
>         READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
>         READ_ARRAY_LENGTH("mem_section", mem_section);

Hmm.. don't we need a similar addition inside 'write_vmcoreinfo_data'.
Something like:
WRITE_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);

> diff --git a/makedumpfile.h b/makedumpfile.h
> index 03fb4ce..7d8c54d 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1880,6 +1880,10 @@ struct offset_table {
>         struct cpu_spec_s {
>                 long    mmu_features;
>         } cpu_spec;
> +
> +       struct init_uts_ns_s {
> +               long    name;
> +       } init_uts_ns;
>  };
>
>  /*
> --
> 2.26.2

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
