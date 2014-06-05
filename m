Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsYIX-0000zp-6N
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 14:05:41 +0000
Date: Thu, 5 Jun 2014 10:05:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 03/13] kexec: Move segment verification code in a
 separate function
Message-ID: <20140605140506.GC17389@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-4-git-send-email-vgoyal@redhat.com>
 <20140604093254.GB4105@pd.tnic> <20140604184743.GC4406@redhat.com>
 <20140604203041.GF4105@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140604203041.GF4105@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Wed, Jun 04, 2014 at 10:30:41PM +0200, Borislav Petkov wrote:
> On Wed, Jun 04, 2014 at 02:47:43PM -0400, Vivek Goyal wrote:
> > Hmm..., Interesting. I never noticed it. So google search seems to say
> > that unuseable is also not wrong.
> 
> Nope, it seems more like "unuseable" is simply a very common misspelling
> which has managed to spread out uncontrollably, even in the kernel :).
> Both Oxford and Merriam-Webster know "unusable" as the only correct
> spelling.

Ok, given that you feel so strongly about it, I will change it next
version of patches. :-).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
