Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQvx-0001Sv-4Z
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 15:47:22 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0FFifaD126630
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 10:47:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q1ewfk0ej-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 10:47:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 15 Jan 2019 15:47:17 -0000
Subject: Re: [RFC PATCH v2 2/2] kexec, KEYS: Make use of platform keyring
 for signature verify
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 15 Jan 2019 10:46:58 -0500
In-Reply-To: <20190115094542.17129-3-kasong@redhat.com>
References: <20190115094542.17129-1-kasong@redhat.com>
 <20190115094542.17129-3-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1547567218.4156.289.camel@linux.ibm.com>
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
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:

> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7d97e432cbbc..a06b04065bb1 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len,
> -				       VERIFY_USE_SECONDARY_KEYRING,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	int ret;
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +			VERIFY_USE_SECONDARY_KEYRING,
> +			VERIFYING_KEXEC_PE_SIGNATURE);
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING

Consider using IS_ENABLED() or IS_BUILTIN().

Mimi

> +	if (ret == -ENOKEY) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +				VERIFY_USE_PLATFORM_KEYRING,
> +				VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +#endif
> +	return ret;
>  }
>  #endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
