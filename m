Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5neR-0006tI-Os
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 07:58:03 +0000
Date: Fri, 28 Sep 2018 09:57:11 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
Message-ID: <20180928075654.GA20768@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com>
 <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

On Fri, Sep 28, 2018 at 11:52:21AM +0800, lijiang wrote:
> There are two functions that are usually called in pairs, they are:
> arch_kexec_post_alloc_pages() and arch_kexec_pre_free_pages().
> 
> One marks the pages as decrypted, another one marks the pages as encrypted.
> 
> But for the crash control pages, no need to call arch_kexec_pre_free_pages(),
> there are three reasons:
> 1. Crash pages are reserved in memblock, these pages are only used by kdump,
>    no other people uses these pages;
> 
> 2. Whenever crash pages are allocated, these pages are always marked as
>    decrypted(when SME is active);
> 
> 3. If we plan to call the arch_kexe_pre_free_pages(), we have to store these
> pages to somewhere, which will have more code changes.

I don't think any of that answers the question *why* control pages do
not need to be marked encrypted again. And I think the reason is simple:
because you don't really need to, because once the crash kernel is done,
you reboot the box.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
