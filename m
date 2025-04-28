Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077ADC369D5
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S3lY2EODpSWf7PbFeYDoT7dall85uxisFJtIG+o9gPU=; b=jPRM7sSXKpPSa0Y3pofO2a1Z/V
	OX7w2Q4DEXFX+qS1a2q4RGe01SY372OVniWSH+B6FS6xlbB4TXXIhh2fJup8Kro4huUUUSeVOqdtU
	rldd9vueYUENA7AX1BRpz8Hrp3U+zY5BHHkiIoXUGPEg5JHL/8RPLXRqHG49vxJIVpyy6jOr9eTvT
	TSOqZT9JZrv6sFXGd40bpqFXf33fvqtMwjqwMhW+JFli+ZALyl8alrzvlvjZj/o8N8j57gVgJd/cv
	h7AklQqEDWHDuP1as38G4SdqBbIH/ryq6bjBezJKGiN2IVwrGFdiEAoMpUFfrRdywjeDtZvEKFuAe
	toWcgRqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9SUa-000000077lk-3hh5;
	Mon, 28 Apr 2025 17:42:08 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9SRP-000000077Dj-25EQ
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 17:38:53 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-54b10956398so5786032e87.0
        for <kexec@lists.infradead.org>; Mon, 28 Apr 2025 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1745861929; x=1746466729; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3lY2EODpSWf7PbFeYDoT7dall85uxisFJtIG+o9gPU=;
        b=ymUf6eZWUpJjuiQapY7bF3sM2AHB/k3YugVjNBGWAw3wctQl6xILE4+I+6BzF7nDBX
         2pMU44s0dNoZyWJO9+b3I+fDhbaOnLVc0nWL19C7IjrNB5rl/o0quvcEfq06/aniltVT
         ugvZ2+/hLJ1G7ZPuDjdAdKZdD1GHU/4Q2TXpwXf02VQhfcDze/Dtu9moVY4nlak/H+S7
         bXXhoesGsnqgx8eGRR0hVWFamfXiWShNXHMVNVLRahcrj7GLW9USMAz13cFj/60pMDMK
         gXn++PR6kyXbsi1MEFYHg70tapClw4XaS7eOjKv5MzDCNUFxYzGFc4+MBFflRBegRVse
         jnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861929; x=1746466729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3lY2EODpSWf7PbFeYDoT7dall85uxisFJtIG+o9gPU=;
        b=VJIl5wGDA3avlnAvTLczcv+E2yrqHBw7SnM4aYt+wfkfRKGiQpCH93pMWvxWD9Hc6u
         JEF4qgD6FMo3gbF7hh+mSq6wO5hVH/pTLntB8NOegUQP2+NudEvNyhxqIw5tsmbxQ0Is
         eNTkHBVK6vfUayGf9zGIbGmd0WiTRGGWs6ytfwUEsSlU6aWStEGHCB0Y/P3mAsvniS4J
         rNe5Dc/dR4PxxfF+3PIhPiVmtj7zc6T4GYQ8LvjWseC33lUepHWFf+gFDMZkOyuMY5N8
         3yzKCFiJel8Wv/o1A8C+Lox9YRTjo6cUCxivUoc2vCBWLL0EhR7/H8Kkn+vwwPYuOD6s
         /Kag==
X-Forwarded-Encrypted: i=1; AJvYcCXgRteKLUnwdu2dg3/i7FLk8ExPS4hCyraeBeQQ7X6GRcIFWfy/XhaTWHNT4z8UXIleZFaaXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJ5IRhGbpCahbiDHqqvf7n7Mwv7DENE7FdYC1ZZ4ZfS2Jqqdh/
	gnn/XXN5Nf2TKLUX5gFK6XFIUspyb5YxkuPUprYuR7ZBUxqxAf6q4EDkyf2zFIJ6cDDPp5aNeK5
	0t67vWkpKdyMGKmGnLZvVthsG+GPeer5uS6d/
X-Gm-Gg: ASbGncv6Ac+pHvH35FclCiGMyCckTX1N3XWaFPZ2M3jDFf8+RHHM5Miuxa7ht24DU7V
	wNoJFcAQvpxPjCgu4sAZ42Mbp/jbjjPei2/LWa5fPDlRNB7s/Oom2HtZDwHNk4+0mEw2FLDw5Cv
	izllatoBJvUqm1n7U5ext0
X-Google-Smtp-Source: AGHT+IFN43fQ9hbOpQBxgucI4grGKEwBuZUMjbsIm9KdgzOVZQUB596Q0XnHklWpWPJ5/jhcVObbJzWmVsLYy44QUGg=
X-Received: by 2002:a05:6512:1111:b0:54a:fe25:43d1 with SMTP id
 2adb3069b0e04-54e9e16ac82mr14004e87.10.1745861928812; Mon, 28 Apr 2025
 10:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162712.77452-1-ross.philipson@oracle.com> <20250421162712.77452-19-ross.philipson@oracle.com>
In-Reply-To: <20250421162712.77452-19-ross.philipson@oracle.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 28 Apr 2025 10:38:37 -0700
X-Gm-Features: ATxdqUEEZeo1CfYqdUjIC7TdnT0JrgIlsLJvYgh7ENhGmufQJu2KPSjPRY2cVks
Message-ID: <CALCETrVayuzp7fstavHkx99eieUCNj3=Zt8D=WOqMnmeT6DKmQ@mail.gmail.com>
Subject: Re: [PATCH v14 18/19] x86: Secure Launch late initcall platform module
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_103851_744257_13308E5C 
X-CRM114-Status: GOOD (  35.81  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> On Apr 21, 2025, at 9:36=E2=80=AFAM, Ross Philipson <ross.philipson@oracl=
e.com> wrote:
>
> =EF=BB=BFFrom: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The Secure Launch platform module is a late init module. During the
> init call, the TPM event log is read and measurements taken in the
> early boot stub code are located. These measurements are extended
> into the TPM PCRs using the mainline TPM kernel driver.

I read through some of the TPM and TXT docs, and I haven=E2=80=99t found a
clear explanation of exactly what gets hashed into which PCR.  (Mostly
because the docs are full of TXT-specific terms.)

But I=E2=80=99m really struggling to understand how the security model ends=
 up
being consistent with this late_initcall thing. We measure some state
into the event log, and then we do a whole bunch of things (everything
from the very beginning of loading the kernel proper to the whenever
in the late_initcall stage this code runs), and then we actually
extend the PCRs.  It seems to me that this may involve a whole lot of
crossing fingers that an attacker can=E2=80=99t find a way to get the kerne=
l
to execute code that changes the event log in memory prior to
extending PCRs such that attacker-controlled values get written.  Even
if the design is, in principle, sound, the attack surface seems much,
much larger than it deserves to be.

Is there some reason for all this complexity instead of extending the
PCRs at the early stage when the measurements are taken?


>
> The platform module also registers the securityfs nodes to allow
> access to TXT register fields on Intel along with the fetching of
> and writing events to the late launch TPM log.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
> arch/x86/kernel/Makefile   |   1 +
> arch/x86/kernel/slmodule.c | 508 +++++++++++++++++++++++++++++++++++++
> 2 files changed, 509 insertions(+)
> create mode 100644 arch/x86/kernel/slmodule.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index a7ca7ca16174..bed87b1c49a2 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_IA32_EMULATION)    +=3D tls.o
> obj-y                +=3D step.o
> obj-$(CONFIG_INTEL_TXT)        +=3D tboot.o
> obj-$(CONFIG_SECURE_LAUNCH)    +=3D slaunch.o
> +obj-$(CONFIG_SECURE_LAUNCH)    +=3D slmodule.o
> obj-$(CONFIG_ISA_DMA_API)    +=3D i8237.o
> obj-y                +=3D stacktrace.o
> obj-y                +=3D cpu/
> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> new file mode 100644
> index 000000000000..64010bac038c
> --- /dev/null
> +++ b/arch/x86/kernel/slmodule.c
> @@ -0,0 +1,508 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch late validation/setup, securityfs exposure and finaliza=
tion.
> + *
> + * Copyright (c) 2025 Apertus Solutions, LLC
> + * Copyright (c) 2025 Assured Information Security, Inc.
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/security.h>
> +#include <linux/memblock.h>
> +#include <linux/tpm.h>
> +#include <asm/segment.h>
> +#include <asm/sections.h>
> +#include <crypto/sha2.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +
> +/*
> + * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
> + * public registers as unsigned values.
> + */
> +#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)            \
> +static ssize_t txt_pub_read_u##size(unsigned int offset,        \
> +        loff_t *read_offset,                    \
> +        size_t read_len,                    \
> +        char __user *buf)                    \
> +{                                    \
> +    char msg_buffer[msg_size];                    \
> +    u##size reg_value =3D 0;                        \
> +    void __iomem *txt;                        \
> +                                    \
> +    txt =3D ioremap(TXT_PUB_CONFIG_REGS_BASE,                \
> +            TXT_NR_CONFIG_PAGES * PAGE_SIZE);        \
> +    if (!txt)                            \
> +        return -EFAULT;                        \
> +    memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));    \
> +    iounmap(txt);                            \
> +    snprintf(msg_buffer, msg_size, fmt, reg_value);            \
> +    return simple_read_from_buffer(buf, read_len, read_offset,    \
> +            &msg_buffer, msg_size);                \
> +}
> +
> +DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
> +DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
> +DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
> +
> +#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)        \
> +static ssize_t txt_##reg_name##_read(struct file *flip,            \
> +        char __user *buf, size_t read_len, loff_t *read_offset)    \
> +{                                    \
> +    return txt_pub_read_u##reg_size(reg_offset, read_offset,    \
> +            read_len, buf);                    \
> +}                                    \
> +static const struct file_operations reg_name##_ops =3D {            \
> +    .read =3D txt_##reg_name##_read,                    \
> +}
> +
> +DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
> +DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
> +DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
> +DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
> +DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
> +DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
> +DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
> +
> +/*
> + * Securityfs exposure
> + */
> +struct memfile {
> +    char *name;
> +    void *addr;
> +    size_t size;
> +};
> +
> +static struct memfile sl_evtlog =3D {"eventlog", NULL, 0};
> +static void *txt_heap;
> +static struct txt_heap_event_log_pointer2_1_element *evtlog21;
> +static DEFINE_MUTEX(sl_evt_log_mutex);
> +static struct tcg_efi_specid_event_head *efi_head;
> +
> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
> +                  size_t count, loff_t *pos)
> +{
> +    ssize_t size;
> +
> +    if (!sl_evtlog.addr)
> +        return 0;
> +
> +    mutex_lock(&sl_evt_log_mutex);
> +    size =3D simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
> +                       sl_evtlog.size);
> +    mutex_unlock(&sl_evt_log_mutex);
> +
> +    return size;
> +}
> +
> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf=
,
> +                   size_t datalen, loff_t *ppos)
> +{
> +    ssize_t result;
> +    char *data;
> +
> +    if (!sl_evtlog.addr)
> +        return 0;
> +
> +    /* No partial writes. */
> +    result =3D -EINVAL;
> +    if (*ppos !=3D 0)
> +        goto out;
> +
> +    data =3D memdup_user(buf, datalen);
> +    if (IS_ERR(data)) {
> +        result =3D PTR_ERR(data);
> +        goto out;
> +    }
> +
> +    mutex_lock(&sl_evt_log_mutex);
> +    if (evtlog21)
> +        result =3D tpm2_log_event(evtlog21, sl_evtlog.addr,
> +                    sl_evtlog.size, datalen, data);
> +    else
> +        result =3D tpm_log_event(sl_evtlog.addr, sl_evtlog.size,
> +                       datalen, data);
> +    mutex_unlock(&sl_evt_log_mutex);
> +
> +    kfree(data);
> +out:
> +    return result;
> +}
> +
> +static const struct file_operations sl_evtlog_ops =3D {
> +    .read =3D sl_evtlog_read,
> +    .write =3D sl_evtlog_write,
> +    .llseek    =3D default_llseek,
> +};
> +
> +struct sfs_file {
> +    const char *name;
> +    const struct file_operations *fops;
> +};
> +
> +#define SL_TXT_ENTRY_COUNT    7
> +static const struct sfs_file sl_txt_files[] =3D {
> +    { "sts", &sts_ops },
> +    { "ests", &ests_ops },
> +    { "errorcode", &errorcode_ops },
> +    { "didvid", &didvid_ops },
> +    { "ver_emif", &ver_emif_ops },
> +    { "scratchpad", &scratchpad_ops },
> +    { "e2sts", &e2sts_ops }
> +};
> +
> +/* sysfs file handles */
> +static struct dentry *slaunch_dir;
> +static struct dentry *event_file;
> +static struct dentry *txt_dir;
> +static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
> +
> +static long slaunch_expose_securityfs(void)
> +{
> +    long ret =3D 0;
> +    int i;
> +
> +    slaunch_dir =3D securityfs_create_dir("slaunch", NULL);
> +    if (IS_ERR(slaunch_dir))
> +        return PTR_ERR(slaunch_dir);
> +
> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +        txt_dir =3D securityfs_create_dir("txt", slaunch_dir);
> +        if (IS_ERR(txt_dir)) {
> +            ret =3D PTR_ERR(txt_dir);
> +            goto remove_slaunch;
> +        }
> +
> +        for (i =3D 0; i < ARRAY_SIZE(sl_txt_files); i++) {
> +            txt_entries[i] =3D securityfs_create_file(
> +                        sl_txt_files[i].name, 0440,
> +                        txt_dir, NULL,
> +                        sl_txt_files[i].fops);
> +            if (IS_ERR(txt_entries[i])) {
> +                ret =3D PTR_ERR(txt_entries[i]);
> +                goto remove_files;
> +            }
> +        }
> +    }
> +
> +    if (sl_evtlog.addr) {
> +        event_file =3D securityfs_create_file(sl_evtlog.name, 0440,
> +                            slaunch_dir, NULL,
> +                            &sl_evtlog_ops);
> +        if (IS_ERR(event_file)) {
> +            ret =3D PTR_ERR(event_file);
> +            goto remove_files;
> +        }
> +    }
> +
> +    return 0;
> +
> +remove_files:
> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +        while (--i >=3D 0)
> +            securityfs_remove(txt_entries[i]);
> +        securityfs_remove(txt_dir);
> +    }
> +
> +remove_slaunch:
> +    securityfs_remove(slaunch_dir);
> +
> +    return ret;
> +}
> +
> +static void slaunch_teardown_securityfs(void)
> +{
> +    int i;
> +
> +    securityfs_remove(event_file);
> +    if (sl_evtlog.addr) {
> +        memunmap(sl_evtlog.addr);
> +        sl_evtlog.addr =3D NULL;
> +    }
> +    sl_evtlog.size =3D 0;
> +
> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +        for (i =3D 0; i < ARRAY_SIZE(sl_txt_files); i++)
> +            securityfs_remove(txt_entries[i]);
> +
> +        securityfs_remove(txt_dir);
> +
> +        if (txt_heap) {
> +            memunmap(txt_heap);
> +            txt_heap =3D NULL;
> +        }
> +    }
> +
> +    securityfs_remove(slaunch_dir);
> +}
> +
> +static void slaunch_intel_evtlog(void __iomem *txt)
> +{
> +    struct slr_entry_log_info *log_info;
> +    struct txt_os_mle_data *params;
> +    struct slr_table *slrt;
> +    void *os_sinit_data;
> +    u64 base, size;
> +
> +    memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
> +    memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
> +
> +    /* now map TXT heap */
> +    txt_heap =3D memremap(base, size, MEMREMAP_WB);
> +    if (!txt_heap)
> +        slaunch_txt_reset(txt, "Error failed to memremap TXT heap\n",
> +                  SL_ERROR_HEAP_MAP);
> +
> +    params =3D (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap)=
;
> +
> +    /* Get the SLRT and remap it */
> +    slrt =3D memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
> +    if (!slrt)
> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                  SL_ERROR_SLRT_MAP);
> +    size =3D slrt->size;
> +    memunmap(slrt);
> +
> +    slrt =3D memremap(params->slrt, size, MEMREMAP_WB);
> +    if (!slrt)
> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                  SL_ERROR_SLRT_MAP);
> +
> +    log_info =3D slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> +    if (!log_info)
> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                  SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +    sl_evtlog.size =3D log_info->size;
> +    sl_evtlog.addr =3D memremap(log_info->addr, log_info->size,
> +                  MEMREMAP_WB);
> +    if (!sl_evtlog.addr)
> +        slaunch_txt_reset(txt, "Error failed to memremap TPM event log\n=
",
> +                  SL_ERROR_EVENTLOG_MAP);
> +
> +    memunmap(slrt);
> +
> +    /* Determine if this is TPM 1.2 or 2.0 event log */
> +    if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
> +            TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
> +        return; /* looks like it is not 2.0 */
> +
> +    /* For TPM 2.0 logs, the extended heap element must be located */
> +    os_sinit_data =3D txt_os_sinit_data_start(txt_heap);
> +
> +    evtlog21 =3D tpm2_find_log2_1_element(os_sinit_data);
> +
> +    /*
> +     * If this fails, things are in really bad shape. Any attempt to wri=
te
> +     * events to the log will fail.
> +     */
> +    if (!evtlog21)
> +        slaunch_txt_reset(txt, "Error failed to find TPM20 event log ele=
ment\n",
> +                  SL_ERROR_TPM_INVALID_LOG20);
> +
> +    /* Save pointer to the EFI SpecID log header */
> +    efi_head =3D (struct tcg_efi_specid_event_head *)(sl_evtlog.addr + s=
izeof(struct tcg_pcr_event));
> +}
> +
> +static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem=
 *txt,
> +                      struct tcg_pcr_event2_head *event)
> +{
> +    u16 *alg_id_field =3D (u16 *)((u8 *)event + sizeof(*event));
> +    struct tpm_digest *digests;
> +    u8 *dptr;
> +    int ret;
> +    u32 i;
> +
> +    /*
> +     * Early SL code ensured the TPM algorithm information passed via
> +     * the log is valid. Small sanity check here.
> +     */
> +    if (event->count !=3D efi_head->num_algs)
> +        slaunch_txt_reset(txt, "Event digest count mismatch with event l=
og\n",
> +                  SL_ERROR_TPM_EVENT_COUNT);
> +
> +    digests =3D kzalloc(efi_head->num_algs * sizeof(*digests), GFP_KERNE=
L);
> +    if (!digests)
> +        slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
> +                  SL_ERROR_GENERIC);
> +
> +    for (i =3D 0; i < event->count; i++) {
> +        dptr =3D (u8 *)alg_id_field + sizeof(u16);
> +
> +        /* Setup each digest for the extend */
> +        digests[i].alg_id =3D efi_head->digest_sizes[i].alg_id;
> +        memcpy(&digests[i].digest[0], dptr,
> +            efi_head->digest_sizes[i].digest_size);
> +
> +        alg_id_field =3D (u16 *)((u8 *)alg_id_field + sizeof(u16) +
> +                efi_head->digest_sizes[i].digest_size);
> +    }
> +
> +    ret =3D tpm_pcr_extend(tpm, event->pcr_idx, digests);
> +    if (ret) {
> +        pr_err("Error extending TPM20 PCR, result: %d\n", ret);
> +        slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
> +                  SL_ERROR_TPM_EXTEND);
> +    }
> +
> +    kfree(digests);
> +}
> +
> +static void slaunch_tpm2_extend(struct tpm_chip *tpm, void __iomem *txt)
> +{
> +    struct tcg_pcr_event *event_header;
> +    struct tcg_pcr_event2_head *event;
> +    int start =3D 0, end =3D 0, size;
> +
> +    event_header =3D (struct tcg_pcr_event *)(sl_evtlog.addr +
> +                        evtlog21->first_record_offset);
> +
> +    /* Skip first TPM 1.2 event to get to first TPM 2.0 event */
> +    event =3D (struct tcg_pcr_event2_head *)((u8 *)event_header + sizeof=
(*event_header) +
> +                           event_header->event_size);
> +
> +    while ((void  *)event < sl_evtlog.addr + evtlog21->next_record_offse=
t) {
> +        size =3D __calc_tpm2_event_size(event, event_header, false);
> +        if (!size)
> +            slaunch_txt_reset(txt, "TPM20 invalid event in event log\n",
> +                      SL_ERROR_TPM_INVALID_EVENT);
> +
> +        /*
> +         * Marker events indicate where the Secure Launch early stub
> +         * started and ended adding post launch events. As they are
> +         * encountered, switch the event type to NO_ACTION so they
> +         * ignored in when the event log is processed since they are
> +         * not really measurements.
> +         */
> +        if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_END) {
> +            event->event_type =3D NO_ACTION;
> +            end =3D 1;
> +            break;
> +        } else if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_START) {
> +            event->event_type =3D NO_ACTION;
> +            start =3D 1;
> +            goto next;
> +        }
> +
> +        if (start)
> +            slaunch_tpm2_extend_event(tpm, txt, event);
> +
> +next:
> +        event =3D (struct tcg_pcr_event2_head *)((u8 *)event + size);
> +    }
> +
> +    if (!start || !end)
> +        slaunch_txt_reset(txt, "Missing start or end events for extendin=
g TPM20 PCRs\n",
> +                  SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
> +{
> +    struct tpm_event_log_header *event_header;
> +    struct tcg_pcr_event *event;
> +    struct tpm_digest digest;
> +    int start =3D 0, end =3D 0;
> +    int size, ret;
> +
> +    event_header =3D (struct tpm_event_log_header *)sl_evtlog.addr;
> +    event =3D (struct tcg_pcr_event *)((u8 *)event_header +
> +                sizeof(*event_header));
> +
> +    while ((void  *)event < sl_evtlog.addr + event_header->next_event_of=
fset) {
> +        size =3D sizeof(*event) + event->event_size;
> +
> +        /*
> +         * See comments in slaunch_tpm2_extend() concerning these specia=
l
> +         * event types.
> +         */
> +        if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_END) {
> +            event->event_type =3D NO_ACTION;
> +            end =3D 1;
> +            break;
> +        } else if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_START) {
> +            event->event_type =3D NO_ACTION;
> +            start =3D 1;
> +            goto next;
> +        }
> +
> +        if (start) {
> +            memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
> +            digest.alg_id =3D TPM_ALG_SHA1;
> +            memcpy(&digest.digest[0], &event->digest[0],
> +                   SHA1_DIGEST_SIZE);
> +
> +            ret =3D tpm_pcr_extend(tpm, event->pcr_idx, &digest);
> +            if (ret) {
> +                pr_err("Error extending TPM12 PCR, result: %d\n", ret);
> +                slaunch_txt_reset(txt, "Failed to extend TPM12 PCR\n",
> +                          SL_ERROR_TPM_EXTEND);
> +            }
> +        }
> +
> +next:
> +        event =3D (struct tcg_pcr_event *)((u8 *)event + size);
> +    }
> +
> +    if (!start || !end)
> +        slaunch_txt_reset(txt, "Missing start or end events for extendin=
g TPM12 PCRs\n",
> +                  SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_pcr_extend(void __iomem *txt)
> +{
> +    struct tpm_chip *tpm;
> +    int rc;
> +
> +    tpm =3D tpm_default_chip();
> +    if (!tpm)
> +        slaunch_txt_reset(txt, "Could not get default TPM chip\n",
> +                  SL_ERROR_TPM_INIT);
> +
> +    rc =3D tpm_chip_set_locality(tpm, 2);
> +    if (rc)
> +        slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
> +                  SL_ERROR_TPM_INIT);
> +
> +    if (evtlog21)
> +        slaunch_tpm2_extend(tpm, txt);
> +    else
> +        slaunch_tpm_extend(tpm, txt);
> +}
> +
> +static int __init slaunch_module_init(void)
> +{
> +    void __iomem *txt;
> +
> +    /* Check to see if Secure Launch happened */
> +    if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=3D
> +        (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
> +        return 0;
> +
> +    txt =3D ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
> +              PAGE_SIZE);
> +    if (!txt)
> +        panic("Error ioremap of TXT priv registers\n");
> +
> +    /* Only Intel TXT is supported at this point */
> +    slaunch_intel_evtlog(txt);
> +    slaunch_pcr_extend(txt);
> +    iounmap(txt);
> +
> +    return slaunch_expose_securityfs();
> +}
> +
> +static void __exit slaunch_module_exit(void)
> +{
> +    slaunch_teardown_securityfs();
> +}
> +
> +late_initcall(slaunch_module_init);
> +__exitcall(slaunch_module_exit);
> --
> 2.39.3
>

