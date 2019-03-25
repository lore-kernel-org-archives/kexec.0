Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8JF1-0004sg-0j
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 06:37:56 +0000
Date: Mon, 25 Mar 2019 07:37:42 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190325063742.GA12016@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
 <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Mar 25, 2019 at 09:58:07AM +0800, lijiang wrote:
> For the SEV virtual machine, it maps the kexec memroy area as
> encrypted, so, no need to invoke this function to change anything.

Look at the code:

set_memory_decrypted->__set_memory_enc_dec

It already *does* invoke this function.

> > 	if (!mem_encrypt_active())
> > 
> > and heads will spin from all the checking of memory encryption aspects.
> > 
> > So this would need a rework so that there are no multiple confusing
> > checks.
> 
> About the three functions, here i copied their comment from the arch/x86/mm/mem_encrypt.c
> Please refer to it.

I know that comment - I have asked for it. Now you go and look at the
code again with your patch applied.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
