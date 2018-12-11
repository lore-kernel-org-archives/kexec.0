Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from namei.org ([65.99.196.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWn4q-00079J-HD
 for kexec@lists.infradead.org; Tue, 11 Dec 2018 18:48:17 +0000
Date: Wed, 12 Dec 2018 05:47:58 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 5/7] efi: Import certificates from UEFI Secure Boot
In-Reply-To: <20181208202705.18673-6-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120547110.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-6-nayna@linux.ibm.com>
MIME-Version: 1.0
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
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, Josh Boyer <jwboyer@fedoraproject.org>, vgoyal@redhat.com

On Sun, 9 Dec 2018, Nayna Jain wrote:

> +/*
> + * Blacklist an X509 TBS hash.
> + */
> +static __init void uefi_blacklist_x509_tbs(const char *source,
> +					   const void *data, size_t len)
> +{
> +	char *hash, *p;
> +
> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +	p = memcpy(hash, "tbs:", 4);
> +	p += 4;
> +	bin2hex(p, data, len);
> +	p += len * 2;
> +	*p = 0;
> +
> +	mark_hash_blacklisted(hash);
> +	kfree(hash);
> +}
> +
> +/*
> + * Blacklist the hash of an executable.
> + */
> +static __init void uefi_blacklist_binary(const char *source,
> +					 const void *data, size_t len)
> +{
> +	char *hash, *p;
> +
> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +	p = memcpy(hash, "bin:", 4);
> +	p += 4;
> +	bin2hex(p, data, len);
> +	p += len * 2;
> +	*p = 0;
> +
> +	mark_hash_blacklisted(hash);
> +	kfree(hash);
> +}
> 

These could be refactored into one function.


-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
