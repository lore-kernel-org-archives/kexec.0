Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8TSp-0004Rd-Db
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 17:32:49 +0000
Date: Mon, 25 Mar 2019 18:32:39 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190325173239.GO12016@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
 <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
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
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: lijiang <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On Mon, Mar 25, 2019 at 05:17:55PM +0000, Singh, Brijesh wrote:
> By default all the memory regions are mapped encrypted. The
> set_memory_{encrypt,decrypt}() is a generic function which can be
> called explicitly to clear/set the encryption mask from the existing
> memory mapping. The mem_encrypt_active() returns true if either SEV or 
> SME is active. So the __set_memory_enc_dec() uses the
> memory_encrypt_active() check to ensure that the function is no-op when
> SME/SEV are not active.
> 
> Currently, the arch_kexec_post_alloc_pages() unconditionally clear the
> encryption mask from the kexec area. In case of SEV, we should not clear
> the encryption mask.

Brijesh, I know all that.

Please read what I said here at the end:

https://lkml.kernel.org/r/20190324150034.GH23289@zn.tnic

With this change, the code looks like this:

+       if (sme_active())
+               return set_memory_decrypted((unsigned long)vaddr, pages);

now in __set_memory_enc_dec via set_memory_decrypted():

        /* Nothing to do if memory encryption is not active */
        if (!mem_encrypt_active())
                return 0;


so you have:

	if (sme_active())

		...

		if (!mem_encrypt_active())


now maybe this is all clear to you and Tom but I betcha others will get
confused. Probably something like "well, what should be active now, SME,
SEV or memory encryption in general"?

I hope you're catching my drift.

So if you want to *not* decrypt memory in the SEV case, then doing something
like this should make it a bit more clear:


	if (sev_active())
		return;

	return set_memory_decrypted((unsigned long)vaddr, pages);

along with a comment *why* we're checking here.

But actually, I'd prefer if you had separate wrappers which are called
for SME and for SEV.

I'll let Tom chime in too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
