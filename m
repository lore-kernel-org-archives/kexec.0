Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsHqQ-0000ue-6T
 for kexec@lists.infradead.org; Wed, 04 Jun 2014 20:31:35 +0000
Date: Wed, 4 Jun 2014 22:30:41 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 03/13] kexec: Move segment verification code in a
 separate function
Message-ID: <20140604203041.GF4105@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-4-git-send-email-vgoyal@redhat.com>
 <20140604093254.GB4105@pd.tnic> <20140604184743.GC4406@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140604184743.GC4406@redhat.com>
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

On Wed, Jun 04, 2014 at 02:47:43PM -0400, Vivek Goyal wrote:
> Hmm..., Interesting. I never noticed it. So google search seems to say
> that unuseable is also not wrong.

Nope, it seems more like "unuseable" is simply a very common misspelling
which has managed to spread out uncontrollably, even in the kernel :).
Both Oxford and Merriam-Webster know "unusable" as the only correct
spelling.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
