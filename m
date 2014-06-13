Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WvU8F-0006r2-UQ
 for kexec@lists.infradead.org; Fri, 13 Jun 2014 16:15:12 +0000
Date: Fri, 13 Jun 2014 18:14:47 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 10/13] kexec: Load and Relocate purgatory at kernel load
 time
Message-ID: <20140613161447.GH4751@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-11-git-send-email-vgoyal@redhat.com>
 <20140610163128.GA6652@nazgul.tnic>
 <20140611192448.GH10723@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140611192448.GH10723@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, mjg59@srcf.ucam.org
Cc: bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Wed, Jun 11, 2014 at 03:24:48PM -0400, Vivek Goyal wrote:
> This new syscall requires sha256 even if signature checking does not
> happen. Purgatory verifies checksum of segments.
> 
> I had to select CRYPTO also otherwise CONFIG_CRYPTO=m broke the build.
> 
> > 
> > Which begs the more important question - shouldn't this new in-kernel
> > loading method support also kexec'ing of kernels without any signature
> > verifications at all?
> 
> I think yes it should allow kexecing kernels without any signature also.
> In fact in long term, we should deprecate the old syscall and maintain
> this new one.
> 
> Now, when does signature checking kick in? I think we can define a new
> config option say KEXEC_ENFORCE_KERNEL_SIG_VERIFICATION. This option
> will make sure kernel signature are verified. 
> 
> If KEXEC_ENFORCE_KERNEL_SIG_VERIFICATION=n, even then signature
> verification should be enforced if secureboot is enabled on the platform.

Right, this makes sense to me. Probably Matthew might want to chime in
here too...

> I will make it configurable in next series. This series does not do
> any signature verification yet. Above CRYPTO and CRYPTO_SHA256 I had
> to select to make sure checksum verfication logic in purgatory works
> fine.

Ok.

> Hmm... I have seen at other places using same name as structure. But I am
> not particular about it will change. Anyway, on most of the places
> I use a pointer to access it.
> 
> struct purgaotry_info *pi  = &image->purgatory_info;

Yep, saw that in the later patches :)

> I would like to retain purgaotry_buf. To shorten it I could do this.
> 
> 	struct purgatory_info *pi = &image->purgatory_info;
> 	vfree(pi->purgatory_buf);
> 	pi->purgatory_buf = NULL;
> 
> I like the clarity in variable names.

Ok.

> I would like to keep it one function. Reason being that apart from
> digest, we also store the list of regions which has been checkummed. And
> you will notice that we skip the purgatory region during checksum
> calculation.
> 
> So I will have to return quite some information from calc() function. Size
> of digest, actual digest buffer which will need to be freed by caller,
> and list of sha regions which will need to be freed by caller. Keeping
> it call in one function makes it little simpler actually.

Hmm, ok.

> Just wanted a small zero buffer. Is there any global zero buffer
> available in kernel. If not, I could use a PAGE_SIZE zero buffer
> instead.

empty_zero_page?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
