Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwtNs-0005Qf-SE
 for kexec@lists.infradead.org; Tue, 17 Jun 2014 13:25:09 +0000
Date: Tue, 17 Jun 2014 09:24:26 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140617132426.GB28340@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140616211328.GK8170@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616211328.GK8170@pd.tnic>
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

On Mon, Jun 16, 2014 at 11:13:28PM +0200, Borislav Petkov wrote:
> On Tue, Jun 03, 2014 at 09:06:49AM -0400, Vivek Goyal wrote:
> > This patch series does not do kernel signature verification yet. I
> > plan to post another patch series for that. Now bzImage is already
> > signed with PKCS7 signature I plan to parse and verify those
> > signatures.
> 
> Btw, do you have a brief outline on how you are going to do the
> extension to signature verification? Nothing formal, just enough of an
> outline that I can see where in the flow it will be plugged in.
> 
> I was wondering how the whole signature signing and verification will
> be done, i.e., where do I get the signature, how and who will verify it
> (I'm guessing the purgatory code), etc, etc.

Hi Boris,

I am still working on signing patches. I have uploaded them here for you
to have a look.

http://people.redhat.com/vgoyal/kdump-secureboot/in-kernel-kexec/bzimage-sig-verification/

Last patch should give you a good idea how signature verification hooks
into kexec.

Signature verification patches are based on David Howell's work.

There is no purgatory involved here. Once we have copied kernel image
into kernel space, first thing we do is call into arch image loader
and ask it to verify signature of image. And bzImage loader in turn
calls into helper functions which can parse a PE signed file and
verify image signature.

I have yet to cleanup the code, implement a config option which enforces
signature verification.

Automatic enforncement of signature verification if secureboot is
enabled will happen once matthew's secureboot patches are merged 
into mainline.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
