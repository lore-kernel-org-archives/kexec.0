Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wwf83-00023A-Ee
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 22:11:51 +0000
Date: Tue, 17 Jun 2014 00:10:59 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140616221059.GM8170@pd.tnic>
References: <20140609154137.GD22049@redhat.com> <20140613075011.GA4751@pd.tnic>
 <20140613124609.GC5871@redhat.com> <20140613153620.GG4751@pd.tnic>
 <20140616173823.GC4515@redhat.com> <20140616200526.GF8170@pd.tnic>
 <20140616205331.GA13257@redhat.com> <20140616210927.GJ8170@pd.tnic>
 <539F60B3.1040509@zytor.com> <20140616214313.GB1870@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616214313.GB1870@redhat.com>
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
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Mon, Jun 16, 2014 at 05:43:13PM -0400, Vivek Goyal wrote:
> Actually currently I am using vzalloc() for command line buffer
> allocation.
> 
> 	image->cmdline_buf = vzalloc(cmdline_len);
> 	if (!image->cmdline_buf)
> 		goto out;
> 
> Should I switch to using kzalloc() instead?

Well, vzalloc could trigger the OOM killer, can't it, for the right
size? If so, then we will have a serious problem.

And this snippet above is down the syscall path.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
