Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwdEj-00057E-WA
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 20:10:38 +0000
Date: Mon, 16 Jun 2014 22:10:00 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 09/13] purgatory: Core purgatory functionality
Message-ID: <20140616201000.GG8170@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-10-git-send-email-vgoyal@redhat.com>
 <20140605200523.GB26110@pd.tnic> <20140606195104.GM1526@redhat.com>
 <20140613101713.GD4751@pd.tnic> <20140616172538.GB4515@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616172538.GB4515@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Mon, Jun 16, 2014 at 01:25:38PM -0400, Vivek Goyal wrote:
> I tried following with CONFIG_KEXEC=n
> 
> ifeq ($(CONFIG_KEXEC),y)
>         $(Q)$(MAKE) $(clean)=arch/x86/purgatory
> endif
> 
> And still "make V=1 clean" shows me that it is going in purgatory dir
> to clean things up.

So add the ifdef for the CONFIG_KEXEC=n .configs.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
