Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-la0-f41.google.com ([209.85.215.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VTWk2-000737-Rr
 for kexec@lists.infradead.org; Tue, 08 Oct 2013 12:50:23 +0000
Received: by mail-la0-f41.google.com with SMTP id ec20so6804464lab.14
 for <kexec@lists.infradead.org>; Tue, 08 Oct 2013 05:49:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52521FA5.3040101@jp.fujitsu.com>
References: <20131002140356.63706540@holzheu> <524D0ADF.2010507@jp.fujitsu.com>
 <52521FA5.3040101@jp.fujitsu.com>
Date: Tue, 8 Oct 2013 15:49:54 +0300
Message-ID: <CACVxJT8S7kA92=80DWVmVJJvbnaQ6WkyvsiFq4wP37WHV=tfuA@mail.gmail.com>
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
From: Alexey Dobriyan <adobriyan@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jan Willeke <willeke@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 7, 2013 at 5:42 AM, HATAYAMA Daisuke
<d.hatayama@jp.fujitsu.com> wrote:

> +static unsigned long
> +get_unmapped_area_vmcore(struct file *filp, unsigned long addr,
> +                        unsigned long len, unsigned long pgoff,
> +                        unsigned long flags)
> +{
> +#ifdef CONFIG_MMU
> +       return current->mm->get_unmapped_area(filp, addr, len, pgoff,
> flags);
> +#else
> +       return -EIO;
> +#endif
> +}
> +
>  static const struct file_operations proc_vmcore_operations = {
>         .read           = read_vmcore,
>         .llseek         = default_llseek,
>         .mmap           = mmap_vmcore,
> +       .get_unmapped_area = get_unmapped_area_vmcore,

I think current->mm->get_unmapped_area should be used by core proc code.
ENOMEM bug looks unrelated though.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
