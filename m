Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g6B0s-0004vo-15
 for kexec@lists.infradead.org; Sat, 29 Sep 2018 08:54:12 +0000
Date: Sat, 29 Sep 2018 10:53:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
Message-ID: <20180929085354.GC11115@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com>
 <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
 <20180928075654.GA20768@zn.tnic>
 <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
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

On Fri, Sep 28, 2018 at 06:09:04PM +0800, lijiang wrote:
> But there are another cases, we might load or unload the crash kernel image and
> initrafms, maybe again and again for test or debug, we don't reboot at once. For

I don't think this qualifies even as a use case - this is what you do
during development.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
