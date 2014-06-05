Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsYMp-0001ff-2R
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 14:10:07 +0000
Date: Thu, 5 Jun 2014 16:07:47 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 03/13] kexec: Move segment verification code in a
 separate function
Message-ID: <20140605140746.GC16642@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-4-git-send-email-vgoyal@redhat.com>
 <20140604093254.GB4105@pd.tnic> <20140604184743.GC4406@redhat.com>
 <20140604203041.GF4105@pd.tnic> <20140605140506.GC17389@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140605140506.GC17389@redhat.com>
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

On Thu, Jun 05, 2014 at 10:05:06AM -0400, Vivek Goyal wrote:
> Ok, given that you feel so strongly about it, I will change it next
> version of patches. :-).

Hehe, thanks! :-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
