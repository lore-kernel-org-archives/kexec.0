Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ws8XF-00034H-Qn
 for kexec@lists.infradead.org; Wed, 04 Jun 2014 10:35:10 +0000
Date: Wed, 4 Jun 2014 12:34:23 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 05/13] kexec: Make kexec_segment user buffer pointer a
 union
Message-ID: <20140604103423.GD4105@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-6-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401800822-27425-6-git-send-email-vgoyal@redhat.com>
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

On Tue, Jun 03, 2014 at 09:06:54AM -0400, Vivek Goyal wrote:
> So far kexec_segment->buf was always a user space pointer as user space
> passed the array of kexec_segment structures and kernel copied it.
> 
> But with new system call, list of kexec segments will be prepared by
> kernel and kexec_segment->buf will point to a kernel memory.
> 
> So while I was adding code where I made assumption that ->buf is pointing
> to kernel memory, sparse started giving warning.
> 
> Make ->buf a union. And where a user space pointer is expected, access
> it using ->buf and where a kernel space pointer is expected, access it
> using ->kbuf. That takes care of sparse warnings.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
