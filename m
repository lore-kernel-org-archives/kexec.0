Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3hrE-00086A-K8
 for kexec@lists.infradead.org; Fri, 30 Aug 2019 14:26:33 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7UEICZB059869
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2019 10:26:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uq3d1dp27-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2019 10:26:30 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Fri, 30 Aug 2019 15:26:28 +0100
Date: Fri, 30 Aug 2019 16:26:22 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH V40 08/29] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
In-Reply-To: <20190820001805.241928-9-matthewgarrett@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-9-matthewgarrett@google.com>
MIME-Version: 1.0
Message-Id: <20190830162622.534a0b8f@laptop-ibm>
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
To: Matthew Garrett <matthewgarrett@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>, linux-api@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org

Hi Matthew,

found a typo ...

On Mon, 19 Aug 2019 17:17:44 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

[...]

> index 6d0635ceddd0..9b4f37a4edf1 100644
> --- a/arch/s390/kernel/kexec_elf.c
> +++ b/arch/s390/kernel/kexec_elf.c
> @@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
>  const struct kexec_file_ops s390_kexec_elf_ops = {
>  	.probe = s390_elf_probe,
>  	.load = s390_elf_load,
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC__SIG
		      ^^
... here.
>  	.verify_sig = s390_verify_sig,
> -#endif /* CONFIG_KEXEC_VERIFY_SIG */
> +#endif /* CONFIG_KEXEC_SIG */
>  };

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
